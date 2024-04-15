return {
	[1001] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 1,
		talk_anchors = 1,
		name = "home",
		narrator_icon = "mmr",
		id = 1001,
		talk_content = "新人，这是我们特意为你准备的欢迎仪式，希望你能再接再厉。",
		narrator_name = "弥弥尔",
		guide_component = {
			"buttonNewbie_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1010005
			}
		},
		skipcondition = {
			{
				"stage",
				1010113
			}
		},
		talk_position = {
			568,
			-284
		}
	},
	[1002] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 2,
		talk_anchors = 2,
		name = "home",
		narrator_icon = "mmr",
		id = 1002,
		talk_content = "弥弥观测站功能开放了。",
		narrator_name = "弥弥尔",
		guide_component = {
			"btn_menu"
		},
		mask_component = {},
		opencondition = {
			{
				"guide",
				17
			}
		},
		skipcondition = {
			{
				"stage",
				1010113
			}
		},
		talk_position = {
			-370,
			-280
		}
	},
	[1003] = {
		closetime = 5,
		priority = -1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "home",
		narrator_icon = "mmr",
		id = 1003,
		talk_content = "矩阵公会现已开放。",
		narrator_name = "弥弥尔",
		guide_component = {
			"btnGuild_"
		},
		mask_component = {},
		opencondition = {
			{
				"playerLevel",
				30
			}
		},
		skipcondition = {
			{
				"stage",
				1010613
			}
		},
		talk_position = {
			170,
			-290
		}
	},
	[1004] = {
		closetime = 5,
		priority = -2,
		talk_adapt = 2,
		talk_anchors = 2,
		name = "home",
		narrator_icon = "mmr",
		id = 1004,
		talk_content = "管理员，热门活动的参与入口已经开放了。",
		narrator_name = "弥弥尔",
		guide_component = {
			"@@activityEntraceView_",
			1
		},
		mask_component = {
			"guideComponents",
			"guide_activity"
		},
		opencondition = {
			{
				"playerLevel",
				35
			}
		},
		skipcondition = {
			{
				"stage",
				1010811
			}
		},
		talk_position = {
			-760,
			-330
		}
	},
	[1005] = {
		closetime = 5,
		priority = -3,
		talk_adapt = 1,
		talk_anchors = 1,
		name = "home",
		narrator_icon = "mmr",
		id = 1005,
		talk_content = "相信管理员现在已经对自己的基本职责非常熟悉了，那就让我们开启进修企划吧！",
		narrator_name = "弥弥尔",
		guide_component = {
			"btn_newbie_task"
		},
		mask_component = {},
		opencondition = {
			{
				"playerLevel",
				41
			}
		},
		skipcondition = {
			{
				"playerLevel",
				45
			}
		},
		talk_position = {
			568,
			-267
		}
	},
	[1101] = {
		closetime = 5,
		priority = 5,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 1101,
		talk_content = "「因子采集」玩法开放，技能升级所需物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1010102
			}
		},
		skipcondition = {
			{
				"stage",
				1010310
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[1102] = {
		closetime = 5,
		priority = 4,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 1102,
		talk_content = "「模拟作战」玩法开放，修正者升级所需物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1010108
			}
		},
		skipcondition = {
			{
				"stage",
				1010310
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[1103] = {
		closetime = 5,
		priority = 3,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 1103,
		talk_content = "「深层勘探」玩法开放，权钥升级所需物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1010113
			}
		},
		skipcondition = {
			{
				"stage",
				1010310
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[1104] = {
		closetime = 5,
		priority = 2,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 1104,
		talk_content = "「失落遗迹」玩法开放，修正者突破所需物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1010204
			}
		},
		skipcondition = {
			{
				"stage",
				1010310
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[1105] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 1105,
		talk_content = "「极限萃取」、「酬金委托」玩法开放，全部物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1010211
			}
		},
		skipcondition = {
			{
				"stage",
				1010310
			}
		},
		talk_position = {
			970,
			285
		}
	},
	get_id_list_by_name = {
		chapterMap = {
			1101,
			1102,
			1103,
			1104,
			1105
		},
		home = {
			1001,
			1002,
			1003,
			1004,
			1005
		}
	},
	all = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1101,
		1102,
		1103,
		1104,
		1105
	}
}
