return {
	GetEnterUI = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaArenaMainUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_ArenaMainUI"
		end
	end,
	GetMainUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaInletUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_InletUI"
		end
	end,
	GetRankUI = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaPTRankUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_PTRankUI"
		end
	end,
	GetRewardUI = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaRewardUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_RewardUI"
		end
	end,
	GetRoundUI = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaRewardtimeUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_RewardtimeUI"
		end
	end,
	GetTrialHeroList = function (slot0)
		return ActivityAttributeArenaCfg[slot0].trial_hero_list
	end
}
