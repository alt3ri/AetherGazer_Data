slot1 = {
	[ActivityConst.ACTIVITY_2_8_SURVIVE_SOLO] = "UI/VersionUI/IndiaUI_2_8/IndiaTationUI/IndiaDisorienTationUI"
}
slot2 = {
	[ActivityConst.ACTIVITY_2_8_SURVIVE_SOLO] = "ACTIVITY_SOLO_SLAYER_DESC"
}
slot3 = {
	[ActivityConst.ACTIVITY_2_8_SURVIVE_SOLO] = "UI/VersionUI/IndiaUI_2_8/IndiaTationUI/IndiaDisorienTationRewardUI"
}

return {
	GetEnterUIName = function (slot0)
		return uv0[slot0]
	end,
	GetGameHelpKey = function (slot0)
		return uv0[slot0] or ""
	end,
	GetRewardPopView = function (slot0)
		return uv0[slot0]
	end
}
