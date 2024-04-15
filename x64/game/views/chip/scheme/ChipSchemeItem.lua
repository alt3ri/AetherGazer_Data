slot0 = class("ChipSchemeItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.renameHandler_ = handler(slot0, slot0.OnRenameChipScheme)

	manager.notify:RegistListener(RENAME_CHIP_SCHEME, slot0.renameHandler_)

	slot0.inputHandler_ = handler(slot0, slot0.OnInput)
	slot0.inputCancelHandler_ = handler(slot0, slot0.OnInputCancel)

	manager.notify:RegistListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, slot0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)

	slot0.controller_ = slot0.stateControl:GetController("bState")
end

function slot0.SetTemplateData(slot0, slot1)
	slot0.dataTemplate = slot1
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.renameBtn_, nil, function ()
		uv0.inputPopFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
	slot0:AddBtnListener(slot0.deleteBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("DELETE_CHIP_SCHEME"), uv0.schemeData_.name),
			OkCallback = function ()
				ChipAction.DeleteChipScheme(uv0.schemeData_.id)
				OperationRecorder.Record("ChipSchemeItem", "okDelete")
			end,
			CancelCallback = function ()
				OperationRecorder.Record("ChipSchemeItem", "cancelDelete")
			end
		})
	end)
	slot0:AddBtnListener(slot0.saveBtn_, nil, function ()
		if #uv0.schemeData_.chipList < 1 then
			ShowTips("SCHEME_IS_NULL")

			return false
		end

		if GameSetting.ai_chip_proposal_num_max.value[1] <= table.length(ChipData:GetSchemeList()) then
			ShowTips("MORE_THEN_MAX_SCHEME_CNT")

			return
		end

		for slot5 = 1, slot0 do
			if slot1[slot5] == nil then
				uv0.saveFlag_ = true

				JumpTools.OpenPageByJump("ProposalPopup")

				break
			end
		end
	end)
	slot0:AddBtnListener(slot0.enabledBtn_, nil, function ()
		uv0:OnEnabledBtn()
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3, slot4)
	slot0.chipManagerID_ = slot1
	slot0.schemeData_ = slot3
	slot4 = slot4 or 0
	slot0.index_ = slot2

	if slot3.id == -1 then
		slot0.controller_:SetSelectedState("state0")

		return
	end

	slot9 = slot3.name
	slot0.nameText_.text = GetI18NText(slot9)

	for slot9 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		if slot3.chipList[slot9] then
			slot0[string.format("icon%sImg_", slot9)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot10].picture_id)

			SetActive(slot0[string.format("icon%sGo_", slot9)].gameObject, true)
		else
			SetActive(slot0[string.format("icon%sGo_", slot9)].gameObject, false)
		end

		SetActive(slot0[string.format("icon%sGo_", slot9)], slot10 and true or false)
	end

	if slot2 == 1 then
		if slot5 == 0 then
			slot0.controller_:SetSelectedState("state0")
		else
			slot0.controller_:SetSelectedState("state2")
		end
	else
		slot0.controller_:SetSelectedState("state1")
	end
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
				for slot6 = 1, GameSetting.ai_chip_proposal_num_max.value[1] do
					if ChipData:GetSchemeList()[slot6] == nil then
						uv2.schemeData_.id = slot6
						uv2.schemeData_.name = uv3

						ChipAction.SaveChipScheme(uv2.schemeData_)

						break
					end
				end
			else
				ChipAction.RenameChipScheme(uv2.schemeData_.id, uv3)

				uv2.schemeData_.name = uv3
			end

			uv2.inputPopFlag_ = false
			uv2.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function slot0.OnEnabledBtn(slot0)
	slot0.dataTemplate.useChipIdList = slot0.schemeData_.chipList

	manager.notify:Invoke(ENABLED_SCHEME)
end

function slot0.OnRenameChipScheme(slot0, slot1)
	if slot0.schemeData_.id == slot1 then
		slot0.nameText_.text = ChipData:GetSchemeList()[slot1].name
	end
end

function slot0.OnInputCancel(slot0)
	slot0.inputPopFlag_ = false
	slot0.saveFlag_ = false
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.inputPopFlag_ = false
	slot0.saveFlag_ = false

	manager.notify:RemoveListener(RENAME_CHIP_SCHEME, slot0.renameHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, slot0.inputCancelHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)

	slot0.renameHandler_ = nil
	slot0.inputHandler_ = nil
	slot0.inputCancelHandler_ = nil
end

return slot0
