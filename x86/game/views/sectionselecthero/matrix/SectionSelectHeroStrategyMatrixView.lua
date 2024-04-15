local var_0_0 = class("SectionSelectHeroStrategyMatrixView", SectionSelectHeroBaseView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)

	arg_1_0.matrix_activity_id = arg_1_0.params_.matrix_activity_id
end

function var_0_0.GetChipView(arg_2_0)
	return SectionSelectHeroMatrixChip
end

function var_0_0.GetComboSkillView(arg_3_0)
	return SectionComboSkillMatrixView
end

function var_0_0.ChangeHeroTeam(arg_4_0, arg_4_1)
	StrategyMatrixData:SetMatrixBattleHeroTeam(arg_4_0.matrix_activity_id, arg_4_1)
end

function var_0_0.GetHeroCfg(arg_5_0, arg_5_1)
	local var_5_0 = StrategyMatrixData:GetHeroSkin(arg_5_0.matrix_activity_id, arg_5_1)

	return SkinCfg[var_5_0]
end

function var_0_0.GetSkinCfg(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.heroTrialList_[arg_6_1] ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[arg_6_0.heroTrialList_[arg_6_1]].skin_id]
	else
		return arg_6_0:GetHeroCfg(arg_6_2)
	end
end

function var_0_0.StartBattle(arg_7_0)
	if StrategyMatrixData:GetGameState(arg_7_0.matrix_activity_id) == MatrixConst.STATE_TYPE.NOTSTARTED then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_REFRESH_DATA"),
			OkCallback = function()
				StrategyMatrixAction.GotoStrategyMatrixPrepare(arg_7_0.matrix_activity_id)
			end
		})
	else
		local var_7_0 = StrategyMatrixData:GetMatrixPhaseData(arg_7_0.matrix_activity_id):GetPhase()
		local var_7_1 = arg_7_0.params_.nodeId

		if var_7_0 == 2 then
			StrategyMatrixAction.DoEvent(arg_7_0.matrix_activity_id)
		else
			StrategyMatrixAction.QueryNextProgress(arg_7_0.matrix_activity_id, {
				var_7_1
			})
		end
	end
end

function var_0_0.ClickHero(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_3.dragging then
		if arg_9_0.selectIndex_ then
			return
		end

		if #arg_9_0.loadingList_ > 0 then
			return
		end

		ShowTips("CAN_NOT_CHANGE_HERO")
	end
end

function var_0_0.GetTotalPower(arg_10_0)
	return 0
end

function var_0_0.RefreshPower(arg_11_0)
	return
end

function var_0_0.RefreshAddBtn(arg_12_0)
	for iter_12_0 = 1, 3 do
		SetActive(arg_12_0.addBtnGo_[iter_12_0], false)
		SetActive(arg_12_0.heroPowerPanel_[iter_12_0].gameObject, false)
	end
end

function var_0_0.RefreshChip(arg_13_0)
	SetActive(arg_13_0.chipPanel_, false)
end

function var_0_0.RefreshRace(arg_14_0)
	local var_14_0, var_14_1 = arg_14_0:GetRaceEffect()

	SetActive(arg_14_0.effectTitlePanel_, var_14_0 ~= 0)

	if var_14_1 then
		local var_14_2 = RaceEffectCfg[var_14_0]

		arg_14_0.effectText_.text = GetI18NText(var_14_2.battle_desc)
		arg_14_0.titleCanvasGroup2_.alpha = 1
	else
		if StrategyMatrixData:GetRaceEffect(arg_14_0.matrix_activity_id) then
			arg_14_0.effectText_.text = GetTips("MATRIX_NO_BATTLE_BUFF")
		else
			arg_14_0.effectText_.text = GetTips("NO_BATTLE_BUFF")
		end

		arg_14_0.titleCanvasGroup2_.alpha = 0.8
	end

	SetActive(arg_14_0.activeGo2_, not var_14_1)
	SetActive(arg_14_0.activeGo1_, var_14_0 == 0)

	if var_14_0 == 0 then
		arg_14_0.titleCanvasGroup1_.alpha = 0.8
		arg_14_0.effectHeroText_.text = GetTips("NO_CORRECTOR_BUFF")

		return
	end

	arg_14_0.titleCanvasGroup1_.alpha = 1

	local var_14_3 = RaceEffectCfg[var_14_0]

	arg_14_0.effectName_.text = GetI18NText(var_14_3.name)
	arg_14_0.effectHeroText_.text = GetI18NText(var_14_3.desc)
	arg_14_0.effectImage_.sprite = getSprite("Atlas/CampItemAtlas", var_14_3.icon)
end

function var_0_0.GetRaceEffect(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = 0
	local var_15_2 = false
	local var_15_3 = arg_15_0.cacheHeroTeam_

	for iter_15_0, iter_15_1 in pairs(var_15_3) do
		if iter_15_1 ~= 0 then
			local var_15_4 = HeroCfg[iter_15_1].race

			var_15_0[var_15_4] = (var_15_0[var_15_4] or 0) + 1

			if var_15_0[var_15_4] == 2 then
				var_15_1 = var_15_4

				if StrategyMatrixData:GetRaceEffect(arg_15_0.matrix_activity_id) then
					var_15_2 = true
				end
			elseif var_15_0[var_15_4] == 3 then
				var_15_2 = true
			end
		end
	end

	return var_15_1, var_15_2, var_15_0[var_15_1] or 1
end

function var_0_0.GetSelectHero(arg_16_0)
	local var_16_0 = false

	if arg_16_0.roomProxy_ then
		local var_16_1 = arg_16_0.roomProxy_:GetHeroTeam()

		arg_16_0.cacheHeroTeam_ = var_16_1.HeroList
		arg_16_0.lockStateList_ = var_16_1.LockStateList
		arg_16_0.lockList_ = var_16_1.LockHeroList
		arg_16_0.heroTrialList_ = var_16_1.TrialHeroList

		if var_16_1.IsInvalid then
			arg_16_0:ChangeHeroTeam(arg_16_0.cacheHeroTeam_)
		end
	else
		local var_16_2

		arg_16_0.cacheHeroTeam_, arg_16_0.lockStateList_, arg_16_0.lockList_, arg_16_0.heroTrialList_, var_16_2 = GetLocalHeroTeam(arg_16_0.stageType_, arg_16_0.stageID_, arg_16_0.params_.activityID)
	end
end

return var_0_0
