local var_0_0 = class("AdvanceTestSelectHeroView", SectionSelectHeroBaseView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)

	arg_1_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.ADVANCETEST)
end

function var_0_0.GoHeroInfoUI(arg_2_0, arg_2_1)
	arg_2_0:Go("/advanceTestTeamInfo", {
		isEnter = true,
		selectHeroPos = arg_2_1,
		stageID = arg_2_0.stageID_,
		stageType = arg_2_0.stageType_,
		stageDifficult = arg_2_0.params_.stageDifficult,
		type = HeroConst.HERO_DATA_TYPE.ADVANCETEST,
		reserveParams = arg_2_0.reserveParams_
	})
end

function var_0_0.StartBattle(arg_3_0)
	local var_3_0 = BattleStageFactory.Produce(arg_3_0.stageType_, arg_3_0.stageID_, {
		dest = arg_3_0.params_.dest,
		activityID = arg_3_0.params_.activityID
	})

	var_3_0:SetMultiple(arg_3_0.multiple_)
	BattleController.GetInstance():LaunchBattle(var_3_0)
end

function var_0_0.GotoReservesUI(arg_4_0)
	JumpTools.OpenPageByJump("/reservesUI", {
		isInit = true,
		stage_type = arg_4_0.stageType_,
		activityID = arg_4_0.params_.activityID,
		hero_list = arg_4_0.cacheHeroTeam_,
		hero_trial_list = arg_4_0.heroTrialList_,
		comboSkill = arg_4_0.comboSkillView_:GetCurComboSkill(),
		chipInfo = {
			enabledID = arg_4_0.chipView_:GetCurEnabledID(),
			chipList = arg_4_0.chipView_:GetCurChipList()
		},
		reserveParams = arg_4_0.reserveParams_
	})
end

function var_0_0.GetHeroPower(arg_5_0, arg_5_1)
	return arg_5_0.heroViewProxy_:GetBattlePower(arg_5_0.cacheHeroTeam_[arg_5_1])
end

return var_0_0
