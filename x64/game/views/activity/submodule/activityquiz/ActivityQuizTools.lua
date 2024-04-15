slot1 = nil
slot2 = {
	[ActivityConst.ACTIVITY_2_8_QUIZ] = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/IndiaPreheatMainUI"
}
slot3 = {
	[ActivityConst.ACTIVITY_2_8_QUIZ] = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/IndiaPopUI"
}
slot4 = {
	[ActivityConst.ACTIVITY_2_8_QUIZ] = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/IndiaShowUI"
}
slot5 = {
	[ActivityConst.ACTIVITY_2_8_QUIZ] = ActivityConst.ACTIVITY_2_8_QUIZ_TASK
}
slot6 = {
	[ActivityConst.ACTIVITY_2_8_QUIZ] = "ACTIVITY_QUIZ_DESCRIBE"
}
slot7 = {
	[ActivityConst.ACTIVITY_2_8_QUIZ] = ""
}
slot8 = {
	[ActivityConst.ACTIVITY_2_8_QUIZ] = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/IndiaHallUI"
}

return {
	GetEnterUIName = function (slot0)
		return uv0[slot0]
	end,
	GetMatchPopUIName = function (slot0)
		return uv0[slot0]
	end,
	GetResultUIName = function (slot0)
		return uv0[slot0]
	end,
	GetTaskActivityID = function (slot0)
		return uv0[slot0]
	end,
	GetHelpKey = function (slot0)
		return uv0[slot0] or ""
	end,
	GetActivitySceneName = function (slot0)
		return ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[slot0][1]].scene
	end,
	GetActivitySceneUIName = function (slot0)
		return uv0[slot0]
	end,
	SetCurActivityID = function (slot0)
		uv0 = slot0
	end,
	GetCurActivityID = function ()
		if uv0 then
			return uv0
		else
			error("未设置活动id")
		end
	end,
	ClearCurActivityID = function ()
		uv0 = nil
	end,
	GetLastSelectedPlayer = function (slot0)
		return getData("activityQuiz", "lastSelectedPlayer_" .. slot0) or ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[slot0][1]].character_list[1]
	end
}
