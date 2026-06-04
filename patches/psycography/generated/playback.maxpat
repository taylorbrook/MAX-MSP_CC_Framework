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
                        1815.0,
                        30.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "hooks from cues outlet 2: clickmute / free-audio"
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
                        2355.0,
                        30.0,
                        1003.0,
                        20.0
                    ],
                    "text": "PROGRAM VOICES (9) — read receive~ master; arg2 = per-segment start sample (set from timeline later). Each tile shows its own meter + length.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-3",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-1",
                        0
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
                    "name": "playvoice.maxpat"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2355.0,
                        75.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-1",
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
                        330.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        975.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-2",
                        0
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
                    "name": "playvoice.maxpat"
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
                        2355.0,
                        135.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-2",
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
                        90.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        225.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-3",
                        0
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
                    "name": "playvoice.maxpat"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2355.0,
                        180.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-3",
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
                        495.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        1545.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-4",
                        0
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
                    "name": "playvoice.maxpat"
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
                        2355.0,
                        225.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-4",
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
                        150.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        405.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-5",
                        0
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
                    "name": "playvoice.maxpat"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2355.0,
                        285.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-5",
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
                        450.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        1365.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-6",
                        0
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
                    "name": "playvoice.maxpat"
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
                        2355.0,
                        330.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-6",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        390.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        1170.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-7",
                        0
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
                    "name": "playvoice.maxpat"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2355.0,
                        375.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-7",
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
                        270.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        795.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-8",
                        0
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
                    "name": "playvoice.maxpat"
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
                        3375.0,
                        30.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-8",
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
                        210.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        75.0,
                        175,
                        120
                    ],
                    "args": [
                        "slot-9",
                        0
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
                    "name": "playvoice.maxpat"
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
                        3375.0,
                        75.0,
                        58.0,
                        20.0
                    ],
                    "text": "slot-9",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-30",
                    "numinlets": 9,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        690.0,
                        210.0,
                        199.0,
                        22.0
                    ],
                    "text": "mc.pack~ 9",
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
                        "signal"
                    ],
                    "patching_rect": [
                        795.0,
                        255.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        795.0,
                        225.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
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
                        3375.0,
                        135.0,
                        261.0,
                        20.0
                    ],
                    "text": "MASTER OUTPUT (uncheck = test mute)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        555.0,
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
                    "maxclass": "message",
                    "id": "obj-35",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1740.0,
                        75.0,
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
                    "maxclass": "newobj",
                    "id": "obj-36",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        720.0,
                        300.0,
                        191.0,
                        22.0
                    ],
                    "text": "mc.dac~ 1 2 3 4 5 6 7 8 9",
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
                        3375.0,
                        180.0,
                        387.0,
                        20.0
                    ],
                    "text": "program channels 1–9 (click owns ch 10 via transport)",
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
                        3375.0,
                        225.0,
                        653.0,
                        20.0
                    ],
                    "text": "FREE-SECTION BED — separate free-running path (NOT master-locked); per-section config later",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-39",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1920.0,
                        75.0,
                        191.0,
                        22.0
                    ],
                    "text": "route freeaudio clickmute",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3375.0,
                        285.0,
                        317.0,
                        20.0
                    ],
                    "text": "clickmute -> click module (wired elsewhere)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1890.0,
                        120.0,
                        65.0,
                        22.0
                    ],
                    "text": "sel 1 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        2175.0,
                        75.0,
                        147.0,
                        22.0
                    ],
                    "text": "buffer~ freebed",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-43",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2175.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
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
                        "signal"
                    ],
                    "patching_rect": [
                        1860.0,
                        30.0,
                        65.0,
                        22.0
                    ],
                    "text": "sig~ 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-45",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        1920.0,
                        210.0,
                        210.0,
                        22.0
                    ],
                    "text": "groove~ freebed @loop 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-46",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1890.0,
                        165.0,
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
                    "maxclass": "message",
                    "id": "obj-47",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1950.0,
                        165.0,
                        44.0,
                        22.0
                    ],
                    "text": "stop",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        45.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-49",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        75.0,
                        86.0,
                        22.0
                    ],
                    "text": "clip 0. 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-50",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1875.0,
                        255.0,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1920.0,
                        255.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0
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
                        1830.0,
                        285.0,
                        135.0,
                        22.0
                    ],
                    "text": "send~ freebed_out",
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
                        3375.0,
                        330.0,
                        555.0,
                        20.0
                    ],
                    "text": "bed level 0..1 (init 0 = silent) -> send~ freebed_out for per-section routing",
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
                    ],
                    "midpoints": [
                        52.0,
                        22.0,
                        82.0,
                        22.0,
                        82.0,
                        60.0,
                        117.5,
                        60.0
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
                    ],
                    "midpoints": [
                        352.0,
                        22.0,
                        547.0,
                        22.0,
                        547.0,
                        60.0,
                        547.0,
                        22.0,
                        502.0,
                        22.0,
                        502.0,
                        60.0,
                        502.0,
                        22.0,
                        442.0,
                        22.0,
                        442.0,
                        60.0,
                        442.0,
                        22.0,
                        635.0,
                        22.0,
                        635.0,
                        60.0,
                        635.0,
                        67.0,
                        408.0,
                        67.0,
                        408.0,
                        203.0,
                        408.0,
                        67.0,
                        588.0,
                        67.0,
                        588.0,
                        203.0,
                        588.0,
                        67.0,
                        787.0,
                        67.0,
                        787.0,
                        203.0,
                        787.0,
                        67.0,
                        783.0,
                        67.0,
                        783.0,
                        203.0,
                        1062.5,
                        203.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        112.0,
                        22.0,
                        202.0,
                        22.0,
                        202.0,
                        60.0,
                        202.0,
                        22.0,
                        262.0,
                        22.0,
                        262.0,
                        60.0,
                        262.0,
                        22.0,
                        202.0,
                        22.0,
                        202.0,
                        60.0,
                        202.0,
                        67.0,
                        213.0,
                        67.0,
                        213.0,
                        203.0,
                        312.5,
                        203.0
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
                        517.0,
                        22.0,
                        635.0,
                        22.0,
                        635.0,
                        60.0,
                        635.0,
                        67.0,
                        1158.0,
                        67.0,
                        1158.0,
                        203.0,
                        1158.0,
                        67.0,
                        588.0,
                        67.0,
                        588.0,
                        203.0,
                        588.0,
                        67.0,
                        1357.0,
                        67.0,
                        1357.0,
                        203.0,
                        1357.0,
                        67.0,
                        1162.0,
                        67.0,
                        1162.0,
                        203.0,
                        1162.0,
                        67.0,
                        978.0,
                        67.0,
                        978.0,
                        203.0,
                        978.0,
                        67.0,
                        783.0,
                        67.0,
                        783.0,
                        203.0,
                        1632.5,
                        203.0
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
                        172.0,
                        22.0,
                        322.0,
                        22.0,
                        322.0,
                        60.0,
                        322.0,
                        22.0,
                        487.0,
                        22.0,
                        487.0,
                        60.0,
                        487.0,
                        22.0,
                        442.0,
                        22.0,
                        442.0,
                        60.0,
                        442.0,
                        22.0,
                        382.0,
                        22.0,
                        382.0,
                        60.0,
                        382.0,
                        22.0,
                        322.0,
                        22.0,
                        322.0,
                        60.0,
                        322.0,
                        22.0,
                        262.0,
                        22.0,
                        262.0,
                        60.0,
                        262.0,
                        67.0,
                        213.0,
                        67.0,
                        213.0,
                        203.0,
                        213.0,
                        67.0,
                        408.0,
                        67.0,
                        408.0,
                        203.0,
                        492.5,
                        203.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        472.0,
                        22.0,
                        547.0,
                        22.0,
                        547.0,
                        60.0,
                        547.0,
                        22.0,
                        635.0,
                        22.0,
                        635.0,
                        60.0,
                        635.0,
                        67.0,
                        967.0,
                        67.0,
                        967.0,
                        203.0,
                        967.0,
                        67.0,
                        588.0,
                        67.0,
                        588.0,
                        203.0,
                        588.0,
                        67.0,
                        1162.0,
                        67.0,
                        1162.0,
                        203.0,
                        1162.0,
                        67.0,
                        978.0,
                        67.0,
                        978.0,
                        203.0,
                        978.0,
                        67.0,
                        783.0,
                        67.0,
                        783.0,
                        203.0,
                        1452.5,
                        203.0
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
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        412.0,
                        22.0,
                        547.0,
                        22.0,
                        547.0,
                        60.0,
                        547.0,
                        22.0,
                        502.0,
                        22.0,
                        502.0,
                        60.0,
                        502.0,
                        22.0,
                        635.0,
                        22.0,
                        635.0,
                        60.0,
                        635.0,
                        67.0,
                        967.0,
                        67.0,
                        967.0,
                        203.0,
                        967.0,
                        67.0,
                        588.0,
                        67.0,
                        588.0,
                        203.0,
                        588.0,
                        67.0,
                        787.0,
                        67.0,
                        787.0,
                        203.0,
                        787.0,
                        67.0,
                        783.0,
                        67.0,
                        783.0,
                        203.0,
                        1257.5,
                        203.0
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
                        292.0,
                        22.0,
                        382.0,
                        22.0,
                        382.0,
                        60.0,
                        382.0,
                        22.0,
                        547.0,
                        22.0,
                        547.0,
                        60.0,
                        547.0,
                        22.0,
                        502.0,
                        22.0,
                        502.0,
                        60.0,
                        502.0,
                        22.0,
                        442.0,
                        22.0,
                        442.0,
                        60.0,
                        442.0,
                        22.0,
                        547.0,
                        22.0,
                        547.0,
                        60.0,
                        547.0,
                        67.0,
                        408.0,
                        67.0,
                        408.0,
                        203.0,
                        408.0,
                        67.0,
                        588.0,
                        67.0,
                        588.0,
                        203.0,
                        588.0,
                        67.0,
                        592.0,
                        67.0,
                        592.0,
                        203.0,
                        882.5,
                        203.0
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
                    ],
                    "midpoints": [
                        232.0,
                        22.0,
                        382.0,
                        22.0,
                        382.0,
                        60.0,
                        382.0,
                        22.0,
                        487.0,
                        22.0,
                        487.0,
                        60.0,
                        487.0,
                        22.0,
                        442.0,
                        22.0,
                        442.0,
                        60.0,
                        442.0,
                        22.0,
                        442.0,
                        22.0,
                        442.0,
                        60.0,
                        442.0,
                        22.0,
                        322.0,
                        22.0,
                        322.0,
                        60.0,
                        322.0,
                        22.0,
                        547.0,
                        22.0,
                        547.0,
                        60.0,
                        547.0,
                        67.0,
                        408.0,
                        67.0,
                        408.0,
                        203.0,
                        408.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        203.0,
                        687.5,
                        203.0
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
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        67.0,
                        408.0,
                        67.0,
                        408.0,
                        203.0,
                        408.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        203.0,
                        397.0,
                        67.0,
                        592.0,
                        67.0,
                        592.0,
                        203.0,
                        697.0,
                        203.0
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
                        "obj-30",
                        1
                    ],
                    "midpoints": [
                        982.0,
                        67.0,
                        787.0,
                        67.0,
                        787.0,
                        203.0,
                        787.0,
                        67.0,
                        783.0,
                        67.0,
                        783.0,
                        203.0,
                        720.125,
                        203.0
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
                        "obj-30",
                        2
                    ],
                    "midpoints": [
                        232.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        203.0,
                        397.0,
                        67.0,
                        592.0,
                        67.0,
                        592.0,
                        203.0,
                        743.25,
                        203.0
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
                        "obj-30",
                        3
                    ],
                    "midpoints": [
                        1552.0,
                        67.0,
                        1158.0,
                        67.0,
                        1158.0,
                        203.0,
                        1158.0,
                        67.0,
                        1357.0,
                        67.0,
                        1357.0,
                        203.0,
                        1357.0,
                        67.0,
                        1162.0,
                        67.0,
                        1162.0,
                        203.0,
                        1162.0,
                        67.0,
                        978.0,
                        67.0,
                        978.0,
                        203.0,
                        978.0,
                        67.0,
                        783.0,
                        67.0,
                        783.0,
                        203.0,
                        766.375,
                        203.0
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
                        "obj-30",
                        4
                    ],
                    "midpoints": [
                        412.0,
                        67.0,
                        787.0,
                        67.0,
                        787.0,
                        203.0,
                        787.0,
                        67.0,
                        592.0,
                        67.0,
                        592.0,
                        203.0,
                        789.5,
                        203.0
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
                        "obj-30",
                        5
                    ],
                    "midpoints": [
                        1372.0,
                        67.0,
                        1158.0,
                        67.0,
                        1158.0,
                        203.0,
                        1158.0,
                        67.0,
                        1162.0,
                        67.0,
                        1162.0,
                        203.0,
                        1162.0,
                        67.0,
                        978.0,
                        67.0,
                        978.0,
                        203.0,
                        812.625,
                        203.0
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
                        "obj-30",
                        6
                    ],
                    "midpoints": [
                        1177.0,
                        67.0,
                        967.0,
                        67.0,
                        967.0,
                        203.0,
                        967.0,
                        67.0,
                        978.0,
                        67.0,
                        978.0,
                        203.0,
                        835.75,
                        203.0
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
                        "obj-30",
                        7
                    ],
                    "midpoints": [
                        802.0,
                        202.5,
                        858.875,
                        202.5
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
                        8
                    ],
                    "midpoints": [
                        607.0,
                        67.0,
                        787.0,
                        67.0,
                        787.0,
                        203.0,
                        882.0,
                        203.0
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
                        789.5,
                        217.0,
                        787.0,
                        217.0,
                        787.0,
                        257.0,
                        802.0,
                        257.0
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
                        "obj-31",
                        1
                    ],
                    "midpoints": [
                        807.0,
                        252.0,
                        839.0,
                        252.0
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
                    ],
                    "midpoints": [
                        591.0,
                        67.0,
                        1158.0,
                        67.0,
                        1158.0,
                        203.0,
                        1158.0,
                        67.0,
                        1537.0,
                        67.0,
                        1537.0,
                        203.0,
                        1537.0,
                        67.0,
                        1357.0,
                        67.0,
                        1357.0,
                        203.0,
                        1357.0,
                        67.0,
                        1162.0,
                        67.0,
                        1162.0,
                        203.0,
                        1162.0,
                        67.0,
                        978.0,
                        67.0,
                        978.0,
                        203.0,
                        978.0,
                        67.0,
                        783.0,
                        67.0,
                        783.0,
                        203.0,
                        1747.0,
                        203.0
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        1760.0,
                        67.0,
                        1158.0,
                        67.0,
                        1158.0,
                        203.0,
                        1158.0,
                        67.0,
                        1537.0,
                        67.0,
                        1537.0,
                        203.0,
                        1537.0,
                        67.0,
                        1357.0,
                        67.0,
                        1357.0,
                        203.0,
                        1357.0,
                        67.0,
                        1353.0,
                        67.0,
                        1353.0,
                        203.0,
                        1353.0,
                        67.0,
                        978.0,
                        67.0,
                        978.0,
                        203.0,
                        978.0,
                        202.0,
                        897.0,
                        202.0,
                        897.0,
                        240.0,
                        807.0,
                        240.0
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
                        "obj-36",
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
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        1830.0,
                        37.0,
                        1873.0,
                        37.0,
                        1873.0,
                        75.0,
                        1873.0,
                        67.0,
                        1909.0,
                        67.0,
                        1909.0,
                        105.0,
                        2015.5,
                        105.0
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
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        2197.0,
                        63.5,
                        2248.5,
                        63.5
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
                        1892.5,
                        67.0,
                        1912.0,
                        67.0,
                        1912.0,
                        105.0,
                        1912.0,
                        67.0,
                        1909.0,
                        67.0,
                        1909.0,
                        105.0,
                        1909.0,
                        112.0,
                        1882.0,
                        112.0,
                        1882.0,
                        150.0,
                        1882.0,
                        157.0,
                        1882.0,
                        157.0,
                        1882.0,
                        195.0,
                        1927.0,
                        195.0
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
                        "obj-46",
                        0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        1922.5,
                        157.0,
                        1938.0,
                        157.0,
                        1938.0,
                        195.0,
                        1957.0,
                        195.0
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
                        "obj-45",
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
                        "obj-45",
                        0
                    ],
                    "midpoints": [
                        1972.0,
                        157.0,
                        1938.0,
                        157.0,
                        1938.0,
                        195.0,
                        1927.0,
                        195.0
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
                        1
                    ],
                    "midpoints": [
                        1858.0,
                        67.0,
                        1912.0,
                        67.0,
                        1912.0,
                        105.0,
                        1912.0,
                        112.0,
                        1882.0,
                        112.0,
                        1882.0,
                        150.0,
                        1882.0,
                        157.0,
                        1882.0,
                        157.0,
                        1882.0,
                        195.0,
                        1882.0,
                        202.0,
                        1912.0,
                        202.0,
                        1912.0,
                        240.0,
                        1912.0,
                        247.0,
                        1912.0,
                        247.0,
                        1912.0,
                        363.0,
                        1919.0,
                        363.0
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
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        1927.0,
                        247.0,
                        1912.0,
                        247.0,
                        1912.0,
                        363.0,
                        1882.0,
                        363.0
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
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        1942.0,
                        282.0,
                        1942.0,
                        247.0,
                        1927.5,
                        247.0
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
                        "obj-52",
                        0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}