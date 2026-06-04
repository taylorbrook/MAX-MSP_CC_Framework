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
            1500.0,
            435.0
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
                        30.0,
                        30.0,
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
                        840.0,
                        285.0,
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
                        240.0,
                        285.0,
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
                        405.0,
                        30.0,
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
                        390.0,
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
                    "maxclass": "message",
                    "id": "obj-6",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        120.0,
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
                        645.0,
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
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        705.0,
                        120.0,
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
                        735.0,
                        165.0,
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
                        810.0,
                        120.0,
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
                        855.0,
                        120.0,
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
                        645.0,
                        210.0,
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
                        600.0,
                        255.0,
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
                        1245.0,
                        30.0,
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
                        30.0,
                        75.0,
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
                        150.0,
                        165.0,
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
                        90.0,
                        120.0,
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
                        255.0,
                        120.0,
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
                        315.0,
                        120.0,
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
                        1245.0,
                        75.0,
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
                        120.0,
                        30.0,
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
                        285.0,
                        285.0,
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
                        420.0,
                        285.0,
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
                        165.0,
                        285.0,
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
                        540.0,
                        285.0,
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
                        1245.0,
                        135.0,
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
                        75.0,
                        285.0,
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
                        480.0,
                        285.0,
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
                        780.0,
                        285.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b 0",
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
                        705.0,
                        285.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b 1",
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
                        945.0,
                        285.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b 2",
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
                        885.0,
                        285.0,
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
                        945.0,
                        285.0,
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
                        1245.0,
                        180.0,
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
                        330.0,
                        30.0,
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
                        360.0,
                        30.0,
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
                        255.0,
                        30.0,
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
                        75.0,
                        30.0,
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
                        285.0,
                        30.0,
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
                        1245.0,
                        225.0,
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
                        1245.0,
                        285.0,
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
                        1245.0,
                        330.0,
                        100.0,
                        20.0
                    ],
                    "text": "click on/off",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1020.0,
                        285.0,
                        58.0,
                        22.0
                    ],
                    "text": "click~",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        1430.0,
                        8.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-55",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1095.0,
                        285.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~",
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
                            470.0,
                            362.0
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
                                    "text": "in 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-2",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-3",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "\n// Noisy click generator -- replaces the pitched cycle~/line~ sine click.\n// in1: 1-sample tick from click tilde.  in2: which click. 0=beat 1=accent 2=subdiv.\n// out1: click signal.\nHistory env(0.);\nHistory lp(0.);\n\ntrig = in1 > 0.;\ntyp = in2;\n\n// per-click level, lowpass coef, and decay in ms\ntamp   = (typ >= 1.5) ? 0.4  : (typ >= 0.5) ? 1.0 : 0.6;\nbright = (typ >= 1.5) ? 0.35 : (typ >= 0.5) ? 0.9 : 0.6;\ntdec   = (typ >= 1.5) ? 14.  : (typ >= 0.5) ? 30. : 22.;\n\n// exp decay env: snap to level on tick, otherwise decay\ndecaysamps = tdec * 0.001 * samplerate;\ncoef = exp(-1. / decaysamps);\nenvval = trig ? tamp : env * coef;\nenv = envval;\n\n// 1-pole lowpass on white noise, higher coef is brighter for accents\nn = noise();\nlpval = lp + bright * (n - lp);\nlp = lpval;\n\nout1 = lpval * envval;\n",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        210.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [
                                        "obj-1",
                                        0
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
                                        "obj-2",
                                        0
                                    ],
                                    "destination": [
                                        "obj-3",
                                        1
                                    ],
                                    "midpoints": [
                                        90.0,
                                        63.5,
                                        423.0,
                                        63.5
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
                                        "obj-4",
                                        0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0,
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    }
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
                    ],
                    "midpoints": [
                        397.0,
                        112.0,
                        410.0,
                        112.0,
                        410.0,
                        150.0,
                        427.0,
                        150.0
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
                    ],
                    "midpoints": [
                        416.75,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        652.0,
                        150.0
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
                    ],
                    "midpoints": [
                        436.5,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        712.0,
                        150.0
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
                    ],
                    "midpoints": [
                        456.25,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        637.0,
                        112.0,
                        697.0,
                        112.0,
                        697.0,
                        150.0,
                        817.0,
                        150.0
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
                    ],
                    "midpoints": [
                        476.0,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        637.0,
                        112.0,
                        697.0,
                        112.0,
                        697.0,
                        150.0,
                        697.0,
                        112.0,
                        802.0,
                        112.0,
                        802.0,
                        150.0,
                        862.0,
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        522.5,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        652.0,
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
                    ],
                    "midpoints": [
                        757.0,
                        198.5,
                        652.0,
                        198.5
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
                    ],
                    "midpoints": [
                        45.0,
                        67.5,
                        178.0,
                        67.5
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
                        37.0,
                        112.0,
                        142.0,
                        112.0,
                        142.0,
                        150.0,
                        200.0,
                        150.0
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
                    ],
                    "midpoints": [
                        206.2,
                        112.0,
                        247.0,
                        112.0,
                        247.0,
                        150.0,
                        322.0,
                        150.0
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
                    ],
                    "midpoints": [
                        358.5,
                        112.0,
                        247.0,
                        112.0,
                        247.0,
                        150.0,
                        200.0,
                        150.0
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
                    ],
                    "midpoints": [
                        180.5,
                        22.0,
                        397.0,
                        22.0,
                        397.0,
                        60.0,
                        397.0,
                        22.0,
                        322.0,
                        22.0,
                        322.0,
                        62.0,
                        322.0,
                        22.0,
                        352.0,
                        22.0,
                        352.0,
                        62.0,
                        352.0,
                        22.0,
                        287.0,
                        22.0,
                        287.0,
                        62.0,
                        287.0,
                        22.0,
                        317.0,
                        22.0,
                        317.0,
                        62.0,
                        317.0,
                        67.0,
                        382.0,
                        67.0,
                        382.0,
                        105.0,
                        382.0,
                        67.0,
                        334.0,
                        67.0,
                        334.0,
                        105.0,
                        334.0,
                        112.0,
                        412.0,
                        112.0,
                        412.0,
                        150.0,
                        412.0,
                        112.0,
                        314.0,
                        112.0,
                        314.0,
                        150.0,
                        314.0,
                        112.0,
                        307.0,
                        112.0,
                        307.0,
                        150.0,
                        307.0,
                        157.0,
                        258.0,
                        157.0,
                        258.0,
                        195.0,
                        258.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        277.0,
                        277.0,
                        277.0,
                        315.0,
                        277.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        427.0,
                        315.0
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
                    ],
                    "midpoints": [
                        180.5,
                        22.0,
                        322.0,
                        22.0,
                        322.0,
                        62.0,
                        322.0,
                        22.0,
                        247.0,
                        22.0,
                        247.0,
                        62.0,
                        247.0,
                        22.0,
                        277.0,
                        22.0,
                        277.0,
                        62.0,
                        277.0,
                        67.0,
                        334.0,
                        67.0,
                        334.0,
                        105.0,
                        334.0,
                        112.0,
                        247.0,
                        112.0,
                        247.0,
                        150.0,
                        322.0,
                        150.0
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
                    ],
                    "midpoints": [
                        349.0,
                        296.0,
                        453.0,
                        296.0
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
                    ],
                    "midpoints": [
                        440.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        277.0,
                        277.0,
                        277.0,
                        315.0,
                        190.5,
                        315.0
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
                    ],
                    "midpoints": [
                        172.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        412.0,
                        277.0,
                        412.0,
                        315.0,
                        412.0,
                        277.0,
                        472.0,
                        277.0,
                        472.0,
                        315.0,
                        614.5,
                        315.0
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
                    ],
                    "midpoints": [
                        648.5,
                        281.0,
                        614.5,
                        281.0
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
                    ],
                    "midpoints": [
                        670.5,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        202.0,
                        637.0,
                        202.0,
                        637.0,
                        240.0,
                        637.0,
                        247.0,
                        592.0,
                        247.0,
                        592.0,
                        285.0,
                        614.5,
                        285.0
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
                    ],
                    "midpoints": [
                        200.0,
                        247.0,
                        592.0,
                        247.0,
                        592.0,
                        285.0,
                        592.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        412.0,
                        277.0,
                        412.0,
                        315.0,
                        412.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        224.0,
                        277.0,
                        472.0,
                        277.0,
                        472.0,
                        315.0,
                        614.5,
                        315.0
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
                    ],
                    "midpoints": [
                        280.5,
                        112.0,
                        412.0,
                        112.0,
                        412.0,
                        150.0,
                        412.0,
                        112.0,
                        410.0,
                        112.0,
                        410.0,
                        150.0,
                        410.0,
                        247.0,
                        592.0,
                        247.0,
                        592.0,
                        285.0,
                        592.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        472.0,
                        277.0,
                        472.0,
                        315.0,
                        614.5,
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
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        547.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        472.0,
                        277.0,
                        472.0,
                        315.0,
                        349.0,
                        315.0
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
                    ],
                    "midpoints": [
                        682.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        472.0,
                        277.0,
                        472.0,
                        315.0,
                        247.0,
                        315.0
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
                    ],
                    "midpoints": [
                        614.5,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        412.0,
                        277.0,
                        412.0,
                        315.0,
                        412.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        224.0,
                        277.0,
                        472.0,
                        277.0,
                        472.0,
                        315.0,
                        114.5,
                        315.0
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
                    ],
                    "midpoints": [
                        82.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        224.0,
                        277.0,
                        532.0,
                        277.0,
                        532.0,
                        315.0,
                        532.0,
                        277.0,
                        472.0,
                        277.0,
                        472.0,
                        315.0,
                        472.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        805.5,
                        315.0
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
                    ],
                    "midpoints": [
                        103.66666666666667,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        412.0,
                        277.0,
                        412.0,
                        315.0,
                        412.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        224.0,
                        277.0,
                        532.0,
                        277.0,
                        532.0,
                        315.0,
                        532.0,
                        277.0,
                        472.0,
                        277.0,
                        472.0,
                        315.0,
                        730.5,
                        315.0
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
                    ],
                    "midpoints": [
                        125.33333333333334,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        277.0,
                        277.0,
                        277.0,
                        315.0,
                        277.0,
                        277.0,
                        412.0,
                        277.0,
                        412.0,
                        315.0,
                        412.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        525.0,
                        315.0
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
                    ],
                    "midpoints": [
                        506.0,
                        277.0,
                        832.0,
                        277.0,
                        832.0,
                        323.0,
                        832.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        697.0,
                        277.0,
                        772.0,
                        277.0,
                        772.0,
                        315.0,
                        772.0,
                        277.0,
                        764.0,
                        277.0,
                        764.0,
                        315.0,
                        764.0,
                        277.0,
                        877.0,
                        277.0,
                        877.0,
                        315.0,
                        877.0,
                        277.0,
                        937.0,
                        277.0,
                        937.0,
                        393.0,
                        970.5,
                        393.0
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
                    ],
                    "midpoints": [
                        943.0,
                        312.0,
                        943.0,
                        277.0,
                        847.0,
                        277.0
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
                    ],
                    "midpoints": [
                        967.0,
                        312.0,
                        967.0,
                        277.0,
                        952.5,
                        277.0
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
                    ],
                    "midpoints": [
                        112.0,
                        112.0,
                        412.0,
                        112.0,
                        412.0,
                        150.0,
                        412.0,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        637.0,
                        112.0,
                        697.0,
                        112.0,
                        697.0,
                        150.0,
                        697.0,
                        112.0,
                        802.0,
                        112.0,
                        802.0,
                        150.0,
                        802.0,
                        112.0,
                        847.0,
                        112.0,
                        847.0,
                        150.0,
                        847.0,
                        112.0,
                        314.0,
                        112.0,
                        314.0,
                        150.0,
                        314.0,
                        112.0,
                        410.0,
                        112.0,
                        410.0,
                        150.0,
                        410.0,
                        157.0,
                        727.0,
                        157.0,
                        727.0,
                        195.0,
                        727.0,
                        157.0,
                        258.0,
                        157.0,
                        258.0,
                        195.0,
                        258.0,
                        202.0,
                        637.0,
                        202.0,
                        637.0,
                        240.0,
                        637.0,
                        247.0,
                        592.0,
                        247.0,
                        592.0,
                        285.0,
                        592.0,
                        277.0,
                        832.0,
                        277.0,
                        832.0,
                        323.0,
                        832.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        224.0,
                        277.0,
                        532.0,
                        277.0,
                        532.0,
                        315.0,
                        532.0,
                        277.0,
                        162.0,
                        277.0,
                        162.0,
                        315.0,
                        162.0,
                        277.0,
                        540.0,
                        277.0,
                        540.0,
                        315.0,
                        540.0,
                        277.0,
                        772.0,
                        277.0,
                        772.0,
                        315.0,
                        772.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        929.0,
                        315.0
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
                    ],
                    "midpoints": [
                        830.0,
                        112.0,
                        903.0,
                        112.0,
                        903.0,
                        150.0,
                        903.0,
                        202.0,
                        830.0,
                        202.0,
                        830.0,
                        240.0,
                        830.0,
                        277.0,
                        878.0,
                        277.0,
                        878.0,
                        323.0,
                        878.0,
                        277.0,
                        839.0,
                        277.0,
                        839.0,
                        315.0,
                        929.0,
                        315.0
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
                    ],
                    "midpoints": [
                        149.8,
                        67.0,
                        382.0,
                        67.0,
                        382.0,
                        105.0,
                        382.0,
                        112.0,
                        412.0,
                        112.0,
                        412.0,
                        150.0,
                        412.0,
                        112.0,
                        314.0,
                        112.0,
                        314.0,
                        150.0,
                        314.0,
                        112.0,
                        307.0,
                        112.0,
                        307.0,
                        150.0,
                        307.0,
                        157.0,
                        258.0,
                        157.0,
                        258.0,
                        195.0,
                        258.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        277.0,
                        277.0,
                        277.0,
                        315.0,
                        277.0,
                        277.0,
                        412.0,
                        277.0,
                        412.0,
                        315.0,
                        412.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        224.0,
                        277.0,
                        162.0,
                        277.0,
                        162.0,
                        315.0,
                        487.0,
                        315.0
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
                    ],
                    "midpoints": [
                        875.0,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        704.0,
                        112.0,
                        704.0,
                        150.0,
                        704.0,
                        112.0,
                        697.0,
                        112.0,
                        697.0,
                        150.0,
                        697.0,
                        112.0,
                        802.0,
                        112.0,
                        802.0,
                        150.0,
                        802.0,
                        157.0,
                        727.0,
                        157.0,
                        727.0,
                        195.0,
                        727.0,
                        202.0,
                        637.0,
                        202.0,
                        637.0,
                        240.0,
                        637.0,
                        247.0,
                        705.0,
                        247.0,
                        705.0,
                        285.0,
                        705.0,
                        277.0,
                        832.0,
                        277.0,
                        832.0,
                        323.0,
                        832.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        697.0,
                        277.0,
                        772.0,
                        277.0,
                        772.0,
                        315.0,
                        772.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        487.0,
                        315.0
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
                    ],
                    "midpoints": [
                        372.0,
                        22.0,
                        485.0,
                        22.0,
                        485.0,
                        60.0,
                        485.0,
                        67.0,
                        491.0,
                        67.0,
                        491.0,
                        105.0,
                        491.0,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        637.0,
                        112.0,
                        697.0,
                        112.0,
                        697.0,
                        150.0,
                        697.0,
                        112.0,
                        802.0,
                        112.0,
                        802.0,
                        150.0,
                        802.0,
                        112.0,
                        410.0,
                        112.0,
                        410.0,
                        150.0,
                        410.0,
                        157.0,
                        727.0,
                        157.0,
                        727.0,
                        195.0,
                        727.0,
                        202.0,
                        637.0,
                        202.0,
                        637.0,
                        240.0,
                        637.0,
                        247.0,
                        592.0,
                        247.0,
                        592.0,
                        285.0,
                        592.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        532.0,
                        277.0,
                        532.0,
                        315.0,
                        532.0,
                        277.0,
                        540.0,
                        277.0,
                        540.0,
                        315.0,
                        540.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        805.5,
                        315.0
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
                    ],
                    "midpoints": [
                        342.0,
                        22.0,
                        485.0,
                        22.0,
                        485.0,
                        60.0,
                        485.0,
                        22.0,
                        392.0,
                        22.0,
                        392.0,
                        62.0,
                        392.0,
                        67.0,
                        491.0,
                        67.0,
                        491.0,
                        105.0,
                        491.0,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        637.0,
                        112.0,
                        697.0,
                        112.0,
                        697.0,
                        150.0,
                        697.0,
                        112.0,
                        410.0,
                        112.0,
                        410.0,
                        150.0,
                        410.0,
                        157.0,
                        727.0,
                        157.0,
                        727.0,
                        195.0,
                        727.0,
                        202.0,
                        637.0,
                        202.0,
                        637.0,
                        240.0,
                        637.0,
                        247.0,
                        592.0,
                        247.0,
                        592.0,
                        285.0,
                        592.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        532.0,
                        277.0,
                        532.0,
                        315.0,
                        532.0,
                        277.0,
                        540.0,
                        277.0,
                        540.0,
                        315.0,
                        730.5,
                        315.0
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
                    ],
                    "midpoints": [
                        267.0,
                        22.0,
                        485.0,
                        22.0,
                        485.0,
                        60.0,
                        485.0,
                        22.0,
                        362.0,
                        22.0,
                        362.0,
                        62.0,
                        362.0,
                        22.0,
                        392.0,
                        22.0,
                        392.0,
                        62.0,
                        392.0,
                        22.0,
                        317.0,
                        22.0,
                        317.0,
                        62.0,
                        317.0,
                        67.0,
                        491.0,
                        67.0,
                        491.0,
                        105.0,
                        491.0,
                        67.0,
                        334.0,
                        67.0,
                        334.0,
                        105.0,
                        334.0,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        637.0,
                        112.0,
                        697.0,
                        112.0,
                        697.0,
                        150.0,
                        697.0,
                        112.0,
                        802.0,
                        112.0,
                        802.0,
                        150.0,
                        802.0,
                        112.0,
                        847.0,
                        112.0,
                        847.0,
                        150.0,
                        847.0,
                        112.0,
                        314.0,
                        112.0,
                        314.0,
                        150.0,
                        314.0,
                        112.0,
                        410.0,
                        112.0,
                        410.0,
                        150.0,
                        410.0,
                        157.0,
                        727.0,
                        157.0,
                        727.0,
                        195.0,
                        727.0,
                        202.0,
                        637.0,
                        202.0,
                        637.0,
                        240.0,
                        637.0,
                        247.0,
                        592.0,
                        247.0,
                        592.0,
                        285.0,
                        592.0,
                        277.0,
                        832.0,
                        277.0,
                        832.0,
                        323.0,
                        832.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        697.0,
                        277.0,
                        540.0,
                        277.0,
                        540.0,
                        315.0,
                        540.0,
                        277.0,
                        772.0,
                        277.0,
                        772.0,
                        315.0,
                        772.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        697.0,
                        277.0,
                        877.0,
                        277.0,
                        877.0,
                        315.0,
                        877.0,
                        277.0,
                        937.0,
                        277.0,
                        937.0,
                        393.0,
                        970.5,
                        393.0
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
                    ],
                    "midpoints": [
                        87.0,
                        22.0,
                        397.0,
                        22.0,
                        397.0,
                        60.0,
                        397.0,
                        22.0,
                        249.0,
                        22.0,
                        249.0,
                        60.0,
                        249.0,
                        22.0,
                        322.0,
                        22.0,
                        322.0,
                        62.0,
                        322.0,
                        22.0,
                        352.0,
                        22.0,
                        352.0,
                        62.0,
                        352.0,
                        22.0,
                        287.0,
                        22.0,
                        287.0,
                        62.0,
                        287.0,
                        22.0,
                        277.0,
                        22.0,
                        277.0,
                        62.0,
                        277.0,
                        67.0,
                        382.0,
                        67.0,
                        382.0,
                        105.0,
                        382.0,
                        67.0,
                        334.0,
                        67.0,
                        334.0,
                        105.0,
                        334.0,
                        112.0,
                        412.0,
                        112.0,
                        412.0,
                        150.0,
                        412.0,
                        112.0,
                        142.0,
                        112.0,
                        142.0,
                        150.0,
                        142.0,
                        112.0,
                        314.0,
                        112.0,
                        314.0,
                        150.0,
                        314.0,
                        112.0,
                        307.0,
                        112.0,
                        307.0,
                        150.0,
                        307.0,
                        157.0,
                        258.0,
                        157.0,
                        258.0,
                        195.0,
                        258.0,
                        277.0,
                        278.0,
                        277.0,
                        278.0,
                        323.0,
                        278.0,
                        277.0,
                        277.0,
                        277.0,
                        277.0,
                        315.0,
                        277.0,
                        277.0,
                        412.0,
                        277.0,
                        412.0,
                        315.0,
                        412.0,
                        277.0,
                        224.0,
                        277.0,
                        224.0,
                        315.0,
                        224.0,
                        277.0,
                        162.0,
                        277.0,
                        162.0,
                        315.0,
                        487.0,
                        315.0
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
                    ],
                    "midpoints": [
                        297.0,
                        22.0,
                        485.0,
                        22.0,
                        485.0,
                        60.0,
                        485.0,
                        22.0,
                        362.0,
                        22.0,
                        362.0,
                        62.0,
                        362.0,
                        22.0,
                        392.0,
                        22.0,
                        392.0,
                        62.0,
                        392.0,
                        67.0,
                        491.0,
                        67.0,
                        491.0,
                        105.0,
                        491.0,
                        67.0,
                        334.0,
                        67.0,
                        334.0,
                        105.0,
                        334.0,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        637.0,
                        112.0,
                        637.0,
                        150.0,
                        637.0,
                        112.0,
                        697.0,
                        112.0,
                        697.0,
                        150.0,
                        697.0,
                        112.0,
                        802.0,
                        112.0,
                        802.0,
                        150.0,
                        802.0,
                        112.0,
                        847.0,
                        112.0,
                        847.0,
                        150.0,
                        847.0,
                        112.0,
                        314.0,
                        112.0,
                        314.0,
                        150.0,
                        314.0,
                        112.0,
                        410.0,
                        112.0,
                        410.0,
                        150.0,
                        410.0,
                        157.0,
                        727.0,
                        157.0,
                        727.0,
                        195.0,
                        727.0,
                        202.0,
                        637.0,
                        202.0,
                        637.0,
                        240.0,
                        637.0,
                        247.0,
                        592.0,
                        247.0,
                        592.0,
                        285.0,
                        592.0,
                        277.0,
                        832.0,
                        277.0,
                        832.0,
                        323.0,
                        832.0,
                        277.0,
                        421.0,
                        277.0,
                        421.0,
                        315.0,
                        421.0,
                        277.0,
                        468.0,
                        277.0,
                        468.0,
                        315.0,
                        468.0,
                        277.0,
                        532.0,
                        277.0,
                        532.0,
                        315.0,
                        532.0,
                        277.0,
                        540.0,
                        277.0,
                        540.0,
                        315.0,
                        540.0,
                        277.0,
                        772.0,
                        277.0,
                        772.0,
                        315.0,
                        772.0,
                        277.0,
                        697.0,
                        277.0,
                        697.0,
                        315.0,
                        929.0,
                        315.0
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
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        787.0,
                        277.0,
                        878.0,
                        277.0,
                        878.0,
                        323.0,
                        878.0,
                        277.0,
                        937.0,
                        277.0,
                        937.0,
                        315.0,
                        937.0,
                        277.0,
                        944.0,
                        277.0,
                        944.0,
                        315.0,
                        944.0,
                        277.0,
                        937.0,
                        277.0,
                        937.0,
                        393.0,
                        1049.0,
                        393.0
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
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        712.0,
                        277.0,
                        878.0,
                        277.0,
                        878.0,
                        323.0,
                        878.0,
                        277.0,
                        839.0,
                        277.0,
                        839.0,
                        315.0,
                        839.0,
                        277.0,
                        937.0,
                        277.0,
                        937.0,
                        315.0,
                        937.0,
                        277.0,
                        877.0,
                        277.0,
                        877.0,
                        315.0,
                        877.0,
                        277.0,
                        937.0,
                        277.0,
                        937.0,
                        393.0,
                        1049.0,
                        393.0
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
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        1085.0,
                        312.0,
                        1085.0,
                        277.0,
                        1049.0,
                        277.0
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
                        "obj-55",
                        0
                    ],
                    "midpoints": [
                        1223.0,
                        312.0,
                        1223.0,
                        277.0,
                        1102.0,
                        277.0
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
                        "obj-55",
                        1
                    ],
                    "midpoints": [
                        824.0,
                        277.0,
                        878.0,
                        277.0,
                        878.0,
                        323.0,
                        878.0,
                        277.0,
                        1004.0,
                        277.0,
                        1004.0,
                        315.0,
                        1004.0,
                        277.0,
                        944.0,
                        277.0,
                        944.0,
                        315.0,
                        944.0,
                        277.0,
                        968.0,
                        277.0,
                        968.0,
                        393.0,
                        968.0,
                        277.0,
                        1012.0,
                        277.0,
                        1012.0,
                        315.0,
                        1209.0,
                        315.0
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
                        "obj-55",
                        1
                    ],
                    "midpoints": [
                        749.0,
                        277.0,
                        878.0,
                        277.0,
                        878.0,
                        323.0,
                        878.0,
                        277.0,
                        839.0,
                        277.0,
                        839.0,
                        315.0,
                        839.0,
                        277.0,
                        1004.0,
                        277.0,
                        1004.0,
                        315.0,
                        1004.0,
                        277.0,
                        944.0,
                        277.0,
                        944.0,
                        315.0,
                        944.0,
                        277.0,
                        968.0,
                        277.0,
                        968.0,
                        393.0,
                        968.0,
                        277.0,
                        1012.0,
                        277.0,
                        1012.0,
                        315.0,
                        1209.0,
                        315.0
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
                        "obj-55",
                        1
                    ],
                    "midpoints": [
                        989.0,
                        277.0,
                        1086.0,
                        277.0,
                        1086.0,
                        315.0,
                        1209.0,
                        315.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        1155.5,
                        277.0,
                        1004.0,
                        277.0,
                        1004.0,
                        315.0,
                        1004.0,
                        277.0,
                        968.0,
                        277.0,
                        968.0,
                        393.0,
                        968.0,
                        277.0,
                        1012.0,
                        277.0,
                        1012.0,
                        315.0,
                        892.0,
                        315.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}