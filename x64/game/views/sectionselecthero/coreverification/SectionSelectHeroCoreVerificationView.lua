local var_0_0 = class("SectionSelectHeroCoreVerificationView", SectionSelectHeroBaseView)

function var_0_0.GoHeroInfoUI(arg_1_0, arg_1_1)
	arg_1_0:Go("/heroTeamInfoCoreVerification", {
		isEnter = true,
		selectHeroPos = arg_1_1,
		stageID = arg_1_0.stageID_,
		stageType = arg_1_0.stageType_,
		reserveParams = arg_1_0.reserveParams_
	})
end

function var_0_0.StartBattle(arg_2_0)
	local var_2_0 = BattleStageFactory.Produce(arg_2_0.stageType_, arg_2_0.stageID_, nil, arg_2_0.reserveParams_)

	var_2_0:SetMultiple(arg_2_0.multiple_)
	BattleController.GetInstance():LaunchBattle(var_2_0)
end

return var_0_0
