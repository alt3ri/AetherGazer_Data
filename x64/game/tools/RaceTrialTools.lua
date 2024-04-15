return {
	InitConst = function (slot0)
		uv0.mainActivityIdDic_ = uv0.mainActivityIdDic_ or {}

		for slot5, slot6 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			uv0.mainActivityIdDic_[slot6] = slot0
		end
	end,
	GetMainActivityID = function (slot0)
		return uv0.mainActivityIdDic_[slot0]
	end,
	GetMainUIName = function (slot0)
		if ActivityRaceTrialUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivityRaceTrialUICfg[slot1].main_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", slot1))

			return "UI/VersionUI/OsirisUI/OsirisUITrialUI"
		end
	end,
	GetFirstRewardPopUIName = function (slot0)
		if ActivityRaceTrialUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivityRaceTrialUICfg[slot1].first_reward_pop_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", slot1))

			return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIRaceTrialFirstRewardUI"
		end
	end,
	GetScoreRewardUIName = function (slot0)
		if ActivityRaceTrialUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivityRaceTrialUICfg[slot1].score_reward_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", slot1))

			return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIRaceTrialScoreRewardUI"
		end
	end,
	GetReadyUIName = function (slot0)
		if ActivityRaceTrialUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivityRaceTrialUICfg[slot1].ready_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", slot1))

			return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIDownRaceTrialSelectAffixUI"
		end
	end,
	GetBattleItemClass = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.OSIRIS then
			return RaceTrialBattleItem
		elseif slot1 == ActivityConst.THEME.VOLUME_DOWN then
			return VolumeDownRaceTrialBattleItem
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_1 then
			return RaceTrialBattleItem_2_1
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_6 then
			return RaceTrialBattleItem_2_6
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_10 then
			return RaceTrialBattleItem_2_10
		else
			return RaceTrialBattleItem
		end
	end
}
