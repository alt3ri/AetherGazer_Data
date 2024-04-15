return {
	GetMainUIName = function (slot0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == slot0 then
			return "UI/VersionUI/SummerUI/SummerArtifactUI"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFArtifactUI/DFArtifactMainUI"
		elseif ActivityConst.ACTIVITY_2_10_LIMITED_CALCULATION == slot0 then
			return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10ArtifactUI/JapanRegionUI_2_10ArtifactUI"
		else
			return "UI/VersionUI/SummerUI/SummerArtifactUI"
		end
	end,
	GetGameHelpKey = function (slot0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == slot0 then
			return "ACTIVITY_SUMMER_LIMITED_CALCULATION_DESCRIPE"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == slot0 then
			return "ACTIVITY_1_7_LIMITED_CALCULATION_DESCRIPE"
		else
			return "ACTIVITY_1_7_LIMITED_CALCULATION_DESCRIPE"
		end
	end,
	GetRankUIName = function (slot0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == slot0 then
			return "UI/VersionUI/SummerUI/SummerArtifactRankUI"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == slot0 then
			return "UI/VersionUI/DarkFlameUI/DFArtifactUI/DFArtifactRankUI"
		elseif ActivityConst.ACTIVITY_2_10_LIMITED_CALCULATION == slot0 then
			return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10ArtifactUI/JapanRegionUI_2_10ArtifactRankUI"
		else
			return "UI/VersionUI/SummerUI/SummerArtifactRankUI"
		end
	end,
	GetBuffList = function (slot0)
		slot1 = nil
		slot2 = {}

		for slot7, slot8 in ipairs(LimitedCalculationData:GetDifficultyList(slot0)) do
			if ActivityLimitCalculationCfg[slot8].player_level ~= 0 then
				table.insert(slot2, slot8)
			end
		end

		return slot2
	end,
	GetDebuffList = function (slot0)
		slot1 = nil
		slot2 = {}

		for slot7, slot8 in ipairs(LimitedCalculationData:GetDifficultyList(slot0)) do
			if ActivityLimitCalculationCfg[slot8].enemy_level ~= 0 then
				table.insert(slot2, slot8)
			end
		end

		return slot2
	end
}
