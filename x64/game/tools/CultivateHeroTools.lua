return {
	GetMainUIName = function (slot0)
		if ActivityCultivateHeroUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivityCultivateHeroUICfg[slot1].main_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityCultivateHeroUICfg has no theme(%d)</color>", slot1))

			return "UI/VersionUI/XuHeng1stUI/XH1stReceivedUI/XH1stReceivedUI"
		end
	end,
	GetRewardUIName = function (slot0)
		if ActivityCultivateHeroUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivityCultivateHeroUICfg[slot1].reward_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityCultivateHeroUICfg has no theme(%d)</color>", slot1))

			return "UI/VersionUI/XuHeng1stUI/XH1stReceivedUI/XH1stRewardPopUI"
		end
	end,
	GetSwitchItemClass = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_0 then
			return CultivateHeroSwitchItem
		else
			return CultivateHeroSwitchItem_2_1
		end
	end
}
