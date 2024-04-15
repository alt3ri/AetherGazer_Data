slot1 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "Widget/Version/NorseUI_3_0/NorseUI_3_0_NianUI/NorseUI_3_0_NianMianUI"
}
slot2 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "Widget/Version/NorseUI_3_0/NorseUI_3_0_NianUI/NorseNianStageUI"
}
slot3 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "Widget/Version/NorseUI_3_0/NorseUI_3_0_NianUI/NorseNianRecallUI"
}
slot4 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "Widget/Version/NorseUI_3_0/NorseUI_3_0_NianUI/NorseNianRoleUI"
}
slot5 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "ACTIVITY_HERO_TASK_DESC"
}

return {
	GetEnterUIName = function (slot0)
		return uv0[slot0]
	end,
	GetMainUIName = function (slot0)
		return uv0[slot0]
	end,
	GetPlayBackUIName = function (slot0)
		return uv0[slot0]
	end,
	GetTaskUIName = function (slot0)
		return uv0[slot0]
	end,
	GetHelpKey = function (slot0)
		return uv0[slot0] or ""
	end,
	IsReward = function (slot0)
		return TaskData2:GetTask(ActivityHeroTaskCfg[slot0].task_id) and slot3.complete_flag == 1
	end
}
