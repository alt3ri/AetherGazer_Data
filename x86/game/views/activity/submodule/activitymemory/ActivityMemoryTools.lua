slot1 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = "SPRING_FESTIVAL_MEMORY_DES"
}
slot2 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = "UI/VersionUI/IndiaUI_2_8/IndiaRecall/IndiaRecallMainUI"
}
slot3 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = "UI/VersionUI/IndiaUI_2_8/IndiaRecall/IndiaRecallPopUI"
}
slot4 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = ActivityConst.ACTIVITY_2_8_SPRING_MEMORY_TASK
}
slot5 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = GameSetting.spring_festival_memory_story_start.value
}
slot6 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = GameSetting.spring_festival_memory_story_process.value
}
slot7 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = GameSetting.spring_festival_memory_story_end.value
}

return {
	GetHelpKey = function (slot0)
		return uv0[slot0] or ""
	end,
	GetEnterUIName = function (slot0)
		return uv0[slot0]
	end,
	GetInfoUIName = function (slot0)
		return uv0[slot0]
	end,
	GetTaskActivityID = function (slot0)
		return uv0[slot0]
	end,
	GetEnterCondition = function (slot0)
		return uv0[slot0]
	end,
	GetActivityCondition = function (slot0)
		return uv0[slot0]
	end,
	GetCollectCondition = function (slot0)
		return uv0[slot0]
	end
}
