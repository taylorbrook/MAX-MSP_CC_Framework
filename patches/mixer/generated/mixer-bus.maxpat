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
			480.0,
			500.0
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
					"maxclass": "panel",
					"id": "obj-25",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						0,
						0,
						80,
						420
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						0.0,
						0.0,
						80.0,
						420.0
					],
					"background": 1,
					"ignoreclick": 1,
					"border": 0,
					"rounded": 7,
					"mode": 0,
					"bgfillcolor": {
						"type": "gradient",
						"color1": [
							0.94,
							0.94,
							0.96,
							1.0
						],
						"color2": [
							0.88,
							0.89,
							0.92,
							1.0
						],
						"color": [
							0.94,
							0.94,
							0.96,
							1.0
						],
						"angle": 270.0,
						"proportion": 0.39,
						"autogradient": 0
					}
				}
			},
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
						30,
						20,
						94.0,
						22.0
					],
					"text": "receive~ #2",
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
						100,
						20,
						94.0,
						22.0
					],
					"text": "receive~ #3",
					"fontname": "Arial",
					"fontsize": 12.0
				}
			},
			{
				"box": {
					"maxclass": "gain~",
					"id": "obj-3",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"signal"
					],
					"patching_rect": [
						200.0,
						60.0,
						36.0,
						130.0
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						22.0,
						28.0,
						36.0,
						220.0
					]
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
						100,
						110,
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
					"maxclass": "dial",
					"id": "obj-5",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						200,
						215,
						36.0,
						36.0
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						24.0,
						254.0,
						36.0,
						36.0
					]
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"id": "obj-6",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						250,
						215,
						40.5,
						22.0
					],
					"text": "/ 127.",
					"fontname": "Arial",
					"fontsize": 12.0
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"id": "obj-7",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						250,
						240,
						36.0,
						22.0
					],
					"text": "t f f",
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
						250,
						265,
						32.5,
						22.0
					],
					"text": "!- 1.",
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
						30,
						240,
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
					"id": "obj-10",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						100,
						240,
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
					"maxclass": "toggle",
					"id": "obj-11",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						200,
						290,
						24.0,
						24.0
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						24.0,
						298.0,
						20.0,
						20.0
					]
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"id": "obj-12",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						240,
						290,
						32.5,
						22.0
					],
					"text": "!- 1",
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
						"signal"
					],
					"patching_rect": [
						30,
						290,
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
					"id": "obj-14",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						100,
						290,
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
					"maxclass": "meter~",
					"id": "obj-15",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						30.0,
						335.0,
						24.0,
						80.0
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						8.0,
						328.0,
						28.0,
						80.0
					]
				}
			},
			{
				"box": {
					"maxclass": "meter~",
					"id": "obj-16",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100.0,
						335.0,
						24.0,
						80.0
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						44.0,
						328.0,
						28.0,
						80.0
					]
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
						200,
						335,
						88.0,
						22.0
					],
					"text": "send~ master-L",
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
						200,
						360,
						88.0,
						22.0
					],
					"text": "send~ master-R",
					"fontname": "Arial",
					"fontsize": 12.0
				}
			},
			{
				"box": {
					"maxclass": "outlet",
					"id": "obj-19",
					"numinlets": 2,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						30,
						430,
						30.0,
						30.0
					],
					"parameter_enable": 0,
					"comment": "Post-Fader Output Left"
				}
			},
			{
				"box": {
					"maxclass": "outlet",
					"id": "obj-20",
					"numinlets": 2,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						100,
						430,
						30.0,
						30.0
					],
					"parameter_enable": 0,
					"comment": "Post-Fader Output Right"
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
						320,
						20,
						62.0,
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
					"id": "obj-22",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						320,
						45,
						36.0,
						22.0
					],
					"text": "t b b b",
					"fontname": "Arial",
					"fontsize": 12.0
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
						320,
						75,
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
					"maxclass": "message",
					"id": "obj-24",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						370,
						75,
						40.0,
						22.0
					],
					"text": "64",
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
						0.0,
						0.0,
						58.0,
						20.0
					],
					"text": "Bus #1",
					"fontname": "Arial",
					"fontsize": 12,
					"presentation": 1,
					"presentation_rect": [
						5.0,
						5.0,
						70.0,
						18.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 1,
					"fontface": 1
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
						0.0,
						0.0,
						40.0,
						20.0
					],
					"text": "+6",
					"fontname": "Arial",
					"fontsize": 8.0,
					"presentation": 1,
					"presentation_rect": [
						0.0,
						23.0,
						20.0,
						12.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 2
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"id": "obj-28",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						20.0
					],
					"text": "0",
					"fontname": "Arial",
					"fontsize": 8.0,
					"presentation": 1,
					"presentation_rect": [
						0.0,
						63.63694267515922,
						20.0,
						12.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 2
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
						0.0,
						0.0,
						40.0,
						20.0
					],
					"text": "-6",
					"fontname": "Arial",
					"fontsize": 8.0,
					"presentation": 1,
					"presentation_rect": [
						0.0,
						102.87261146496816,
						20.0,
						12.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 2
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"id": "obj-30",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						20.0
					],
					"text": "-12",
					"fontname": "Arial",
					"fontsize": 8.0,
					"presentation": 1,
					"presentation_rect": [
						0.0,
						125.29299363057325,
						20.0,
						12.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 2
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
						0.0,
						0.0,
						40.0,
						20.0
					],
					"text": "-24",
					"fontname": "Arial",
					"fontsize": 8.0,
					"presentation": 1,
					"presentation_rect": [
						0.0,
						164.52866242038218,
						20.0,
						12.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 2
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"id": "obj-32",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						20.0
					],
					"text": "-48",
					"fontname": "Arial",
					"fontsize": 8.0,
					"presentation": 1,
					"presentation_rect": [
						0.0,
						223.38216560509554,
						20.0,
						12.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 2
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
						0.0,
						0.0,
						40.0,
						20.0
					],
					"text": "Pan",
					"fontname": "Arial",
					"fontsize": 8,
					"presentation": 1,
					"presentation_rect": [
						5.0,
						258.0,
						18.0,
						12.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 2
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"id": "obj-34",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": [],
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						20.0
					],
					"text": "M",
					"fontname": "Arial",
					"fontsize": 8,
					"presentation": 1,
					"presentation_rect": [
						5.0,
						300.0,
						14.0,
						12.0
					],
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 2
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
						450,
						80,
						142.0,
						22.0
					],
					"text": "set Bus #1",
					"fontname": "Arial",
					"fontsize": 12.0
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-26",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						200.0,
						200.0,
						44.0,
						22.0
					],
					"text": "/ 128."
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
					],
					"midpoints": [
						77.0,
						51.0,
						218.0,
						51.0
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
						"obj-4",
						0
					],
					"midpoints": [
						147.0,
						76.0,
						107.0,
						76.0
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
						297.5,
						256.0,
						297.5,
						207,
						257.0,
						207
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
						"obj-8",
						0
					],
					"midpoints": [
						279.0,
						263.5,
						257.0,
						263.5
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
						1
					],
					"midpoints": [
						257.0,
						251.0,
						135.0,
						251.0
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
						1
					],
					"midpoints": [
						266.25,
						263.5,
						65.0,
						263.5
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
						"obj-9",
						0
					],
					"midpoints": [
						207.0,
						215.0,
						37.0,
						215.0
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
						"obj-10",
						0
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
					"midpoints": [
						279.5,
						319.0,
						279.5,
						282,
						247.0,
						282
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
						1
					],
					"midpoints": [
						256.25,
						301.0,
						65.0,
						301.0
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
					],
					"midpoints": [
						256.25,
						301.0,
						135.0,
						301.0
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
						"obj-13",
						0
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
						"obj-15",
						0
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
						"obj-16",
						0
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
						51.0,
						323.5,
						244.0,
						323.5
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
						"obj-18",
						0
					],
					"midpoints": [
						121.0,
						336.0,
						244.0,
						336.0
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
						"obj-19",
						0
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
						"obj-20",
						0
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
						"obj-24",
						0
					],
					"midpoints": [
						349.0,
						71.0,
						377.0,
						71.0
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
						"obj-3",
						0
					],
					"midpoints": [
						340.0,
						78.5,
						218.0,
						78.5
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
						"obj-5",
						0
					],
					"midpoints": [
						390.0,
						156.0,
						218.0,
						156.0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						2
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
						"obj-26",
						0
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
						"obj-26",
						0
					],
					"midpoints": [
						440.0,
						195.0,
						209.0,
						195.0
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
						"obj-4",
						1
					],
					"midpoints": [
						209.0,
						220.0,
						440.0,
						220.0,
						440.0,
						102.0,
						135.0,
						102.0
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
