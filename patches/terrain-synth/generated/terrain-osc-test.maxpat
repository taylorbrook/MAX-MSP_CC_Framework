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
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        15,
                        520,
                        24.0
                    ],
                    "text": "terrain-osc CPU test  --  slice 2 (poly~ @up oversampling load test)",
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ],
                    "bgcolor": [
                        0.88,
                        0.9,
                        0.95,
                        1.0
                    ]
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
                        895.0,
                        15,
                        58.0,
                        20.0
                    ],
                    "text": "v0.2.0",
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
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        48,
                        760,
                        48
                    ],
                    "text": "Turn audio on. 1) terrain fills at load (perlin noise, 256x256 float32 named 'terrain'). 2) set voices / oversampling, re-enter freq after changing voices (new instances need target 0 + freq). 3) read CPU % (adstatus cpu, 250 ms). Protocol + results table: test-results/terrain-osc-cpu-test.md",
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
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        108,
                        780.0,
                        20.0
                    ],
                    "text": "1. terrain source -> jit.matrix terrain 1 float32 256 256 (basis noise.gradient; scale = feature size). jit.3m readouts under jit.expr: min / mean / max of the raw terrain",
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
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        15,
                        132,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.02",
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
                        140,
                        132,
                        87.5,
                        22.0
                    ],
                    "text": "loadmess 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        158,
                        90,
                        20.0
                    ],
                    "text": "noise scale",
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
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        140,
                        158,
                        50,
                        20.0
                    ],
                    "text": "seed",
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
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        240,
                        158,
                        50,
                        20.0
                    ],
                    "text": "regen",
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
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        15,
                        180,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        140,
                        180,
                        50,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "button",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        240,
                        180,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        15,
                        212,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        140,
                        212,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b i",
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
                        15,
                        244,
                        114.0,
                        22.0
                    ],
                    "text": "scale $1 $1 1.",
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
                        140,
                        244,
                        65.0,
                        22.0
                    ],
                    "text": "seed $1",
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
                        15,
                        280,
                        300.0,
                        22.0
                    ],
                    "text": "jit.bfg 1 float32 256 256 @basis noise.gradient",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        15,
                        314,
                        268.0,
                        22.0
                    ],
                    "text": "jit.matrix terrain 1 float32 256 256",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        212.0,
                        120.0,
                        120.0
                    ],
                    "text": "jit.pwindow",
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
                        15,
                        400.0,
                        520,
                        20.0
                    ],
                    "text": "2. poly~ terrain-osc-core  (voices x oversampling) -> gain~ / scope~ / spectroscope~",
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
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        15,
                        424.0,
                        107.0,
                        22.0
                    ],
                    "text": "loadmess 110.",
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
                        ""
                    ],
                    "patching_rect": [
                        200,
                        424.0,
                        92.0,
                        22.0
                    ],
                    "text": "loadmess set 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        300,
                        424.0,
                        92.0,
                        22.0
                    ],
                    "text": "loadmess set 1",
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
                        15,
                        450.0,
                        70,
                        20.0
                    ],
                    "text": "freq Hz",
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
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        200,
                        450.0,
                        60,
                        20.0
                    ],
                    "text": "voices",
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
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        300,
                        450.0,
                        90,
                        20.0
                    ],
                    "text": "oversample",
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
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        15,
                        472.0,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
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
                        200,
                        472.0,
                        50,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        300,
                        472.0,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "items": [
                        "1x",
                        ",",
                        "2x",
                        ",",
                        "4x"
                    ]
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
                        15,
                        504.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f b",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        120,
                        504.0,
                        72.0,
                        22.0
                    ],
                    "text": "target 0",
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
                        200,
                        504.0,
                        79.0,
                        22.0
                    ],
                    "text": "voices $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        300,
                        504.0,
                        100.0,
                        22.0
                    ],
                    "text": "select 0 1 2",
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
                        300,
                        536.0,
                        44.0,
                        22.0
                    ],
                    "text": "up 1",
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
                        355,
                        536.0,
                        44.0,
                        22.0
                    ],
                    "text": "up 2",
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
                        410,
                        536.0,
                        44.0,
                        22.0
                    ],
                    "text": "up 4",
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
                        100.0,
                        544.0,
                        184.0,
                        22.0
                    ],
                    "text": "receive tosc-test-params",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-38",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        605.0,
                        219.0,
                        22.0
                    ],
                    "text": "poly~ terrain-osc-core 1 up 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-39",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        244.0,
                        605.0,
                        420,
                        20.0
                    ],
                    "text": "in 1: freq (after target 0) | in 2: params | messages: voices N, up N",
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
                    "maxclass": "gain~",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        15.0,
                        640.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        42.0,
                        640.0,
                        15.0,
                        140.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "scope~",
                    "id": "obj-42",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        80.0,
                        640.0,
                        140.0,
                        140.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "spectroscope~",
                    "id": "obj-43",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        235.0,
                        640.0,
                        220.0,
                        140.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-44",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        795.0,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0,
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
                    "maxclass": "comment",
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        235,
                        790.0,
                        340,
                        20.0
                    ],
                    "text": "spectroscope~: aliasing check at high pitch / wide orbit",
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
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        830.0,
                        560,
                        200,
                        20.0
                    ],
                    "text": "CPU % (adstatus cpu, 250 ms)",
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
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        584,
                        87.5,
                        22.0
                    ],
                    "text": "loadmess 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        830.0,
                        612,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
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
                        830.0,
                        644,
                        79.0,
                        22.0
                    ],
                    "text": "metro 250",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-50",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        676,
                        107.0,
                        22.0
                    ],
                    "text": "adstatus cpu",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        830.0,
                        108,
                        560,
                        20.0
                    ],
                    "text": "3. orbit / shaper params -> send tosc-test-params -> poly~ in 2 (target 0 = all voices)",
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
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        830.0,
                        470,
                        163.0,
                        22.0
                    ],
                    "text": "send tosc-test-params",
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
                        830.0,
                        132,
                        120,
                        20.0
                    ],
                    "text": "shape",
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
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        154,
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
                    "maxclass": "umenu",
                    "id": "obj-56",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        182,
                        105,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "items": [
                        "ellipse",
                        ",",
                        "epitrochoid",
                        ",",
                        "squarcle"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-57",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        212,
                        107.0,
                        22.0
                    ],
                    "text": "prepend shape",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        960.0,
                        132,
                        120,
                        20.0
                    ],
                    "text": "rx 0-0.5",
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
                    "id": "obj-59",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        960.0,
                        154,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-60",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        960.0,
                        182,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-61",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        960.0,
                        212,
                        97.0,
                        22.0
                    ],
                    "text": "prepend rx",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        1090.0,
                        132,
                        120,
                        20.0
                    ],
                    "text": "ry 0-0.5",
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
                    "id": "obj-63",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        154,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-64",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        182,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-65",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        212,
                        97.0,
                        22.0
                    ],
                    "text": "prepend ry",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-66",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1220.0,
                        132,
                        120,
                        20.0
                    ],
                    "text": "rot turns 0-1",
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
                    "id": "obj-67",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1220.0,
                        154,
                        93.0,
                        22.0
                    ],
                    "text": "loadmess 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-68",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1220.0,
                        182,
                        70,
                        22.0
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
                        ""
                    ],
                    "patching_rect": [
                        1220.0,
                        212,
                        97.0,
                        22.0
                    ],
                    "text": "prepend rot",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-70",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        830.0,
                        242,
                        120,
                        20.0
                    ],
                    "text": "cx 0-1",
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
                    "id": "obj-71",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        264,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-72",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        292,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
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
                        830.0,
                        322,
                        97.0,
                        22.0
                    ],
                    "text": "prepend cx",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-74",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        960.0,
                        242,
                        120,
                        20.0
                    ],
                    "text": "cy 0-1",
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
                    "id": "obj-75",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        960.0,
                        264,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-76",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        960.0,
                        292,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
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
                        960.0,
                        322,
                        97.0,
                        22.0
                    ],
                    "text": "prepend cy",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-78",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1090.0,
                        242,
                        120,
                        20.0
                    ],
                    "text": "lobes 1-16",
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
                    "id": "obj-79",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        264,
                        87.5,
                        22.0
                    ],
                    "text": "loadmess 3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-80",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        292,
                        50,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-81",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        322,
                        107.0,
                        22.0
                    ],
                    "text": "prepend lobes",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-82",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1220.0,
                        242,
                        120,
                        20.0
                    ],
                    "text": "lobeamt 0-1",
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
                    "id": "obj-83",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1220.0,
                        264,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.4",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-84",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1220.0,
                        292,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-85",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1220.0,
                        322,
                        121.0,
                        22.0
                    ],
                    "text": "prepend lobeamt",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-86",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        830.0,
                        352,
                        120,
                        20.0
                    ],
                    "text": "zoomk Hz",
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
                    "id": "obj-87",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        374,
                        114.0,
                        22.0
                    ],
                    "text": "loadmess 4000.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-88",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        402,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-89",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        432,
                        107.0,
                        22.0
                    ],
                    "text": "prepend zoomk",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-90",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        960.0,
                        352,
                        120,
                        20.0
                    ],
                    "text": "zoomlo 0.01-1",
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
                    "id": "obj-91",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        960.0,
                        374,
                        107.0,
                        22.0
                    ],
                    "text": "loadmess 0.05",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-92",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        960.0,
                        402,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
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
                        960.0,
                        432,
                        114.0,
                        22.0
                    ],
                    "text": "prepend zoomlo",
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
                        1090.0,
                        352,
                        120,
                        20.0
                    ],
                    "text": "drive 0.1-10",
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
                    "id": "obj-95",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        374,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 1.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-96",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        402,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
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
                        1090.0,
                        432,
                        107.0,
                        22.0
                    ],
                    "text": "prepend drive",
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
                        15,
                        574.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 100",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-99",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        830.0,
                        708,
                        60,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-100",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        125.0,
                        573.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger l b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-101",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        15.0,
                        348.0,
                        212.0,
                        22.0
                    ],
                    "text": "jit.expr @expr in[0]*0.5+0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-102",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        970,
                        560,
                        380.0,
                        20.0
                    ],
                    "text": "orbit x (0-1, must jitter; frozen = freq never reached the instance)",
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
                    "id": "obj-103",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        970,
                        584,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-104",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        970,
                        614,
                        70,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-105",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        344.0,
                        62.25,
                        22.0
                    ],
                    "text": "jit.3m",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-106",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        250,
                        372,
                        60,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-107",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        315,
                        372,
                        60,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-108",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        380,
                        372,
                        60,
                        22.0
                    ],
                    "parameter_enable": 0
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
                        330,
                        108,
                        480.0,
                        20.0
                    ],
                    "text": "fallback: analytic terrain into the same matrix (click) -- bypasses jit.bfg entirely",
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
                    "maxclass": "message",
                    "id": "obj-110",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330,
                        132,
                        408.0,
                        22.0
                    ],
                    "text": "exprfill 0 sin(snorm[0]*PI*3.)*cos(snorm[1]*PI*3.), bang",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-111",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        250,
                        344,
                        93.0,
                        22.0
                    ],
                    "text": "trigger l l",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-5",
                        0
                    ],
                    "destination": [
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        65.0,
                        150.0,
                        7.0,
                        150.0,
                        7.0,
                        186.0,
                        50.0,
                        186.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        183.75,
                        150.0,
                        198.0,
                        150.0,
                        198.0,
                        186.0,
                        165.0,
                        186.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        22.0,
                        207.0,
                        61.5,
                        207.0
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
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        147.0,
                        207.0,
                        186.5,
                        207.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-13",
                        1
                    ],
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        101.0,
                        239.0,
                        22.0,
                        239.0
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
                        22.0,
                        204.0,
                        132.0,
                        204.0,
                        132.0,
                        242.0,
                        132.0,
                        236.0,
                        137.0,
                        236.0,
                        137.0,
                        274.0,
                        137.0,
                        236.0,
                        132.0,
                        236.0,
                        132.0,
                        274.0,
                        165.0,
                        274.0
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
                        226.0,
                        239.0,
                        147.0,
                        239.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        147.0,
                        236.0,
                        132.0,
                        236.0,
                        132.0,
                        274.0,
                        165.0,
                        274.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        72.0,
                        236.0,
                        132.0,
                        236.0,
                        132.0,
                        274.0,
                        165.0,
                        274.0
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
                        "obj-12",
                        0
                    ],
                    "destination": [
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        252.0,
                        172.0,
                        198.0,
                        172.0,
                        198.0,
                        210.0,
                        198.0,
                        204.0,
                        241.0,
                        204.0,
                        241.0,
                        242.0,
                        241.0,
                        236.0,
                        213.0,
                        236.0,
                        213.0,
                        274.0,
                        165.0,
                        274.0
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        22.0,
                        308.0,
                        149.0,
                        308.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        68.5,
                        442.0,
                        93.0,
                        442.0,
                        93.0,
                        478.0,
                        50.0,
                        478.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        246.0,
                        442.0,
                        268.0,
                        442.0,
                        268.0,
                        478.0,
                        225.0,
                        478.0
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
                        346.0,
                        442.0,
                        292.0,
                        442.0,
                        292.0,
                        478.0,
                        335.0,
                        478.0
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
                        22.0,
                        499.0,
                        61.5,
                        499.0
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
                    ],
                    "midpoints": [
                        307.0,
                        499.0,
                        350.0,
                        499.0
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
                    ],
                    "midpoints": [
                        873.75,
                        609.0,
                        842.0,
                        609.0
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
                        "obj-49",
                        0
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
                        869.5,
                        671.0,
                        837.0,
                        671.0
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
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        101.0,
                        515.0,
                        127.0,
                        515.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        22.0,
                        566.0,
                        7.0,
                        566.0,
                        7.0,
                        604.0,
                        22.0,
                        604.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        156.0,
                        496.0,
                        116.0,
                        496.0,
                        116.0,
                        534.0,
                        116.0,
                        536.0,
                        92.0,
                        536.0,
                        92.0,
                        574.0,
                        92.0,
                        565.0,
                        117.0,
                        565.0,
                        117.0,
                        603.0,
                        117.0,
                        566.0,
                        123.0,
                        566.0,
                        123.0,
                        604.0,
                        22.0,
                        604.0
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
                    ],
                    "midpoints": [
                        239.5,
                        496.0,
                        116.0,
                        496.0,
                        116.0,
                        534.0,
                        116.0,
                        496.0,
                        112.0,
                        496.0,
                        112.0,
                        534.0,
                        112.0,
                        536.0,
                        92.0,
                        536.0,
                        92.0,
                        574.0,
                        92.0,
                        565.0,
                        117.0,
                        565.0,
                        117.0,
                        603.0,
                        117.0,
                        566.0,
                        123.0,
                        566.0,
                        123.0,
                        604.0,
                        123.0,
                        597.0,
                        236.0,
                        597.0,
                        236.0,
                        633.0,
                        22.0,
                        633.0
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
                        "obj-33",
                        1
                    ],
                    "destination": [
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        335.6666666666667,
                        528.0,
                        352.0,
                        528.0,
                        352.0,
                        566.0,
                        362.0,
                        566.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-33",
                        2
                    ],
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        364.3333333333333,
                        528.0,
                        407.0,
                        528.0,
                        407.0,
                        566.0,
                        417.0,
                        566.0
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
                    ],
                    "midpoints": [
                        322.0,
                        536.0,
                        92.0,
                        536.0,
                        92.0,
                        574.0,
                        92.0,
                        565.0,
                        226.0,
                        565.0,
                        226.0,
                        603.0,
                        226.0,
                        566.0,
                        123.0,
                        566.0,
                        123.0,
                        604.0,
                        123.0,
                        597.0,
                        236.0,
                        597.0,
                        236.0,
                        633.0,
                        22.0,
                        633.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        377.0,
                        528.0,
                        292.0,
                        528.0,
                        292.0,
                        566.0,
                        292.0,
                        536.0,
                        292.0,
                        536.0,
                        292.0,
                        574.0,
                        292.0,
                        565.0,
                        226.0,
                        565.0,
                        226.0,
                        603.0,
                        226.0,
                        566.0,
                        123.0,
                        566.0,
                        123.0,
                        604.0,
                        123.0,
                        597.0,
                        236.0,
                        597.0,
                        236.0,
                        633.0,
                        22.0,
                        633.0
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
                        432.0,
                        528.0,
                        292.0,
                        528.0,
                        292.0,
                        566.0,
                        292.0,
                        528.0,
                        347.0,
                        528.0,
                        347.0,
                        566.0,
                        347.0,
                        536.0,
                        292.0,
                        536.0,
                        292.0,
                        574.0,
                        292.0,
                        565.0,
                        226.0,
                        565.0,
                        226.0,
                        603.0,
                        226.0,
                        566.0,
                        123.0,
                        566.0,
                        123.0,
                        604.0,
                        123.0,
                        597.0,
                        236.0,
                        597.0,
                        236.0,
                        633.0,
                        22.0,
                        633.0
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
                        "obj-38",
                        0
                    ],
                    "destination": [
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        22.0,
                        632.0,
                        45.0,
                        632.0,
                        45.0,
                        788.0,
                        45.0,
                        632.0,
                        65.0,
                        632.0,
                        65.0,
                        788.0,
                        87.0,
                        788.0
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
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        22.0,
                        597.0,
                        236.0,
                        597.0,
                        236.0,
                        633.0,
                        236.0,
                        632.0,
                        45.0,
                        632.0,
                        45.0,
                        788.0,
                        45.0,
                        632.0,
                        65.0,
                        632.0,
                        65.0,
                        788.0,
                        65.0,
                        632.0,
                        72.0,
                        632.0,
                        72.0,
                        788.0,
                        242.0,
                        788.0
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
                    ],
                    "midpoints": [
                        64.0,
                        785.0,
                        64.0,
                        632.0,
                        49.5,
                        632.0
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
                        "obj-44",
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
                        "obj-44",
                        1
                    ],
                    "midpoints": [
                        22.0,
                        632.0,
                        34.0,
                        632.0,
                        34.0,
                        788.0,
                        53.0,
                        788.0
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
                        "obj-56",
                        0
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
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        837.0,
                        208.0,
                        883.5,
                        208.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        883.5,
                        234.0,
                        958.0,
                        234.0,
                        958.0,
                        270.0,
                        958.0,
                        256.0,
                        938.0,
                        256.0,
                        938.0,
                        294.0,
                        938.0,
                        284.0,
                        908.0,
                        284.0,
                        908.0,
                        322.0,
                        908.0,
                        314.0,
                        935.0,
                        314.0,
                        935.0,
                        352.0,
                        935.0,
                        344.0,
                        958.0,
                        344.0,
                        958.0,
                        380.0,
                        958.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        394.0,
                        908.0,
                        394.0,
                        908.0,
                        432.0,
                        908.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        911.5,
                        462.0
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
                        "obj-60",
                        0
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
                        "obj-61",
                        0
                    ],
                    "midpoints": [
                        967.0,
                        208.0,
                        1008.5,
                        208.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        1008.5,
                        204.0,
                        945.0,
                        204.0,
                        945.0,
                        242.0,
                        945.0,
                        234.0,
                        958.0,
                        234.0,
                        958.0,
                        270.0,
                        958.0,
                        234.0,
                        952.0,
                        234.0,
                        952.0,
                        270.0,
                        952.0,
                        256.0,
                        938.0,
                        256.0,
                        938.0,
                        294.0,
                        938.0,
                        256.0,
                        952.0,
                        256.0,
                        952.0,
                        294.0,
                        952.0,
                        284.0,
                        952.0,
                        284.0,
                        952.0,
                        322.0,
                        952.0,
                        314.0,
                        935.0,
                        314.0,
                        935.0,
                        352.0,
                        935.0,
                        314.0,
                        952.0,
                        314.0,
                        952.0,
                        352.0,
                        952.0,
                        344.0,
                        958.0,
                        344.0,
                        958.0,
                        380.0,
                        958.0,
                        344.0,
                        952.0,
                        344.0,
                        952.0,
                        380.0,
                        952.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        394.0,
                        952.0,
                        394.0,
                        952.0,
                        432.0,
                        952.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        945.0,
                        424.0,
                        952.0,
                        424.0,
                        952.0,
                        462.0,
                        911.5,
                        462.0
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
                        1097.0,
                        208.0,
                        1138.5,
                        208.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        1138.5,
                        204.0,
                        945.0,
                        204.0,
                        945.0,
                        242.0,
                        945.0,
                        204.0,
                        1065.0,
                        204.0,
                        1065.0,
                        242.0,
                        1065.0,
                        234.0,
                        958.0,
                        234.0,
                        958.0,
                        270.0,
                        958.0,
                        234.0,
                        1088.0,
                        234.0,
                        1088.0,
                        270.0,
                        1088.0,
                        234.0,
                        1082.0,
                        234.0,
                        1082.0,
                        270.0,
                        1082.0,
                        256.0,
                        938.0,
                        256.0,
                        938.0,
                        294.0,
                        938.0,
                        256.0,
                        1068.0,
                        256.0,
                        1068.0,
                        294.0,
                        1068.0,
                        256.0,
                        1082.0,
                        256.0,
                        1082.0,
                        294.0,
                        1082.0,
                        284.0,
                        1038.0,
                        284.0,
                        1038.0,
                        322.0,
                        1038.0,
                        284.0,
                        1082.0,
                        284.0,
                        1082.0,
                        322.0,
                        1082.0,
                        314.0,
                        935.0,
                        314.0,
                        935.0,
                        352.0,
                        935.0,
                        314.0,
                        1065.0,
                        314.0,
                        1065.0,
                        352.0,
                        1065.0,
                        314.0,
                        1082.0,
                        314.0,
                        1082.0,
                        352.0,
                        1082.0,
                        344.0,
                        958.0,
                        344.0,
                        958.0,
                        380.0,
                        958.0,
                        344.0,
                        1088.0,
                        344.0,
                        1088.0,
                        380.0,
                        1088.0,
                        344.0,
                        1082.0,
                        344.0,
                        1082.0,
                        380.0,
                        1082.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        366.0,
                        1075.0,
                        366.0,
                        1075.0,
                        404.0,
                        1075.0,
                        366.0,
                        1082.0,
                        366.0,
                        1082.0,
                        404.0,
                        1082.0,
                        394.0,
                        1038.0,
                        394.0,
                        1038.0,
                        432.0,
                        1038.0,
                        394.0,
                        1082.0,
                        394.0,
                        1082.0,
                        432.0,
                        1082.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        945.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        1082.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        911.5,
                        462.0
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
                        1227.0,
                        208.0,
                        1268.5,
                        208.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        1268.5,
                        204.0,
                        945.0,
                        204.0,
                        945.0,
                        242.0,
                        945.0,
                        204.0,
                        1065.0,
                        204.0,
                        1065.0,
                        242.0,
                        1065.0,
                        204.0,
                        1082.0,
                        204.0,
                        1082.0,
                        242.0,
                        1082.0,
                        234.0,
                        958.0,
                        234.0,
                        958.0,
                        270.0,
                        958.0,
                        234.0,
                        1088.0,
                        234.0,
                        1088.0,
                        270.0,
                        1088.0,
                        234.0,
                        1082.0,
                        234.0,
                        1082.0,
                        270.0,
                        1082.0,
                        234.0,
                        1212.0,
                        234.0,
                        1212.0,
                        270.0,
                        1212.0,
                        256.0,
                        938.0,
                        256.0,
                        938.0,
                        294.0,
                        938.0,
                        256.0,
                        1068.0,
                        256.0,
                        1068.0,
                        294.0,
                        1068.0,
                        256.0,
                        1082.0,
                        256.0,
                        1082.0,
                        294.0,
                        1082.0,
                        256.0,
                        1212.0,
                        256.0,
                        1212.0,
                        294.0,
                        1212.0,
                        284.0,
                        1038.0,
                        284.0,
                        1038.0,
                        322.0,
                        1038.0,
                        284.0,
                        1082.0,
                        284.0,
                        1082.0,
                        322.0,
                        1082.0,
                        284.0,
                        1212.0,
                        284.0,
                        1212.0,
                        322.0,
                        1212.0,
                        314.0,
                        935.0,
                        314.0,
                        935.0,
                        352.0,
                        935.0,
                        314.0,
                        1065.0,
                        314.0,
                        1065.0,
                        352.0,
                        1065.0,
                        314.0,
                        1082.0,
                        314.0,
                        1082.0,
                        352.0,
                        1082.0,
                        314.0,
                        1212.0,
                        314.0,
                        1212.0,
                        352.0,
                        1212.0,
                        344.0,
                        958.0,
                        344.0,
                        958.0,
                        380.0,
                        958.0,
                        344.0,
                        1088.0,
                        344.0,
                        1088.0,
                        380.0,
                        1088.0,
                        344.0,
                        1082.0,
                        344.0,
                        1082.0,
                        380.0,
                        1082.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        366.0,
                        1075.0,
                        366.0,
                        1075.0,
                        404.0,
                        1075.0,
                        366.0,
                        1082.0,
                        366.0,
                        1082.0,
                        404.0,
                        1082.0,
                        394.0,
                        1038.0,
                        394.0,
                        1038.0,
                        432.0,
                        1038.0,
                        394.0,
                        1082.0,
                        394.0,
                        1082.0,
                        432.0,
                        1082.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        945.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        1082.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        911.5,
                        462.0
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
                        837.0,
                        318.0,
                        878.5,
                        318.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        878.5,
                        344.0,
                        958.0,
                        344.0,
                        958.0,
                        380.0,
                        958.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        394.0,
                        908.0,
                        394.0,
                        908.0,
                        432.0,
                        908.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        911.5,
                        462.0
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
                        967.0,
                        318.0,
                        1008.5,
                        318.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        1008.5,
                        314.0,
                        935.0,
                        314.0,
                        935.0,
                        352.0,
                        935.0,
                        344.0,
                        958.0,
                        344.0,
                        958.0,
                        380.0,
                        958.0,
                        344.0,
                        952.0,
                        344.0,
                        952.0,
                        380.0,
                        952.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        394.0,
                        952.0,
                        394.0,
                        952.0,
                        432.0,
                        952.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        945.0,
                        424.0,
                        952.0,
                        424.0,
                        952.0,
                        462.0,
                        911.5,
                        462.0
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
                        1097.0,
                        318.0,
                        1143.5,
                        318.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        1143.5,
                        314.0,
                        935.0,
                        314.0,
                        935.0,
                        352.0,
                        935.0,
                        314.0,
                        1065.0,
                        314.0,
                        1065.0,
                        352.0,
                        1065.0,
                        344.0,
                        958.0,
                        344.0,
                        958.0,
                        380.0,
                        958.0,
                        344.0,
                        1088.0,
                        344.0,
                        1088.0,
                        380.0,
                        1088.0,
                        344.0,
                        1082.0,
                        344.0,
                        1082.0,
                        380.0,
                        1082.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        366.0,
                        1075.0,
                        366.0,
                        1075.0,
                        404.0,
                        1075.0,
                        366.0,
                        1082.0,
                        366.0,
                        1082.0,
                        404.0,
                        1082.0,
                        394.0,
                        1038.0,
                        394.0,
                        1038.0,
                        432.0,
                        1038.0,
                        394.0,
                        1082.0,
                        394.0,
                        1082.0,
                        432.0,
                        1082.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        945.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        1082.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        911.5,
                        462.0
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
                        "obj-84",
                        0
                    ],
                    "destination": [
                        "obj-85",
                        0
                    ],
                    "midpoints": [
                        1227.0,
                        318.0,
                        1280.5,
                        318.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        1280.5,
                        314.0,
                        935.0,
                        314.0,
                        935.0,
                        352.0,
                        935.0,
                        314.0,
                        1065.0,
                        314.0,
                        1065.0,
                        352.0,
                        1065.0,
                        314.0,
                        1082.0,
                        314.0,
                        1082.0,
                        352.0,
                        1082.0,
                        344.0,
                        958.0,
                        344.0,
                        958.0,
                        380.0,
                        958.0,
                        344.0,
                        1088.0,
                        344.0,
                        1088.0,
                        380.0,
                        1088.0,
                        344.0,
                        1082.0,
                        344.0,
                        1082.0,
                        380.0,
                        1082.0,
                        366.0,
                        952.0,
                        366.0,
                        952.0,
                        404.0,
                        952.0,
                        366.0,
                        1075.0,
                        366.0,
                        1075.0,
                        404.0,
                        1075.0,
                        366.0,
                        1082.0,
                        366.0,
                        1082.0,
                        404.0,
                        1082.0,
                        394.0,
                        1038.0,
                        394.0,
                        1038.0,
                        432.0,
                        1038.0,
                        394.0,
                        1082.0,
                        394.0,
                        1082.0,
                        432.0,
                        1082.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        945.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        1082.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        911.5,
                        462.0
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
                        "obj-88",
                        0
                    ],
                    "midpoints": [
                        887.0,
                        399.0,
                        865.0,
                        399.0
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
                        "obj-89",
                        0
                    ],
                    "midpoints": [
                        837.0,
                        428.0,
                        883.5,
                        428.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-89",
                        0
                    ],
                    "destination": [
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        883.5,
                        462.0,
                        911.5,
                        462.0
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
                        "obj-92",
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
                        "obj-93",
                        0
                    ],
                    "midpoints": [
                        967.0,
                        428.0,
                        1017.0,
                        428.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        1017.0,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        911.5,
                        462.0
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
                        "obj-96",
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
                        "obj-97",
                        0
                    ],
                    "midpoints": [
                        1097.0,
                        428.0,
                        1143.5,
                        428.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        1143.5,
                        424.0,
                        945.0,
                        424.0,
                        945.0,
                        462.0,
                        945.0,
                        424.0,
                        1082.0,
                        424.0,
                        1082.0,
                        462.0,
                        911.5,
                        462.0
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
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        65.0,
                        597.0,
                        7.0,
                        597.0,
                        7.0,
                        635.0,
                        7.0,
                        632.0,
                        34.0,
                        632.0,
                        34.0,
                        788.0,
                        26.0,
                        788.0
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
                        "obj-99",
                        0
                    ],
                    "midpoints": [
                        837.0,
                        703.0,
                        860.0,
                        703.0
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
                        "obj-100",
                        0
                    ],
                    "midpoints": [
                        192.0,
                        569.5,
                        171.5,
                        569.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-100",
                        1
                    ],
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        1428.0,
                        600.0,
                        1428.0,
                        496.0,
                        127.0,
                        496.0
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
                        "obj-38",
                        1
                    ],
                    "midpoints": [
                        132.0,
                        600.0,
                        227.0,
                        600.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        1420.0,
                        375.0,
                        1420.0,
                        204.0,
                        390.0,
                        204.0
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
                        "obj-103",
                        0
                    ],
                    "midpoints": [
                        227.0,
                        552.0,
                        822.0,
                        552.0,
                        822.0,
                        588.0,
                        822.0,
                        552.0,
                        962.0,
                        552.0,
                        962.0,
                        588.0,
                        962.0,
                        565.0,
                        226.0,
                        565.0,
                        226.0,
                        603.0,
                        226.0,
                        576.0,
                        822.0,
                        576.0,
                        822.0,
                        614.0,
                        822.0,
                        597.0,
                        672.0,
                        597.0,
                        672.0,
                        633.0,
                        672.0,
                        604.0,
                        822.0,
                        604.0,
                        822.0,
                        644.0,
                        822.0,
                        606.0,
                        962.0,
                        606.0,
                        962.0,
                        644.0,
                        977.0,
                        644.0
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
                        "obj-104",
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
                        "obj-106",
                        0
                    ],
                    "midpoints": [
                        337.0,
                        336.0,
                        351.0,
                        336.0,
                        351.0,
                        374.0,
                        351.0,
                        364.0,
                        307.0,
                        364.0,
                        307.0,
                        402.0,
                        280.0,
                        402.0
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
                        "obj-107",
                        0
                    ],
                    "midpoints": [
                        353.0833333333333,
                        336.0,
                        351.0,
                        336.0,
                        351.0,
                        374.0,
                        345.0,
                        374.0
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
                        "obj-108",
                        0
                    ],
                    "midpoints": [
                        369.1666666666667,
                        364.0,
                        383.0,
                        364.0,
                        383.0,
                        402.0,
                        410.0,
                        402.0
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        534.0,
                        124.0,
                        235.5,
                        124.0,
                        235.5,
                        162.0,
                        235.5,
                        150.0,
                        198.0,
                        150.0,
                        198.0,
                        186.0,
                        198.0,
                        150.0,
                        298.0,
                        150.0,
                        298.0,
                        186.0,
                        298.0,
                        172.0,
                        198.0,
                        172.0,
                        198.0,
                        210.0,
                        198.0,
                        172.0,
                        272.0,
                        172.0,
                        272.0,
                        212.0,
                        272.0,
                        204.0,
                        241.0,
                        204.0,
                        241.0,
                        242.0,
                        241.0,
                        204.0,
                        322.0,
                        204.0,
                        322.0,
                        340.0,
                        322.0,
                        236.0,
                        213.0,
                        236.0,
                        213.0,
                        274.0,
                        213.0,
                        272.0,
                        323.0,
                        272.0,
                        323.0,
                        310.0,
                        149.0,
                        310.0
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
                        "obj-111",
                        0
                    ],
                    "midpoints": [
                        22.0,
                        340.0,
                        235.0,
                        340.0,
                        235.0,
                        378.0,
                        296.5,
                        378.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-111",
                        1
                    ],
                    "destination": [
                        "obj-105",
                        0
                    ],
                    "midpoints": [
                        336.0,
                        355.0,
                        361.125,
                        355.0
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
                        "obj-101",
                        0
                    ],
                    "midpoints": [
                        257.0,
                        357.0,
                        22.0,
                        357.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
        "bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ],
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