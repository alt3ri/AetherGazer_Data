local var_0_0 = class("AbyssSelectHeroView", SectionSelectHeroBaseView)

function var_0_0.GoHeroInfoUI(arg_1_0, arg_1_1)
	arg_1_0:Go("/abyssTeamInfo", {
		isEnter = true,
		selectHeroPos = arg_1_1,
		stageID = arg_1_0.stageID_,
		stageType = arg_1_0.stageType_,
		layer = arg_1_0.params_.layer,
		reserveParams = arg_1_0.reserveParams_
	})
end

function var_0_0.StartBattle(arg_2_0)
	if arg_2_0.params_.curActivityID ~= AbyssData:GetActivityId() then
		ShowTips("ERROR_ACTIVITY_NOT_OPEN")

		return
	end

	local var_2_0 = AbyssData:GetAbyssCfg(arg_2_0.params_.layer)

	if var_2_0.stage_list[arg_2_0.params_.stageIndex][1] == 3 then
		local var_2_1 = AbyssData:GetStageData(var_2_0.level, arg_2_0.params_.stageIndex).phase or 1

		AbyssData:SetCurrentBossPhase(var_2_1)
	end

	local var_2_2 = {
		activityID = arg_2_0.params_.activityID,
		curActivityID = arg_2_0.params_.curActivityID
	}
	local var_2_3 = BattleStageFactory.Produce(arg_2_0.stageType_, arg_2_0.stageID_, var_2_2, arg_2_0.reserveParams_)

	var_2_3:SetMultiple(arg_2_0.multiple_)
	var_2_3:SetStageData(var_2_0.level, arg_2_0.params_.stageIndex)
	BattleController.GetInstance():LaunchBattle(var_2_3)
end

function var_0_0.GotoReservesUI(arg_3_0)
	JumpTools.OpenPageByJump("/reservesUI", {
		isInit = true,
		stage_type = arg_3_0.stageType_,
		stage_id = arg_3_0.stageID_,
		activityID = arg_3_0.params_.activityID,
		hero_list = arg_3_0.cacheHeroTeam_,
		hero_trial_list = arg_3_0.heroTrialList_,
		lockList = arg_3_0:GetLockList(),
		comboSkill = arg_3_0.comboSkillView_:GetCurComboSkill(),
		chipInfo = {
			enabledID = arg_3_0.chipView_:GetCurEnabledID(),
			chipList = arg_3_0.chipView_:GetCurChipList()
		},
		reserveParams = arg_3_0.reserveParams_
	})
end

function var_0_0.GetLockList(arg_4_0)
	local var_4_0 = {}

	table.insertto(var_4_0, AbyssTools.GetLayerLockHeroList(arg_4_0.params_.layer))
	table.insertto(var_4_0, AbyssTools.GetGlobalBanHeroList())

	return var_4_0
end

return var_0_0
