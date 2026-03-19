{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 9,
			"minor": 1,
			"revision": 2,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [
			85.0,
			104.0,
			630.0,
			632.0
		],
		"openinpresentation": 1,
		"boxes": [
			{
				"box": {
					"angle": 270.0,
					"background": 1,
					"grad1": [
						0.94,
						0.94,
						0.96,
						1.0
					],
					"grad2": [
						0.88,
						0.89,
						0.92,
						1.0
					],
					"id": "obj-43",
					"maxclass": "panel",
					"mode": 1,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						80.0,
						500.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						0.0,
						80.0,
						500.0
					],
					"proportion": 0.39,
					"rounded": 7
				}
			},
			{
				"box": {
					"comment": "Audio Input Left",
					"id": "obj-1",
					"index": 1,
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						30.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"comment": "Audio Input Right",
					"id": "obj-2",
					"index": 2,
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						100.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"comment": "Insert Return Left",
					"id": "obj-3",
					"index": 3,
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						240.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"comment": "Insert Return Right",
					"id": "obj-4",
					"index": 4,
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						300.0,
						20.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-5",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						55.0,
						20.0,
						65.0,
						20.0
					],
					"text": "Audio L"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-6",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						125.0,
						20.0,
						65.0,
						20.0
					],
					"text": "Audio R"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-7",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						265.0,
						20.0,
						79.0,
						20.0
					],
					"text": "Ins Ret L"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-8",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						325.0,
						20.0,
						79.0,
						20.0
					],
					"text": "Ins Ret R"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "dial",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"float"
					],
					"parameter_enable": 0,
					"patching_rect": [
						200.0,
						50.0,
						36.0,
						36.0
					],
					"presentation": 1,
					"presentation_rect": [
						24.0,
						24.0,
						36.0,
						36.0
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-10",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						250.0,
						60.0,
						111.0,
						22.0
					],
					"text": "scale 0 127 0. 2."
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-11",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						30.0,
						60.0,
						42.0,
						22.0
					],
					"text": "*~ 1."
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						100.0,
						60.0,
						42.0,
						22.0
					],
					"text": "*~ 1."
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						200.0,
						110.0,
						24.0,
						24.0
					],
					"presentation": 1,
					"presentation_rect": [
						30.0,
						64.0,
						20.0,
						20.0
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-14",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						240.0,
						110.0,
						32.5,
						22.0
					],
					"text": "+ 1"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-15",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						30.0,
						110.0,
						160.0,
						22.0
					],
					"text": "selector~ 2"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-16",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						100.0,
						110.0,
						160.0,
						22.0
					],
					"text": "selector~ 2"
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "gain~",
					"multichannelvariant": 0,
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						200.0,
						165.0,
						36.0,
						130.0
					],
					"presentation": 1,
					"presentation_rect": [
						22.0,
						100.0,
						36.0,
						220.0
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-18",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						100.0,
						215.0,
						42.0,
						22.0
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "dial",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"float"
					],
					"parameter_enable": 0,
					"patching_rect": [
						200.0,
						320.0,
						36.0,
						36.0
					],
					"presentation": 1,
					"presentation_rect": [
						24.0,
						326.0,
						36.0,
						36.0
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-20",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"float"
					],
					"patching_rect": [
						250.0,
						320.0,
						40.5,
						22.0
					],
					"text": "/ 127."
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-21",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"float",
						"float"
					],
					"patching_rect": [
						250.0,
						345.0,
						36.0,
						22.0
					],
					"text": "t f f"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-22",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"float"
					],
					"patching_rect": [
						250.0,
						370.0,
						32.5,
						22.0
					],
					"text": "!- 1."
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-23",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						30.0,
						345.0,
						42.0,
						22.0
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-24",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						100.0,
						345.0,
						42.0,
						22.0
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						200.0,
						390.0,
						24.0,
						24.0
					],
					"presentation": 1,
					"presentation_rect": [
						24.0,
						370.0,
						20.0,
						20.0
					]
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
						"int"
					],
					"patching_rect": [
						240.0,
						390.0,
						32.5,
						22.0
					],
					"text": "!- 1"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-27",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						30.0,
						390.0,
						42.0,
						22.0
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-28",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						100.0,
						390.0,
						42.0,
						22.0
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "meter~",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"float"
					],
					"patching_rect": [
						30.0,
						435.0,
						24.0,
						80.0
					],
					"presentation": 1,
					"presentation_rect": [
						8.0,
						400.0,
						28.0,
						90.0
					]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "meter~",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"float"
					],
					"patching_rect": [
						100.0,
						435.0,
						24.0,
						80.0
					],
					"presentation": 1,
					"presentation_rect": [
						44.0,
						400.0,
						28.0,
						90.0
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-31",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						200.0,
						435.0,
						92.0,
						22.0
					],
					"text": "send~ master-L"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-32",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						200.0,
						460.0,
						94.0,
						22.0
					],
					"text": "send~ master-R"
				}
			},
			{
				"box": {
					"comment": "Post-Fader Output Left",
					"id": "obj-33",
					"index": 1,
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						530.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"comment": "Post-Fader Output Right",
					"id": "obj-34",
					"index": 2,
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						100.0,
						530.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"comment": "Pre-Fader Send Left",
					"id": "obj-35",
					"index": 3,
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						200.0,
						530.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"comment": "Pre-Fader Send Right",
					"id": "obj-36",
					"index": 4,
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						260.0,
						530.0,
						30.0,
						30.0
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-37",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 0,
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 9,
							"minor": 1,
							"revision": 2,
							"architecture": "x64",
							"modernui": 1
						},
						"classnamespace": "box",
						"rect": [
							100.0,
							100.0,
							1275.0,
							300.0
						],
						"boxes": [
							{
								"box": {
									"comment": "",
									"id": "obj-1",
									"index": 1,
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										30.0,
										15.0,
										30.0,
										30.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-2",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										60.0,
										15.0,
										51.0,
										20.0
									],
									"text": "Pre L"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-3",
									"index": 2,
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										216.0,
										15.0,
										30.0,
										30.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-4",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										246.0,
										15.0,
										51.0,
										20.0
									],
									"text": "Pre R"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-5",
									"index": 3,
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										402.0,
										15.0,
										30.0,
										30.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-6",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										432.0,
										15.0,
										79.0,
										20.0
									],
									"text": "PostFdr L"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-7",
									"index": 4,
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										588.0,
										15.0,
										30.0,
										30.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-8",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										618.0,
										15.0,
										79.0,
										20.0
									],
									"text": "PostFdr R"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-9",
									"index": 5,
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										774.0,
										15.0,
										30.0,
										30.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-10",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										804.0,
										15.0,
										79.0,
										20.0
									],
									"text": "PostPan L"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-11",
									"index": 6,
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										960.0,
										15.0,
										30.0,
										30.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-12",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										990.0,
										15.0,
										79.0,
										20.0
									],
									"text": "PostPan R"
								}
							},
							{
								"box": {
									"fontface": 1,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-13",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										30.0,
										55.0,
										58.0,
										20.0
									],
									"text": "Send 1",
									"textcolor": [
										0.3,
										0.3,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-14",
									"items": [
										"Pre-Fader",
										",",
										"Post-Fader",
										",",
										"Post-Pan"
									],
									"maxclass": "umenu",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"int",
										"",
										""
									],
									"parameter_enable": 0,
									"patching_rect": [
										30.0,
										80.0,
										90.0,
										22.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-15",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										30.0,
										110.0,
										32.5,
										22.0
									],
									"text": "+ 1"
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "dial",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"parameter_enable": 0,
									"patching_rect": [
										80.0,
										80.0,
										34.0,
										34.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-17",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										80.0,
										120.0,
										40.5,
										22.0
									],
									"text": "/ 127."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-18",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										30.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-19",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										95.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-20",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										30.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-21",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										95.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-22",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										30.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-1-L"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-23",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										95.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-1-R"
								}
							},
							{
								"box": {
									"fontface": 1,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-24",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										170.0,
										55.0,
										58.0,
										20.0
									],
									"text": "Send 2",
									"textcolor": [
										0.3,
										0.3,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-25",
									"items": [
										"Pre-Fader",
										",",
										"Post-Fader",
										",",
										"Post-Pan"
									],
									"maxclass": "umenu",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"int",
										"",
										""
									],
									"parameter_enable": 0,
									"patching_rect": [
										170.0,
										80.0,
										90.0,
										22.0
									]
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
										"int"
									],
									"patching_rect": [
										170.0,
										110.0,
										32.5,
										22.0
									],
									"text": "+ 1"
								}
							},
							{
								"box": {
									"id": "obj-27",
									"maxclass": "dial",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"parameter_enable": 0,
									"patching_rect": [
										220.0,
										80.0,
										34.0,
										34.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-28",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										220.0,
										120.0,
										40.5,
										22.0
									],
									"text": "/ 127."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-29",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										170.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-30",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										235.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-31",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										170.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-32",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										235.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-33",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										170.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-2-L"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-34",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										235.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-2-R"
								}
							},
							{
								"box": {
									"fontface": 1,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-35",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										310.0,
										55.0,
										58.0,
										20.0
									],
									"text": "Send 3",
									"textcolor": [
										0.3,
										0.3,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-36",
									"items": [
										"Pre-Fader",
										",",
										"Post-Fader",
										",",
										"Post-Pan"
									],
									"maxclass": "umenu",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"int",
										"",
										""
									],
									"parameter_enable": 0,
									"patching_rect": [
										310.0,
										80.0,
										90.0,
										22.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-37",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										310.0,
										110.0,
										32.5,
										22.0
									],
									"text": "+ 1"
								}
							},
							{
								"box": {
									"id": "obj-38",
									"maxclass": "dial",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"parameter_enable": 0,
									"patching_rect": [
										360.0,
										80.0,
										34.0,
										34.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-39",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										360.0,
										120.0,
										40.5,
										22.0
									],
									"text": "/ 127."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-40",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										310.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-41",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										375.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-42",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										310.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-43",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										375.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-44",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										310.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-3-L"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-45",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										375.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-3-R"
								}
							},
							{
								"box": {
									"fontface": 1,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-46",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										450.0,
										55.0,
										58.0,
										20.0
									],
									"text": "Send 4",
									"textcolor": [
										0.3,
										0.3,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-47",
									"items": [
										"Pre-Fader",
										",",
										"Post-Fader",
										",",
										"Post-Pan"
									],
									"maxclass": "umenu",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"int",
										"",
										""
									],
									"parameter_enable": 0,
									"patching_rect": [
										450.0,
										80.0,
										90.0,
										22.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-48",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										450.0,
										110.0,
										32.5,
										22.0
									],
									"text": "+ 1"
								}
							},
							{
								"box": {
									"id": "obj-49",
									"maxclass": "dial",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"parameter_enable": 0,
									"patching_rect": [
										500.0,
										80.0,
										34.0,
										34.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-50",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										500.0,
										120.0,
										40.5,
										22.0
									],
									"text": "/ 127."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-51",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										450.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-52",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										515.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-53",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										450.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-54",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										515.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-55",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										450.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-4-L"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-56",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										515.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-4-R"
								}
							},
							{
								"box": {
									"fontface": 1,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-57",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										590.0,
										55.0,
										58.0,
										20.0
									],
									"text": "Send 5",
									"textcolor": [
										0.3,
										0.3,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-58",
									"items": [
										"Pre-Fader",
										",",
										"Post-Fader",
										",",
										"Post-Pan"
									],
									"maxclass": "umenu",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"int",
										"",
										""
									],
									"parameter_enable": 0,
									"patching_rect": [
										590.0,
										80.0,
										90.0,
										22.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-59",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										590.0,
										110.0,
										32.5,
										22.0
									],
									"text": "+ 1"
								}
							},
							{
								"box": {
									"id": "obj-60",
									"maxclass": "dial",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"parameter_enable": 0,
									"patching_rect": [
										640.0,
										80.0,
										34.0,
										34.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-61",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										640.0,
										120.0,
										40.5,
										22.0
									],
									"text": "/ 127."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-62",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										590.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-63",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										655.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-64",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										590.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-65",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										655.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-66",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										590.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-5-L"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-67",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										655.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-5-R"
								}
							},
							{
								"box": {
									"fontface": 1,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-68",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										730.0,
										55.0,
										58.0,
										20.0
									],
									"text": "Send 6",
									"textcolor": [
										0.3,
										0.3,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-69",
									"items": [
										"Pre-Fader",
										",",
										"Post-Fader",
										",",
										"Post-Pan"
									],
									"maxclass": "umenu",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"int",
										"",
										""
									],
									"parameter_enable": 0,
									"patching_rect": [
										730.0,
										80.0,
										90.0,
										22.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-70",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										730.0,
										110.0,
										32.5,
										22.0
									],
									"text": "+ 1"
								}
							},
							{
								"box": {
									"id": "obj-71",
									"maxclass": "dial",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"parameter_enable": 0,
									"patching_rect": [
										780.0,
										80.0,
										34.0,
										34.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-72",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										780.0,
										120.0,
										40.5,
										22.0
									],
									"text": "/ 127."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-73",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										730.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-74",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										795.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-75",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										730.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-76",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										795.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-77",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										730.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-6-L"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-78",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										795.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-6-R"
								}
							},
							{
								"box": {
									"fontface": 1,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-79",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										870.0,
										55.0,
										58.0,
										20.0
									],
									"text": "Send 7",
									"textcolor": [
										0.3,
										0.3,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-80",
									"items": [
										"Pre-Fader",
										",",
										"Post-Fader",
										",",
										"Post-Pan"
									],
									"maxclass": "umenu",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"int",
										"",
										""
									],
									"parameter_enable": 0,
									"patching_rect": [
										870.0,
										80.0,
										90.0,
										22.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-81",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										870.0,
										110.0,
										32.5,
										22.0
									],
									"text": "+ 1"
								}
							},
							{
								"box": {
									"id": "obj-82",
									"maxclass": "dial",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"parameter_enable": 0,
									"patching_rect": [
										920.0,
										80.0,
										34.0,
										34.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-83",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										920.0,
										120.0,
										40.5,
										22.0
									],
									"text": "/ 127."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-84",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										870.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-85",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										935.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-86",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										870.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-87",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										935.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-88",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										870.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-7-L"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-89",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										935.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-7-R"
								}
							},
							{
								"box": {
									"fontface": 1,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-90",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										1010.0,
										55.0,
										58.0,
										20.0
									],
									"text": "Send 8",
									"textcolor": [
										0.3,
										0.3,
										0.35,
										1.0
									]
								}
							},
							{
								"box": {
									"id": "obj-91",
									"items": [
										"Pre-Fader",
										",",
										"Post-Fader",
										",",
										"Post-Pan"
									],
									"maxclass": "umenu",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"int",
										"",
										""
									],
									"parameter_enable": 0,
									"patching_rect": [
										1010.0,
										80.0,
										90.0,
										22.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-92",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										1010.0,
										110.0,
										32.5,
										22.0
									],
									"text": "+ 1"
								}
							},
							{
								"box": {
									"id": "obj-93",
									"maxclass": "dial",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"parameter_enable": 0,
									"patching_rect": [
										1060.0,
										80.0,
										34.0,
										34.0
									]
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-94",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										1060.0,
										120.0,
										40.5,
										22.0
									],
									"text": "/ 127."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-95",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										1010.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-96",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										1075.0,
										150.0,
										160.0,
										22.0
									],
									"text": "selector~ 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-97",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										1010.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-98",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										1075.0,
										185.0,
										42.0,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-99",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										1010.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-8-L"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-100",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										1075.0,
										215.0,
										88.0,
										22.0
									],
									"text": "send~ bus-8-R"
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-18",
										1
									],
									"midpoints": [
										39.5,
										97.5,
										86.5,
										97.5
									],
									"order": 7,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-29",
										1
									],
									"midpoints": [
										39.5,
										97.5,
										226.5,
										97.5
									],
									"order": 6,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-40",
										1
									],
									"midpoints": [
										39.5,
										97.5,
										366.5,
										97.5
									],
									"order": 5,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-51",
										1
									],
									"midpoints": [
										39.5,
										97.5,
										506.5,
										97.5
									],
									"order": 4,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-62",
										1
									],
									"midpoints": [
										39.5,
										97.5,
										646.5,
										97.5
									],
									"order": 3,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-73",
										1
									],
									"midpoints": [
										39.5,
										97.5,
										786.5,
										97.5
									],
									"order": 2,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-84",
										1
									],
									"midpoints": [
										39.5,
										97.5,
										926.5,
										97.5
									],
									"order": 1,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-95",
										1
									],
									"midpoints": [
										39.5,
										97.5,
										1066.5,
										97.5
									],
									"order": 0,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-19",
										3
									],
									"midpoints": [
										969.5,
										97.5,
										245.5,
										97.5
									],
									"order": 7,
									"source": [
										"obj-11",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-30",
										3
									],
									"midpoints": [
										969.5,
										97.5,
										385.5,
										97.5
									],
									"order": 6,
									"source": [
										"obj-11",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										3
									],
									"midpoints": [
										969.5,
										97.5,
										525.5,
										97.5
									],
									"order": 5,
									"source": [
										"obj-11",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-52",
										3
									],
									"midpoints": [
										969.5,
										97.5,
										665.5,
										97.5
									],
									"order": 4,
									"source": [
										"obj-11",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-63",
										3
									],
									"midpoints": [
										969.5,
										97.5,
										805.5,
										97.5
									],
									"order": 3,
									"source": [
										"obj-11",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-74",
										3
									],
									"midpoints": [
										969.5,
										97.5,
										945.5,
										97.5
									],
									"order": 2,
									"source": [
										"obj-11",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-85",
										3
									],
									"midpoints": [
										969.5,
										97.5,
										1085.5,
										97.5
									],
									"order": 1,
									"source": [
										"obj-11",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-96",
										3
									],
									"midpoints": [
										969.5,
										97.5,
										1225.5,
										97.5
									],
									"order": 0,
									"source": [
										"obj-11",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-15",
										0
									],
									"source": [
										"obj-14",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-18",
										0
									],
									"order": 1,
									"source": [
										"obj-15",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-19",
										0
									],
									"midpoints": [
										39.5,
										141.0,
										104.5,
										141.0
									],
									"order": 0,
									"source": [
										"obj-15",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-17",
										0
									],
									"source": [
										"obj-16",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-20",
										1
									],
									"midpoints": [
										89.5,
										163.5,
										62.5,
										163.5
									],
									"order": 1,
									"source": [
										"obj-17",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-21",
										1
									],
									"midpoints": [
										89.5,
										163.5,
										127.5,
										163.5
									],
									"order": 0,
									"source": [
										"obj-17",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-20",
										0
									],
									"midpoints": [
										39.5,
										178.5,
										39.5,
										178.5
									],
									"source": [
										"obj-18",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-21",
										0
									],
									"midpoints": [
										104.5,
										178.5,
										104.5,
										178.5
									],
									"source": [
										"obj-19",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-22",
										0
									],
									"midpoints": [
										39.5,
										211.0,
										39.5,
										211.0
									],
									"source": [
										"obj-20",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-23",
										0
									],
									"midpoints": [
										104.5,
										211.0,
										104.5,
										211.0
									],
									"source": [
										"obj-21",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-26",
										0
									],
									"source": [
										"obj-25",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-29",
										0
									],
									"order": 1,
									"source": [
										"obj-26",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-30",
										0
									],
									"midpoints": [
										179.5,
										141.0,
										244.5,
										141.0
									],
									"order": 0,
									"source": [
										"obj-26",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-28",
										0
									],
									"source": [
										"obj-27",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-31",
										1
									],
									"midpoints": [
										229.5,
										163.5,
										202.5,
										163.5
									],
									"order": 1,
									"source": [
										"obj-28",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-32",
										1
									],
									"midpoints": [
										229.5,
										163.5,
										267.5,
										163.5
									],
									"order": 0,
									"source": [
										"obj-28",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-31",
										0
									],
									"midpoints": [
										179.5,
										178.5,
										179.5,
										178.5
									],
									"source": [
										"obj-29",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-19",
										1
									],
									"midpoints": [
										225.5,
										97.5,
										151.5,
										97.5
									],
									"order": 7,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-30",
										1
									],
									"midpoints": [
										225.5,
										97.5,
										291.5,
										97.5
									],
									"order": 6,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										1
									],
									"midpoints": [
										225.5,
										97.5,
										431.5,
										97.5
									],
									"order": 5,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-52",
										1
									],
									"midpoints": [
										225.5,
										97.5,
										571.5,
										97.5
									],
									"order": 4,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-63",
										1
									],
									"midpoints": [
										225.5,
										97.5,
										711.5,
										97.5
									],
									"order": 3,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-74",
										1
									],
									"midpoints": [
										225.5,
										97.5,
										851.5,
										97.5
									],
									"order": 2,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-85",
										1
									],
									"midpoints": [
										225.5,
										97.5,
										991.5,
										97.5
									],
									"order": 1,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-96",
										1
									],
									"midpoints": [
										225.5,
										97.5,
										1131.5,
										97.5
									],
									"order": 0,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-32",
										0
									],
									"midpoints": [
										244.5,
										178.5,
										244.5,
										178.5
									],
									"source": [
										"obj-30",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-33",
										0
									],
									"midpoints": [
										179.5,
										211.0,
										179.5,
										211.0
									],
									"source": [
										"obj-31",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-34",
										0
									],
									"midpoints": [
										244.5,
										211.0,
										244.5,
										211.0
									],
									"source": [
										"obj-32",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-37",
										0
									],
									"source": [
										"obj-36",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-40",
										0
									],
									"order": 1,
									"source": [
										"obj-37",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										0
									],
									"midpoints": [
										319.5,
										141.0,
										384.5,
										141.0
									],
									"order": 0,
									"source": [
										"obj-37",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-39",
										0
									],
									"source": [
										"obj-38",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-42",
										1
									],
									"midpoints": [
										369.5,
										163.5,
										342.5,
										163.5
									],
									"order": 1,
									"source": [
										"obj-39",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-43",
										1
									],
									"midpoints": [
										369.5,
										163.5,
										407.5,
										163.5
									],
									"order": 0,
									"source": [
										"obj-39",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-42",
										0
									],
									"midpoints": [
										319.5,
										178.5,
										319.5,
										178.5
									],
									"source": [
										"obj-40",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-43",
										0
									],
									"midpoints": [
										384.5,
										178.5,
										384.5,
										178.5
									],
									"source": [
										"obj-41",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-44",
										0
									],
									"midpoints": [
										319.5,
										211.0,
										319.5,
										211.0
									],
									"source": [
										"obj-42",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-45",
										0
									],
									"midpoints": [
										384.5,
										211.0,
										384.5,
										211.0
									],
									"source": [
										"obj-43",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-48",
										0
									],
									"source": [
										"obj-47",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-51",
										0
									],
									"order": 1,
									"source": [
										"obj-48",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-52",
										0
									],
									"midpoints": [
										459.5,
										141.0,
										524.5,
										141.0
									],
									"order": 0,
									"source": [
										"obj-48",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-50",
										0
									],
									"source": [
										"obj-49",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-18",
										2
									],
									"midpoints": [
										411.5,
										97.5,
										133.5,
										97.5
									],
									"order": 7,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-29",
										2
									],
									"midpoints": [
										411.5,
										97.5,
										273.5,
										97.5
									],
									"order": 6,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-40",
										2
									],
									"order": 5,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-51",
										2
									],
									"midpoints": [
										411.5,
										97.5,
										553.5,
										97.5
									],
									"order": 4,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-62",
										2
									],
									"midpoints": [
										411.5,
										97.5,
										693.5,
										97.5
									],
									"order": 3,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-73",
										2
									],
									"midpoints": [
										411.5,
										97.5,
										833.5,
										97.5
									],
									"order": 2,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-84",
										2
									],
									"midpoints": [
										411.5,
										97.5,
										973.5,
										97.5
									],
									"order": 1,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-95",
										2
									],
									"midpoints": [
										411.5,
										97.5,
										1113.5,
										97.5
									],
									"order": 0,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-53",
										1
									],
									"midpoints": [
										509.5,
										163.5,
										482.5,
										163.5
									],
									"order": 1,
									"source": [
										"obj-50",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-54",
										1
									],
									"midpoints": [
										509.5,
										163.5,
										547.5,
										163.5
									],
									"order": 0,
									"source": [
										"obj-50",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-53",
										0
									],
									"midpoints": [
										459.5,
										178.5,
										459.5,
										178.5
									],
									"source": [
										"obj-51",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-54",
										0
									],
									"midpoints": [
										524.5,
										178.5,
										524.5,
										178.5
									],
									"source": [
										"obj-52",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-55",
										0
									],
									"midpoints": [
										459.5,
										211.0,
										459.5,
										211.0
									],
									"source": [
										"obj-53",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-56",
										0
									],
									"midpoints": [
										524.5,
										211.0,
										524.5,
										211.0
									],
									"source": [
										"obj-54",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-59",
										0
									],
									"source": [
										"obj-58",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-62",
										0
									],
									"order": 1,
									"source": [
										"obj-59",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-63",
										0
									],
									"midpoints": [
										599.5,
										141.0,
										664.5,
										141.0
									],
									"order": 0,
									"source": [
										"obj-59",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-61",
										0
									],
									"source": [
										"obj-60",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-64",
										1
									],
									"midpoints": [
										649.5,
										163.5,
										622.5,
										163.5
									],
									"order": 1,
									"source": [
										"obj-61",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-65",
										1
									],
									"midpoints": [
										649.5,
										163.5,
										687.5,
										163.5
									],
									"order": 0,
									"source": [
										"obj-61",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-64",
										0
									],
									"midpoints": [
										599.5,
										178.5,
										599.5,
										178.5
									],
									"source": [
										"obj-62",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-65",
										0
									],
									"midpoints": [
										664.5,
										178.5,
										664.5,
										178.5
									],
									"source": [
										"obj-63",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-66",
										0
									],
									"midpoints": [
										599.5,
										211.0,
										599.5,
										211.0
									],
									"source": [
										"obj-64",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-67",
										0
									],
									"midpoints": [
										664.5,
										211.0,
										664.5,
										211.0
									],
									"source": [
										"obj-65",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-70",
										0
									],
									"source": [
										"obj-69",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-19",
										2
									],
									"midpoints": [
										597.5,
										97.5,
										198.5,
										97.5
									],
									"order": 7,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-30",
										2
									],
									"midpoints": [
										597.5,
										97.5,
										338.5,
										97.5
									],
									"order": 6,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										2
									],
									"midpoints": [
										597.5,
										97.5,
										478.5,
										97.5
									],
									"order": 5,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-52",
										2
									],
									"order": 4,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-63",
										2
									],
									"midpoints": [
										597.5,
										97.5,
										758.5,
										97.5
									],
									"order": 3,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-74",
										2
									],
									"midpoints": [
										597.5,
										97.5,
										898.5,
										97.5
									],
									"order": 2,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-85",
										2
									],
									"midpoints": [
										597.5,
										97.5,
										1038.5,
										97.5
									],
									"order": 1,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-96",
										2
									],
									"midpoints": [
										597.5,
										97.5,
										1178.5,
										97.5
									],
									"order": 0,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-73",
										0
									],
									"order": 1,
									"source": [
										"obj-70",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-74",
										0
									],
									"midpoints": [
										739.5,
										141.0,
										804.5,
										141.0
									],
									"order": 0,
									"source": [
										"obj-70",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-72",
										0
									],
									"source": [
										"obj-71",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-75",
										1
									],
									"midpoints": [
										789.5,
										163.5,
										762.5,
										163.5
									],
									"order": 1,
									"source": [
										"obj-72",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-76",
										1
									],
									"midpoints": [
										789.5,
										163.5,
										827.5,
										163.5
									],
									"order": 0,
									"source": [
										"obj-72",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-75",
										0
									],
									"midpoints": [
										739.5,
										178.5,
										739.5,
										178.5
									],
									"source": [
										"obj-73",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-76",
										0
									],
									"midpoints": [
										804.5,
										178.5,
										804.5,
										178.5
									],
									"source": [
										"obj-74",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-77",
										0
									],
									"midpoints": [
										739.5,
										211.0,
										739.5,
										211.0
									],
									"source": [
										"obj-75",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-78",
										0
									],
									"midpoints": [
										804.5,
										211.0,
										804.5,
										211.0
									],
									"source": [
										"obj-76",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-81",
										0
									],
									"source": [
										"obj-80",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-84",
										0
									],
									"order": 1,
									"source": [
										"obj-81",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-85",
										0
									],
									"midpoints": [
										879.5,
										141.0,
										944.5,
										141.0
									],
									"order": 0,
									"source": [
										"obj-81",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-83",
										0
									],
									"source": [
										"obj-82",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-86",
										1
									],
									"midpoints": [
										929.5,
										163.5,
										902.5,
										163.5
									],
									"order": 1,
									"source": [
										"obj-83",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-87",
										1
									],
									"midpoints": [
										929.5,
										163.5,
										967.5,
										163.5
									],
									"order": 0,
									"source": [
										"obj-83",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-86",
										0
									],
									"midpoints": [
										879.5,
										178.5,
										879.5,
										178.5
									],
									"source": [
										"obj-84",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-87",
										0
									],
									"midpoints": [
										944.5,
										178.5,
										944.5,
										178.5
									],
									"source": [
										"obj-85",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-88",
										0
									],
									"midpoints": [
										879.5,
										211.0,
										879.5,
										211.0
									],
									"source": [
										"obj-86",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-89",
										0
									],
									"midpoints": [
										944.5,
										211.0,
										944.5,
										211.0
									],
									"source": [
										"obj-87",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-18",
										3
									],
									"midpoints": [
										783.5,
										97.5,
										180.5,
										97.5
									],
									"order": 7,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-29",
										3
									],
									"midpoints": [
										783.5,
										97.5,
										320.5,
										97.5
									],
									"order": 6,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-40",
										3
									],
									"midpoints": [
										783.5,
										97.5,
										460.5,
										97.5
									],
									"order": 5,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-51",
										3
									],
									"midpoints": [
										783.5,
										97.5,
										600.5,
										97.5
									],
									"order": 4,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-62",
										3
									],
									"midpoints": [
										783.5,
										97.5,
										740.5,
										97.5
									],
									"order": 3,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-73",
										3
									],
									"midpoints": [
										783.5,
										97.5,
										880.5,
										97.5
									],
									"order": 2,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-84",
										3
									],
									"midpoints": [
										783.5,
										97.5,
										1020.5,
										97.5
									],
									"order": 1,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-95",
										3
									],
									"midpoints": [
										783.5,
										97.5,
										1160.5,
										97.5
									],
									"order": 0,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-92",
										0
									],
									"source": [
										"obj-91",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-95",
										0
									],
									"order": 1,
									"source": [
										"obj-92",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-96",
										0
									],
									"midpoints": [
										1019.5,
										141.0,
										1084.5,
										141.0
									],
									"order": 0,
									"source": [
										"obj-92",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-94",
										0
									],
									"source": [
										"obj-93",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-97",
										1
									],
									"midpoints": [
										1069.5,
										163.5,
										1042.5,
										163.5
									],
									"order": 1,
									"source": [
										"obj-94",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-98",
										1
									],
									"midpoints": [
										1069.5,
										163.5,
										1107.5,
										163.5
									],
									"order": 0,
									"source": [
										"obj-94",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-97",
										0
									],
									"midpoints": [
										1019.5,
										178.5,
										1019.5,
										178.5
									],
									"source": [
										"obj-95",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-98",
										0
									],
									"midpoints": [
										1084.5,
										178.5,
										1084.5,
										178.5
									],
									"source": [
										"obj-96",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-99",
										0
									],
									"midpoints": [
										1019.5,
										211.0,
										1019.5,
										211.0
									],
									"source": [
										"obj-97",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-100",
										0
									],
									"midpoints": [
										1084.5,
										211.0,
										1084.5,
										211.0
									],
									"source": [
										"obj-98",
										0
									]
								}
							}
						],
						"editing_bgcolor": [
							0.333,
							0.333,
							0.333,
							1.0
						]
					},
					"patching_rect": [
						30.0,
						570.0,
						200.0,
						22.0
					],
					"saved_object_attributes": {
						"editing_bgcolor": [
							0.333,
							0.333,
							0.333,
							1.0
						]
					},
					"text": "p sends"
				}
			},
			{
				"box": {
					"bgcolor": [
						0.85,
						0.92,
						0.85,
						1.0
					],
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-38",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						420.0,
						20.0,
						62.0,
						22.0
					],
					"text": "loadbang"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-39",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"bang",
						"bang",
						"bang",
						"bang"
					],
					"patching_rect": [
						420.0,
						45.0,
						52.0,
						22.0
					],
					"text": "t b b b b"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-40",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						420.0,
						75.0,
						40.0,
						22.0
					],
					"text": "128"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-41",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						470.0,
						75.0,
						40.0,
						22.0
					],
					"text": "64"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-42",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						520.0,
						75.0,
						40.0,
						22.0
					],
					"text": "64"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-44",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						5.0,
						5.0,
						70.0,
						20.0
					],
					"text": "Ch 1",
					"textcolor": [
						0.0,
						0.0,
						0.0,
						1.0
					],
					"textjustification": 1
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-45",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						44.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						5.0,
						28.0,
						25.0,
						15.0
					],
					"text": "Gain",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-46",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						5.0,
						67.0,
						19.0,
						15.0
					],
					"text": "Ins",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-47",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						95.0,
						20.0,
						15.0
					],
					"text": "+6",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-48",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						135.63694267515922,
						20.0,
						15.0
					],
					"text": "0",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-49",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						174.87261146496814,
						20.0,
						15.0
					],
					"text": "-6",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-50",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						197.29299363057325,
						20.0,
						15.0
					],
					"text": "-12",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-51",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						236.52866242038218,
						20.0,
						15.0
					],
					"text": "-24",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-52",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						0.0,
						295.38216560509557,
						20.0,
						15.0
					],
					"text": "-48",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-53",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						5.0,
						330.0,
						23.0,
						15.0
					],
					"text": "Pan",
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
					"fontname": "Arial",
					"fontsize": 8.0,
					"id": "obj-54",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						0.0,
						0.0,
						40.0,
						15.0
					],
					"presentation": 1,
					"presentation_rect": [
						5.0,
						372.0,
						15.0,
						15.0
					],
					"text": "M",
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
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-55",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						500.0,
						100.0,
						135.0,
						22.0
					],
					"text": "set Ch #1"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"destination": [
						"obj-11",
						0
					],
					"source": [
						"obj-1",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-11",
						1
					],
					"midpoints": [
						259.5,
						71.0,
						62.5,
						71.0
					],
					"order": 1,
					"source": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-12",
						1
					],
					"midpoints": [
						259.5,
						71.0,
						132.5,
						71.0
					],
					"order": 0,
					"source": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-15",
						1
					],
					"midpoints": [
						39.5,
						96.0,
						110.0,
						96.0
					],
					"order": 1,
					"source": [
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-35",
						0
					],
					"midpoints": [
						39.5,
						306.0,
						209.5,
						306.0
					],
					"order": 0,
					"source": [
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-16",
						1
					],
					"midpoints": [
						109.5,
						96.0,
						180.0,
						96.0
					],
					"order": 1,
					"source": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-36",
						0
					],
					"midpoints": [
						109.5,
						306.0,
						269.5,
						306.0
					],
					"order": 0,
					"source": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-14",
						0
					],
					"midpoints": [
						279.5,
						139.0,
						279.5,
						102.0,
						249.5,
						102.0
					],
					"source": [
						"obj-13",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-15",
						0
					],
					"midpoints": [
						249.5,
						121.0,
						39.5,
						121.0
					],
					"order": 1,
					"source": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-16",
						0
					],
					"midpoints": [
						249.5,
						121.0,
						109.5,
						121.0
					],
					"order": 0,
					"source": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-17",
						0
					],
					"midpoints": [
						39.5,
						148.5,
						209.5,
						148.5
					],
					"order": 0,
					"source": [
						"obj-15",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-37",
						0
					],
					"midpoints": [
						39.5,
						351.0,
						39.5,
						351.0
					],
					"order": 1,
					"source": [
						"obj-15",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"midpoints": [
						109.5,
						173.5,
						109.5,
						173.5
					],
					"order": 0,
					"source": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-37",
						1
					],
					"midpoints": [
						109.5,
						351.0,
						75.7,
						351.0
					],
					"order": 1,
					"source": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						1
					],
					"midpoints": [
						590.0,
						300.0,
						590.0,
						207.0,
						132.5,
						207.0
					],
					"source": [
						"obj-17",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-23",
						0
					],
					"midpoints": [
						209.5,
						320.0,
						39.5,
						320.0
					],
					"order": 1,
					"source": [
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-37",
						2
					],
					"midpoints": [
						209.5,
						432.5,
						111.9,
						432.5
					],
					"order": 0,
					"source": [
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-24",
						0
					],
					"order": 1,
					"source": [
						"obj-18",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-37",
						3
					],
					"midpoints": [
						109.5,
						403.5,
						148.1,
						403.5
					],
					"order": 0,
					"source": [
						"obj-18",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-20",
						0
					],
					"midpoints": [
						297.5,
						361.0,
						297.5,
						312.0,
						259.5,
						312.0
					],
					"source": [
						"obj-19",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-12",
						0
					],
					"source": [
						"obj-2",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-21",
						0
					],
					"source": [
						"obj-20",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-22",
						0
					],
					"midpoints": [
						276.5,
						368.5,
						259.5,
						368.5
					],
					"source": [
						"obj-21",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-24",
						1
					],
					"midpoints": [
						259.5,
						356.0,
						132.5,
						356.0
					],
					"source": [
						"obj-21",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-23",
						1
					],
					"midpoints": [
						259.5,
						368.5,
						62.5,
						368.5
					],
					"source": [
						"obj-22",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-27",
						0
					],
					"order": 1,
					"source": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-37",
						4
					],
					"midpoints": [
						39.5,
						468.5,
						184.3,
						468.5
					],
					"order": 0,
					"source": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-28",
						0
					],
					"order": 1,
					"source": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-37",
						5
					],
					"midpoints": [
						109.5,
						468.5,
						220.5,
						468.5
					],
					"order": 0,
					"source": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-26",
						0
					],
					"midpoints": [
						279.5,
						419.0,
						279.5,
						382.0,
						249.5,
						382.0
					],
					"source": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-27",
						1
					],
					"midpoints": [
						249.5,
						401.0,
						62.5,
						401.0
					],
					"order": 1,
					"source": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-28",
						1
					],
					"midpoints": [
						249.5,
						401.0,
						132.5,
						401.0
					],
					"order": 0,
					"source": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-29",
						0
					],
					"order": 2,
					"source": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-31",
						0
					],
					"midpoints": [
						39.5,
						423.5,
						209.5,
						423.5
					],
					"order": 0,
					"source": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-33",
						0
					],
					"order": 1,
					"source": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-30",
						0
					],
					"order": 2,
					"source": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-32",
						0
					],
					"midpoints": [
						109.5,
						436.0,
						209.5,
						436.0
					],
					"order": 0,
					"source": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-34",
						0
					],
					"order": 1,
					"source": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-15",
						2
					],
					"midpoints": [
						249.5,
						80.0,
						180.5,
						80.0
					],
					"source": [
						"obj-3",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-39",
						0
					],
					"source": [
						"obj-38",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-40",
						0
					],
					"source": [
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-41",
						0
					],
					"midpoints": [
						440.5,
						71.0,
						479.5,
						71.0
					],
					"source": [
						"obj-39",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-42",
						0
					],
					"midpoints": [
						451.5,
						71.0,
						529.5,
						71.0
					],
					"source": [
						"obj-39",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-55",
						0
					],
					"source": [
						"obj-39",
						3
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-16",
						2
					],
					"midpoints": [
						309.5,
						80.0,
						250.5,
						80.0
					],
					"source": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-17",
						0
					],
					"midpoints": [
						429.5,
						131.0,
						209.5,
						131.0
					],
					"source": [
						"obj-40",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-9",
						0
					],
					"midpoints": [
						479.5,
						73.5,
						209.5,
						73.5
					],
					"source": [
						"obj-41",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-19",
						0
					],
					"midpoints": [
						529.5,
						208.5,
						209.5,
						208.5
					],
					"source": [
						"obj-42",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-44",
						0
					],
					"source": [
						"obj-55",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-10",
						0
					],
					"midpoints": [
						209.5,
						73.0,
						259.5,
						73.0
					],
					"source": [
						"obj-9",
						0
					]
				}
			}
		],
		"editing_bgcolor": [
			0.333,
			0.333,
			0.333,
			1.0
		]
	}
}
