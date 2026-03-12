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
      85,
      104,
      900,
      750
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
            1093.0,
            30.0,
            135.0,
            20.0
          ],
          "text": "PERFORMANCE PATCH",
          "fontname": "Arial",
          "fontsize": 12.0
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
            1093.0,
            150.0,
            436.0,
            20.0
          ],
          "text": "Audio buses via send~/receive~ \u2014 see subpatchers for details",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-3",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            30.0,
            30.0,
            58.0,
            22.0
          ],
          "text": "adc~ 1",
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
            249.0,
            30.0,
            128.0,
            22.0
          ],
          "text": "send~ live-input",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-5",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            270.0,
            142.0,
            22.0
          ],
          "text": "p input-processing",
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
                  "maxclass": "newobj",
                  "id": "obj-1",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30.0,
                    30.0,
                    149.0,
                    22.0
                  ],
                  "text": "receive~ live-input",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    1291.0,
                    30.0,
                    163.0,
                    20.0
                  ],
                  "text": "--- PARAMETRIC EQ ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-3",
                  "numinlets": 8,
                  "numoutlets": 7,
                  "outlettype": [
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    152.0,
                    100.0,
                    22.0
                  ],
                  "text": "filtergraph~",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-4",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    249.0,
                    30.0,
                    72.0,
                    22.0
                  ],
                  "text": "cascade~",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    1291.0,
                    150.0,
                    261.0,
                    20.0
                  ],
                  "text": "--- 3-BAND MULTIBAND COMPRESSOR ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-6",
                  "numinlets": 3,
                  "numoutlets": 4,
                  "outlettype": [
                    "signal",
                    "signal",
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    391.0,
                    30.0,
                    100.0,
                    22.0
                  ],
                  "text": "svf~ 300 0.5",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 4,
                  "outlettype": [
                    "signal",
                    "signal",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    561.0,
                    30.0,
                    79.0,
                    22.0
                  ],
                  "text": "omx.comp~",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-8",
                  "numinlets": 3,
                  "numoutlets": 4,
                  "outlettype": [
                    "signal",
                    "signal",
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    561.0,
                    152.0,
                    107.0,
                    22.0
                  ],
                  "text": "svf~ 3000 0.5",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-9",
                  "numinlets": 2,
                  "numoutlets": 4,
                  "outlettype": [
                    "signal",
                    "signal",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    738.0,
                    30.0,
                    79.0,
                    22.0
                  ],
                  "text": "omx.comp~",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-10",
                  "numinlets": 2,
                  "numoutlets": 4,
                  "outlettype": [
                    "signal",
                    "signal",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    738.0,
                    152.0,
                    79.0,
                    22.0
                  ],
                  "text": "omx.comp~",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-11",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    887.0,
                    30.0,
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
                  "id": "obj-12",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    997.0,
                    30.0,
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
                  "id": "obj-13",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1107.0,
                    30.0,
                    114.0,
                    22.0
                  ],
                  "text": "send~ proc-out",
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
                    "obj-4",
                    0
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-6",
                    1
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
                    "obj-8",
                    0
                  ],
                  "destination": [
                    "obj-9",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-8",
                    1
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
                    "obj-7",
                    0
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
                    "obj-9",
                    0
                  ],
                  "destination": [
                    "obj-11",
                    1
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
                    "obj-12",
                    0
                  ],
                  "order": 0
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
                    1
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
                    "obj-13",
                    0
                  ],
                  "order": 0
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
          "id": "obj-6",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            392.0,
            100.0,
            22.0
          ],
          "text": "p cue-system",
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
                  "maxclass": "comment",
                  "id": "obj-1",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1458.0,
                    30.0,
                    303.0,
                    20.0
                  ],
                  "text": "--- MIDI TRIGGER (note 64 = next cue) ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-2",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    30.0,
                    58.0,
                    22.0
                  ],
                  "text": "notein",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-3",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    228.0,
                    30.0,
                    79.0,
                    22.0
                  ],
                  "text": "stripnote",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-4",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    433.0,
                    30.0,
                    79.0,
                    22.0
                  ],
                  "text": "select 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    1458.0,
                    150.0,
                    170.0,
                    20.0
                  ],
                  "text": "--- MANUAL TRIGGER ---",
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
                    30.0,
                    152.0,
                    128.0,
                    22.0
                  ],
                  "text": "receive next-cue",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-7",
                  "numinlets": 5,
                  "numoutlets": 4,
                  "outlettype": [
                    "",
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    582.0,
                    30.0,
                    114.0,
                    22.0
                  ],
                  "text": "counter 0 1 99",
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
                    766.0,
                    30.0,
                    121.0,
                    22.0
                  ],
                  "text": "send cue-number",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    1458.0,
                    270.0,
                    177.0,
                    20.0
                  ],
                  "text": "--- CUE DATA (coll) ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-10",
                  "numinlets": 2,
                  "numoutlets": 4,
                  "outlettype": [
                    "",
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    766.0,
                    152.0,
                    107.0,
                    22.0
                  ],
                  "text": "coll cue-data",
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
                    30.0,
                    274.0,
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
                  "id": "obj-12",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    228.0,
                    152.0,
                    135.0,
                    22.0
                  ],
                  "text": "read cue-data.txt",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "comment",
                  "id": "obj-13",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1458.0,
                    390.0,
                    534.0,
                    20.0
                  ],
                  "text": "delay_send dist_send det_send del_time del_fb dist_drv det_amt sf1 sf2 sf3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-14",
                  "numinlets": 1,
                  "numoutlets": 10,
                  "outlettype": [
                    "",
                    "",
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
                    957.0,
                    30.0,
                    198.0,
                    22.0
                  ],
                  "text": "unpack f f f f f f f s s s",
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
                    1225.0,
                    30.0,
                    149.0,
                    22.0
                  ],
                  "text": "send delay-send-lvl",
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
                    1225.0,
                    152.0,
                    142.0,
                    22.0
                  ],
                  "text": "send dist-send-lvl",
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
                    1225.0,
                    274.0,
                    156.0,
                    22.0
                  ],
                  "text": "send detune-send-lvl",
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
                    1225.0,
                    396.0,
                    121.0,
                    22.0
                  ],
                  "text": "send delay-time",
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
                    1225.0,
                    518.0,
                    107.0,
                    22.0
                  ],
                  "text": "send delay-fb",
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
                    1225.0,
                    640.0,
                    121.0,
                    22.0
                  ],
                  "text": "send dist-drive",
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
                    1225.0,
                    762.0,
                    121.0,
                    22.0
                  ],
                  "text": "send detune-amt",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-22",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1225.0,
                    884.0,
                    163.0,
                    22.0
                  ],
                  "text": "send sfplay-1-trigger",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-23",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1225.0,
                    1006.0,
                    163.0,
                    22.0
                  ],
                  "text": "send sfplay-2-trigger",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-24",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1225.0,
                    1128.0,
                    163.0,
                    22.0
                  ],
                  "text": "send sfplay-3-trigger",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "obj-2",
                    1
                  ],
                  "destination": [
                    "obj-3",
                    1
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                    "obj-6",
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
                    "obj-7",
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
                    "obj-11",
                    0
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
                    0
                  ],
                  "destination": [
                    "obj-14",
                    0
                  ],
                  "order": 0
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
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
                    5
                  ],
                  "destination": [
                    "obj-20",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
                    6
                  ],
                  "destination": [
                    "obj-21",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
                    7
                  ],
                  "destination": [
                    "obj-22",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
                    8
                  ],
                  "destination": [
                    "obj-23",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
                    9
                  ],
                  "destination": [
                    "obj-24",
                    0
                  ],
                  "order": 0
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
          "id": "obj-7",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            514.0,
            128.0,
            22.0
          ],
          "text": "p feedback-delay",
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
                  "maxclass": "comment",
                  "id": "obj-1",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    622.0,
                    30.0,
                    170.0,
                    20.0
                  ],
                  "text": "--- FEEDBACK DELAY ---",
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
                    "signal"
                  ],
                  "patching_rect": [
                    30.0,
                    30.0,
                    135.0,
                    22.0
                  ],
                  "text": "receive~ proc-out",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-3",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    152.0,
                    170.0,
                    22.0
                  ],
                  "text": "receive delay-send-lvl",
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
                    270.0,
                    30.0,
                    51.0,
                    22.0
                  ],
                  "text": "$1 50",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-5",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    391.0,
                    30.0,
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
                  "id": "obj-6",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    512.0,
                    30.0,
                    40.0,
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
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    622.0,
                    150.0,
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
                  "id": "obj-8",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    622.0,
                    272.0,
                    93.0,
                    22.0
                  ],
                  "text": "tapin~ 5000",
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
                    "signal"
                  ],
                  "patching_rect": [
                    622.0,
                    394.0,
                    93.0,
                    22.0
                  ],
                  "text": "tapout~ 500",
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
                    30.0,
                    274.0,
                    142.0,
                    22.0
                  ],
                  "text": "receive delay-time",
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
                    30.0,
                    396.0,
                    128.0,
                    22.0
                  ],
                  "text": "receive delay-fb",
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
                    270.0,
                    152.0,
                    51.0,
                    22.0
                  ],
                  "text": "$1 50",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-13",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    391.0,
                    152.0,
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
                  "id": "obj-14",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    622.0,
                    516.0,
                    40.0,
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
                  "id": "obj-15",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    622.0,
                    638.0,
                    121.0,
                    22.0
                  ],
                  "text": "send~ delay-ret",
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
                    "obj-5",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-2",
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
                    "obj-5",
                    0
                  ],
                  "destination": [
                    "obj-6",
                    1
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
                    "obj-8",
                    0
                  ],
                  "destination": [
                    "obj-9",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-10",
                    0
                  ],
                  "destination": [
                    "obj-9",
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
                    "obj-13",
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
                    "obj-14",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
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
                    "obj-9",
                    0
                  ],
                  "destination": [
                    "obj-15",
                    0
                  ],
                  "order": 0
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
          "id": "obj-8",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            636.0,
            100.0,
            22.0
          ],
          "text": "p distortion",
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
                  "maxclass": "comment",
                  "id": "obj-1",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    976.0,
                    30.0,
                    233.0,
                    20.0
                  ],
                  "text": "--- DISTORTION (overdrive~) ---",
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
                    "signal"
                  ],
                  "patching_rect": [
                    30.0,
                    30.0,
                    135.0,
                    22.0
                  ],
                  "text": "receive~ proc-out",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-3",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    152.0,
                    163.0,
                    22.0
                  ],
                  "text": "receive dist-send-lvl",
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
                    263.0,
                    30.0,
                    51.0,
                    22.0
                  ],
                  "text": "$1 50",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-5",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    384.0,
                    30.0,
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
                  "id": "obj-6",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    505.0,
                    30.0,
                    40.0,
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
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    615.0,
                    30.0,
                    107.0,
                    22.0
                  ],
                  "text": "overdrive~ 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-8",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    274.0,
                    142.0,
                    22.0
                  ],
                  "text": "receive dist-drive",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-9",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    792.0,
                    30.0,
                    114.0,
                    22.0
                  ],
                  "text": "send~ dist-ret",
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
                    "obj-5",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-2",
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
                    "obj-5",
                    0
                  ],
                  "destination": [
                    "obj-6",
                    1
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
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-8",
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
                    "obj-7",
                    0
                  ],
                  "destination": [
                    "obj-9",
                    0
                  ],
                  "order": 0
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
          "id": "obj-9",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            758.0,
            72.0,
            22.0
          ],
          "text": "p detune",
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
                  "maxclass": "comment",
                  "id": "obj-1",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1004.0,
                    30.0,
                    205.0,
                    20.0
                  ],
                  "text": "--- DETUNE (freqshift~) ---",
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
                    "signal"
                  ],
                  "patching_rect": [
                    30.0,
                    30.0,
                    135.0,
                    22.0
                  ],
                  "text": "receive~ proc-out",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-3",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    152.0,
                    177.0,
                    22.0
                  ],
                  "text": "receive detune-send-lvl",
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
                    277.0,
                    30.0,
                    51.0,
                    22.0
                  ],
                  "text": "$1 50",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-5",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    398.0,
                    30.0,
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
                  "id": "obj-6",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    519.0,
                    30.0,
                    40.0,
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
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    629.0,
                    30.0,
                    107.0,
                    22.0
                  ],
                  "text": "freqshift~ 5.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-8",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    274.0,
                    142.0,
                    22.0
                  ],
                  "text": "receive detune-amt",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-9",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    806.0,
                    30.0,
                    128.0,
                    22.0
                  ],
                  "text": "send~ detune-ret",
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
                    "obj-5",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-2",
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
                    "obj-5",
                    0
                  ],
                  "destination": [
                    "obj-6",
                    1
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
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-8",
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
                    "obj-7",
                    0
                  ],
                  "destination": [
                    "obj-9",
                    0
                  ],
                  "order": 0
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
          "id": "obj-10",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            880.0,
            142.0,
            22.0
          ],
          "text": "p soundfile-player",
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
                  "maxclass": "comment",
                  "id": "obj-1",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1578.0,
                    30.0,
                    254.0,
                    20.0
                  ],
                  "text": "--- 3x STEREO SOUNDFILE PLAYER ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    1578.0,
                    150.0,
                    128.0,
                    20.0
                  ],
                  "text": "--- Player 1 ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-3",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    30.0,
                    184.0,
                    22.0
                  ],
                  "text": "receive sfplay-1-trigger",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-4",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    284.0,
                    30.0,
                    86.0,
                    22.0
                  ],
                  "text": "route none",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-5",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    440.0,
                    30.0,
                    93.0,
                    22.0
                  ],
                  "text": "trigger b s",
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
                    603.0,
                    30.0,
                    100.0,
                    22.0
                  ],
                  "text": "prepend open",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 3,
                  "outlettype": [
                    "signal",
                    "signal",
                    "bang"
                  ],
                  "patching_rect": [
                    773.0,
                    30.0,
                    79.0,
                    22.0
                  ],
                  "text": "sfplay~ 2",
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
                    603.0,
                    152.0,
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
                  "id": "obj-9",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    922.0,
                    30.0,
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
                  "id": "obj-10",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    1032.0,
                    30.0,
                    58.0,
                    22.0
                  ],
                  "text": "*~ 0.5",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    1578.0,
                    270.0,
                    128.0,
                    20.0
                  ],
                  "text": "--- Player 2 ---",
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
                    30.0,
                    152.0,
                    184.0,
                    22.0
                  ],
                  "text": "receive sfplay-2-trigger",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    284.0,
                    152.0,
                    86.0,
                    22.0
                  ],
                  "text": "route none",
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
                    440.0,
                    152.0,
                    93.0,
                    22.0
                  ],
                  "text": "trigger b s",
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
                    603.0,
                    274.0,
                    100.0,
                    22.0
                  ],
                  "text": "prepend open",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-16",
                  "numinlets": 2,
                  "numoutlets": 3,
                  "outlettype": [
                    "signal",
                    "signal",
                    "bang"
                  ],
                  "patching_rect": [
                    773.0,
                    152.0,
                    79.0,
                    22.0
                  ],
                  "text": "sfplay~ 2",
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
                    603.0,
                    396.0,
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
                  "id": "obj-18",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    922.0,
                    152.0,
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
                  "id": "obj-19",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    1032.0,
                    152.0,
                    58.0,
                    22.0
                  ],
                  "text": "*~ 0.5",
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
                    1578.0,
                    390.0,
                    128.0,
                    20.0
                  ],
                  "text": "--- Player 3 ---",
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
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    274.0,
                    184.0,
                    22.0
                  ],
                  "text": "receive sfplay-3-trigger",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-22",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    284.0,
                    274.0,
                    86.0,
                    22.0
                  ],
                  "text": "route none",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    440.0,
                    274.0,
                    93.0,
                    22.0
                  ],
                  "text": "trigger b s",
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
                    ""
                  ],
                  "patching_rect": [
                    603.0,
                    518.0,
                    100.0,
                    22.0
                  ],
                  "text": "prepend open",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-25",
                  "numinlets": 2,
                  "numoutlets": 3,
                  "outlettype": [
                    "signal",
                    "signal",
                    "bang"
                  ],
                  "patching_rect": [
                    773.0,
                    274.0,
                    79.0,
                    22.0
                  ],
                  "text": "sfplay~ 2",
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
                    603.0,
                    640.0,
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
                  "id": "obj-27",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    922.0,
                    274.0,
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
                  "id": "obj-28",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    1032.0,
                    274.0,
                    58.0,
                    22.0
                  ],
                  "text": "*~ 0.5",
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
                    1578.0,
                    510.0,
                    149.0,
                    20.0
                  ],
                  "text": "--- Sum Players ---",
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
                    1160.0,
                    30.0,
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
                    1270.0,
                    30.0,
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
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1380.0,
                    30.0,
                    128.0,
                    22.0
                  ],
                  "text": "send~ sfplay-ret",
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-4",
                    1
                  ],
                  "destination": [
                    "obj-5",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-5",
                    1
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
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-5",
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
                    "obj-8",
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
                    "obj-9",
                    0
                  ],
                  "order": 0
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
                    "obj-12",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-13",
                    1
                  ],
                  "destination": [
                    "obj-14",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
                    1
                  ],
                  "destination": [
                    "obj-15",
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-17",
                    0
                  ],
                  "destination": [
                    "obj-16",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-16",
                    0
                  ],
                  "destination": [
                    "obj-18",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                    "obj-22",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-22",
                    1
                  ],
                  "destination": [
                    "obj-23",
                    0
                  ],
                  "order": 0
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
                    "obj-25",
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
                    "obj-26",
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
                    "obj-25",
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
                    "obj-27",
                    0
                  ],
                  "order": 0
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
                    1
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
                    "obj-28",
                    0
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                    1
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
                    "obj-28",
                    0
                  ],
                  "destination": [
                    "obj-31",
                    1
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
          "maxclass": "comment",
          "id": "obj-11",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            1002.0,
            205.0,
            20.0
          ],
          "text": "========== MIXER ==========",
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
            "signal"
          ],
          "patching_rect": [
            30.0,
            152.0,
            135.0,
            22.0
          ],
          "text": "receive~ proc-out",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "gain~",
          "id": "obj-13",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            249.0,
            152.0,
            22.0,
            140.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            20,
            62,
            38,
            150
          ]
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-14",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            447.0,
            30.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            62,
            62,
            22,
            150
          ]
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-15",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            1122.0,
            40.0,
            20.0
          ],
          "text": "DRY",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            20,
            35,
            90,
            22
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-16",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            30.0,
            274.0,
            142.0,
            22.0
          ],
          "text": "receive~ delay-ret",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "gain~",
          "id": "obj-17",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            249.0,
            392.0,
            22.0,
            140.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            120,
            62,
            38,
            150
          ]
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-18",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            447.0,
            230.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            162,
            62,
            22,
            150
          ]
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-19",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            1242.0,
            51.0,
            20.0
          ],
          "text": "DELAY",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            120,
            35,
            90,
            22
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
            30.0,
            396.0,
            135.0,
            22.0
          ],
          "text": "receive~ dist-ret",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "gain~",
          "id": "obj-21",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            249.0,
            632.0,
            22.0,
            140.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            220,
            62,
            38,
            150
          ]
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-22",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            447.0,
            552.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            262,
            62,
            22,
            150
          ]
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
            1093.0,
            1362.0,
            44.0,
            20.0
          ],
          "text": "DIST",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            220,
            35,
            90,
            22
          ]
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
            30.0,
            518.0,
            149.0,
            22.0
          ],
          "text": "receive~ detune-ret",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "gain~",
          "id": "obj-25",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            249.0,
            872.0,
            22.0,
            140.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            320,
            62,
            38,
            150
          ]
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-26",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            447.0,
            752.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            362,
            62,
            22,
            150
          ]
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
            1093.0,
            1482.0,
            58.0,
            20.0
          ],
          "text": "DETUNE",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            320,
            35,
            90,
            22
          ]
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
            30.0,
            640.0,
            149.0,
            22.0
          ],
          "text": "receive~ sfplay-ret",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "gain~",
          "id": "obj-29",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            249.0,
            1112.0,
            22.0,
            140.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            420,
            62,
            38,
            150
          ]
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-30",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            447.0,
            952.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            462,
            62,
            22,
            150
          ]
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
            1093.0,
            1602.0,
            51.0,
            20.0
          ],
          "text": "FILES",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            420,
            35,
            90,
            22
          ]
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
            447.0,
            430.0,
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
            557.0,
            30.0,
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
            667.0,
            30.0,
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
            777.0,
            30.0,
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
          "maxclass": "comment",
          "id": "obj-36",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            1722.0,
            114.0,
            20.0
          ],
          "text": "--- MASTER ---",
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
            887.0,
            30.0,
            22.0,
            140.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            520,
            62,
            38,
            150
          ]
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
            979.0,
            30.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            562,
            62,
            22,
            150
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
            1093.0,
            1842.0,
            58.0,
            20.0
          ],
          "text": "MASTER",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            520,
            35,
            90,
            22
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-40",
          "numinlets": 2,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            979.0,
            230.0,
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
          "maxclass": "comment",
          "id": "obj-41",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            1962.0,
            156.0,
            20.0
          ],
          "text": "--- CUE CONTROLS ---",
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
            30.0,
            762.0,
            142.0,
            22.0
          ],
          "text": "receive cue-number",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "number",
          "id": "obj-43",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            249.0,
            1352.0,
            50.0,
            22.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            70,
            227,
            60,
            24
          ]
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
            249.0,
            1400.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            205,
            227,
            28,
            28
          ]
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
            249.0,
            1474.0,
            107.0,
            22.0
          ],
          "text": "send next-cue",
          "fontname": "Arial",
          "fontsize": 12.0
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
            1093.0,
            2082.0,
            44.0,
            20.0
          ],
          "text": "CUE:",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            20,
            227,
            45,
            24
          ]
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-47",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1093.0,
            2202.0,
            44.0,
            20.0
          ],
          "text": "NEXT",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            150,
            227,
            50,
            24
          ]
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
            1093.0,
            2322.0,
            135.0,
            20.0
          ],
          "text": "PERFORMANCE PATCH",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            250,
            227,
            200,
            22
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
            "obj-4",
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
            "obj-13",
            0
          ],
          "order": 0
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
          "order": 0
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
          ],
          "order": 0
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
            "obj-21",
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
            "obj-22",
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
            "obj-25",
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
            "obj-26",
            0
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
            "obj-13",
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
            "obj-17",
            0
          ],
          "destination": [
            "obj-32",
            1
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
            "obj-21",
            0
          ],
          "destination": [
            "obj-33",
            1
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
            "obj-25",
            0
          ],
          "destination": [
            "obj-34",
            1
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
            "obj-29",
            0
          ],
          "destination": [
            "obj-35",
            1
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
            "obj-37",
            0
          ],
          "order": 0
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
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-37",
            0
          ],
          "destination": [
            "obj-40",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-37",
            0
          ],
          "destination": [
            "obj-40",
            1
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
            0
          ],
          "destination": [
            "obj-45",
            0
          ],
          "order": 0
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}