return {
	GetMainUIName = function(arg_1_0)
		local var_1_0 = ActivityTools.GetActivityTheme(arg_1_0)

		if ActivityHeroTrialUICfg[var_1_0] then
			return ActivityHeroTrialUICfg[var_1_0].main_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityHeroTrialUICfg has no theme(%d)</color>", var_1_0))

			return "UI/VersionUI/XuHengUI/XH2ndHeroTrialUI/XH2ndHeroTrialUI"
		end
	end,
	GetHeroStandardID = function(arg_2_0)
		local var_2_0 = HeroStandardSystemCfg.all[1]
		local var_2_1 = ActivityHeroTrialCfg[arg_2_0]

		if not var_2_1 then
			Debug.Log(string.format("<color=ff0000>ActivityHeroTrialCfg has no id(%s)</color>, return default standardID(%s)", arg_2_0, var_2_0))

			return var_2_0
		end

		local var_2_2 = BattleHeroTrialStageCfg[var_2_1.stage_id]

		if not var_2_2 then
			Debug.Log(string.format("<color=ff0000>BattleHeroTrialStageCfg has no id(%s)</color>, return default standardID(%s)", var_2_1.stage_id, var_2_0))

			return var_2_0
		end

		return var_2_2.hero_list[1][2]
	end
}
