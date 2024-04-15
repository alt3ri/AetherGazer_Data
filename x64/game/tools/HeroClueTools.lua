return {
	GetEnterViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_6 then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheatMainUI"
		else
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheatMainUI"
		end
	end,
	GetMainViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_6 then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheatRoleUI"
		else
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheatRoleUI"
		end
	end,
	GetTaskViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_6 then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheatRewardUI"
		else
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheatRewardUI"
		end
	end,
	GetDrawResultViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_6 then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheatPopUI"
		else
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheatPopUI"
		end
	end,
	GetClueDetailViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_6 then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheaDetailsUI"
		else
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPreheatUI/JapanRegionPreheaDetailsUI"
		end
	end,
	GetTaskActivityID = function (slot0)
		return ActivityCfg[slot0].sub_activity_list[1]
	end,
	GetPlayTaskActivityID = function (slot0)
		return ActivityCfg[slot0].sub_activity_list[2]
	end
}
