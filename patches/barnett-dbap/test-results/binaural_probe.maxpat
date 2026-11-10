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
     "maxclass": "newobj",
     "id": "obj-1",
     "numinlets": 1,
     "numoutlets": 17,
     "outlettype": [
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal"
     ],
     "patching_rect": [
      40.0,
      60.0,
      520.0,
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
       600.0,
       450.0
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
         "maxclass": "codebox",
         "id": "obj-1",
         "numinlets": 0,
         "numoutlets": 17,
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
          50.0,
          80.0,
          400.0,
          200.0
         ],
         "parameter_enable": 0,
         "code": "History n(0);\nslot = floor(n / 12000);\nph = n - slot * 12000;\nch = slot - floor(slot / 18) * 18;\nimp = 0;\nif (ph < 0.5) {\n    imp = 0.5;\n}\nout1 = imp * (ch > -0.5 && ch < 0.5);\nout2 = imp * (ch > 0.5 && ch < 1.5);\nout3 = imp * (ch > 1.5 && ch < 2.5);\nout4 = imp * (ch > 2.5 && ch < 3.5);\nout5 = imp * (ch > 3.5 && ch < 4.5);\nout6 = imp * (ch > 4.5 && ch < 5.5);\nout7 = imp * (ch > 5.5 && ch < 6.5);\nout8 = imp * (ch > 6.5 && ch < 7.5);\nout9 = imp * (ch > 7.5 && ch < 8.5);\nout10 = imp * (ch > 8.5 && ch < 9.5);\nout11 = imp * (ch > 9.5 && ch < 10.5);\nout12 = imp * (ch > 10.5 && ch < 11.5);\nout13 = imp * (ch > 11.5 && ch < 12.5);\nout14 = imp * (ch > 12.5 && ch < 13.5);\nout15 = imp * (ch > 13.5 && ch < 14.5);\nout16 = imp * (ch > 14.5 && ch < 15.5);\nout17 = imp * (ch > 15.5 && ch < 16.5);\nn = n + 1;\n",
         "fontname": "Arial",
         "fontsize": 12.0
        }
       },
       {
        "box": {
         "maxclass": "newobj",
         "id": "obj-2",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          50.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 1",
         "fontname": "Arial",
         "fontsize": 12.0
        }
       },
       {
        "box": {
         "maxclass": "newobj",
         "id": "obj-3",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          130.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 2",
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
          320.0,
          30.0,
          22.0
         ],
         "text": "out 3",
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
          290.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 4",
         "fontname": "Arial",
         "fontsize": 12.0
        }
       },
       {
        "box": {
         "maxclass": "newobj",
         "id": "obj-6",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          370.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 5",
         "fontname": "Arial",
         "fontsize": 12.0
        }
       },
       {
        "box": {
         "maxclass": "newobj",
         "id": "obj-7",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          450.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 6",
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
          530.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 7",
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
          610.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 8",
         "fontname": "Arial",
         "fontsize": 12.0
        }
       },
       {
        "box": {
         "maxclass": "newobj",
         "id": "obj-10",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          690.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 9",
         "fontname": "Arial",
         "fontsize": 12.0
        }
       },
       {
        "box": {
         "maxclass": "newobj",
         "id": "obj-11",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          770.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 10",
         "fontname": "Arial",
         "fontsize": 12.0
        }
       },
       {
        "box": {
         "maxclass": "newobj",
         "id": "obj-12",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          850.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 11",
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
          930.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 12",
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
          1010.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 13",
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
          1090.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 14",
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
          1170.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 15",
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
          1250.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 16",
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
          1330.0,
          320.0,
          30.0,
          22.0
         ],
         "text": "out 17",
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
          "obj-2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-1",
          1
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
          "obj-1",
          2
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
          "obj-1",
          3
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
          "obj-1",
          4
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
          "obj-1",
          5
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
          "obj-1",
          6
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
          "obj-1",
          7
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
          "obj-1",
          8
         ],
         "destination": [
          "obj-10",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "obj-1",
          9
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
          "obj-1",
          10
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
          "obj-1",
          11
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
          12
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
          "obj-1",
          13
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
          "obj-1",
          14
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
          "obj-1",
          15
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
          "obj-1",
          16
         ],
         "destination": [
          "obj-18",
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
   },
   {
    "box": {
     "maxclass": "newobj",
     "id": "obj-2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      40.0,
      220.0,
      58.0,
      22.0
     ],
     "text": "*~ 0.1",
     "fontname": "Arial",
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "id": "obj-3",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      140.0,
      220.0,
      58.0,
      22.0
     ],
     "text": "*~ 0.1",
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
      400.0,
      220.0,
      58.0,
      22.0
     ],
     "text": "*~ 0.1",
     "fontname": "Arial",
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "maxclass": "newobj",
     "id": "obj-5",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      40.0,
      260.0,
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
     "id": "obj-6",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "patching_rect": [
      140.0,
      260.0,
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
     "id": "obj-7",
     "numinlets": 2,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      40.0,
      310.0,
      72.0,
      22.0
     ],
     "text": "dac~ 1 2",
     "fontname": "Arial",
     "fontsize": 12.0
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
      40,
      20,
      863.0,
      20.0
     ],
     "text": "binaural probe: 0.5 impulse into decoder inlet k every 12000 samples (k = 0..15), slot 16 = marker on L+R, slot 17 silent",
     "fontname": "Arial",
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-dec",
     "maxclass": "newobj",
     "text": "abc_3d_binaural3~",
     "numinlets": 16,
     "numoutlets": 3,
     "outlettype": [
      "signal",
      "signal",
      ""
     ],
     "patching_rect": [
      40.0,
      150.0,
      480.0,
      22.0
     ]
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "obj-1",
      16
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
      "obj-2",
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
      "obj-4",
      0
     ],
     "destination": [
      "obj-5",
      1
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
      "obj-6",
      0
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
      1
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
      "obj-dec",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      1
     ],
     "destination": [
      "obj-dec",
      1
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
      "obj-dec",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      3
     ],
     "destination": [
      "obj-dec",
      3
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      4
     ],
     "destination": [
      "obj-dec",
      4
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      5
     ],
     "destination": [
      "obj-dec",
      5
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      6
     ],
     "destination": [
      "obj-dec",
      6
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      7
     ],
     "destination": [
      "obj-dec",
      7
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      8
     ],
     "destination": [
      "obj-dec",
      8
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      9
     ],
     "destination": [
      "obj-dec",
      9
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      10
     ],
     "destination": [
      "obj-dec",
      10
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      11
     ],
     "destination": [
      "obj-dec",
      11
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      12
     ],
     "destination": [
      "obj-dec",
      12
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      13
     ],
     "destination": [
      "obj-dec",
      13
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      14
     ],
     "destination": [
      "obj-dec",
      14
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-1",
      15
     ],
     "destination": [
      "obj-dec",
      15
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-dec",
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
      "obj-dec",
      1
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   }
  ],
  "dependency_cache": [],
  "autosave": 0
 }
}