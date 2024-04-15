return {
	GetMainUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.TYR then
			return "UI/VersionUI/DarkFlameUI/DFCutGrassUI/DFCutGrassMainUI"
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_4 then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionHuntingUI/JapanRegionHtMainUI"
		else
			return "UI/VolumeIIIUI/VolumeCutgrassMainUI"
		end
	end,
	GetSelectUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.TYR then
			return "UI/VersionUI/DarkFlameUI/DFCutGrassUI/DFCutGrassStageUI"
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_4 then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionHuntingUI/JapanRegionHtStageUI"
		else
			return "UI/VolumeIIIUI/VolumeCutgrassSelectUI"
		end
	end,
	GetRewardUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.TYR then
			return "UI/VersionUI/DarkFlameUI/DFCutGrassUI/DFCutGrassRewardUI"
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_4 then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionHuntingUI/JapanRegionHtRewardUI"
		else
			return "UI/VersionUI/HellaUI/Slayer/HellaSlayerRewardUI"
		end
	end,
	GetRewardItemClass = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.TYR then
			return SlayerRewardItem_1_7
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_4 then
			return SlayerRewardItem_1_7
		else
			return HellaSlayerRewardItem
		end
	end
}
