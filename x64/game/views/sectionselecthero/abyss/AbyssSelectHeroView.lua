slot0 = class("AbyssSelectHeroView", SectionSelectHeroBaseView)

function slot0.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/abyssTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		stageType = slot0.stageType_,
		layer = slot0.params_.layer,
		reserveParams = slot0.reserveParams_
	})
end

function slot0.StartBattle(slot0)
	if slot0.params_.curActivityID ~= AbyssData:GetActivityId() then
		ShowTips("ERROR_ACTIVITY_NOT_OPEN")

		return
	end

	if AbyssData:GetAbyssCfg(slot0.params_.layer).stage_list[slot0.params_.stageIndex][1] == 3 then
		AbyssData:SetCurrentBossPhase(AbyssData:GetStageData(slot1.level, slot0.params_.stageIndex).phase or 1)
	end

	slot3 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, {
		activityID = slot0.params_.activityID,
		curActivityID = slot0.params_.curActivityID
	}, slot0.reserveParams_)

	slot3:SetMultiple(slot0.multiple_)
	slot3:SetStageData(slot1.level, slot0.params_.stageIndex)
	BattleController.GetInstance():LaunchBattle(slot3)
end

function slot0.GotoReservesUI(slot0)
	JumpTools.OpenPageByJump("/reservesUI", {
		isInit = true,
		stage_type = slot0.stageType_,
		stage_id = slot0.stageID_,
		activityID = slot0.params_.activityID,
		hero_list = slot0.cacheHeroTeam_,
		hero_trial_list = slot0.heroTrialList_,
		lockList = slot0:GetLockList(),
		comboSkill = slot0.comboSkillView_:GetCurComboSkill(),
		chipInfo = {
			enabledID = slot0.chipView_:GetCurEnabledID(),
			chipList = slot0.chipView_:GetCurChipList()
		},
		reserveParams = slot0.reserveParams_
	})
end

function slot0.GetLockList(slot0)
	slot1 = {}

	table.insertto(slot1, AbyssTools.GetLayerLockHeroList(slot0.params_.layer))
	table.insertto(slot1, AbyssTools.GetGlobalBanHeroList())

	return slot1
end

return slot0
