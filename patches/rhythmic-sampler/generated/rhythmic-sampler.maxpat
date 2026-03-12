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
      1700.0,
      1200.0
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
            50.0,
            760.0,
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
            50.0,
            790.0,
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
            160.0,
            180.0,
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
            50.0,
            250.0,
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
            50.0,
            820.0,
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
            160.0,
            250.0,
            142.0,
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
            50.0,
            330.0,
            79.0,
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
            50.0,
            400.0,
            79.0,
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
            50.0,
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
          "id": "obj-10",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            50.0,
            80.0,
            93.0,
            22.0
          ],
          "text": "trigger b b",
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
            160.0,
            130.0,
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
          "maxclass": "bpatcher",
          "id": "obj-12",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            800.0,
            30.0,
            400,
            400
          ],
          "args": [ "slot-1", "slot-1-out" ],
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
          "id": "obj-13",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1210.0,
            30.0,
            400,
            400
          ],
          "args": [ "slot-2", "slot-2-out" ],
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
          "id": "obj-14",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            800.0,
            440.0,
            400,
            400
          ],
          "args": [ "slot-3", "slot-3-out" ],
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
          "id": "obj-15",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1210.0,
            440.0,
            400,
            400
          ],
          "args": [ "slot-4", "slot-4-out" ],
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
          "id": "obj-16",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            800.0,
            850.0,
            400,
            400
          ],
          "args": [ "slot-5", "slot-5-out" ],
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
          "id": "obj-17",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1210.0,
            850.0,
            400,
            400
          ],
          "args": [ "slot-6", "slot-6-out" ],
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
          "id": "obj-18",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            800.0,
            1260.0,
            400,
            400
          ],
          "args": [ "slot-7", "slot-7-out" ],
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
          "id": "obj-19",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1210.0,
            1260.0,
            400,
            400
          ],
          "args": [ "slot-8", "slot-8-out" ],
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
          "id": "obj-20",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            400.0,
            30.0,
            149.0,
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
          "id": "obj-21",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            590.0,
            30.0,
            149.0,
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
          "id": "obj-22",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            590.0,
            140.0,
            149.0,
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
          "id": "obj-23",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            590.0,
            250.0,
            149.0,
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
          "id": "obj-24",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            590.0,
            360.0,
            149.0,
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
          "id": "obj-25",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            590.0,
            470.0,
            149.0,
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
          "id": "obj-26",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            590.0,
            580.0,
            149.0,
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
          "id": "obj-27",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            590.0,
            690.0,
            149.0,
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
          "id": "obj-28",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            480.0,
            90.0,
            40.0,
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
          "id": "obj-29",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            480.0,
            200.0,
            40.0,
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
            480.0,
            310.0,
            40.0,
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
            480.0,
            420.0,
            40.0,
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
            480.0,
            530.0,
            40.0,
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
            480.0,
            640.0,
            40.0,
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
            480.0,
            750.0,
            40.0,
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
            480.0,
            820.0,
            58.0,
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
          "id": "obj-36",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            480.0,
            900.0,
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
          "id": "obj-37",
          "numinlets": 2,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            480.0,
            1080.0,
            44.0,
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
          "id": "obj-38",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            560.0,
            1060.0,
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
          "id": "obj-39",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            50.0,
            850.0,
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
          "id": "obj-40",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            50.0,
            510.0,
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
          "id": "obj-41",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            150.0,
            640.0,
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
          "id": "obj-42",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            50.0,
            640.0,
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
          "id": "obj-43",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            50.0,
            575.0,
            72.0,
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
          "id": "obj-44",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            50.0,
            880.0,
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
          "order": 0
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
          "midpoints": [
            231.0,
            290.0,
            122.0,
            290.0
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
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-20",
            0
          ],
          "destination": [
            "obj-28",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-21",
            0
          ],
          "destination": [
            "obj-28",
            1
          ],
          "midpoints": [
            664.0,
            65.0,
            513.0,
            65.0
          ],
          "order": 0
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
          ],
          "order": 0
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
          "midpoints": [
            664.0,
            175.0,
            513.0,
            175.0
          ],
          "order": 0
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
          "order": 0
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
          "midpoints": [
            664.0,
            285.0,
            513.0,
            285.0
          ],
          "order": 0
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
          "order": 0
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
          "midpoints": [
            664.0,
            395.0,
            513.0,
            395.0
          ],
          "order": 0
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
          "order": 0
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
          "midpoints": [
            664.0,
            505.0,
            513.0,
            505.0
          ],
          "order": 0
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
          "order": 0
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
          "midpoints": [
            664.0,
            615.0,
            513.0,
            615.0
          ],
          "order": 0
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
          "order": 0
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
          "midpoints": [
            664.0,
            725.0,
            513.0,
            725.0
          ],
          "order": 0
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
          "order": 0
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
            1
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
            "obj-38",
            0
          ],
          "midpoints": [
            485.0,
            1055.0,
            567.0,
            1055.0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-40",
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
            "obj-43",
            0
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
            "obj-43",
            1
          ],
          "destination": [
            "obj-41",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-41",
            0
          ],
          "destination": [
            "obj-37",
            0
          ],
          "midpoints": [
            196.0,
            1080.0,
            487.0,
            1080.0
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
            "obj-37",
            0
          ],
          "midpoints": [
            72.0,
            1080.0,
            487.0,
            1080.0
          ],
          "order": 0
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}