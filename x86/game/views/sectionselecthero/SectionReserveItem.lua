local var_0_0 = class("SectionReservesItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.curController_ = arg_3_0.controllerExCollection:GetController("cur")
	arg_3_0.selectController_ = arg_3_0.controllerExCollection:GetController("select")
	arg_3_0.inputHandler_ = handler(arg_3_0, arg_3_0.OnInput)
	arg_3_0.inputCancelHandler_ = handler(arg_3_0, arg_3_0.OnInputCancel)

	manager.notify:RegistListener(INPUT_POP_CLICK_OK, arg_3_0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, arg_3_0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, arg_3_0.inputCancelHandler_)

	arg_3_0.handler_ = handler(arg_3_0, arg_3_0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, arg_3_0.handler_)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		if arg_4_0.clickCallback_ then
			arg_4_0.clickCallback_(arg_4_0.info_.index)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.renameBtn_, nil, function()
		arg_4_0.inputPopFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.info_ = arg_7_1

	if arg_7_3 and arg_7_0.info_.hero_list[1] ~= 0 then
		arg_7_0.curController_:SetSelectedState("false")
	else
		arg_7_0.curController_:SetSelectedState(arg_7_2 and arg_7_4 and "true" or "false")
	end

	if arg_7_0.info_.name ~= "" then
		arg_7_0.customNameText_.text = GetI18NText(arg_7_0.info_.name)
	else
		arg_7_0.defaultNameText_.text = string.format(GetTips("%s"), arg_7_1.index)
	end
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(arg_8_1 == arg_8_0.info_.index and "true" or "false")
end

function var_0_0.OnInput(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.inputPopFlag_ and not arg_9_0.saveFlag_ then
		return
	end

	if not arg_9_0.gameObject_.activeInHierarchy then
		return
	end

	if arg_9_1 == "" then
		ShowTips("INPUT_EQUIP_PROPOSAL_NAME")

		return
	end

	if IsAllSpace(arg_9_1) then
		ShowTips("INPUT_CHAT_CONTENT")

		arg_9_2.text = ""

		return
	end

	local var_9_0, var_9_1 = textLimit(arg_9_1, GameSetting.user_name_max.value[1])

	arg_9_2.text = var_9_0
	arg_9_1 = var_9_0

	if not nameRule(arg_9_1) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		arg_9_2.text = ""

		return
	end

	WordVerifyBySDK(arg_9_1, function(arg_10_0)
		if not arg_10_0 then
			ShowTips("SENSITIVE_WORD")

			arg_9_2.text = ""

			return
		else
			if not var_9_1 then
				return
			end

			if arg_9_0.saveFlag_ then
				BattleFieldAction.SaveReservesTeam(arg_9_0.info_.index, arg_9_1, arg_9_0.info_.hero_list, arg_9_0.info_.comboSkill, arg_9_0.info_.chipInfo, "FORMATION_PLAN_SAVED")
			else
				BattleFieldAction.SaveReservesTeam(arg_9_0.info_.index, arg_9_1, arg_9_0.info_.hero_list, arg_9_0.info_.comboSkill, arg_9_0.info_.chipInfo, "FORMATION_PLAN_NAME_CHANGED")
			end

			arg_9_0.inputPopFlag_ = false
			arg_9_0.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function var_0_0.OnInputCancel(arg_11_0)
	arg_11_0.inputPopFlag_ = false
	arg_11_0.saveFlag_ = false
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	arg_12_0.inputPopFlag_ = false
	arg_12_0.saveFlag_ = false

	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, arg_12_0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, arg_12_0.inputCancelHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, arg_12_0.inputCancelHandler_)
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, arg_12_0.handler_)

	arg_12_0.inputHandler_ = nil
	arg_12_0.inputCancelHandler_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
