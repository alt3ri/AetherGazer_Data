return {
	GetRankUIName = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2_RANK then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtRankUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_1_PT2_RANK then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndPtUI/XH2ndPtRankUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_2_PT2_RANK then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdPtUI/XH3rdPtRankUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_RANK_UP then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPTUPRankUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_RANK_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPTDownRankUI"
		elseif slot0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_RANK_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPtDownUI/JapanRegionPTDownRankUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_RANK_UP then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTUp/IndiaPTUpRankUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_RANK_DOWN then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTDown/IndiaPTDownRankUI"
		else
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtRankUI"
		end
	end,
	GetRankItemClass = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2_RANK then
			return ActivityPT2RankItem
		else
			return ActivityRaceRankItem
		end
	end
}
