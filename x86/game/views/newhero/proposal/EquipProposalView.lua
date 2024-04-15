slot0 = class("EquipProposalView", ReduxView)
slot1 = {
	"存为新方案",
	"装备",
	"已装备"
}
slot2 = {
	"detail",
	"rough"
}

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/HeroEquipOptionUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectItem_ = nil
	slot0.heroEquipProposal_ = 0
	slot0.proposalState_ = 1
	slot0.panelState_ = 1

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.inputHandler_ = handler(slot0, slot0.OnInput)
	slot0.inputCancelHandler_ = handler(slot0, slot0.OnInputCancel)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.gridScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.proposalList_, ProposalItem)
	slot0.equipDisc_ = EquipDisc.New(slot0.discGo_)
	slot0.equipOverrall_ = EquipOverall.New(slot0.equipoverrallGo_)

	slot0.equipOverrall_:RegistSkillClick(handler(slot0, slot0.SkillClick))
	slot0.equipOverrall_:RegistOptionButton(handler(slot0, slot0.SaveOptionFunc), handler(slot0, slot0.EquipOptionFunc), handler(slot0, slot0.DeleteOptionFunc))

	slot0.equipSkillPop_ = EquipNewSkillInfoView.New(slot0.equipSkillGo_)
	slot0.skillPopController_ = slot0.transCon_:GetController("skill")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnPopMask_, nil, function ()
		uv0:HideMaskMessage()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.heroID_ = slot0.params_.heroID
	slot0.proposalList_ = ProposalData:GetProposalData()
	slot0.heroInfo_ = HeroData:GetHeroData(slot0.heroID_)

	slot0.equipOverrall_:OnEnter(slot0.params_.proxy)
	slot0.equipDisc_:OnEnter({
		isShowDetail = true
	})
	slot0:HideMaskMessage()
	manager.notify:RegistListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, slot0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:UpdateData()

	slot0.selectItem_ = 1

	slot0.gridScroll_:StartScroll(#slot0.sortedList_)
	slot0:RefreshRight(1)

	slot0.curproposalText_.text = GetTips("EQUIP_PROPOSAL") .. string.format("：%s/%s", #slot0.sortedList_ - (slot0.heroEquipProposal_ == 0 and 1 or 0), GameSetting.equip_proposal_num_max.value[1])
end

function slot0.UpdateData(slot0)
	slot0.sortedList_ = {}
	slot2 = nil

	for slot6, slot7 in pairs(slot0.proposalList_) do
		if table.equal(slot7.equip_list, HeroTools.GetHeroEquipS(slot0.heroID_), "all") then
			slot2 = slot7
			slot0.sortedList_[1] = slot7
		end
	end

	if slot2 then
		slot0.sortedList_[1] = slot2
	else
		slot0.sortedList_[1] = {
			proposal_id = 0,
			proposal_name = GetTips("CURRENT_SCHEME"),
			equip_list = slot1
		}
	end

	slot3 = 2

	for slot7, slot8 in pairs(slot0.proposalList_) do
		if slot2 then
			if slot8.proposal_id ~= slot2.proposal_id then
				slot0.sortedList_[slot3] = slot8
				slot3 = slot3 + 1
			end
		else
			slot0.sortedList_[slot3] = slot8
			slot3 = slot3 + 1
		end
	end

	slot0.heroEquipProposal_ = slot2 and slot2.proposal_id or 0
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:ShowSelect(slot0.selectItem_ == slot1)
	slot2:RefreshUI(slot0.sortedList_[slot1])
	slot2:RegistCallBack(function ()
		uv0:SelectItem(uv1)
	end, function ()
		uv0.renameFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
end

function slot0.RefreshRight(slot0, slot1)
	slot0:RefreshButtonState(slot0.sortedList_[slot1].proposal_id)
	slot0.equipOverrall_:RefreshHeroInfo(slot0.heroInfo_, slot0.sortedList_[slot1].equip_list, slot0.proposalState_)

	slot0.equipDataList_ = EquipTools.GetEquipDataList(slot0.sortedList_[slot1].equip_list)

	slot0.equipDisc_:RefreshItem(slot0.equipDataList_)
end

function slot0.SelectItem(slot0, slot1)
	slot2, slot3 = slot0.gridScroll_:GetHeadAndTail()

	if slot0.selectItem_ and slot2 <= slot0.selectItem_ and slot0.selectItem_ <= slot3 then
		slot0.gridScroll_:GetItemByIndex(slot0.selectItem_):ShowSelect(false)
	end

	slot0.selectItem_ = slot1

	slot0.gridScroll_:GetItemByIndex(slot0.selectItem_):ShowSelect(true)
	slot0:RefreshRight(slot1)
end

function slot0.OnEquipQuickDressOn(slot0, slot1, slot2)
	for slot6 = 1, 6 do
		HeroAction.HeroChangeEquip(slot2.hero_id, slot2.use_equip_list[slot6].equip_id, slot2.use_equip_list[slot6].pos)
	end

	slot0:RefreshUI()
	ShowTips("SUCCESS_EQUIP_PROPOSAL")
end

function slot0.OnAddProposal(slot0)
	slot0:RefreshUI()
	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function slot0.OnModifyProposal(slot0)
	slot1, slot2 = slot0.gridScroll_:GetHeadAndTail()

	if slot0.selectItem_ and slot1 <= slot0.selectItem_ and slot0.selectItem_ <= slot2 then
		slot0.gridScroll_:GetItemByIndex(slot0.selectItem_):RefreshUI(slot0.sortedList_[slot0.selectItem_])
	end

	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function slot0.OnDeleteProposal(slot0)
	slot0:RefreshUI()
end

function slot0.EquipOptionFunc(slot0)
	if slot0.proposalState_ == "notEquip" then
		for slot8, slot9 in ipairs(slot0.sortedList_[slot0.selectItem_].equip_list) do
			if HeroData:GetEquipMap()[slot9.equip_id] and slot10 ~= slot0.heroID_ then
				slot4 = 0 + 1
				({
					[slot8] = {
						equip_id = slot9.equip_id,
						pos = slot9.pos
					}
				})[slot8].equiping = slot10
			end
		end

		if slot4 ~= 0 then
			slot0:Go("ProposalCheck", {
				equipS = slot2
			})
		else
			for slot9 = 1, #slot2 do
			end

			EquipAction.EquipQuickDressOn(slot0.heroID_, {
				[slot9] = {
					pos = slot2[slot9].pos,
					equip_id = slot2[slot9].equip_id
				}
			})
		end
	end
end

function slot0.SaveOptionFunc(slot0)
	if slot0.proposalState_ == "notSave" then
		if GameSetting.equip_proposal_num_max.value[1] < #slot0.sortedList_ then
			ShowTips("ERROR_EQUIP_PROPOSAL_NUM_LIMIT")

			return
		end

		slot0.saveFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end
end

function slot0.DeleteOptionFunc(slot0)
	ProposalAction.DeleteProposal(slot0.sortedList_[slot0.selectItem_].proposal_id)
end

function slot0.SkillClick(slot0, slot1, slot2)
	slot0.equipSkillPop_:RefreshData(slot0, slot2)
	slot0.skillPopController_:SetSelectedState("show")
end

function slot0.HideMaskMessage(slot0)
	slot0.skillPopController_:SetSelectedState("hide")
	slot0.equipOverrall_:DeSelect()
end

function slot0.RefreshButtonState(slot0, slot1)
	slot2 = nil
	slot0.proposalState_ = slot1 == 0 and "notSave" or slot1 ~= slot0.heroEquipProposal_ and "notEquip" or "equipping"
end

function slot0.OnInput(slot0, slot1, slot2)
	if not slot0.renameFlag_ and not slot0.saveFlag_ then
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

			if uv2.renameFlag_ then
				ProposalAction.ModifyProposal(uv2.heroID_, uv3, uv2.sortedList_[uv2.selectItem_].proposal_id)
			else
				ProposalAction.AddProposal(uv2.heroID_, uv3, 0)
			end

			uv2.renameFlag_ = false
			uv2.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function slot0.OnInputCancel(slot0)
	slot0.renameFlag_ = false
	slot0.saveFlag_ = false
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.equipOverrall_:OnExit()
	slot0.equipDisc_:OnExit()
	slot0:OnInputCancel()
	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, slot0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, slot0.inputCancelHandler_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.equipSkillPop_:Dispose()
	slot0.equipOverrall_:Dispose()
	slot0.equipDisc_:Dispose()
	slot0.gridScroll_:Dispose()

	slot0.inputHandler_ = nil
	slot0.inputCancelHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
