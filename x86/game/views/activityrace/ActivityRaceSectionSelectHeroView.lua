slot1 = class("ActivityRaceSectionSelectHeroView", import("game.views.sectionSelectHero.SectionSelectHeroBaseView"))

function slot1.GoHeroInfoUI(slot0, slot1)
	if type(BattleStageTools.GetRestrictHeroList(slot0.stageType_, slot0.stageID_)) == "table" and slot2[slot1][1] ~= 0 and HeroCfg[slot3[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], slot3[1]) then
		ShowTips("CAN_NOT_CHANGE_HERO")

		return
	end

	slot0:Go("/activityRaceHeroTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		activityID = slot0.params_.activityID,
		stageType = slot0.stageType_,
		reserveParams = slot0.reserveParams_
	})
end

function slot1.GotoReservesUI(slot0)
	JumpTools.OpenPageByJump("/activityRaceReservesUI", {
		isInit = true,
		stage_type = slot0.stageType_,
		activityID = slot0.params_.activityID,
		hero_list = slot0.cacheHeroTeam_,
		hero_trial_list = slot0.heroTrialList_,
		lastParams = slot0.params_,
		lockList = slot0.lockList_,
		race = slot0.params_.race,
		comboSkill = slot0.comboSkillView_:GetCurComboSkill(),
		chipInfo = {
			enabledID = slot0.chipView_:GetCurEnabledID(),
			chipList = slot0.chipView_:GetCurChipList()
		},
		reserveParams = slot0.reserveParams_
	})
end

return slot1
