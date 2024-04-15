return {
	GetMainUIName = function (slot0)
		if ActivityHeroTrialUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivityHeroTrialUICfg[slot1].main_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityHeroTrialUICfg has no theme(%d)</color>", slot1))

			return "UI/VersionUI/XuHengUI/XH2ndHeroTrialUI/XH2ndHeroTrialUI"
		end
	end,
	GetHeroStandardID = function (slot0)
		slot1 = HeroStandardSystemCfg.all[1]

		if not ActivityHeroTrialCfg[slot0] then
			Debug.Log(string.format("<color=ff0000>ActivityHeroTrialCfg has no id(%s)</color>, return default standardID(%s)", slot0, slot1))

			return slot1
		end

		if not BattleHeroTrialStageCfg[slot2.stage_id] then
			Debug.Log(string.format("<color=ff0000>BattleHeroTrialStageCfg has no id(%s)</color>, return default standardID(%s)", slot2.stage_id, slot1))

			return slot1
		end

		return slot3.hero_list[1][2]
	end
}
