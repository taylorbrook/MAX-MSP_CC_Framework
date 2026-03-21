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
      100.0,
      100.0,
      4640.0,
      632.0
    ],
    "bglocked": 0,
    "openinpresentation": 1,
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
            1050.0,
            30.0,
            128.0,
            20.0
          ],
          "text": "RHYTHMIC SAMPLER",
          "fontname": "Arial",
          "fontsize": 18,
          "presentation": 1,
          "presentation_rect": [
            10,
            10,
            200,
            30
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
            1050.0,
            75.0,
            40.0,
            20.0
          ],
          "text": "BPM",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            10,
            50,
            60,
            20
          ]
        }
      },
      {
        "box": {
          "maxclass": "number",
          "id": "obj-3",
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
          "presentation": 1,
          "presentation_rect": [
            75,
            45,
            60,
            25
          ]
        }
      },
      {
        "box": {
          "maxclass": "toggle",
          "id": "obj-4",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            30.0,
            30.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            150,
            45,
            30,
            30
          ]
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
            1050.0,
            135.0,
            44.0,
            20.0
          ],
          "text": "PLAY",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            200,
            50,
            60,
            20
          ]
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
            30.0,
            195.0,
            92.0,
            22.0
          ],
          "text": "expr 60000./$f1/4.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-7",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            30.0,
            240.0,
            69.0,
            22.0
          ],
          "text": "metro 125",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-8",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            30.0,
            285.0,
            97.5,
            22.0
          ],
          "text": "send tick",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-9",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            75.0,
            30.0,
            62.0,
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
          "id": "obj-10",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            60.0,
            75.0,
            80.5,
            22.0
          ],
          "text": "trigger b b b",
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
            75.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "120",
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
            135.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "128",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "bpatcher",
          "id": "obj-13",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1185.0,
            30.0,
            400,
            400
          ],
          "args": [
            "slot-1",
            "slot-1-out"
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
          "name": "slot.maxpat",
          "presentation": 1,
          "presentation_rect": [
            10,
            90,
            400,
            400
          ]
        }
      },
      {
        "box": {
          "maxclass": "bpatcher",
          "id": "obj-14",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1605.0,
            30.0,
            400,
            400
          ],
          "args": [
            "slot-2",
            "slot-2-out"
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
          "name": "slot.maxpat",
          "presentation": 1,
          "presentation_rect": [
            420,
            90,
            400,
            400
          ]
        }
      },
      {
        "box": {
          "maxclass": "bpatcher",
          "id": "obj-15",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2010.0,
            30.0,
            400,
            400
          ],
          "args": [
            "slot-3",
            "slot-3-out"
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
          "name": "slot.maxpat",
          "presentation": 1,
          "presentation_rect": [
            830,
            90,
            400,
            400
          ]
        }
      },
      {
        "box": {
          "maxclass": "bpatcher",
          "id": "obj-16",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2430.0,
            30.0,
            400,
            400
          ],
          "args": [
            "slot-4",
            "slot-4-out"
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
          "name": "slot.maxpat",
          "presentation": 1,
          "presentation_rect": [
            1240,
            90,
            400,
            400
          ]
        }
      },
      {
        "box": {
          "maxclass": "bpatcher",
          "id": "obj-17",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2850.0,
            30.0,
            400,
            400
          ],
          "args": [
            "slot-5",
            "slot-5-out"
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
          "name": "slot.maxpat",
          "presentation": 1,
          "presentation_rect": [
            10,
            500,
            400,
            400
          ]
        }
      },
      {
        "box": {
          "maxclass": "bpatcher",
          "id": "obj-18",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3255.0,
            30.0,
            400,
            400
          ],
          "args": [
            "slot-6",
            "slot-6-out"
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
          "name": "slot.maxpat",
          "presentation": 1,
          "presentation_rect": [
            420,
            500,
            400,
            400
          ]
        }
      },
      {
        "box": {
          "maxclass": "bpatcher",
          "id": "obj-19",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3675.0,
            30.0,
            400,
            400
          ],
          "args": [
            "slot-7",
            "slot-7-out"
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
          "name": "slot.maxpat",
          "presentation": 1,
          "presentation_rect": [
            830,
            500,
            400,
            400
          ]
        }
      },
      {
        "box": {
          "maxclass": "bpatcher",
          "id": "obj-20",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            4095.0,
            30.0,
            400,
            400
          ],
          "args": [
            "slot-8",
            "slot-8-out"
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
          "name": "slot.maxpat",
          "presentation": 1,
          "presentation_rect": [
            1240,
            500,
            400,
            400
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
            "signal"
          ],
          "patching_rect": [
            915.0,
            30.0,
            94.0,
            22.0
          ],
          "text": "receive~ slot-1-out",
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
            795.0,
            30.0,
            94.0,
            22.0
          ],
          "text": "receive~ slot-2-out",
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
            "signal"
          ],
          "patching_rect": [
            690.0,
            30.0,
            94.0,
            22.0
          ],
          "text": "receive~ slot-3-out",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-24",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            585.0,
            30.0,
            94.0,
            22.0
          ],
          "text": "receive~ slot-4-out",
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
            "signal"
          ],
          "patching_rect": [
            480.0,
            30.0,
            94.0,
            22.0
          ],
          "text": "receive~ slot-5-out",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-26",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            360.0,
            30.0,
            94.0,
            22.0
          ],
          "text": "receive~ slot-6-out",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-27",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            255.0,
            30.0,
            94.0,
            22.0
          ],
          "text": "receive~ slot-7-out",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-28",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            150.0,
            30.0,
            94.0,
            22.0
          ],
          "text": "receive~ slot-8-out",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-29",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            885.0,
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
          "id": "obj-30",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            855.0,
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
          "id": "obj-31",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            735.0,
            165.0,
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
          "id": "obj-32",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            615.0,
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
          "id": "obj-33",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            495.0,
            240.0,
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
          "id": "obj-34",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            390.0,
            285.0,
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
          "id": "obj-35",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            285.0,
            330.0,
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
          "id": "obj-36",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            300.0,
            375.0,
            42.0,
            22.0
          ],
          "text": "*~ 0.3",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "gain~",
          "id": "obj-37",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            225.0,
            405.0,
            22.0,
            140.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            10,
            910,
            200,
            50
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-38",
          "numinlets": 2,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            480.0,
            570.0,
            35.0,
            22.0
          ],
          "text": "dac~",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-39",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            255.0,
            405.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            220,
            910,
            100,
            50
          ]
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
            4500.0,
            30.0,
            58.0,
            20.0
          ],
          "text": "MASTER",
          "fontname": "Arial",
          "fontsize": 11,
          "presentation": 1,
          "presentation_rect": [
            10,
            895,
            80,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "toggle",
          "id": "obj-41",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            690.0,
            45.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            10,
            1020,
            25,
            25
          ]
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-42",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            750.0,
            120.0,
            93.0,
            22.0
          ],
          "text": "startwindow",
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
            690.0,
            120.0,
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
          "maxclass": "newobj",
          "id": "obj-44",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            690.0,
            75.0,
            71.0,
            22.0
          ],
          "text": "select 0",
          "fontname": "Arial",
          "fontsize": 12.0
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
            4500.0,
            75.0,
            100.0,
            20.0
          ],
          "text": "Audio On/Off",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            40,
            1025,
            80,
            15
          ]
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
            165.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "1",
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
            "obj-6",
            0
          ],
          "order": 0,
          "midpoints": [
            37.0,
            191.0,
            76.0,
            191.0
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
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-4",
            0
          ],
          "destination": [
            "obj-7",
            0
          ],
          "order": 0
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
            0
          ],
          "order": 0
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
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-10",
            1
          ],
          "destination": [
            "obj-11",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-11",
            0
          ],
          "destination": [
            "obj-3",
            0
          ],
          "order": 0,
          "midpoints": [
            95.0,
            153.5,
            55.0,
            153.5
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
            "obj-29",
            0
          ],
          "order": 0,
          "midpoints": [
            962.0,
            63.5,
            892.0,
            63.5
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
            "obj-29",
            1
          ],
          "order": 0,
          "midpoints": [
            842.0,
            63.5,
            925.5,
            63.5
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
            "obj-30",
            0
          ],
          "order": 0,
          "midpoints": [
            908.75,
            108.5,
            862.0,
            108.5
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
            "obj-30",
            1
          ],
          "order": 0,
          "midpoints": [
            737.0,
            86.0,
            895.5,
            86.0
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
          "order": 0,
          "midpoints": [
            878.75,
            153.5,
            742.0,
            153.5
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
            "obj-31",
            1
          ],
          "order": 0,
          "midpoints": [
            632.0,
            108.5,
            775.5,
            108.5
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
          "order": 0,
          "midpoints": [
            758.75,
            191.0,
            622.0,
            191.0
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
            "obj-32",
            1
          ],
          "order": 0,
          "midpoints": [
            527.0,
            123.5,
            655.5,
            123.5
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
          ],
          "order": 0,
          "midpoints": [
            638.75,
            228.5,
            502.0,
            228.5
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
            "obj-33",
            1
          ],
          "order": 0,
          "midpoints": [
            407.0,
            146.0,
            535.5,
            146.0
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
          "order": 0,
          "midpoints": [
            518.75,
            273.5,
            397.0,
            273.5
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
            "obj-34",
            1
          ],
          "order": 0,
          "midpoints": [
            302.0,
            168.5,
            430.5,
            168.5
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
          "order": 0,
          "midpoints": [
            413.75,
            318.5,
            292.0,
            318.5
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
            "obj-35",
            1
          ],
          "order": 0,
          "midpoints": [
            197.0,
            191.0,
            325.5,
            191.0
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
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-36",
            0
          ],
          "destination": [
            "obj-37",
            0
          ],
          "order": 0,
          "midpoints": [
            321.0,
            401.0,
            236.0,
            401.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-10",
            2
          ],
          "destination": [
            "obj-12",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-12",
            0
          ],
          "destination": [
            "obj-37",
            0
          ],
          "order": 0,
          "midpoints": [
            155.0,
            273.5,
            236.0,
            273.5
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
          ],
          "order": 0,
          "midpoints": [
            232.0,
            557.5,
            487.0,
            557.5
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
            1
          ],
          "order": 0,
          "midpoints": [
            232.0,
            557.5,
            508.0,
            557.5
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
          "order": 0,
          "midpoints": [
            277.0,
            550.0,
            277.0,
            397.0,
            262.5,
            397.0
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
            "obj-44",
            0
          ],
          "order": 0,
          "midpoints": [
            702.0,
            72.0,
            725.5,
            72.0
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
            "obj-43",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-44",
            1
          ],
          "destination": [
            "obj-42",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-42",
            0
          ],
          "destination": [
            "obj-38",
            0
          ],
          "order": 0,
          "midpoints": [
            796.5,
            356.0,
            487.0,
            356.0
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
            "obj-38",
            0
          ],
          "order": 0,
          "midpoints": [
            712.0,
            356.0,
            487.0,
            356.0
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
            "obj-41",
            0
          ]
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}