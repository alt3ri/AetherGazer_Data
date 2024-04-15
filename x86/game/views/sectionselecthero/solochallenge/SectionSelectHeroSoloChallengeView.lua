local var_0_0 = class("SectionSelectHeroSoloChallengeView", SectionSelectHeroBaseView)

function var_0_0.GoHeroInfoUI(arg_1_0, arg_1_1)
	ShowTips("CAN_NOT_CHANGE_HERO")
end

function var_0_0.RefreshChip(arg_2_0)
	local var_2_0 = false

	SetActive(arg_2_0.chipPanel_, var_2_0)

	if var_2_0 then
		arg_2_0.chipView_:SetData(arg_2_0.stageType_, arg_2_0.stageID_)
	end
end

function var_0_0.RefreshRace(arg_3_0)
	var_0_0.super.RefreshRace(arg_3_0)
	SetActive(arg_3_0.effectPanel_, false)
end

function var_0_0.GetSelectHero(arg_4_0)
	local var_4_0 = false
	local var_4_1

	arg_4_0.cacheHeroTeam_, arg_4_0.lockStateList_, arg_4_0.lockList_, arg_4_0.heroTrialList_, var_4_1 = ReserveTools.GetHeroList(arg_4_0.reserveParams_)
end

return var_0_0
