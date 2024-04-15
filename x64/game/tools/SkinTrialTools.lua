return {
	GetMainViewUIName = function (slot0)
		if ActivitySkinTrialUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivitySkinTrialUICfg[slot1].main_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivitySkinTrialUICfg has no theme(%d)</color>", slot1))

			return "UI/VersionUI/XuHengUI/XHSkinTrialUI/XHSkinTrialMainUI"
		end
	end,
	GetSelectViewUIName = function (slot0)
		if ActivitySkinTrialUICfg[ActivityTools.GetActivityTheme(slot0)] then
			return ActivitySkinTrialUICfg[slot1].select_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivitySkinTrialUICfg has no theme(%d)</color>", slot1))

			return "UI/VersionUI/XuHengUI/XHSkinTrialUI/XHSkinTrialUI"
		end
	end,
	GoToSelectView = function (slot0, slot1)
		slot3 = ActivitySkinTrialCfg[slot1]

		if ActivitySkinTrialUICfg[ActivityTools.GetActivityTheme(slot0)] then
			if ActivitySkinTrialUICfg[slot2].script_version == "3" then
				JumpTools.OpenPageByJump("/skinTrialSelectView_3_0", {
					activityID = slot0,
					skinTrialID = slot1
				})
			else
				JumpTools.OpenPageByJump("/skinTrialSelectView_2_0", {
					activityID = slot0,
					skinTrialID = slot1
				})
			end
		else
			Debug.Log(string.format("<color=ff0000>ActivitySkinTrialUICfg has no theme(%d)</color>", slot2 or ""))
		end
	end,
	GetHeroStandardID = function (slot0)
		slot1 = HeroStandardSystemCfg.all[1]

		if not ActivitySkinTrialCfg[slot0] then
			Debug.Log(string.format("<color=ff0000>ActivitySkinTrialCfg has no id(%s)</color>, return default standardID(%s)", slot0, slot1))

			return slot1
		end

		if not BattleSkinTrialStageCfg[slot2.stage_id] then
			Debug.Log(string.format("<color=ff0000>BattleSkinTrialStageCfg has no id(%s)</color>, return default standardID(%s)", slot2.stage_id, slot1))

			return slot1
		end

		return slot3.hero_list[1][2]
	end
}
