return {
	[101] = {
		talk_anchors = 0,
		type = "EnterStage",
		talk_adapt = 0,
		is_finish = false,
		id = 101,
		talk_content = "",
		params = {
			1010001
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[102] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		talk_adapt = 0,
		is_finish = true,
		id = 102,
		talk_content = "",
		params = {
			103,
			104,
			105,
			106,
			102
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[103] = {
		talk_anchors = 0,
		talk_position = "",
		type = "SetTeam",
		talk_adapt = 0,
		is_finish = false,
		id = 103,
		talk_content = "",
		params = {
			1084,
			0,
			0
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {}
	},
	[104] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 104,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				1,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				1,
				"buttonImage_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[105] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 105,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"battleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[106] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		mask_scale = "ARRAY",
		is_finish = false,
		id = 106,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		talk_position = {}
	},
	[107] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		talk_adapt = 0,
		is_finish = false,
		id = 107,
		talk_content = "",
		params = {
			true
		},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"confirmBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[201] = {
		talk_anchors = 0,
		type = "EnterStage",
		talk_adapt = 0,
		is_finish = false,
		id = 201,
		talk_content = "",
		params = {
			1010002
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[202] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		talk_adapt = 0,
		is_finish = true,
		id = 202,
		talk_content = "",
		params = {
			203,
			204,
			205,
			202
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[203] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 203,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				2,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				2,
				"buttonImage_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[204] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 204,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"battleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[205] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 205,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[206] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		talk_adapt = 0,
		is_finish = true,
		id = 206,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"confirmBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[301] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 301,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[302] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 302,
		talk_content = "进入源层前，先提升队伍的实力做准备吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-918,
			300
		}
	},
	[304] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 304,
		talk_content = "首先，试着提升薇儿丹蒂的作战等级吧。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				1,
				"heroInfoView_",
				"upgradeBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[305] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 305,
		talk_content = "学习资料已经准备好了，点击「升级」就可以快速获得作战知识。",
		params = {},
		guide_component = {
			"common",
			"heroUpgrade",
			{
				"okBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[306] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		talk_adapt = 0,
		is_finish = false,
		id = 306,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"newHeroUpgradeSuccess",
			{
				"bgBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[307] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 307,
		talk_content = "",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[308] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 308,
		talk_content = "此外，我们还可以通过提升技能等级来强化修正者的能力。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle2_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[309] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 309,
		talk_content = "返回主界面。",
		params = {},
		guide_component = {
			"windowBar",
			"homeBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			581,
			-218
		}
	},
	[405] = {
		talk_anchors = 0,
		talk_position = "",
		type = "SetTeam",
		talk_adapt = 0,
		is_finish = false,
		id = 405,
		talk_content = "",
		params = {
			1084,
			0,
			0
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {}
	},
	[406] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 406,
		talk_content = "",
		params = {
			313,
			10100,
			1010003,
			1,
			1
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[407] = {
		talk_anchors = 0,
		type = "EventTrigger",
		talk_adapt = 0,
		is_finish = false,
		id = 407,
		talk_content = "有新人加入了我们，将前鬼坊编入作战队伍吧。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"selectHeroView_",
				"drag_2"
			},
			"EventTriggerListener"
		},
		mask_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_addBtn2"
			}
		},
		mask_scale = {},
		talk_position = {
			109.4,
			-348
		}
	},
	[408] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 408,
		talk_content = "",
		params = {},
		guide_component = {
			"listIndex",
			"newHeroTeamInfo",
			{
				"heroHeadList_"
			},
			2,
			{
				"selfBtn_"
			}
		},
		mask_component = {
			"child",
			"heroTeamInfo",
			{
				"guideComponents",
				"guide_listContent"
			},
			"1148/heroinfo"
		},
		mask_scale = {},
		talk_position = {}
	},
	[409] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 409,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"newHeroTeamInfo",
			{
				"joinBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[410] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 410,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[411] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		talk_adapt = 0,
		is_finish = true,
		id = 411,
		talk_content = "",
		params = {
			413,
			414,
			415,
			411
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[412] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		talk_adapt = 0,
		is_finish = false,
		id = 412,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"confirmBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[413] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 413,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				3,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				2,
				"buttonImage_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[414] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 414,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"battleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[415] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 415,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[501] = {
		talk_anchors = 0,
		talk_position = "",
		type = "SetTeam",
		talk_adapt = 0,
		is_finish = false,
		id = 501,
		talk_content = "",
		params = {
			1084,
			1148,
			0
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {}
	},
	[502] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 502,
		talk_content = "",
		params = {
			313,
			10100,
			1010004,
			1,
			1
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[503] = {
		talk_anchors = 4,
		type = "EventTrigger",
		talk_adapt = 0,
		is_finish = false,
		id = 503,
		talk_content = "看起来出现了更为强大的敌人，但是不用担心，波塞冬也赶到了。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"selectHeroView_",
				"drag_3"
			},
			"EventTriggerListener"
		},
		mask_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_addBtn3"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[504] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 504,
		talk_content = "将新加入的波塞冬编入作战队伍。",
		params = {},
		guide_component = {
			"listIndex",
			"newHeroTeamInfo",
			{
				"heroHeadList_"
			},
			3,
			{
				"selfBtn_"
			}
		},
		mask_component = {
			"child",
			"heroTeamInfo",
			{
				"guideComponents",
				"guide_listContent"
			},
			"1039/heroinfo"
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[505] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 505,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"newHeroTeamInfo",
			{
				"joinBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[506] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 506,
		talk_content = "有了波塞冬的支援，小队实力也更有保证了。现在，继续迎击敌人吧。",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[507] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		talk_adapt = 0,
		is_finish = true,
		id = 507,
		talk_content = "",
		params = {
			509,
			510,
			511
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[508] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		talk_adapt = 0,
		is_finish = false,
		id = 508,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"confirmBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[509] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 509,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				4,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				2,
				"buttonImage_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[510] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 510,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"battleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[511] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 511,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[601] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 601,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[602] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 602,
		talk_content = "队伍整备得差不多了，继续执行任务吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-380.8,
			404.75
		}
	},
	[603] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 603,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"contentView_",
				7,
				"mainPlotPanelView_",
				"button_"
			}
		},
		mask_component = {
			"common",
			"chapterMap",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[604] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 604,
		talk_content = "",
		params = {
			"chapterMapContent",
			10100
		},
		guide_component = {
			"child_getcom",
			"chapterMapContent",
			{
				"itemParent_"
			},
			"10100",
			"Button"
		},
		mask_component = {
			"common",
			"chapterMapContent",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[605] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 605,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				5,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				5,
				"gameObject_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[606] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 606,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"battleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[607] = {
		talk_anchors = 0,
		talk_position = "",
		type = "SetTeam",
		talk_adapt = 0,
		is_finish = false,
		id = 607,
		talk_content = "",
		params = {
			1084,
			1148,
			1039
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {}
	},
	[608] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 608,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[609] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		talk_adapt = 0,
		is_finish = true,
		id = 609,
		talk_content = "",
		params = {
			605,
			606,
			607,
			608
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[610] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		talk_adapt = 0,
		is_finish = false,
		id = 610,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"confirmBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[801] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 801,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[802] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 802,
		talk_content = "管理员，权钥系统已经完成调试了，去看看吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			50,
			-300
		}
	},
	[804] = {
		talk_anchors = 0,
		type = "ClickCToggle",
		talk_adapt = 0,
		is_finish = false,
		id = 804,
		talk_content = "当修正者苏醒时，「盖亚」系统会为其赋予一定的系统权能，即是权钥。权钥既是修正者的武器，也是修正者的力量来源。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle3_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-93,
			133
		}
	},
	[805] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 805,
		talk_content = "和修正者可以变强一样，权钥也能够被强化。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				3,
				"weaponstrengthBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			960,
			117
		}
	},
	[806] = {
		talk_anchors = 0,
		type = "EventTrigger",
		talk_adapt = 0,
		is_finish = false,
		id = 806,
		talk_content = "从源层深处发现的源质结晶可以被权钥净化并吸收。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"listIndex_getcom",
			"weapon",
			{
				"pageView",
				"lvupView",
				"view",
				"scrollHelper_"
			},
			1,
			{
				"eventTriggerListener_"
			},
			"EventTriggerListener"
		},
		mask_component = {},
		mask_scale = {
			0.7,
			0.7
		},
		talk_position = {
			28,
			-50
		}
	},
	[807] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 807,
		talk_content = "这次的行动收获了不少源质结晶，试着强化一下薇儿丹蒂的权钥——卢恩之刃吧。",
		params = {},
		guide_component = {
			"common",
			"weapon",
			{
				"pageView",
				"lvupView",
				"view",
				"upgradeBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			960,
			117
		}
	},
	[808] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		talk_adapt = 0,
		is_finish = false,
		id = 808,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"weaponStr",
			{
				"bgmask_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[809] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 809,
		talk_content = "除了吸收源质结晶以外，还有其他的方式能够增强权钥的力量，点击回到权钥界面。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[810] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 810,
		talk_content = "每件权钥都可以选择一位钥从依附，增强修正者对其的控制力。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				3,
				"servantcontentBtn_"
			}
		},
		mask_component = {
			"common",
			"newHero",
			{
				"pages_",
				3,
				"guideComponents",
				"guide_notequipped"
			}
		},
		mask_scale = {},
		talk_position = {
			0,
			-289
		}
	},
	[811] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 811,
		talk_content = "需要注意，每个神系的钥从仅可以依附在对应神系的修正者权钥之上。",
		params = {},
		guide_component = {
			"common",
			"weaponServant",
			{
				"guideComponents",
				"guide_camp"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-209.89
		}
	},
	[812] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 812,
		talk_content = "钥从依附权钥后，除了可以提供攻击力加成外，还具备有特殊的权能。",
		params = {},
		guide_component = {
			"common",
			"weaponServant",
			{
				"guideComponents",
				"guide_weaponStr"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			151.8
		}
	},
	[813] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 813,
		talk_content = "钥从依附权钥后，除了可以提供攻击力加成外，还具备有特殊的权能。",
		params = {},
		guide_component = {
			"common",
			"weaponServant",
			{
				"guideComponents",
				"guide_describe"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			14,
			-34
		}
	},
	[814] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 814,
		talk_content = "现在选择这位钥从依附在卢恩之刃上吧。",
		params = {},
		guide_component = {
			"listIndex",
			"weaponServant",
			{
				"singleton",
				"listView",
				"viewHold",
				"viewModule",
				"staticVar",
				"scrollHelper"
			},
			2,
			{
				"clickBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-210,
			94.44
		}
	},
	[815] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 815,
		talk_content = "现在选择这位钥从依附在卢恩之刃上吧。",
		params = {},
		guide_component = {
			"common",
			"weaponServant",
			{
				"singleton",
				"viewDetail",
				"exchangeBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-398,
			237.49
		}
	},
	[816] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 816,
		talk_content = "权钥调整完毕，继续执行任务吧。",
		params = {},
		guide_component = {
			"windowBar",
			"homeBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			581,
			-218
		}
	},
	[817] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 817,
		talk_content = "选择继续作战。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-380.8,
			404.75
		}
	},
	[818] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 818,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"contentView_",
				7,
				"mainPlotPanelView_",
				"button_"
			}
		},
		mask_component = {
			"common",
			"chapterMap",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[901] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 901,
		talk_content = "选择继续作战。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-380.8,
			404.75
		}
	},
	[902] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 902,
		talk_content = "",
		params = {
			305,
			10101,
			1010101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1001] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 1001,
		talk_content = "",
		params = {
			306
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1002] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1002,
		talk_content = "新人，历战轮回装置的调试已经完成了，现在去确认一下吧。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				4,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			428.55,
			-264
		}
	},
	[1003] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1003,
		talk_content = "历战轮回系统会不断考验你和小队成员的极限，尽可能地在模拟战场中坚持，取得好成绩吧。",
		params = {
			"chapterMap",
			4,
			401
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"401",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"401/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			563,
			-186.99
		}
	},
	[1004] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1004,
		talk_content = "",
		params = {},
		guide_component = {
			"listIndex",
			"towerStage",
			{
				"list"
			},
			1,
			{
				"m_btn"
			}
		},
		mask_component = {
			"listIndex",
			"towerStage",
			{
				"list"
			},
			1,
			{
				"guideComponents",
				"guide_conent"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[1005] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 1005,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[1101] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 1101,
		talk_content = "",
		params = {
			306
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1102] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1102,
		talk_content = "新人，黑区净化系统已调整完毕，现在就去看看吧。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				4,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			428.55,
			-264
		}
	},
	[1103] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1103,
		talk_content = "",
		params = {
			"chapterMap",
			4,
			302
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"302",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"302/guide_mask"
		},
		mask_scale = {},
		talk_position = {}
	},
	[1104] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1104,
		talk_content = "系统将模拟世界线的变动，给参与作战的修正者更严格的考核。",
		params = {},
		guide_component = {
			"common",
			"mythicDifficulty",
			{
				"m_sureBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			83,
			-381
		}
	},
	[1105] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 1105,
		talk_content = "更详细的内容，可以参考这里的说明手册。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[1201] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 1201,
		talk_content = "",
		params = {
			306
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1202] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1202,
		talk_content = "新人，在之前的行动中，我们已经收集到了足够的移转之辉，现在需要将它转换成有用的算力，具体细节等你来隐科组再谈。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				4,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			428.55,
			-264
		}
	},
	[1203] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1203,
		talk_content = "",
		params = {
			"chapterMap",
			4,
			404
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"404",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"404/guide_mask"
		},
		mask_scale = {},
		talk_position = {}
	},
	[1204] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1204,
		talk_content = "",
		params = {},
		guide_component = {
			"child_getcom",
			"warChessStage",
			{
				"itemParent_"
			},
			"4040101",
			"Button"
		},
		mask_component = {
			"child_getcom",
			"warChessStage",
			{
				"itemParent_"
			},
			"4040101",
			"Button"
		},
		mask_scale = {},
		talk_position = {}
	},
	[1301] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 1301,
		talk_content = "",
		params = {
			306
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1302] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1302,
		talk_content = "新人，梦境再构装置的使用权限已开放了，现在去看看吧。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				4,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			428.55,
			-264
		}
	},
	[1303] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1303,
		talk_content = "这个装置藉由梦境系统，真实地再构了与修正者们交战过的强大敌人。",
		params = {
			"chapterMap",
			4,
			301
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"301",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"301/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			563,
			-186.99
		}
	},
	[1304] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1304,
		talk_content = "点击选择你想挑战的对手。",
		params = {},
		guide_component = {
			"common",
			"bossSwitch",
			{
				"bossItemList_",
				1,
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			318,
			-120
		}
	},
	[1305] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 1305,
		talk_content = "更详细的内容，可以参考这里的说明手册。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[1601] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 1601,
		talk_content = "点击这里，可以看到当前所拥有的全部钥从。",
		params = {},
		guide_component = {
			"common",
			"weaponServantList",
			{
				"guideComponents",
				"guide_material"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1423,
			726
		}
	},
	[1602] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1602,
		talk_content = "对沉睡着的钥从，可以对其进行真名唤醒。",
		params = {},
		guide_component = {
			"common",
			"weaponServantList",
			{
				"BtnWake"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			486,
			733
		}
	},
	[1701] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 1701,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1702] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1702,
		talk_content = "探测系统开放了。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_draw"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			170,
			-300
		}
	},
	[1704] = {
		talk_anchors = 4,
		type = "ClickCToggle",
		talk_adapt = 0,
		is_finish = false,
		id = 1704,
		talk_content = "在定向扩充探测中选择喜欢的修正者吧",
		params = {
			"draw",
			3000801
		},
		guide_component = {
			"treeGroup",
			"draw",
			{
				"tree_"
			},
			5
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			779,
			435
		}
	},
	[1801] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 1801,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1802] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1802,
		talk_content = "新人，神格系统的权限已经开放，去为修正者选择合适的作战方式吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			50,
			-300
		}
	},
	[1804] = {
		talk_anchors = 0,
		type = "ClickCToggle",
		talk_adapt = 0,
		is_finish = false,
		id = 1804,
		talk_content = "神格对应着修正者使用神力的方式，是「盖亚」系统赋予修正者权能的一部分。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle6_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-93,
			-158
		}
	},
	[1805] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1805,
		talk_content = "通过调整神格，可以让修正者具备不同的作战能力。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				6,
				"adjustBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-384,
			237
		}
	},
	[1806] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 1806,
		talk_content = "与神格共鸣可以增强修正者的技能，使之拥有更加强力的效果。",
		params = {},
		guide_component = {
			"common",
			"astrolabeAdjust",
			{
				"guideComponents",
				"guide_message"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			31,
			279
		}
	},
	[1807] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 1807,
		talk_content = "每个修正者最多可以共鸣三个神格，可以通过重置的方式重新选择其他神格进行共鸣。",
		params = {},
		guide_component = {
			"common",
			"astrolabeAdjust",
			{
				"guideComponents",
				"guide_reset"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			382,
			227
		}
	},
	[1808] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1808,
		talk_content = "解锁神格后即可与相应神格进行共鸣，为修正者选择你认为最适合的神格搭配吧。",
		params = {},
		guide_component = {
			"common",
			"astrolabeAdjust",
			{
				"guideComponents",
				"guide_unlockBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-384,
			266
		}
	},
	[1901] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 1901,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1902] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1902,
		talk_content = "新人，管理喵的作战用开发已经完成了，去看看吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_menu"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-377,
			-305.6
		}
	},
	[1903] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1903,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"menuPop",
			{
				"chipBtn_"
			}
		},
		mask_component = {
			"common",
			"menuPop",
			{
				"guideComponents",
				"guide_chip"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[1904] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1904,
		talk_content = "管理喵所拥有的强大算力，可以在作战中承担一部分的指挥工作。",
		params = {},
		guide_component = {
			"child_getcom",
			"chipManager",
			{
				"guideComponents",
				"guide_listContent"
			},
			"6",
			"Button"
		},
		mask_component = {
			"common",
			"chipManager",
			{
				"guideComponents",
				"guide_chip"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1905] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 1905,
		talk_content = "每只管理喵都有擅长的演算方向，启用后可以在作战中产生特别的效果。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"guideComponents",
				"guide_info"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1906] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1906,
		talk_content = "当满足一定研发条件后，即可将对应的管理喵应用到作战中。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"chipManagerInfoView_",
				"btn_unlock2Btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1907] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1907,
		talk_content = "通过管理芯片的辅助，管理喵的战术决策也能得到扩展。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"mimirchipBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1908] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1908,
		talk_content = "管理喵芯片有不同的种类，各自侧重不同的效果。",
		params = {},
		guide_component = {
			"listIndex",
			"chipManager",
			{
				"chipUIList_"
			},
			1,
			{
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1909] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 1909,
		talk_content = "不同的芯片组合可以给管理喵的战术带来丰富的可能性。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"guideComponents",
				"guide_explain"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1910] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1910,
		talk_content = "同样，在满足一定研发条件后，就可以解锁对应的管理芯片。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"chipInfoView_",
				"btn_unlock2Btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1911] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 1911,
		talk_content = "管理喵的作用已经介绍完毕了，现在我们去启用试试看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"homeBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			581,
			-218
		}
	},
	[1912] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1912,
		talk_content = "选择继续作战。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-380.8,
			404.75
		}
	},
	[1913] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1913,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"contentView_",
				7,
				"mainPlotPanelView_",
				"button_"
			}
		},
		mask_component = {
			"common",
			"chapterMap",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[1914] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1914,
		talk_content = "",
		params = {
			"chapterMapContent",
			10103
		},
		guide_component = {
			"child_getcom",
			"chapterMapContent",
			{
				"itemParent_"
			},
			"10103",
			"Button"
		},
		mask_component = {
			"common",
			"chapterMapContent",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[1915] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1915,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				1,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				1,
				"gameObject_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[1916] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1916,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"battleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1917] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1917,
		talk_content = "将管理喵加入到作战队伍中，协助作战指挥吧。",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"selectHeroView_",
				"mimirInfoView_",
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1918] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1918,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"battleChipManager",
			{
				"chipManagerInfoView_",
				"btn_useBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1919] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1919,
		talk_content = "请选择合适的管理芯片进行安装，丰富管理喵的战术决策。",
		params = {},
		guide_component = {
			"common",
			"battleChipManager",
			{
				"chipManagerInfoView_",
				"chipManagerUnlockView_",
				"chipBtn1_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1920] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1920,
		talk_content = "将选中的管理芯片为管理喵安装上吧。",
		params = {},
		guide_component = {
			"common",
			"battleChipInfo",
			{
				"useBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1921] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 1921,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[1922] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 1922,
		talk_content = "管理喵启用完毕，返回继续执行作战计划。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[1923] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 1923,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[2001] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 2001,
		talk_content = "",
		params = {
			306
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[2002] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2002,
		talk_content = "新人，已经通过了的战斗区域，偶尔也会有异象再生。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				3,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			411.5,
			-280
		}
	},
	[2003] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2003,
		talk_content = "参加战场清扫，有可能会找到稀有的遗落刻印。",
		params = {
			"chapterMap",
			3,
			202
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				3,
				"itemParent_"
			},
			"202",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			563,
			-186.99
		}
	},
	[2004] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2004,
		talk_content = "管理员可以选择一个刻印套装进行UP，掉落必是该套装的一个部位。",
		params = {},
		guide_component = {
			"common",
			"equipSection",
			{
				"guideComponents",
				"guide_equip"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[2005] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 2005,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[2102] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 2,
		is_finish = false,
		id = 2102,
		talk_content = "新人，新任务的情报已经更新，从这里确认一下吧。",
		params = {},
		guide_component = {
			"common",
			"chapterMapContent",
			{
				"hardLevelView_",
				"selectDifficultBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-740,
			-217
		}
	},
	[2103] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 2,
		is_finish = false,
		id = 2103,
		talk_content = "在这里可以切换任务的类型。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMapContent",
			{
				"guideComponents",
				"guide_diffcultPanel"
			},
			"levelBtn2",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-740,
			-217
		}
	},
	[2201] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2201,
		talk_content = "新人，「科尔盖」那边似乎有任务委派给你，现在去看看吧。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				3,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			411.5,
			-280
		}
	},
	[2202] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2202,
		talk_content = "与「科尔盖」的联合特勤任务已经开放了，根据他们提供的情报，也许会从任务中找到稀有的刻印赋能模组。",
		params = {
			"chapterMap",
			3,
			203
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				3,
				"itemParent_"
			},
			"203",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			563,
			-186.99
		}
	},
	[2203] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 2203,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[2301] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2301,
		talk_content = "矩阵公会现已开放。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btnGuild_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			1424,
			272
		}
	},
	[2401] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2401,
		talk_content = "欢迎来到餐厅，现在来看看如何查看菜品以及存储的食材，首先点击菜谱，这里有记录已解锁的菜品信息。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"recipebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			295,
			-60
		}
	},
	[2402] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2402,
		talk_content = "左侧这里可以看到菜品对应的厨具类型，上架的时候也可以考虑尽量搭配不同类型的菜品。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_typelist"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-150,
			10
		}
	},
	[2403] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2403,
		talk_content = "这里会显示厨具可制作的菜品列表，有些菜品需要达到更高的餐厅等级后才能制作。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_foodmenu"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			460,
			10
		}
	},
	[2404] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2404,
		talk_content = "选中菜品后，可以查看具体信息。",
		params = {},
		guide_component = {
			"child_getcom",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_content"
			},
			"foodItem(Clone)/itemButton",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			100,
			0
		}
	},
	[2405] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2405,
		talk_content = "这里可以看到菜品的预计收益以及菜品口味。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_foodtitle"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			490,
			0
		}
	},
	[2406] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2406,
		talk_content = "该菜品制作需要的食材以及数量会在这里显示。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_mater"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			520,
			50
		}
	},
	[2407] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2407,
		talk_content = "前往仓库可以查看当前库存的食材以及数量。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"bagBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-150,
			-150
		}
	},
	[2408] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2408,
		talk_content = "食材的信息以及数量都会在这里显示，可以通过完成委托任务获得更多食材。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"baguilistUilist_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			460,
			10
		}
	},
	[2501] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2501,
		talk_content = "管理员，食材已经准备好了，点击菜单准备将菜品上架吧。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"foodtitleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			200,
			-350
		}
	},
	[2502] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2502,
		talk_content = "这里是已经解锁的菜品，点击上架，已经上架的菜品会全天候自动售卖，上架上限会随餐厅等级提升而变多。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseSignFoodView",
			{
				"guideComponents",
				"guide_content"
			},
			"foodItem(Clone)/food/shelvesBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			450,
			100
		}
	},
	[2503] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2503,
		talk_content = "这里是菜品消耗的食材，如果食材不够，菜品就会进入售罄状态并且无法盈利。",
		params = {},
		guide_component = {
			"common",
			"PopSetFoodView",
			{
				"guideComponents",
				"bg_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			420,
			-220
		}
	},
	[2504] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 2504,
		talk_content = "餐厅想要能妥善经营则上架的菜品可不能少，先上架一道菜品吧。",
		params = {},
		guide_component = {
			"common",
			"PopSetFoodView",
			{
				"confirmbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-330
		}
	},
	[2505] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2505,
		talk_content = "第二道菜品的食材也已经准备好了，一并点击上架吧。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseSignFoodView",
			{
				"guideComponents",
				"guide_content"
			},
			"foodItem(Clone)/food/shelvesBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			200,
			-350
		}
	},
	[2506] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2506,
		talk_content = "上架完后，餐厅的准备工作就完成了，只需要等待客人前来用餐就可以盈利了~",
		params = {},
		guide_component = {
			"common",
			"PopSetFoodView",
			{
				"confirmbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-330
		}
	},
	[2601] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2601,
		talk_content = "既然菜品已经上架完毕，那也不能干等着食材耗尽，可以通过完成委托任务来积累食材。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"taskbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			295,
			-60
		}
	},
	[2602] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2602,
		talk_content = "这是收到的委托请求，完成这些请求可以获得由委托人送来的食材，并且餐厅等级提升后有机会接到全新的委托。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormTaskDispatchView",
			{
				"guideComponents",
				"guide_content"
			},
			"taskItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			150,
			10
		}
	},
	[2603] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2603,
		talk_content = "了解完委托的信息后就可以准备派遣啦，委托完成后会立刻获得新的委托任务。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormTaskDispatchView",
			{
				"guideComponents",
				"guide_content"
			},
			"taskItem(Clone)/taskBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-290
		}
	},
	[2604] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2604,
		talk_content = "完成委托会消耗体力，这里可以看到修正者的体力信息，如果体力为空或是已被派遣就无法再派遣了。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseCharacterView",
			{
				"guideComponents",
				"guide_content"
			},
			"heroHeadPrefab(Clone)/heroinfo/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			115,
			90
		}
	},
	[2605] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2605,
		talk_content = "没有被派遣的修正者的体力会随着时间恢复，记得合理规划修正者的作息~",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"characteruilistUilist_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			250,
			-290
		}
	},
	[2606] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2606,
		talk_content = "这里可以看到本次委托需要消耗的总体力，选择的修正者的体力之和需要不小于这部分才能进行派遣",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"battlebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			100,
			-150
		}
	},
	[2607] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2607,
		talk_content = "每次委托可能会有不一样的推荐类型，搭配对应的修正者时可以增加委托大成功的概率。",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"recuilistUilist_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			320,
			-370
		}
	},
	[2608] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2608,
		talk_content = "当前委托的大成功完成的实时概率，如果大成功达成委托则会获得额外的奖励~",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"guideComponents",
				"guide_probability"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			-290
		}
	},
	[2701] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2701,
		talk_content = "和诗蔻蒂一起出游吧。“出游日记”现已开放。",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"skuldbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			164,
			-410
		}
	},
	[2702] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2702,
		talk_content = "诗蔻蒂正在房间里休息。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"guideComponents",
				"guide_skuld"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2703] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2703,
		talk_content = "今天要去哪里游玩呢？来为诗蔻蒂安排出游行程吧。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"gototravelbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			96,
			-422
		}
	},
	[2704] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2704,
		talk_content = "选择本次出游的地点。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelMapView",
			{
				"btn_1"
			}
		},
		mask_component = {
			"common",
			"skuldTravelMapView",
			{
				"guideComponents",
				"guide_item_btn1"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2705] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2705,
		talk_content = "选择本次出游携带的物品。携带不同的物品去往同一地点，会有不同的见闻哦。",
		params = {},
		guide_component = {
			"child_getcom",
			"skuldTravelItemSelectView",
			{
				"guideComponents",
				"guide_item"
			},
			"Item(Clone)/bg_common",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2706] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2706,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"skuldTravelItemSelectView",
			{
				"travelbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[2801] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2801,
		talk_content = "游玩结束，我们回来啦。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelResultView",
			{
				"guideComponents",
				"guide_skuld"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2802] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2802,
		talk_content = "出游会为诗蔻蒂带来见闻的增长~",
		params = {},
		guide_component = {
			"common",
			"skuldTravelResultView",
			{
				"guideComponents",
				"guide_skuld"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2803] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2803,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"skuldTravelResultView",
			{
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2804] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2804,
		talk_content = "来看看在本次出游中发生的事件吧。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelPlotView",
			{
				"bgbtn_"
			}
		},
		mask_component = {
			"common",
			"skuldTravelPlotView",
			{
				"guideComponents",
				"guide_bg"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2805] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2805,
		talk_content = "出游事件都被诗蔻蒂收藏在了这里，管理员可以随时进行查看。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"plotbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-396,
			-294
		}
	},
	[2806] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2806,
		talk_content = "经过几次出游，诗蔻蒂会把自己的所思所想记录在这里。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"finalresultbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-396,
			-294
		}
	},
	[2807] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2807,
		talk_content = "诗蔻蒂并不擅长表达，因此，这些内容需要诗蔻蒂的见闻满足一定条件，且收录特定的出游事件后才能开启哦~",
		params = {},
		guide_component = {
			"listIndex",
			"skuldTravelFinalResultView",
			{
				"list_"
			},
			2,
			{
				"transform_"
			}
		},
		mask_component = {
			"listIndex",
			"skuldTravelFinalResultView",
			{
				"list_"
			},
			2,
			{
				"guideComponents",
				"guide_opt"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[2808] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 2808,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[2809] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 2809,
		talk_content = "别忘了领取出游奖励~",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"rewardbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-396,
			-294
		}
	},
	[2810] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 2810,
		talk_content = "更加详细的内容，就在这里查看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[2901] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2901,
		talk_content = "出游时获得的相片，似乎发生了变化。",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"skuldbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			164,
			-410
		}
	},
	[2902] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 2902,
		talk_content = "相片都存放在这里……怎么多出来了一张？",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"finalresultbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-396,
			-294
		}
	},
	[3001] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3001,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"springFestivalMain",
			{
				"canteenGo_"
			},
			"Button"
		},
		mask_component = {
			"common",
			"springFestivalMain",
			{
				"guideComponents",
				"guide_canteen"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[3101] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3101,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"springFestivalMain",
			{
				"btn5_"
			},
			"Button"
		},
		mask_component = {
			"common",
			"springFestivalMain",
			{
				"guideComponents",
				"guide_btn5"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[3201] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3201,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"springFestivalMain",
			{
				"btn4_"
			},
			"Button"
		},
		mask_component = {
			"common",
			"springFestivalMain",
			{
				"guideComponents",
				"guide_btn4"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[3401] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3401,
		talk_content = "新人，经过初步学习后，物资获取权限已经全部为你开启。",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"resourceButton_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[3501] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 3501,
		talk_content = "",
		params = {
			306
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[3502] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3502,
		talk_content = "隐科组对于刻印的研究有了重大突破，让我们去看看吧。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				3,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			411.5,
			-280
		}
	},
	[3503] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3503,
		talk_content = "报告显示源层深处极少数泉水会有产生伴生的透明结晶，其提取物可用于突破权钥与刻印的桎梏。",
		params = {
			"chapterMap",
			3,
			205
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				3,
				"itemParent_"
			},
			"205",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			563,
			-186.99
		}
	},
	[3504] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 3504,
		talk_content = "更详细的内容，可以参考这里的说明手册。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[3601] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 3601,
		talk_content = "新人，你结识了一位能力强劲的同伴呢，快来与这位修正者一起熟悉一下基础的战斗操作吧！",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-380.8,
			404.75
		}
	},
	[3602] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3602,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				4,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[3603] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3603,
		talk_content = "",
		params = {
			"chapterMap",
			4,
			402
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"402",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"402/guide_mask"
		},
		mask_scale = {},
		talk_position = {}
	},
	[3604] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 3604,
		talk_content = "基础教学可以让你了解一些经常会用到的战斗知识。",
		params = {},
		guide_component = {
			"common",
			"teachStage",
			{
				"buttle01Trs_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			1086,
			133
		}
	},
	[3605] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 3605,
		talk_content = "角色教学可以让你更了解与自己并肩作战的修正者，最大效率的协助对方发挥出全部力量。",
		params = {},
		guide_component = {
			"common",
			"teachStage",
			{
				"buttle02Trs_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			1086,
			133
		}
	},
	[3701] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3701,
		talk_content = "哼哼~不要惊慌，是本大人我。这次是来告诉你一个重要消息的，那就是可以通过对刻印进行「赋能」，对刻印进行提升哦。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"btn_enchant"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-291,
			135
		}
	},
	[3702] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 3702,
		talk_content = "刻印满足等级需求后，将直接解锁一个固定的「赋能效果」。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"pages_",
				4,
				"fixedListGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			33,
			198
		}
	},
	[3703] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 3703,
		talk_content = "同时解锁一个新的赋能位置，可以消耗「赋能模块」进行主动赋能，获取额外的「赋能效果」。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"pages_",
				4,
				"enchant_1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			31,
			-124
		}
	},
	[3704] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 3704,
		talk_content = "本大人知道的讯息已经全部同步给你了，如果想要了解更多刻印「赋能」相关的内容，就打开这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[3801] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 3801,
		talk_content = "",
		params = {
			306
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[3802] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3802,
		talk_content = "本喵刚刚得到隐科组传来讯息，在源层深处中的遗迹里发现可以强化刻印的材料。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				3,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			411.5,
			-280
		}
	},
	[3803] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 3803,
		talk_content = "只不过前进的路上遍布游荡的视骸，消灭它们然后获取更多的启示录吧！",
		params = {
			"chapterMap",
			3,
			204
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				3,
				"itemParent_"
			},
			"204",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			563,
			-186.99
		}
	},
	[3902] = {
		talk_anchors = 4,
		type = "ClickCToggle",
		talk_adapt = 0,
		is_finish = false,
		id = 3902,
		talk_content = "新人，隐科组将高品质的刻印核心制作成了独立模块，用于增幅「中继之环」的神能反应效率，这种增幅被称为「跃迁」。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle8_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3903] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 3903,
		talk_content = "当某个位置装备的刻印等级达到40级时，可消耗材料解锁该位置对应的「跃迁核心」。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				7,
				"item_1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[4001] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 4001,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4002] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4002,
		talk_content = "新人，跃迁系统的权限已经开放，我们去看看吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"btn_goddess"
			}
		},
		mask_scale = {},
		talk_position = {
			50,
			-300
		}
	},
	[4003] = {
		talk_anchors = 0,
		type = "ClickCToggle",
		talk_adapt = 0,
		is_finish = false,
		id = 4003,
		talk_content = "隐科组将高品质的刻印核心制作成了独立模块，用于增幅「中继之环」的神能反应效率，这种增幅被称为「跃迁」。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle5_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-93,
			-61
		}
	},
	[4004] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4004,
		talk_content = "当某个位置装备的刻印等级达到40级时，可消耗材料解锁该位置对应的「跃迁核心」。",
		params = {},
		guide_component = {
			"child_getcom",
			"newHero",
			{
				"pages_",
				5,
				"transitionDiscView_",
				"itemParent_"
			},
			"item1",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			401,
			243.7
		}
	},
	[4005] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4005,
		talk_content = "",
		params = {},
		guide_component = {
			"child_getcom",
			"newHero",
			{
				"pages_",
				5,
				"transitionDetailInfoView_",
				"btnParent_"
			},
			"upBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4006] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4006,
		talk_content = "「跃迁核心」被成功激活后，可以对修正者的多项能力进行专项增幅。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"chipModuleObj_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			194,
			327
		}
	},
	[4007] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4007,
		talk_content = "每个「跃迁核心」最多得到2种能力增幅，不过不用担心，增幅效果可以随时来这里进行更换调整。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_disc"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4008] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4008,
		talk_content = "「跃迁核心」的专项增幅可以大幅度提升修正者的实力。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_desc"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			327
		}
	},
	[4009] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4009,
		talk_content = "「跃迁技能」装备以及升级需要消耗「跃迁因子」。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_cost"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-390,
			379
		}
	},
	[4010] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4010,
		talk_content = "「跃迁因子」的持有数量和当前可持有的数量上限可以在这里查看。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_point"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			174,
			-216
		}
	},
	[4011] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4011,
		talk_content = "管理员需要先获取「跃迁因子」，才能顺利装备「跃迁技能」哦~",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"exchangeBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			174,
			-311
		}
	},
	[4012] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4012,
		talk_content = "「跃迁因子」的数量可以通过消耗权能材料进行提升，这种材料可以在黑区净化的Ω难度获取。",
		params = {},
		guide_component = {
			"common",
			"transitionGiftPt",
			{
				"guideComponents",
				"guide_list"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			518,
			-19
		}
	},
	[4101] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4101,
		talk_content = "通过对普通五星刻印进行神力融合，可以为修正者进行能力增幅。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"btn_reset"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-291,
			40
		}
	},
	[4102] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4102,
		talk_content = "「神系重构」可以将普通的五星刻印「重构」为随机神系刻印，为其提供对应神系额外的属性加成。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"pages_",
				5,
				"reset_1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			32,
			-20
		}
	},
	[4103] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4103,
		talk_content = "「显晰重构」可以将神系刻印「重构」为专属刻印，为对应修正者提供更多的属性加成。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"pages_",
				5,
				"reset_2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			32,
			-187
		}
	},
	[4104] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 4104,
		talk_content = "这么重要的消息本大人可第一时间就过来告诉你了哦~如果想要了解更多刻印重构相关的内容，就打开这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[4204] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4204,
		talk_content = "由爆炸产生的空洞就像是黑洞一样不受控制，且呈现出崩溃的迹象，因此这里也被称为“失序深阱”，失序深阱中存在多个阶层，当一个阶层内的所有区域清理完毕后，便可解锁后续阶层。",
		params = {},
		guide_component = {
			"common",
			"abyssMain",
			{
				"uiListGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-100
		}
	},
	[4205] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4205,
		talk_content = "每个区域根据难易程度有不同的评级，如果是评级为Ω的区域则可以反复挑战积累清理进度。",
		params = {},
		guide_component = {
			"common",
			"abyssMain",
			{
				"levelItems_",
				1,
				"gameObject_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-100
		}
	},
	[4206] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4206,
		talk_content = "点击可以选中该区域。",
		params = {},
		guide_component = {
			"common",
			"abyssMain",
			{
				"levelItems_",
				1,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-100
		}
	},
	[4207] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4207,
		talk_content = "当前区域的相关信息会在这里显示，点击区域目标的头像可以查看其具体信息。",
		params = {},
		guide_component = {
			"common",
			"abyssMain",
			{
				"bossGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			50
		}
	},
	[4208] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 4208,
		talk_content = "想要了解更多有关失序深阱相关的内容，就参考这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[4301] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4301,
		talk_content = "经过隐科组最终的调试，修正者与权钥「同调」装置现已正式启用。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			50,
			-300
		}
	},
	[4302] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4302,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				1,
				"heroInfoView_",
				"moduleView_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4303] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4303,
		talk_content = "调动起深刻的记忆及情绪对「同调」的效果有较为明显的增幅。此处摆放的是由修正者自己提供的，对自身影响较大的物品。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleView",
			{
				"guideComponents",
				"guide_pic"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4304] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4304,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"weaponModuleView",
			{
				"getBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4305] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4305,
		talk_content = "此处可以查看「同调」后可获得的提升。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleUnlockView",
			{
				"guideComponents",
				"guide_list"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-387,
			148
		}
	},
	[4306] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4306,
		talk_content = "解锁该修正者的「同调」需要完成对应的专属任务。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleUnlockView",
			{
				"guideComponents",
				"guide_mission"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1120,
			-210
		}
	},
	[4307] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4307,
		talk_content = "同时开启「同调」需要满足一定的解锁条件。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleUnlockView",
			{
				"guideComponents",
				"guide_condition"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1120,
			-422
		}
	},
	[4308] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 4308,
		talk_content = "若是想了解更多关于「同调」相关的信息，就点开这里的说明手册进行查看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[4401] = {
		talk_anchors = 1,
		type = "ClickCToggle",
		talk_adapt = 1,
		is_finish = false,
		id = 4401,
		talk_content = "新人，完成入职签到可以结识新的修正者，获取大量探测凭证哦。",
		params = {},
		guide_component = {
			"treeGroup",
			"activityNoob",
			{
				"tree_"
			},
			1
		},
		mask_component = {
			"common",
			"activityNoob",
			{
				"guideComponents",
				"guide_1"
			}
		},
		mask_scale = {},
		talk_position = {
			764,
			-196
		}
	},
	[4402] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 4402,
		talk_content = "点击此处领取今日的奖励吧！",
		params = {},
		guide_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				1,
				"contenViewList_",
				1,
				"uiList_"
			},
			1,
			{
				"button_"
			}
		},
		mask_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				1,
				"contenViewList_",
				1,
				"uiList_"
			},
			1,
			{
				"guideComponents",
				"guide_item"
			}
		},
		mask_scale = {},
		talk_position = {
			37,
			-194
		}
	},
	[4403] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		talk_adapt = 0,
		is_finish = false,
		id = 4403,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"switchHeroReward",
			{
				"bgBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4404] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4404,
		talk_content = "明天也有可以领取的奖励不要忘记了哦！",
		params = {},
		guide_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				1,
				"contenViewList_",
				1,
				"uiList_"
			},
			2,
			{
				"guideComponents",
				"guide_item"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			226,
			-193
		}
	},
	[4405] = {
		talk_anchors = 0,
		type = "ClickCToggle",
		talk_adapt = 1,
		is_finish = false,
		id = 4405,
		talk_content = "新人课程将会引导管理员熟悉日后需要处理的事务。",
		params = {},
		guide_component = {
			"treeGroup",
			"activityNoob",
			{
				"tree_"
			},
			2
		},
		mask_component = {
			"common",
			"activityNoob",
			{
				"guideComponents",
				"guide_2"
			}
		},
		mask_scale = {},
		talk_position = {
			-208,
			84
		}
	},
	[4406] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 2,
		is_finish = false,
		id = 4406,
		talk_content = "完成全部课程任务，可以将修正者「潮音·波塞冬」神识超越至Ω。",
		params = {},
		guide_component = {
			"common",
			"activityNoob",
			{
				"pages_",
				2,
				"guideComponents",
				"guide_pt"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-372,
			364
		}
	},
	[4407] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 2,
		is_finish = false,
		id = 4407,
		talk_content = "课程任务每天逐步解锁。",
		params = {},
		guide_component = {
			"common",
			"activityNoob",
			{
				"pages_",
				2,
				"guideComponents",
				"guide_task"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1392,
			326
		}
	},
	[4408] = {
		talk_anchors = 1,
		type = "ClickCToggle",
		talk_adapt = 1,
		is_finish = false,
		id = 4408,
		talk_content = "管理员达到一定等级时，可领取对应的等级奖励。",
		params = {},
		guide_component = {
			"treeGroup",
			"activityNoob",
			{
				"tree_"
			},
			3
		},
		mask_component = {
			"common",
			"activityNoob",
			{
				"guideComponents",
				"guide_3"
			}
		},
		mask_scale = {},
		talk_position = {
			758,
			-404
		}
	},
	[4409] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 2,
		is_finish = false,
		id = 4409,
		talk_content = "当管理员等级达到60级时，可以将「朝约·薇儿丹蒂」神识超越至SSS，并获得圣树5星通用钥从「妖精·盖拉德丽尔」。",
		params = {},
		guide_component = {
			"common",
			"activityNoob",
			{
				"pages_",
				3,
				"guideComponents",
				"guide_reward"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-886,
			145
		}
	},
	[4410] = {
		talk_anchors = 1,
		type = "ClickCToggle",
		talk_adapt = 1,
		is_finish = false,
		id = 4410,
		talk_content = "当然，作为新加入的成员，管理员也可以在日常委托中获取丰厚奖励哦。",
		params = {},
		guide_component = {
			"treeGroup",
			"activityNoob",
			{
				"tree_"
			},
			4
		},
		mask_component = {
			"common",
			"activityNoob",
			{
				"guideComponents",
				"guide_4"
			}
		},
		mask_scale = {},
		talk_position = {
			768,
			-509
		}
	},
	[4411] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4411,
		talk_content = "完成当天的委托任务后，次日05:00会解锁新的委托任务。",
		params = {},
		guide_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				4,
				"scrollHelper_"
			},
			1,
			{
				"transform_"
			}
		},
		mask_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				4,
				"scrollHelper_"
			},
			1,
			{
				"guideComponents",
				"guide_infoitem"
			}
		},
		mask_scale = {},
		talk_position = {
			766,
			315
		}
	},
	[4412] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4412,
		talk_content = "完成全部委托任务后，可以将「追炎·前鬼坊天狗」神识超越至SSS，并获得专属换装「校园时光」。",
		params = {},
		guide_component = {
			"common",
			"activityNoob",
			{
				"pages_",
				4,
				"guideComponents",
				"guide_pic"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-457,
			267
		}
	},
	[4501] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4501,
		talk_content = "相信管理员现在已经对自己的基本职责非常熟悉了，那就让我们开启进修企划吧！",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_newbie_task"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_newbie_task"
			}
		},
		mask_scale = {},
		talk_position = {
			678,
			-267
		}
	},
	[4601] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 4601,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4602] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4602,
		talk_content = "得到大国主的最新消息，演算终端机调试完毕，多维变量模拟已启动。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-380.8,
			404.75
		}
	},
	[4603] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4603,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				4,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4604] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4604,
		talk_content = "演算终端机是大国主为了演算盖亚世界变动率而领导研发的模拟装置，但目前只作为战术决策的训练场所而存在。",
		params = {
			"chapterMap",
			4,
			303
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"303",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"303/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			563,
			-186.99
		}
	},
	[4605] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4605,
		talk_content = "在多维变量的挑战中可以使用「多维信标」协助探索。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_beaconBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-432.5,
			-242
		}
	},
	[4606] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4606,
		talk_content = "「多维信标」需要足够的数据支撑才能顺利解锁激活，获取后可以为接下来的探索带来便利。",
		params = {},
		guide_component = {
			"listIndex",
			"polyhedronBeaconOperate",
			{
				"list_"
			},
			1,
			{
				"transform_"
			}
		},
		mask_component = {
			"listIndex",
			"polyhedronBeaconOperate",
			{
				"list_"
			},
			1,
			{
				"guideComponents",
				"guide_beaconitem"
			}
		},
		mask_scale = {},
		talk_position = {
			-53,
			105
		}
	},
	[4607] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4607,
		talk_content = "解锁一个「多维信标」试试吧。",
		params = {},
		guide_component = {
			"listIndex",
			"polyhedronBeaconOperate",
			{
				"list_"
			},
			1,
			{
				"m_unlockBtn"
			}
		},
		mask_component = {
			"listIndex",
			"polyhedronBeaconOperate",
			{
				"list_"
			},
			1,
			{
				"guideComponents",
				"guide_beaconitemunlock"
			}
		},
		mask_scale = {},
		talk_position = {
			-53,
			-202.76
		}
	},
	[4608] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 4608,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[4609] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4609,
		talk_content = "「多维终端」中记录着你探索的脚步，不断累积的经验会使你的探索更加顺遂。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_terminalBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-367,
			-460
		}
	},
	[4610] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4610,
		talk_content = "提升「多维终端」的等级，可以获得天赋点数激活加成，提供探索助力。",
		params = {},
		guide_component = {
			"common",
			"polyhedronTerminal",
			{
				"m_levelBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-325
		}
	},
	[4611] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4611,
		talk_content = "为了更有效的探索多维空间，「多维终端」所选天赋每周可重置1次。",
		params = {},
		guide_component = {
			"common",
			"polyhedronTerminal",
			{
				"guideComponents",
				"guide_resetBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-260,
			-424
		}
	},
	[4612] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 4612,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[4613] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 4613,
		talk_content = "点击此处可以选择映射出跟随你探索多维空间的修正者。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_heroBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			805,
			475
		}
	},
	[4614] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4614,
		talk_content = "",
		params = {},
		guide_component = {
			"listIndex",
			"polyhedronHero",
			{
				"shortScrollHelper_"
			},
			2,
			{
				"selfBtn_"
			}
		},
		mask_component = {
			"listIndex",
			"polyhedronHero",
			{
				"shortScrollHelper_"
			},
			2,
			{
				"guideComponents",
				"guide_hero"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4615] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 2,
		is_finish = false,
		id = 4615,
		talk_content = "在多维空间映射出对应的修正者，需要消耗「映射仪」。",
		params = {},
		guide_component = {
			"common",
			"polyhedronHero",
			{
				"pages_",
				1,
				"guideComponents",
				"guide_cost"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-870,
			162
		}
	},
	[4616] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 2,
		is_finish = false,
		id = 4616,
		talk_content = "「映射仪」每周四5:00自动生成，日常最大持有数为1。",
		params = {},
		guide_component = {
			"windowBarCurrency",
			44,
			{
				"transform_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-676,
			-119
		}
	},
	[4617] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 4617,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[4618] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 1,
		is_finish = false,
		id = 4618,
		talk_content = "通过「维度曲线」可以获取「偏移记录」。「维度曲线」会在固定周期重置，任务内容也会根据时间推移进行更迭。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_taskBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			805,
			379
		}
	},
	[4619] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 1,
		is_finish = false,
		id = 4619,
		talk_content = "影响「维度偏移」幅度，探索到更多不同的信息可以领取相应的奖励。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_policyBtn"
			}
		},
		mask_component = {
			"common",
			"polyhedronLobby",
			{
				"guideComponents",
				"guide_score"
			}
		},
		mask_scale = {},
		talk_position = {
			864,
			646
		}
	},
	[4620] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 1,
		is_finish = false,
		id = 4620,
		talk_content = "在「维度偏移」中获得的「幸运之证」，可以在「因幡万事屋」中兑换各种物品。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_shopBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			805,
			180
		}
	},
	[4621] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 4621,
		talk_content = "若是想了解更多关于「多维变量」相关的信息，就点开这里的说明手册进行查看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[4701] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 4701,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4702] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4702,
		talk_content = "管理员，隐科组的心居开发企划似乎有新的进展了。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_dorm_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-280
		}
	},
	[4801] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4801,
		talk_content = "看看深空之眼大楼中的心居区域，这里可以提供修正者休息的场所。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"dimianGo_"
			}
		},
		mask_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"guideComponents",
				"guide_step1"
			}
		},
		mask_scale = {},
		talk_position = {
			400,
			-230
		}
	},
	[4803] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4803,
		talk_content = "有许多宿舍房间还未开放，通过餐厅经营积累的小窝资金扩展宿舍房间。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"item4Go_"
			}
		},
		mask_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"guideComponents",
				"guide_item4"
			}
		},
		mask_scale = {},
		talk_position = {
			420,
			-80
		}
	},
	[4804] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4804,
		talk_content = "也有可以即刻入住的宿舍房间，当修正者好感度达到5级时即可安排入住。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"item2Go_"
			}
		},
		mask_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"guideComponents",
				"guide_item3"
			}
		},
		mask_scale = {},
		talk_position = {
			-55,
			30
		}
	},
	[4805] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4805,
		talk_content = "当修正者入住后，可以给入住的修正者赠送家具来布置房间，并且房间将会和该修正者绑定。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"item2Go_"
			}
		},
		mask_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"guideComponents",
				"guide_item3"
			}
		},
		mask_scale = {},
		talk_position = {
			-55,
			30
		}
	},
	[4806] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4806,
		talk_content = "拖动或点击切换按钮可以将视图切换到其他的区域。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"btnupBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-581,
			722
		}
	},
	[4807] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = true,
		id = 4807,
		talk_content = "如果想查看其他管理员的房间布置，可以随时通过参观功能查看。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"visitBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-650,
			181
		}
	},
	[4809] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4809,
		talk_content = "大厅现在还处于闲置状态，先点击进入看看吧",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"publicBtn_"
			}
		},
		mask_component = {
			"common",
			"dormChooseRoomView",
			{
				"roomItemView",
				"guideComponents",
				"guide_lobby"
			}
		},
		mask_scale = {},
		talk_position = {
			200,
			-200
		}
	},
	[4902] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 4902,
		talk_content = "点击编辑按钮，可以重新布置当前场景，部分家具需要赠送后才能在编辑中摆放。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"fureidbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-416,
			320
		}
	},
	[4903] = {
		talk_anchors = 0,
		type = "ClickCToggle",
		talk_adapt = 0,
		is_finish = true,
		id = 4903,
		talk_content = "通过切换类型可以查看当前持有的各种家具，当然现在已经准备好一些家具了。",
		params = {},
		guide_component = {
			"common",
			"roomEdit",
			{
				"item_22Tgl_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-198,
			-83
		}
	},
	[4904] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 4904,
		talk_content = "嗯…看起来大厅的门窗还得自己动手安装，通过拖动的方式可以将家具放入场景内。",
		params = {},
		guide_component = {
			"child_getcom",
			"roomEdit",
			{
				"guideComponents",
				"guide_content"
			},
			"furItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1052,
			149
		}
	},
	[5001] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5001,
		talk_content = "编辑好之后可以点击设置将当前房间设置为展示房间，其他管理员可以参观当前房间的布置。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"exhib"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-427,
			-200
		}
	},
	[5003] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 1,
		is_finish = false,
		id = 5003,
		talk_content = "通过导航按钮可以快捷切换至不同场景。",
		params = {},
		guide_component = {
			"child_getcom",
			"dorm",
			{
				"tempquickGo_"
			},
			"ButtonNa",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			631,
			163
		}
	},
	[5004] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5004,
		talk_content = "点击查看当前可以来到大厅休息的修正者。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"characterplacebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-578.6,
			320
		}
	},
	[5005] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = true,
		id = 5005,
		talk_content = "当前修正者的信息都会在这里显示。",
		params = {},
		guide_component = {
			"common",
			"dormHeroDeployView",
			{
				"uilistGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-609,
			375
		}
	},
	[5006] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5006,
		talk_content = "选中修正者后，可以拖动将修正者放入大厅中，再次点击可以将其从大厅召回。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormHeroDeployView",
			{
				"guideComponents",
				"guide_content"
			},
			"heroItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			797,
			111.86
		}
	},
	[5101] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5101,
		talk_content = "当前修正者体力详情，在大厅中恢复速度是固定的，在宿舍中会随着宿舍等级上升而加快。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"guideComponents",
				"guide_obj"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-886,
			347
		}
	},
	[5102] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5102,
		talk_content = "邀请修正者进餐可以增加修正者的体力，需要注意相同修正者存在每日次数限制。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"feedfoodbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-369,
			376
		}
	},
	[5103] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = true,
		id = 5103,
		talk_content = "当修正者有自己的宿舍后，可以为其赠送家具，家具赠送后可以在大厅或该修正者宿舍中摆放。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"giftbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-388,
			186
		}
	},
	[5104] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5104,
		talk_content = "尝试抚摸修正者或许能看到其意想不到的一面。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"touchbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-388,
			612
		}
	},
	[5105] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5105,
		talk_content = "与修正者进行互动游戏也可以获取少量乐园印戳。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"gameBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-528,
			612
		}
	},
	[5201] = {
		talk_anchors = 4,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5201,
		talk_content = "游园街的餐厅也开放了，可以通过经营餐厅来赚取报酬。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"canteenBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			594.33,
			311
		}
	},
	[5202] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 2,
		is_finish = false,
		id = 5202,
		talk_content = "想经营好餐厅首先就要将修正者分配到合适的岗位，点击可以为每个岗位派遣修正者。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"jobSetBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-630,
			270
		}
	},
	[5203] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5203,
		talk_content = "餐厅中有不同岗位，现在查看的是厨师岗位。",
		params = {},
		guide_component = {
			"common",
			"restaurantJobSetView",
			{
				"guideComponents",
				"guide_job"
			},
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-246,
			180
		}
	},
	[5204] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5204,
		talk_content = "点击可以选择想要派遣的修正者，修正者头像会显示对应技能加成。",
		params = {},
		guide_component = {
			"listIndex",
			"restaurantJobSetView",
			{
				"heroScroll"
			},
			1,
			{
				"heroitemBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			109,
			-16
		}
	},
	[5205] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5205,
		talk_content = "修正者的体力以及等级信息可以通过这里查看。",
		params = {},
		guide_component = {
			"common",
			"restaurantJobSetView",
			{
				"guideComponents",
				"guide_heroinfo"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			312.4,
			63.12
		}
	},
	[5206] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = true,
		id = 5206,
		talk_content = "这里会显示技能详情，技能需要达到特定等级才能解锁。",
		params = {},
		guide_component = {
			"child_getcom",
			"restaurantJobSetView",
			{
				"guideComponents",
				"guide_skillinfo"
			},
			"itemSkillInfo(Clone)",
			"RectTransform"
		},
		mask_component = {
			"common",
			"restaurantJobSetView",
			{
				"guideComponents",
				"guide_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			349,
			-144.92
		}
	},
	[5207] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5207,
		talk_content = "如果确认无误，可以设置当前选中的修正者，需要所有岗位都派遣完毕后才能开始经营。",
		params = {},
		guide_component = {
			"common",
			"restaurantJobSetView",
			{
				"confirmBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			57,
			-314
		}
	},
	[5301] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5301,
		talk_content = "管理员，食材已经准备好了，点击菜单准备将菜品上架吧。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"foodtitleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-125.31,
			-278.95
		}
	},
	[5302] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5302,
		talk_content = "这里是已经解锁的菜品，点击上架，已经上架的菜品会全天候自动售卖。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseSignFoodView",
			{
				"guideComponents",
				"guide_content"
			},
			"foodItem(Clone)/food/shelvesBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			455,
			195
		}
	},
	[5303] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5303,
		talk_content = "这里是菜品消耗的食材，最大制作数量会受到可使用的食材数量的限制。",
		params = {},
		guide_component = {
			"common",
			"reviseSignFoodNumView",
			{
				"guideComponents",
				"guide_cost"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-131.1,
			-215.08
		}
	},
	[5304] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5304,
		talk_content = "可以设定菜品售卖的预期数量，设定后如果想重新调整数量则需要先将设定好的订单下架。",
		params = {},
		guide_component = {
			"common",
			"reviseSignFoodNumView",
			{
				"guideComponents",
				"guide_set"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			256.89,
			5.23
		}
	},
	[5305] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5305,
		talk_content = "根据设定的数量，可以看到订单完成的预计耗时与预计收益。",
		params = {},
		guide_component = {
			"common",
			"reviseSignFoodNumView",
			{
				"guideComponents",
				"guide_info"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			306,
			-214.47
		}
	},
	[5401] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 2,
		is_finish = false,
		id = 5401,
		talk_content = "菜品所需的食材可以通过完成委托任务来积累。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"taskbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-630,
			-420
		}
	},
	[5402] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5402,
		talk_content = "这是收到的委托请求，完成这些请求可以获得由委托人送来的食材，并且随厨具等级提升后有机会接到全新的委托。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormTaskDispatchView",
			{
				"guideComponents",
				"guide_content"
			},
			"taskItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			37,
			125
		}
	},
	[5403] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5403,
		talk_content = "了解完委托的信息后就可以准备派遣啦，委托完成后会立刻获得新的委托任务。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormTaskDispatchView",
			{
				"guideComponents",
				"guide_content"
			},
			"taskItem(Clone)/unlock/taskBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-49,
			-368.07
		}
	},
	[5404] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5404,
		talk_content = "这里可以看到修正者的信息，当修正者适合该委托时对应类型标签会亮起。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseCharacterView",
			{
				"guideComponents",
				"guide_content"
			},
			"heroHeadPrefabN(Clone)/heroinfo/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			115,
			90
		}
	},
	[5405] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5405,
		talk_content = "这里可以看到本次委托需要消耗的总体力，选择的修正者的体力之和需要不小于所需总体里才能进行派遣。",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"battlebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			357.52,
			-171.88
		}
	},
	[5406] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5406,
		talk_content = "每次委托可能会有不一样的推荐类型，搭配对应的修正者时可以增加委托大成功的概率。",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"recuilistUilist_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-3.7,
			-353.05
		}
	},
	[5407] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5407,
		talk_content = "当前委托的大成功完成的实时概率，如果大成功达成委托则会获得额外的奖励~",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"guideComponents",
				"guide_probability"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			266,
			-345.77
		}
	},
	[5408] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5408,
		talk_content = "在委托中可以快速选择当前任务最适合委派的修正者。",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"quickBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			367,
			-338.77
		}
	},
	[5501] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 2,
		is_finish = false,
		id = 5501,
		talk_content = "通过不断经营餐厅，可以提升餐厅中的设施等级。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"cookBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-630,
			140
		}
	},
	[5502] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5502,
		talk_content = "设施等级提升能解锁新的菜品以及提高对应菜系的收益，同时还能增加餐厅的人气值。",
		params = {},
		guide_component = {
			"common",
			"restaurantCookUpView",
			{
				"uitreeGo_"
			}
		},
		mask_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide1_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			110,
			-179
		}
	},
	[5503] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5503,
		talk_content = "设施的收益效果会在这里显示，等级上升后对应数值也会增加。",
		params = {},
		guide_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide_skill"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			84.511,
			-54.47
		}
	},
	[5504] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5504,
		talk_content = "当餐厅经营满足条件后，相应的设施才能提升等级。",
		params = {},
		guide_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide_condition"
			}
		},
		mask_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide2_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			77.29,
			-343.39
		}
	},
	[5505] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5505,
		talk_content = "满足升级条件后需要消耗一定的材料才能升级。",
		params = {},
		guide_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide_cost"
			}
		},
		mask_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide3_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			77.287,
			-29.131
		}
	},
	[5603] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5603,
		talk_content = "管理员，隐科组最近开发出了一款全新的数据收集系统，一起来看一下吧！管理员需要先选择希望探索的区域。让我们从艾因索菲开始探索吧！",
		params = {},
		guide_component = {
			"common",
			"adminCatExploreView",
			{
				"itemViewList",
				1,
				"exploreBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			309,
			-100
		}
	},
	[5604] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5604,
		talk_content = "管理员可以在这里选择探索时长，探索时间越长可获得的奖励越多。",
		params = {},
		guide_component = {
			"common",
			"adminCatExplorePop",
			{
				"guideComponents",
				"timeList_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			220,
			70
		}
	},
	[5605] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5605,
		talk_content = "在这里可以选择需要派遣的管理喵，不同管理喵拥有不同的天赋和技能，派遣管理喵前往更适合自己探索的区域可以事半功倍哦。",
		params = {},
		guide_component = {
			"listIndex",
			"adminCatExplorePop",
			{
				"adminCatList"
			},
			1,
			{
				"selectBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			220,
			280
		}
	},
	[5606] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 5606,
		talk_content = "选择完成后点击这里就可以出发进行探索了。",
		params = {},
		guide_component = {
			"common",
			"adminCatExplorePop",
			{
				"guideComponents",
				"guide_battleBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			309,
			-270
		}
	},
	[5608] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5608,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-350,
			300
		}
	},
	[5701] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5701,
		talk_content = "管理员约库尔原质区出现了信息不明的视骸冲破了表层，科尔盖发来消息集结人手前去解决，我们赶快前去支援吧！",
		params = {},
		guide_component = {
			"common",
			"strongholdMain",
			{
				"m_teachBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-400,
			-290
		}
	},
	[5702] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5702,
		talk_content = "支援行动开始前，先了解下战区情况吧~点击此处进入作战。",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHeroTeach",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			200,
			-290
		}
	},
	[5703] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5703,
		talk_content = "「功勋陈列」中可查看玩家当前在「约库尔救援」活动中的任务进度",
		params = {},
		guide_component = {
			"common",
			"strongholdMain",
			{
				"m_operateBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-400,
			-290
		}
	},
	[5704] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5704,
		talk_content = "「约库尔救援」行动中的贡献将以等级的方式展现。",
		params = {},
		guide_component = {
			"common",
			"strongholdOperate",
			{
				"m_taskBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-200,
			-290
		}
	},
	[5705] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5705,
		talk_content = "完成任务可以获得对应序列的「功勋值」。",
		params = {},
		guide_component = {
			"common",
			"strongholdOperate",
			{
				"curPage",
				"m_type2Btn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-200,
			-290
		}
	},
	[5706] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5706,
		talk_content = "提升序列等级可解锁「力场增幅」技能并与队友「共享」技能效果。",
		params = {},
		guide_component = {
			"common",
			"strongholdOperate",
			{
				"m_skillBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-200,
			-290
		}
	},
	[5707] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5707,
		talk_content = "同时序列等级的提升也可以获得「数据模块」，使用后可大幅提升修正者的作战能力。",
		params = {},
		guide_component = {
			"common",
			"strongholdOperate",
			{
				"m_increaseBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-200,
			-290
		}
	},
	[5708] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5708,
		talk_content = "序列达到一定等级后将获得救援行动的官方认证并获得额外的行动奖励！",
		params = {},
		guide_component = {
			"common",
			"strongholdOperate",
			{
				"m_rewardBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-200,
			-290
		}
	},
	[5801] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5801,
		talk_content = "点击「前往作战」继续执行任务吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[5802] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5802,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"contentView_",
				7,
				"mainPlotPanelView_",
				"button_"
			}
		},
		mask_component = {
			"common",
			"chapterMap",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[5901] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5901,
		talk_content = "百味轩因为转型失误经营不善濒临倒闭，咱和他们老板是旧识所以接手盘下了大半。",
		params = {},
		guide_component = {
			"common",
			"CombineGameMainView",
			{
				"gameObject_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-34,
			-318
		}
	},
	[5902] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5902,
		talk_content = "伴川街正为年末的醒岁节做准备，咱决定对百味轩重新装修，在醒岁节重新开业！",
		params = {},
		guide_component = {
			"common",
			"CombineGameMainView",
			{
				"gameObject_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-34,
			-318
		}
	},
	[5903] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5903,
		talk_content = "作为饱经风霜的百年老店，百味轩无疑是一些人心中不可磨灭的回忆。",
		params = {},
		guide_component = {
			"common",
			"CombineGameMainView",
			{
				"gameObject_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-34,
			-318
		}
	},
	[5904] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5904,
		talk_content = "但这份情怀并不足以支撑食客在其失去那份味道后再次踏入这家店铺，更何况还换了个老板，所以正式开业前的试营业便是必不可少的一步。",
		params = {},
		guide_component = {
			"common",
			"CombineGameMainView",
			{
				"tutorialBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-34,
			-318
		}
	},
	[5905] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5905,
		talk_content = "正式开始营业前，还是先来带你熟悉熟悉业务吧。",
		params = {},
		guide_component = {
			"common",
			"CombineGameTeachView",
			{
				"start1Btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-15,
			-320
		}
	},
	[5906] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5906,
		talk_content = "这里就是咱刚盘下来的店铺，也是后续经营的主要场所。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step0"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5907] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5907,
		talk_content = "可以看到地图上已经有了一些单元格，那咱就先介绍下这些单元格的效果吧~",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step0"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5908] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5908,
		talk_content = "这个是食物，是维持经营的必要资源。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5909] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5909,
		talk_content = "每回合都会消耗一定数量的食物，当食物不足时，就会宣告经营失败了。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5910] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5910,
		talk_content = "这个是客人，接待客人会给咱的店铺提供人气。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5911] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5911,
		talk_content = "咱还可以消耗人气使用专业能力发动强力效果，所以人气的积累也是很重要的。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5912] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5912,
		talk_content = "这个是建筑，积累建筑到达一定数量后就可以扩大经营规模。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce3"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5913] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5913,
		talk_content = "扩大经营规模后，可以解锁更强力的专业能力和天赋，帮助咱更容易的达成经营目标。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce3"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5914] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5914,
		talk_content = "这里会显示目前各项资源的积累数量，如果忘记每项资源的具体效果也可以点击对应图标再次查看。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce4"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5915] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5915,
		talk_content = "诶，你问具体怎么获得这些资源吗？",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step0"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5916] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5916,
		talk_content = "其实很简单，只要三个及以上相同类型和相同等级的单元格相连时，就会自动合成更高级的单元格，同时获得单元格数量*单元格等级的对应资源。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step0"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5917] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5917,
		talk_content = "为什么这样可以获得资源？具体原理咱也不是很懂，不过能赚钱就是好事。还是先来试试完成一次合成吧~",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step0"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5918] = {
		talk_anchors = 4,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5918,
		talk_content = "按住单元格，把它拖到相邻的位置上试试。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5919] = {
		talk_anchors = 4,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5919,
		talk_content = "按住单元格，把它拖到相邻的位置上试试。",
		params = {
			"pointerUp"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5920] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5920,
		talk_content = "合成成功！不仅获得了3点食物，同时单元格还提升了1级。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce5"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5921] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5921,
		talk_content = "不过要注意的是单元格等级是不能超过当前的单元格等级上限的。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce5"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5922] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5922,
		talk_content = "点击这里可以查看当前的单元格等级上限和单次最大移动距离。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_button1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5923] = {
		talk_anchors = 4,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5923,
		talk_content = "再来试试完成一次建筑合成吧。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step3"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5924] = {
		talk_anchors = 4,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5924,
		talk_content = "再来试试完成一次建筑合成吧。",
		params = {
			"pointerUp"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step3"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5925] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5925,
		talk_content = "累积了足够的建筑，经营规模扩大了，也解锁了新的能力。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce6"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-573,
			-374
		}
	},
	[5926] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 5926,
		talk_content = "点击空白区域，关闭弹窗。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce9"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			0
		}
	},
	[5927] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5927,
		talk_content = "点击这里可以查看当前角色已解锁的能力。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_button2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5928] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5928,
		talk_content = "我们先完成教学，后面再来仔细看吧~",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_button2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5929] = {
		talk_anchors = 4,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5929,
		talk_content = "再来尝试下获取人气吧。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5930] = {
		talk_anchors = 4,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5930,
		talk_content = "再来尝试下获取人气吧。",
		params = {
			"pointerUp"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_step2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5931] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5931,
		talk_content = "不好，这里出现了一个恶客。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce7"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5932] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5932,
		talk_content = "恶客不仅不会提供给我们任何收益，还会占据其他格子的位置。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce7"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5933] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5933,
		talk_content = "不过敢在咱的地盘上闹事，必须给他点颜色瞧瞧。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce7"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5934] = {
		talk_anchors = 0,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5934,
		talk_content = "使用刚刚积累的人气可以释放咱的专业能力，驱逐恶客，同时还能获得额外的食物。",
		params = {
			"skillSelected"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce8"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-626,
			-166
		}
	},
	[5935] = {
		talk_anchors = 0,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5935,
		talk_content = "拖动技能到对应的单元格上就可以使用了。",
		params = {
			"skillRelease"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce10"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-626,
			-166
		}
	},
	[5936] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5936,
		talk_content = "这边还生成了一个灾祸，灾祸也是一种负面单元格。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce11"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5937] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5937,
		talk_content = "与恶客不同的是，即使不去处理，灾祸也会在倒计时结束后自动消失。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce11"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5938] = {
		talk_anchors = 0,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5938,
		talk_content = "不过咱还是可以使用专业能力去加快灾祸的结束，同时还能获得额外的建筑。",
		params = {
			"skillSelected"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce12"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-626,
			-166
		}
	},
	[5939] = {
		talk_anchors = 0,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5939,
		talk_content = "拖动技能到对应的单元格上就可以使用了。",
		params = {
			"skillRelease"
		},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce10"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-626,
			-166
		}
	},
	[5940] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5940,
		talk_content = "每次移动单元格位置都会增加使经营时间增加一回合，达到一定回合后就会进入下一个经营阶段，面临的经营压力会更大。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce13"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5941] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5941,
		talk_content = "在这里可以看到营业目标，达成营业目标后即可获得胜利。",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce14"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5942] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 5942,
		talk_content = "咱的经营技巧可全都传授给你了，好好加油吧~",
		params = {},
		guide_component = {
			"common",
			"CombineGameView",
			{
				"guideComponents",
				"guide_introduce14"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			300
		}
	},
	[5943] = {
		talk_anchors = 0,
		type = "CombineGameStep",
		talk_adapt = 0,
		is_finish = false,
		id = 5943,
		talk_content = "\t",
		params = {},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			0
		}
	},
	[6001] = {
		talk_anchors = 0,
		type = "JumpTo",
		talk_adapt = 0,
		is_finish = false,
		id = 6001,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[6002] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6002,
		talk_content = "修正者还有其他方式可以提升自身的力量，我们去了解一下吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			50,
			-300
		}
	},
	[6003] = {
		talk_anchors = 0,
		type = "ClickCToggle",
		talk_adapt = 0,
		is_finish = false,
		id = 6003,
		talk_content = "薇儿丹蒂还有明显的提升空间，刻印可以为她提供额外的力量。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle4_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-93,
			36
		}
	},
	[6004] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6004,
		talk_content = "在中继之环中可以查看刻印的配备情况。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				4,
				"equipDisc_",
				"equipItem_",
				1,
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			321,
			304
		}
	},
	[6005] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6005,
		talk_content = "在刚才的战斗中获得了新的刻印，现在为薇儿丹蒂装备上吧。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				4,
				"equipInfo_",
				"btnChange_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-384,
			230
		}
	},
	[6006] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6006,
		talk_content = "每个刻印都有对应的装备位。",
		params = {},
		guide_component = {
			"listIndex",
			"heroEquipBag",
			{
				"equipBag_",
				"scrollHelper_"
			},
			1,
			{
				"clickBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			418,
			-492
		}
	},
	[6007] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6007,
		talk_content = "将刻印置入对应的装备位。",
		params = {},
		guide_component = {
			"common",
			"heroEquipBag",
			{
				"equipInfoViewMiddle_",
				"btnChange_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-802,
			230
		}
	},
	[6008] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6008,
		talk_content = "",
		params = {},
		guide_component = {
			"messageBox",
			"okBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[6009] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6009,
		talk_content = "每三个同名刻印同时装备时还会有额外的加成效果。",
		params = {},
		guide_component = {
			"common",
			"heroEquipBag",
			{
				"guideComponents",
				"guide_suit"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-28,
			-3
		}
	},
	[6010] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6010,
		talk_content = "同作为人类文明史的载体，刻印间可以通过共化来进行升级。",
		params = {},
		guide_component = {
			"common",
			"heroEquipBag",
			{
				"equipInfoViewRight_",
				"btnCulture_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-418,
			226
		}
	},
	[6011] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6011,
		talk_content = "选择作为共化素材的刻印「启示录」。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"pages_",
				2,
				"btnAutoSelect_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			35,
			-53
		}
	},
	[6012] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 6012,
		talk_content = "「启示录」是一种特殊的刻印，当它作为共化材料时可以提供更多的经验。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"pages_",
				2,
				"btnLevelup_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-384,
			230
		}
	},
	[6101] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6101,
		talk_content = "管理员，「弥弥尔工作室」推出的「偶像竞技」玩法开放测试了！",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"cricketBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			250,
			-210
		}
	},
	[6201] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6201,
		talk_content = "点击这里可以为修正者进行各项属性的培养。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeCamp",
			{
				"heroPropBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-70,
			-280
		}
	},
	[6202] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6202,
		talk_content = "这里是可以进行培养的修正者，可以通过标识看到哪些修正者是当前的进攻角色或防守角色。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"guideComponents",
				"guide_content"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-265,
			350
		}
	},
	[6203] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6203,
		talk_content = "只有当前参与到「偶像竞技」的修正者才可以进行培养，后续肯定会有更多的修正者参与进来~",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"guideComponents",
				"guide_content"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-265,
			350
		}
	},
	[6204] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6204,
		talk_content = "选择一名修正者看看吧。",
		params = {},
		guide_component = {
			"listIndex",
			"idolTraineeTrain",
			{
				"heroUIList_"
			},
			1,
			{
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-265,
			350
		}
	},
	[6205] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6205,
		talk_content = "修正者的各项属性数据都显示在这啦。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"pageGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-220,
			200
		}
	},
	[6206] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6206,
		talk_content = "每个修正者的属性会有差异，可以合理规划培养目标。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"pageGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-220,
			200
		}
	},
	[6207] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6207,
		talk_content = "每个修正者的风格也会有所差异，根据舞台的推荐风格派出修正者更容易获得高分。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"guideComponents",
				"guide_content2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-220,
			200
		}
	},
	[6208] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6208,
		talk_content = "每日可以对修正者培养的次数存在限制。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"guideComponents",
				"guide_content3"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			500,
			210
		}
	},
	[6209] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6209,
		talk_content = "每日会有随机的推荐神系的修正者，为这些修正者进行培养可以获得额外的加成。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"guideComponents",
				"guide_race"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			500,
			210
		}
	},
	[6210] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6210,
		talk_content = "可以选择对应属性的项目进行训练，训练同样会消耗修正者的体力。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"guideComponents",
				"guide_train"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			500,
			-250
		}
	},
	[6211] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6211,
		talk_content = "可以先点击进行乐感属性的训练。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"guideComponents",
				"guide_train1"
			}
		},
		mask_component = {
			"common",
			"idolTraineeTrain",
			{
				"train1Btn_"
			}
		},
		mask_scale = {},
		talk_position = {
			500,
			-250
		}
	},
	[6212] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6212,
		talk_content = "当体力较高的时候进行训练，更容易获得额外的属性加成。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeTrain",
			{
				"guideComponents",
				"guide_train1"
			}
		},
		mask_component = {
			"common",
			"idolTraineeTrain",
			{
				"train1Btn_"
			}
		},
		mask_scale = {},
		talk_position = {
			500,
			-250
		}
	},
	[6301] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6301,
		talk_content = "这里可以放入修正者进行休息并恢复体力。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeCamp",
			{
				"changeHeroBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-180,
			-280
		}
	},
	[6302] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6302,
		talk_content = "和大厅或宿舍一样，可以将修正者拖拽放入房间中。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeDepolyChara",
			{
				"heroList_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-250,
			-200
		}
	},
	[6303] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6303,
		talk_content = "在这里会获得等同于宿舍的体力恢复，如果未入住宿舍则会获得等同于大厅的体力恢复。",
		params = {},
		guide_component = {
			"child_getcom",
			"idolTraineeDepolyChara",
			{
				"guideComponents",
				"guide_content"
			},
			"heroItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-250,
			-200
		}
	},
	[6401] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6401,
		talk_content = "可以与其他参与「偶像竞技」的陌生人或好友进行对战了。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeCamp",
			{
				"pvpBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			500,
			-280
		}
	},
	[6403] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6403,
		talk_content = "这是舞台的基础信息，可以看到当前舞台推荐的风格或神系。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeEnterBattleView",
			{
				"guideComponents",
				"guide_info"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-200,
			-200
		}
	},
	[6404] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6404,
		talk_content = "与其他玩家对战前，可以随时查看或更换应对挑战以及进行挑战的修正者。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeEnterBattleView",
			{
				"heroBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-380,
			-250
		}
	},
	[6405] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6405,
		talk_content = "以当前舞台的推荐情况来选择合适的修正者则更容易获得胜利，更换挑战和应对挑战的修正者后，修正者头像也会有对应标识显示。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeEnterBattleView",
			{
				"selectHeroGo_"
			},
			{
				"heroListGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-400,
			-400
		}
	},
	[6407] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6407,
		talk_content = "先看看好友或陌生人是如何选择应对挑战的修正者吧。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeEnterBattleView",
			{
				"enterBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			450,
			-250
		}
	},
	[6408] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6408,
		talk_content = "点击切换至陌生人。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeEnterBattleView",
			{
				"guideComponents",
				"guide_strgbtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			260
		}
	},
	[6409] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6409,
		talk_content = "可以根据舞台情况以及对方的培养情况来选择对手，也能查看对方修正者的详细信息。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeEnterBattleView",
			{
				"guideComponents",
				"guide_content"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-400,
			-400
		}
	},
	[6410] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6410,
		talk_content = "如果挑战失败也不要气馁，做好准备后再多多尝试吧~",
		params = {},
		guide_component = {
			"common",
			"idolTraineeEnterBattleView",
			{
				"guideComponents",
				"guide_content2"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-400,
			-400
		}
	},
	[6501] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6501,
		talk_content = "通过每日培养或者对战可以完成任务。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeCamp",
			{
				"taskBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-200,
			-280
		}
	},
	[6502] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6502,
		talk_content = "完成任务获得的评分会推进阶段进度，每完成一个阶段都会获得对应奖励。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeQuest",
			{
				"guideComponents",
				"guide_info"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-150,
			135
		}
	},
	[6503] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6503,
		talk_content = "阶段1~阶段3完成后会获得随机的修正者情报。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeQuest",
			{
				"guideComponents",
				"guide_rank1_4"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-150,
			135
		}
	},
	[6504] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6504,
		talk_content = "点击可以查看阶段进度及奖励，完成阶段4可以从已招募的部分修正者中定向选取所需的修正者情报。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeQuest",
			{
				"rank4Btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			135,
			135
		}
	},
	[6505] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6505,
		talk_content = "每次完成阶段4后将重新从阶段1开始新的一轮，坚持完成任务获得奖励吧。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeQuest",
			{
				"guideComponents",
				"guide_info"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			135,
			135
		}
	},
	[6601] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6601,
		talk_content = "管理员，隐科组根据以往收集的数据已研究出神能回路增幅装置，需要修正者到实验室协助完成装置稳定性测试。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-380.8,
			404.75
		}
	},
	[6602] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6602,
		talk_content = "隐科组本次研发出的神能回路增幅装置能够有效提升神能输出效率，但考虑到在实战中新装置的稳定性可能会有波动，于是设置了「迭代校验」便于检测统计使用数据。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"toggleView_",
				4,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			428.55,
			-264
		}
	},
	[6603] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6603,
		talk_content = "点击前往「迭代校验」。",
		params = {
			"chapterMap",
			4,
			305
		},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"305",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"305/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			563,
			-186.99
		}
	},
	[6604] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6604,
		talk_content = "本次测试设置了不同属性的实战场景。",
		params = {},
		guide_component = {
			"common",
			"coreVerificationMain",
			{
				"mainBossItem_",
				"mainBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[6605] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6605,
		talk_content = "每个属性又设置了不同难度的实战对象可供挑战，管理员等级达到指定等级即可解锁对应难度的实战对象。",
		params = {},
		guide_component = {
			"listIndex",
			"coreVerificationInfo",
			{
				"tabList_"
			},
			1,
			{
				"mainBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			843,
			-225
		}
	},
	[6606] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6606,
		talk_content = "当前难度的BOSS信息在这里显示，成功挑战BOSS后队伍成员将被锁定，每个实战对象至多锁定6名修正者。",
		params = {},
		guide_component = {
			"common",
			"coreVerificationInfo",
			{
				"guideComponents",
				"guide_element"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-79,
			266.61
		}
	},
	[6607] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 6607,
		talk_content = "若是想了解更多关于「迭代校验」相关的信息，就点开这里的说明手册进行查看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[6701] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6701,
		talk_content = "欢迎来到危机预演行动！在正式进入战场之前，先了解一下与常规战斗的不同之处吧。",
		params = {},
		guide_component = {
			"common",
			"activityReforgeChapterView",
			{
				"levelBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-204
		}
	},
	[6702] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6702,
		talk_content = "在所有章节中，完成的顺序可以任选。但序章中建议按序完成。",
		params = {},
		guide_component = {
			"common",
			"activityReforgeLevelView",
			{
				"levelItemList_",
				1,
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			139,
			-12
		}
	},
	[6703] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 6703,
		talk_content = "点此进入第一关。",
		params = {},
		guide_component = {
			"common",
			"activityReforgeLevelView",
			{
				"startBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-367,
			229
		}
	},
	[6801] = {
		talk_anchors = 2,
		type = "HighLight",
		talk_adapt = 2,
		is_finish = false,
		id = 6801,
		talk_content = "一个关卡包含多场波次，需要为每一个波次分配不同的队伍才能开始战斗。",
		params = {},
		guide_component = {
			"common",
			"activityReforgeWaveView",
			{
				"guideComponents",
				"guide_teams"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-890,
			-247.98
		}
	},
	[6802] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6802,
		talk_content = "第一波次的信息建议我们派遣常规修正者队伍，点此进行队伍分配",
		params = {},
		guide_component = {
			"common",
			"activityReforgeWaveView",
			{
				"teamBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			419,
			77
		}
	},
	[6803] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = true,
		id = 6803,
		talk_content = "每个队伍只能负责一个波次，请根据波次合队伍信息合理规划。",
		params = {},
		guide_component = {
			"listIndex",
			"activityReforgeTeamView",
			{
				"teamList_"
			},
			1,
			{
				"selectBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			419,
			77
		}
	},
	[6804] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 2,
		is_finish = false,
		id = 6804,
		talk_content = "第一波次分配完成，点此为第二波次指派队伍。",
		params = {},
		guide_component = {
			"listIndex",
			"activityReforgeWaveView",
			{
				"waveList_"
			},
			2,
			{
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-890,
			-367
		}
	},
	[6805] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6805,
		talk_content = "第二波次的信息建议我们使用精锐修正者队伍，点此进行分配。",
		params = {},
		guide_component = {
			"common",
			"activityReforgeWaveView",
			{
				"teamBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			419,
			77
		}
	},
	[6806] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 6806,
		talk_content = "",
		params = {},
		guide_component = {
			"listIndex",
			"activityReforgeTeamView",
			{
				"teamList_"
			},
			1,
			{
				"selectBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			419,
			77
		}
	},
	[6807] = {
		talk_anchors = 4,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6807,
		talk_content = "战术技能是「危机预演」中非常强大的场外技能，花费资金解锁，可以瞬间扭转战场局势。您可以在技能界面中详细查看。",
		params = {},
		guide_component = {
			"common",
			"activityReforgeWaveView",
			{
				"guideComponents",
				"guide_skills"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			384,
			248
		}
	},
	[6808] = {
		talk_anchors = 1,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 6808,
		talk_content = "每一个波次的特点与任务各不相同，请明确其倾向后再针对性地分配队伍与技能。",
		params = {},
		guide_component = {
			"common",
			"activityReforgeWaveView",
			{
				"guideComponents",
				"guide_waves"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			438,
			-342
		}
	},
	[6809] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 6809,
		talk_content = "若是想了解更多关于「迭代校验」相关的信息，就点开这里的说明手册进行查看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[7001] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 7001,
		talk_content = "除玩家对战外也可以尝试固定关卡的挑战",
		params = {},
		guide_component = {
			"common",
			"idolTraineeCamp",
			{
				"challengeBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-280
		}
	},
	[7002] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 7002,
		talk_content = "除玩家对战外也可以尝试固定关卡的挑战，点击后可以进行关卡挑战。",
		params = {},
		guide_component = {
			"listIndex",
			"idolTraineeChapterMain",
			{
				"chapterUIList_"
			},
			1,
			{
				"btn_"
			}
		},
		mask_component = {
			"listIndex",
			"idolTraineeChapterMain",
			{
				"chapterUIList_"
			},
			1,
			{
				"pic_"
			}
		},
		mask_scale = {},
		talk_position = {
			500,
			-400
		}
	},
	[7003] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 7003,
		talk_content = "关卡可以重复挑战，当关卡胜利后会解锁后续关卡。",
		params = {},
		guide_component = {
			"listIndex",
			"idolTraineeLevelMainView",
			{
				"levelUIList_"
			},
			1,
			{
				"transform_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-50
		}
	},
	[7004] = {
		talk_anchors = 0,
		type = "HighLight",
		talk_adapt = 0,
		is_finish = false,
		id = 7004,
		talk_content = "根据当前关卡挑战完成的情况，可以领取对应的奖励。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeLevelMainView",
			{
				"rewardBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-210,
			-260
		}
	},
	[7005] = {
		talk_anchors = 0,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 7005,
		talk_content = "点击挑战看看关卡信息吧。",
		params = {},
		guide_component = {
			"listIndex",
			"idolTraineeLevelMainView",
			{
				"levelUIList_"
			},
			1,
			{
				"challengeBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-50
		}
	},
	[7007] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 7007,
		talk_content = "这是会在舞台上出现的对手，点击头像可以查看详细信息。",
		params = {},
		guide_component = {
			"common",
			"idolTraineeEnterBattleView",
			{
				"stageInfoPage",
				"ememyItem",
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-400,
			-320
		}
	},
	[7101] = {
		talk_anchors = 3,
		type = "ClickButton",
		talk_adapt = 0,
		is_finish = false,
		id = 7101,
		talk_content = "经过隐科组测试，增幅装置可正常投入使用。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-918,
			300
		}
	},
	[7102] = {
		talk_anchors = 4,
		type = "ClickCToggle",
		talk_adapt = 0,
		is_finish = false,
		id = 7102,
		talk_content = "按照标准规范流程，需要先在这里进入技能页面。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle2_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[7103] = {
		talk_anchors = 2,
		type = "ClickButton",
		talk_adapt = 2,
		is_finish = false,
		id = 7103,
		talk_content = "选择需要强化的技能。",
		params = {},
		guide_component = {
			"common_getcom",
			"newHero",
			{
				"pages_",
				2,
				"skillItem1Go_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-775,
			-197
		}
	},
	[7104] = {
		talk_anchors = 1,
		type = "ClickButton",
		talk_adapt = 1,
		is_finish = false,
		id = 7104,
		talk_content = "进入属性强化页面。",
		params = {},
		guide_component = {
			"common",
			"skillView",
			{
				"propertyBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			678,
			-299
		}
	},
	[7105] = {
		talk_anchors = 3,
		type = "HighLight",
		talk_adapt = 2,
		is_finish = false,
		id = 7105,
		talk_content = "满足相应条件后，即可进行技能属性的强化。",
		params = {},
		guide_component = {
			"common",
			"skillView",
			{
				"guideComponents",
				"guide_upgrade"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-317,
			336
		}
	},
	all = {
		101,
		102,
		103,
		104,
		105,
		106,
		107,
		201,
		202,
		203,
		204,
		205,
		206,
		301,
		302,
		304,
		305,
		306,
		307,
		308,
		309,
		405,
		406,
		407,
		408,
		409,
		410,
		411,
		412,
		413,
		414,
		415,
		501,
		502,
		503,
		504,
		505,
		506,
		507,
		508,
		509,
		510,
		511,
		601,
		602,
		603,
		604,
		605,
		606,
		607,
		608,
		609,
		610,
		801,
		802,
		804,
		805,
		806,
		807,
		808,
		809,
		810,
		811,
		812,
		813,
		814,
		815,
		816,
		817,
		818,
		901,
		902,
		1001,
		1002,
		1003,
		1004,
		1005,
		1101,
		1102,
		1103,
		1104,
		1105,
		1201,
		1202,
		1203,
		1204,
		1301,
		1302,
		1303,
		1304,
		1305,
		1601,
		1602,
		1701,
		1702,
		1704,
		1801,
		1802,
		1804,
		1805,
		1806,
		1807,
		1808,
		1901,
		1902,
		1903,
		1904,
		1905,
		1906,
		1907,
		1908,
		1909,
		1910,
		1911,
		1912,
		1913,
		1914,
		1915,
		1916,
		1917,
		1918,
		1919,
		1920,
		1921,
		1922,
		1923,
		2001,
		2002,
		2003,
		2004,
		2005,
		2102,
		2103,
		2201,
		2202,
		2203,
		2301,
		2401,
		2402,
		2403,
		2404,
		2405,
		2406,
		2407,
		2408,
		2501,
		2502,
		2503,
		2504,
		2505,
		2506,
		2601,
		2602,
		2603,
		2604,
		2605,
		2606,
		2607,
		2608,
		2701,
		2702,
		2703,
		2704,
		2705,
		2706,
		2801,
		2802,
		2803,
		2804,
		2805,
		2806,
		2807,
		2808,
		2809,
		2810,
		2901,
		2902,
		3001,
		3101,
		3201,
		3401,
		3501,
		3502,
		3503,
		3504,
		3601,
		3602,
		3603,
		3604,
		3605,
		3701,
		3702,
		3703,
		3704,
		3801,
		3802,
		3803,
		3902,
		3903,
		4001,
		4002,
		4003,
		4004,
		4005,
		4006,
		4007,
		4008,
		4009,
		4010,
		4011,
		4012,
		4101,
		4102,
		4103,
		4104,
		4204,
		4205,
		4206,
		4207,
		4208,
		4301,
		4302,
		4303,
		4304,
		4305,
		4306,
		4307,
		4308,
		4401,
		4402,
		4403,
		4404,
		4405,
		4406,
		4407,
		4408,
		4409,
		4410,
		4411,
		4412,
		4501,
		4601,
		4602,
		4603,
		4604,
		4605,
		4606,
		4607,
		4608,
		4609,
		4610,
		4611,
		4612,
		4613,
		4614,
		4615,
		4616,
		4617,
		4618,
		4619,
		4620,
		4621,
		4701,
		4702,
		4801,
		4803,
		4804,
		4805,
		4806,
		4807,
		4809,
		4902,
		4903,
		4904,
		5001,
		5003,
		5004,
		5005,
		5006,
		5101,
		5102,
		5103,
		5104,
		5105,
		5201,
		5202,
		5203,
		5204,
		5205,
		5206,
		5207,
		5301,
		5302,
		5303,
		5304,
		5305,
		5401,
		5402,
		5403,
		5404,
		5405,
		5406,
		5407,
		5408,
		5501,
		5502,
		5503,
		5504,
		5505,
		5603,
		5604,
		5605,
		5606,
		5608,
		5701,
		5702,
		5703,
		5704,
		5705,
		5706,
		5707,
		5708,
		5801,
		5802,
		5901,
		5902,
		5903,
		5904,
		5905,
		5906,
		5907,
		5908,
		5909,
		5910,
		5911,
		5912,
		5913,
		5914,
		5915,
		5916,
		5917,
		5918,
		5919,
		5920,
		5921,
		5922,
		5923,
		5924,
		5925,
		5926,
		5927,
		5928,
		5929,
		5930,
		5931,
		5932,
		5933,
		5934,
		5935,
		5936,
		5937,
		5938,
		5939,
		5940,
		5941,
		5942,
		5943,
		6001,
		6002,
		6003,
		6004,
		6005,
		6006,
		6007,
		6008,
		6009,
		6010,
		6011,
		6012,
		6101,
		6201,
		6202,
		6203,
		6204,
		6205,
		6206,
		6207,
		6208,
		6209,
		6210,
		6211,
		6212,
		6301,
		6302,
		6303,
		6401,
		6403,
		6404,
		6405,
		6407,
		6408,
		6409,
		6410,
		6501,
		6502,
		6503,
		6504,
		6505,
		6601,
		6602,
		6603,
		6604,
		6605,
		6606,
		6607,
		6701,
		6702,
		6703,
		6801,
		6802,
		6803,
		6804,
		6805,
		6806,
		6807,
		6808,
		6809,
		7001,
		7002,
		7003,
		7004,
		7005,
		7007,
		7101,
		7102,
		7103,
		7104,
		7105
	}
}
