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
      1741.0,
      617.0
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
            1095.0,
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
            1095.0,
            75.0,
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
          "numoutlets": 3,
          "outlettype": [
            "signal",
            "signal",
            "signal"
          ],
          "patching_rect": [
            600.0,
            30.0,
            64.0,
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
            600.0,
            75.0,
            88.0,
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
            990.0,
            30.0,
            86.0,
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
                    94.0,
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
                    495.0,
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
                    135.0,
                    30.0,
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
                    105.0,
                    75.0,
                    69.0,
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
                    495.0,
                    75.0,
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
                    90.0,
                    120.0,
                    88.0,
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
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    75.0,
                    150.0,
                    121.0,
                    22.0
                  ],
                  "text": "gen~ @gen comp-engine.gendsp",
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
                    210.0,
                    150.0,
                    88.0,
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
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    195.0,
                    195.0,
                    121.0,
                    22.0
                  ],
                  "text": "gen~ @gen comp-engine.gendsp",
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
                    "signal"
                  ],
                  "patching_rect": [
                    330.0,
                    195.0,
                    121.0,
                    22.0
                  ],
                  "text": "gen~ @gen comp-engine.gendsp",
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
                    165.0,
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
                  "id": "obj-12",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    270.0,
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
                  "id": "obj-13",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    240.0,
                    330.0,
                    88.0,
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
                  "order": 0,
                  "midpoints": [
                    77.0,
                    63.5,
                    112.0,
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    142.0,
                    63.5,
                    167.0,
                    63.5
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
                    "obj-6",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    139.5,
                    108.5,
                    97.0,
                    108.5
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
                  "order": 0,
                  "midpoints": [
                    97.0,
                    146.0,
                    135.5,
                    146.0
                  ]
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
                  "order": 0,
                  "midpoints": [
                    121.66666666666667,
                    146.0,
                    217.0,
                    146.0
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
                  ],
                  "order": 0,
                  "midpoints": [
                    217.0,
                    183.5,
                    255.5,
                    183.5
                  ]
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
                  "order": 0,
                  "midpoints": [
                    241.66666666666666,
                    183.5,
                    390.5,
                    183.5
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
                    "obj-11",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    135.5,
                    206.0,
                    172.0,
                    206.0
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
                    "obj-11",
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    255.5,
                    228.5,
                    205.5,
                    228.5
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
                  ],
                  "order": 0,
                  "midpoints": [
                    188.75,
                    273.5,
                    277.0,
                    273.5
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    390.5,
                    251.0,
                    310.5,
                    251.0
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
            990.0,
            75.0,
            86.0,
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
                    1305.0,
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
                    51.0,
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
                    30.0,
                    75.0,
                    62.5,
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
                    30.0,
                    120.0,
                    71.0,
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
                    1305.0,
                    75.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90.0,
                    30.0,
                    83.0,
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
                    60.0,
                    150.0,
                    81.5,
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
                    60.0,
                    195.0,
                    97.5,
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
                    1305.0,
                    135.0,
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
                    165.0,
                    195.0,
                    67.0,
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
                    195.0,
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
                  "maxclass": "message",
                  "id": "obj-12",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    150.0,
                    75.0,
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
                    1305.0,
                    180.0,
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
                    135.0,
                    240.0,
                    116.0,
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
                    150.0,
                    285.0,
                    97.5,
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
                    270.0,
                    285.0,
                    97.5,
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
                    375.0,
                    285.0,
                    97.5,
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
                    480.0,
                    285.0,
                    97.5,
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
                    600.0,
                    285.0,
                    97.5,
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
                    720.0,
                    285.0,
                    97.5,
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
                    825.0,
                    285.0,
                    97.5,
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
                    930.0,
                    285.0,
                    97.5,
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
                    1050.0,
                    285.0,
                    97.5,
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
                    1170.0,
                    285.0,
                    97.5,
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
                  "order": 0,
                  "midpoints": [
                    55.5,
                    63.5,
                    85.5,
                    63.5
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
                  "order": 0,
                  "midpoints": [
                    37.0,
                    108.5,
                    65.5,
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
                    "obj-7",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    37.0,
                    146.0,
                    67.0,
                    146.0
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
                  "order": 0,
                  "midpoints": [
                    131.5,
                    101.0,
                    67.0,
                    101.0
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
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    67.0,
                    183.5,
                    108.75,
                    183.5
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
                    "obj-10",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    67.0,
                    183.5,
                    172.0,
                    183.5
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
                  ],
                  "order": 0,
                  "midpoints": [
                    226.0,
                    63.5,
                    157.0,
                    63.5
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
                    "obj-10",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    217.5,
                    146.0,
                    172.0,
                    146.0
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
                    "obj-14",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    172.0,
                    228.5,
                    193.0,
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
                    "obj-15",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    142.0,
                    273.5,
                    198.75,
                    273.5
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
                  "order": 0,
                  "midpoints": [
                    153.33333333333334,
                    273.5,
                    318.75,
                    273.5
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
                  "order": 0,
                  "midpoints": [
                    164.66666666666666,
                    273.5,
                    423.75,
                    273.5
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
                  "order": 0,
                  "midpoints": [
                    176.0,
                    273.5,
                    528.75,
                    273.5
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
                  "order": 0,
                  "midpoints": [
                    187.33333333333334,
                    273.5,
                    648.75,
                    273.5
                  ]
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
                  "order": 0,
                  "midpoints": [
                    198.66666666666669,
                    273.5,
                    768.75,
                    273.5
                  ]
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
                  "order": 0,
                  "midpoints": [
                    210.0,
                    273.5,
                    873.75,
                    273.5
                  ]
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
                  "order": 0,
                  "midpoints": [
                    221.33333333333334,
                    273.5,
                    978.75,
                    273.5
                  ]
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
                  "order": 0,
                  "midpoints": [
                    232.66666666666669,
                    273.5,
                    1098.75,
                    273.5
                  ]
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
                  "order": 0,
                  "midpoints": [
                    244.0,
                    273.5,
                    1218.75,
                    273.5
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
          "id": "obj-7",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            990.0,
            135.0,
            86.0,
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
                    465.0,
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
                    94.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    135.0,
                    30.0,
                    83.0,
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
                    150.0,
                    75.0,
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
                    ""
                  ],
                  "patching_rect": [
                    165.0,
                    120.0,
                    39.0,
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
                    105.0,
                    150.0,
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
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    225.0,
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
                  "id": "obj-8",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    195.0,
                    72.0,
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
                    285.0,
                    195.0,
                    80.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    240.0,
                    30.0,
                    83.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    330.0,
                    30.0,
                    83.0,
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
                    345.0,
                    75.0,
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
                    ""
                  ],
                  "patching_rect": [
                    360.0,
                    120.0,
                    39.0,
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
                    375.0,
                    195.0,
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
                  "id": "obj-15",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    120.0,
                    195.0,
                    88.0,
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
                  "order": 0,
                  "midpoints": [
                    77.0,
                    101.0,
                    112.0,
                    101.0
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    172.0,
                    146.0,
                    140.0,
                    146.0
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
                  "order": 0,
                  "midpoints": [
                    126.0,
                    183.5,
                    232.0,
                    183.5
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
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    248.75,
                    206.0,
                    66.0,
                    206.0
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
                  ],
                  "order": 0,
                  "midpoints": [
                    66.0,
                    206.0,
                    325.0,
                    206.0
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
                    "obj-9",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    281.5,
                    123.5,
                    325.0,
                    123.5
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
                  "order": 0,
                  "midpoints": [
                    325.0,
                    206.0,
                    382.0,
                    206.0
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    367.0,
                    168.5,
                    410.0,
                    168.5
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
                    "obj-7",
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    396.0,
                    206.0,
                    265.5,
                    206.0
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
                    "obj-15",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    325.0,
                    206.0,
                    164.0,
                    206.0
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
          "id": "obj-8",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            990.0,
            180.0,
            86.0,
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
                    360.0,
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
                    94.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    240.0,
                    30.0,
                    83.0,
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
                    255.0,
                    75.0,
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
                    ""
                  ],
                  "patching_rect": [
                    255.0,
                    120.0,
                    39.0,
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
                    150.0,
                    150.0,
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
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    120.0,
                    195.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    135.0,
                    30.0,
                    83.0,
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
                    135.0,
                    240.0,
                    88.0,
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
                  "order": 0,
                  "midpoints": [
                    77.0,
                    101.0,
                    157.0,
                    101.0
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    262.0,
                    146.0,
                    185.0,
                    146.0
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
                  "order": 0,
                  "midpoints": [
                    171.0,
                    183.5,
                    127.0,
                    183.5
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
                    "obj-7",
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    176.5,
                    123.5,
                    220.0,
                    123.5
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
            990.0,
            240.0,
            86.0,
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
                    360.0,
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
                    94.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    240.0,
                    30.0,
                    83.0,
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
                    255.0,
                    75.0,
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
                    ""
                  ],
                  "patching_rect": [
                    255.0,
                    120.0,
                    39.0,
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
                    150.0,
                    150.0,
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
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    120.0,
                    195.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    135.0,
                    30.0,
                    83.0,
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
                    135.0,
                    240.0,
                    88.0,
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
                  "order": 0,
                  "midpoints": [
                    77.0,
                    101.0,
                    157.0,
                    101.0
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    262.0,
                    146.0,
                    185.0,
                    146.0
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
                  "order": 0,
                  "midpoints": [
                    171.0,
                    183.5,
                    127.0,
                    183.5
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
                    "obj-7",
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    176.5,
                    123.5,
                    220.0,
                    123.5
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
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    127.0,
                    228.5,
                    179.0,
                    228.5
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
          "id": "obj-10",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            990.0,
            285.0,
            86.0,
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
                    615.0,
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
                    615.0,
                    75.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30.0,
                    30.0,
                    83.0,
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
                    30.0,
                    75.0,
                    101.0,
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
                    45.0,
                    120.0,
                    80.5,
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
                    30.0,
                    150.0,
                    97.0,
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
                    30.0,
                    195.0,
                    172.0,
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
                    150.0,
                    150.0,
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
                    105.0,
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
                  "id": "obj-10",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    105.0,
                    285.0,
                    42.0,
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
                    615.0,
                    135.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    135.0,
                    30.0,
                    83.0,
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
                    150.0,
                    75.0,
                    101.0,
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
                    150.0,
                    120.0,
                    80.5,
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
                    195.0,
                    150.0,
                    97.0,
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
                    225.0,
                    195.0,
                    172.0,
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
                    315.0,
                    150.0,
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
                    285.0,
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
                  "id": "obj-19",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    285.0,
                    285.0,
                    42.0,
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
                    615.0,
                    180.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    225.0,
                    30.0,
                    83.0,
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
                    255.0,
                    75.0,
                    101.0,
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
                    270.0,
                    120.0,
                    80.5,
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
                    360.0,
                    150.0,
                    97.0,
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
                    405.0,
                    195.0,
                    172.0,
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
                    480.0,
                    150.0,
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
                    480.0,
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
                  "id": "obj-28",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    480.0,
                    285.0,
                    42.0,
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
                    615.0,
                    225.0,
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
                    195.0,
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
                  "id": "obj-31",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    330.0,
                    360.0,
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
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    315.0,
                    405.0,
                    88.0,
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
                  "order": 0,
                  "midpoints": [
                    124.0,
                    108.5,
                    85.25,
                    108.5
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
                    "obj-6",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    118.5,
                    146.0,
                    78.5,
                    146.0
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
                  "order": 0,
                  "midpoints": [
                    78.5,
                    183.5,
                    37.0,
                    183.5
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
                    "obj-8",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    52.0,
                    146.0,
                    157.0,
                    146.0
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
                    "obj-7",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    170.0,
                    183.5,
                    37.0,
                    183.5
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
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    37.0,
                    228.5,
                    112.0,
                    228.5
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
                  ],
                  "order": 0,
                  "midpoints": [
                    116.0,
                    228.5,
                    145.5,
                    228.5
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
                  "order": 0,
                  "midpoints": [
                    176.5,
                    63.5,
                    200.5,
                    63.5
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
                    "obj-14",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    244.0,
                    108.5,
                    190.25,
                    108.5
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
                  "order": 0,
                  "midpoints": [
                    157.0,
                    146.0,
                    322.0,
                    146.0
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
                    "obj-16",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    335.0,
                    183.5,
                    232.0,
                    183.5
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
                    "obj-18",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    232.0,
                    228.5,
                    292.0,
                    228.5
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
                  "order": 0,
                  "midpoints": [
                    266.5,
                    63.5,
                    305.5,
                    63.5
                  ]
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
                  "order": 0,
                  "midpoints": [
                    349.0,
                    108.5,
                    310.25,
                    108.5
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
                  "order": 0,
                  "midpoints": [
                    343.5,
                    146.0,
                    408.5,
                    146.0
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
                  "order": 0,
                  "midpoints": [
                    277.0,
                    146.0,
                    487.0,
                    146.0
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
                    "obj-25",
                    0
                  ],
                  "order": 0,
                  "midpoints": [
                    500.0,
                    183.5,
                    412.0,
                    183.5
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
                  "order": 0,
                  "midpoints": [
                    412.0,
                    228.5,
                    487.0,
                    228.5
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    491.0,
                    228.5,
                    520.5,
                    228.5
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
                  "order": 0,
                  "midpoints": [
                    126.0,
                    318.5,
                    202.0,
                    318.5
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    306.0,
                    318.5,
                    235.5,
                    318.5
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
                    218.75,
                    356.0,
                    337.0,
                    356.0
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
                    1
                  ],
                  "order": 0,
                  "midpoints": [
                    501.0,
                    333.5,
                    370.5,
                    333.5
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
            1095.0,
            135.0,
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
            30.0,
            94.0,
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
            60.0,
            75.0,
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
            ""
          ],
          "patching_rect": [
            90.0,
            75.0,
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
            1095.0,
            180.0,
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
            135.0,
            30.0,
            94.0,
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
            180.0,
            75.0,
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
            ""
          ],
          "patching_rect": [
            195.0,
            75.0,
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
            1095.0,
            225.0,
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
            255.0,
            30.0,
            94.0,
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
            285.0,
            75.0,
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
            ""
          ],
          "patching_rect": [
            315.0,
            75.0,
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
            1095.0,
            285.0,
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
            360.0,
            30.0,
            94.0,
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
            390.0,
            75.0,
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
            ""
          ],
          "patching_rect": [
            420.0,
            75.0,
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
            1095.0,
            330.0,
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
            465.0,
            30.0,
            94.0,
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
            495.0,
            75.0,
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
            ""
          ],
          "patching_rect": [
            525.0,
            75.0,
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
            1095.0,
            375.0,
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
            105.0,
            225.0,
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
            180.0,
            270.0,
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
            285.0,
            315.0,
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
            390.0,
            360.0,
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
          "maxclass": "comment",
          "id": "obj-36",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1545.0,
            30.0,
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
            390.0,
            405.0,
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
            ""
          ],
          "patching_rect": [
            420.0,
            405.0,
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
            1545.0,
            75.0,
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
            390.0,
            555.0,
            35.0,
            22.0
          ],
          "text": "dac~",
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
          "maxclass": "comment",
          "id": "obj-41",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1545.0,
            135.0,
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
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            735.0,
            30.0,
            83.0,
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
            750.0,
            75.0,
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
            855.0,
            0.0,
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
            855.0,
            30.0,
            97.5,
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
            1545.0,
            180.0,
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
            1545.0,
            225.0,
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
            1545.0,
            285.0,
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
          "order": 0,
          "midpoints": [
            607.0,
            63.5,
            644.0,
            63.5
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
          "order": 0,
          "midpoints": [
            112.0,
            220.0,
            112.0,
            67.0,
            97.5,
            67.0
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
          "order": 0,
          "midpoints": [
            217.0,
            220.0,
            217.0,
            67.0,
            202.5,
            67.0
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
          "order": 0,
          "midpoints": [
            337.0,
            220.0,
            337.0,
            67.0,
            322.5,
            67.0
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
          "order": 0,
          "midpoints": [
            442.0,
            220.0,
            442.0,
            67.0,
            427.5,
            67.0
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
          "order": 0,
          "midpoints": [
            547.0,
            220.0,
            547.0,
            67.0,
            532.5,
            67.0
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
            "obj-32",
            0
          ],
          "order": 0,
          "midpoints": [
            67.0,
            220.0,
            112.0,
            220.0
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
            "obj-32",
            1
          ],
          "order": 0,
          "midpoints": [
            187.0,
            220.0,
            145.5,
            220.0
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
            128.75,
            258.5,
            187.0,
            258.5
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
            "obj-33",
            1
          ],
          "order": 0,
          "midpoints": [
            292.0,
            242.5,
            220.5,
            242.5
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
            203.75,
            303.5,
            292.0,
            303.5
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
            "obj-34",
            1
          ],
          "order": 0,
          "midpoints": [
            397.0,
            265.0,
            325.5,
            265.0
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
            308.75,
            348.5,
            397.0,
            348.5
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
            "obj-35",
            1
          ],
          "order": 0,
          "midpoints": [
            502.0,
            287.5,
            430.5,
            287.5
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
          "order": 0,
          "midpoints": [
            442.0,
            550.0,
            442.0,
            397.0,
            427.5,
            397.0
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
          "order": 0,
          "midpoints": [
            867.0,
            27.0,
            903.75,
            27.0
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