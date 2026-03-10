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
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            30.0,
            30.0,
            86.0,
            22.0
          ],
          "text": "cycle~ 440",
          "fontname": "Arial",
          "fontsize": 12.0
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
            186.0,
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
          "maxclass": "ezdac~",
          "id": "obj-3",
          "numinlets": 2,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            314.0,
            30.0,
            45.0,
            45.0
          ],
          "parameter_enable": 0
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
            "obj-2",
            0
          ],
          "destination": [
            "obj-3",
            1
          ],
          "order": 0
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}
