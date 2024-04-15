slot0 = class("SectionReservesItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.curController_ = slot0.controllerExCollection:GetController("cur")
	slot0.selectController_ = slot0.controllerExCollection:GetController("select")
	slot0.inputHandler_ = handler(slot0, slot0.OnInput)
	slot0.inputCancelHandler_ = handler(slot0, slot0.OnInputCancel)

	manager.notify:RegistListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, slot0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)

	slot0.handler_ = handler(slot0, slot0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, slot0.handler_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		if uv0.clickCallback_ then
			uv0.clickCallback_(uv0.info_.index)
		end
	end)
	slot0:AddBtnListener(slot0.renameBtn_, nil, function ()
		uv0.inputPopFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3, slot4)
	slot0.info_ = slot1

	if slot3 and slot0.info_.hero_list[1] ~= 0 then
		slot0.curController_:SetSelectedState("false")
	else
		slot0.curController_:SetSelectedState(slot2 and slot4 and "true" or "false")
	end

	if slot0.info_.name ~= "" then
		slot0.customNameText_.text = GetI18NText(slot0.info_.name)
	else
		slot0.defaultNameText_.text = string.format(GetTips("%s"), slot1.index)
	end
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 == slot0.info_.index and "true" or "false")
end

function slot0.OnInput(slot0, slot1, slot2)
	if not slot0.inputPopFlag_ and not slot0.saveFlag_ then
		return
	end

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	if slot1 == "" then
		ShowTips("INPUT_EQUIP_PROPOSAL_NAME")

		return
	end

	if IsAllSpace(slot1) then
		ShowTips("INPUT_CHAT_CONTENT")

		slot2.text = ""

		return
	end

	slot3, slot4 = textLimit(slot1, GameSetting.user_name_max.value[1])
	slot2.text = slot3

	if not nameRule(slot3) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		slot2.text = ""

		return
	end

	WordVerifyBySDK(slot1, function (slot0)
		if not slot0 then
			ShowTips("SENSITIVE_WORD")

			uv0.text = ""

			return
		else
			if not uv1 then
				return
			end

			if uv2.saveFlag_ then
				BattleFieldAction.SaveReservesTeam(uv2.info_.index, uv3, uv2.info_.hero_list, uv2.info_.comboSkill, uv2.info_.chipInfo, "FORMATION_PLAN_SAVED")
			else
				BattleFieldAction.SaveReservesTeam(uv2.info_.index, uv3, uv2.info_.hero_list, uv2.info_.comboSkill, uv2.info_.chipInfo, "FORMATION_PLAN_NAME_CHANGED")
			end

			uv2.inputPopFlag_ = false
			uv2.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function slot0.OnInputCancel(slot0)
	slot0.inputPopFlag_ = false
	slot0.saveFlag_ = false
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.inputPopFlag_ = false
	slot0.saveFlag_ = false

	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, slot0.inputCancelHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, slot0.handler_)

	slot0.inputHandler_ = nil
	slot0.inputCancelHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
