local var_0_0 = class("SectionSelectHeroMatrixView", SectionSelectHeroBaseView)

function var_0_0.GetChipView(arg_1_0)
	return SectionSelectHeroMatrixChip
end

function var_0_0.GetComboSkillView(arg_2_0)
	return SectionComboSkillMatrixView
end

function var_0_0.ChangeHeroTeam(arg_3_0, arg_3_1)
	MatrixData:SetMatrixBattleHeroTeam(arg_3_1)
end

function var_0_0.GetHeroCfg(arg_4_0, arg_4_1)
	local var_4_0 = MatrixData:GetHeroSkin(arg_4_1)

	return SkinCfg[var_4_0]
end

function var_0_0.GetSkinCfg(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.heroTrialList_[arg_5_1] ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[arg_5_0.heroTrialList_[arg_5_1]].skin_id]
	else
		return arg_5_0:GetHeroCfg(arg_5_2)
	end
end

function var_0_0.StartBattle(arg_6_0)
	if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_REFRESH_DATA"),
			OkCallback = function()
				arg_6_0:Go("/matrixBlank/matrixPrepare")
			end
		})
	else
		local var_6_0 = MatrixData:GetMatrixPhaseData():GetPhase()
		local var_6_1 = arg_6_0.params_.eventId

		if var_6_0 == 2 then
			MatrixAction.DoEvent()
		else
			MatrixAction.QueryNextProgress({
				var_6_1
			})
		end
	end
end

function var_0_0.ClickHero(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_3.dragging then
		if arg_8_0.selectIndex_ then
			return
		end

		if #arg_8_0.loadingList_ > 0 then
			return
		end

		ShowTips("CAN_NOT_CHANGE_HERO")
	end
end

function var_0_0.GetTotalPower(arg_9_0)
	return 0
end

function var_0_0.RefreshPower(arg_10_0)
	return
end

function var_0_0.RefreshAddBtn(arg_11_0)
	for iter_11_0 = 1, 3 do
		SetActive(arg_11_0.addBtnGo_[iter_11_0], false)
		SetActive(arg_11_0.heroPowerPanel_[iter_11_0].gameObject, false)
	end
end

function var_0_0.RefreshChip(arg_12_0)
	if MatrixData:GetChipManagerID() == 0 then
		SetActive(arg_12_0.chipPanel_, false)

		return
	end

	arg_12_0.chipView_:SetData(arg_12_0.stageType_, arg_12_0.stageID_)
end

function var_0_0.RefreshRace(arg_13_0)
	local var_13_0, var_13_1 = arg_13_0:GetRaceEffect()

	SetActive(arg_13_0.effectTitlePanel_, var_13_0 ~= 0)

	if var_13_1 then
		local var_13_2 = RaceEffectCfg[var_13_0]

		arg_13_0.effectText_.text = GetI18NText(var_13_2.battle_desc)
		arg_13_0.titleCanvasGroup2_.alpha = 1
	else
		if MatrixData:GetRaceEffect() then
			arg_13_0.effectText_.text = GetTips("MATRIX_NO_BATTLE_BUFF")
		else
			arg_13_0.effectText_.text = GetTips("NO_BATTLE_BUFF")
		end

		arg_13_0.titleCanvasGroup2_.alpha = 0.8
	end

	SetActive(arg_13_0.activeGo2_, not var_13_1)
	SetActive(arg_13_0.activeGo1_, var_13_0 == 0)

	if var_13_0 == 0 then
		arg_13_0.titleCanvasGroup1_.alpha = 0.8
		arg_13_0.effectHeroText_.text = GetTips("NO_CORRECTOR_BUFF")

		return
	end

	arg_13_0.titleCanvasGroup1_.alpha = 1

	local var_13_3 = RaceEffectCfg[var_13_0]

	arg_13_0.effectName_.text = GetI18NText(var_13_3.name)
	arg_13_0.effectHeroText_.text = GetI18NText(var_13_3.desc)
	arg_13_0.effectImage_.sprite = getSprite("Atlas/CampItemAtlas", var_13_3.icon)
end

function var_0_0.GetRaceEffect(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = 0
	local var_14_2 = false
	local var_14_3 = arg_14_0.cacheHeroTeam_

	for iter_14_0, iter_14_1 in pairs(var_14_3) do
		if iter_14_1 ~= 0 then
			local var_14_4 = HeroCfg[iter_14_1].race

			var_14_0[var_14_4] = (var_14_0[var_14_4] or 0) + 1

			if var_14_0[var_14_4] == 2 then
				var_14_1 = var_14_4

				if MatrixData:GetRaceEffect() then
					var_14_2 = true
				end
			elseif var_14_0[var_14_4] == 3 then
				var_14_2 = true
			end
		end
	end

	return var_14_1, var_14_2, var_14_0[var_14_1] or 1
end

return var_0_0
