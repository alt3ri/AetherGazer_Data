slot0 = class("AdvanceTestSelectHeroView", SectionSelectHeroBaseView)

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.ADVANCETEST)
end

function slot0.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/advanceTestTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		stageType = slot0.stageType_,
		stageDifficult = slot0.params_.stageDifficult,
		type = HeroConst.HERO_DATA_TYPE.ADVANCETEST,
		reserveParams = slot0.reserveParams_
	})
end

function slot0.StartBattle(slot0)
	slot1 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, {
		dest = slot0.params_.dest,
		activityID = slot0.params_.activityID
	})

	slot1:SetMultiple(slot0.multiple_)
	BattleController.GetInstance():LaunchBattle(slot1)
end

function slot0.GotoReservesUI(slot0)
	JumpTools.OpenPageByJump("/reservesUI", {
		isInit = true,
		stage_type = slot0.stageType_,
		activityID = slot0.params_.activityID,
		hero_list = slot0.cacheHeroTeam_,
		hero_trial_list = slot0.heroTrialList_,
		comboSkill = slot0.comboSkillView_:GetCurComboSkill(),
		chipInfo = {
			enabledID = slot0.chipView_:GetCurEnabledID(),
			chipList = slot0.chipView_:GetCurChipList()
		},
		reserveParams = slot0.reserveParams_
	})
end

function slot0.GetHeroPower(slot0, slot1)
	return slot0.heroViewProxy_:GetBattlePower(slot0.cacheHeroTeam_[slot1])
end

return slot0
