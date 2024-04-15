slot0 = class("ReserveProposalView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Formation/FormationReserveView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectHeroView_ = nil
	slot0.btnStateController_ = slot0.controllerExCollection_:GetController("btnState")
	slot0.schemeSwitchList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.switchListGo_, ReserveProposalSwitchItem)
	slot0.clickSchemeHandler_ = handler(slot0, slot0.OnClickScheme)
	slot0.renameSchemeHandler_ = handler(slot0, slot0.OnRenameScheme)
	slot0.inputHandler_ = handler(slot0, slot0.OnInput)
	slot0.deleteProposalHandler_ = handler(slot0, slot0.OnDeleteProposal)
	slot0.changeHeroTeamHandler_ = handler(slot0, slot0.OnChangeHeroTeam)
	slot0.changeComboSkillHander_ = handler(slot0, slot0.OnChangeComboSkill)
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.saveBtn_, nil, function ()
		if uv0.curSelectContID_ == uv0.tempContID_ and GameSetting.default_formation_num_max.value[1] == #uv0.curProposalContIDList_ then
			ShowTips("RESERVE_PROPOSAL_SAVE_LIMIT")

			return
		end

		if uv0.sectionProxy_:GetHeroIDList()[1] == 0 then
			ShowTips("TEAM_SET_NEEDED")

			return
		end

		for slot8, slot9 in ipairs(uv0.curProposalContIDList_) do
			if slot9 ~= uv0.curSelectContID_ and uv0:IsReserveProposalEqual(slot9, uv0.sectionProxy_:GetHeroIDList(), uv0.sectionProxy_:GetComboSkillID(), uv0.sectionProxy_:GetMimirID(), uv0.sectionProxy_:GetMimirChipList()) then
				ShowTips("RESERVE_PROPOSAL_SAME")

				return
			end
		end

		uv0.saveContID_ = uv0.curSelectContID_

		if ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(uv0.curSelectContID_):GetName() == "" then
			JumpTools.OpenPageByJump("ProposalPopup")
		else
			uv0:SaveProposal()
		end
	end)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		for slot4, slot5 in ipairs(uv0.sectionProxy_:GetHeroIDList()) do
			if slot5 ~= 0 and table.indexof(uv0.curLockHeroList_, slot5) then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end
		end

		uv0:ApplyProposal()
		ShowTips("RESERVE_PROPOSAL_SELECT_SUCCESS")
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.deleteBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FORMATION_PLAN_DELETE_CONFIRM"), ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(uv0.curSelectContID_):GetName()),
			OkCallback = function ()
				uv0.sectionProxy_:ResetTeam()
			end
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(INPUT_POP_CLICK_OK, slot0.inputHandler_)
	slot0:RegistEventListener(RESERVE_RESET_CONT_DATA, slot0.deleteProposalHandler_)
	slot0:RegistEventListener(SECTION_CHANGE_HERO_TEAM, slot0.changeHeroTeamHandler_)
	slot0:RegistEventListener(COMBO_SKILL_SELECT, slot0.changeComboSkillHander_)
	slot0:UpdateDefaultParams()
	slot0:TryReload()
	slot0:UpdateSubViewParams()
	slot0:UpdateBar()
	slot0:UpdateCamera()
	slot0:ResetTempData()
	slot0:SubViewOnEnter()
	slot0:RefreshUI()
end

function slot0.UpdateSubViewParams(slot0)
	slot0.selectHeroView_:SetProxy(slot0.sectionProxy_)
end

function slot0.SubViewOnEnter(slot0)
	slot0.selectHeroView_:OnEnter()
end

function slot0.OnExit(slot0)
	slot0.params_.lastTempContID = slot0.tempContID_

	slot0:RemoveAllEventListener()
	slot0:SubViewOnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function slot0.SubViewOnExit(slot0)
	slot0.selectHeroView_:OnExit()
end

function slot0.Dispose(slot0)
	slot0.schemeSwitchList_:Dispose()

	slot0.schemeSwitchList_ = nil

	slot0.selectHeroView_:Dispose()

	slot0.selectHeroView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.UpdateCamera(slot0)
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()
end

function slot0.UpdateBar(slot0)
	slot0.sectionProxy_:UpdateBar()
end

function slot0.UpdateDefaultParams(slot0)
	slot0.stageID_ = slot0.params_.stage_id
	slot0.stageType_ = slot0.params_.stage_type or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	slot0.targetSectionProxy_ = slot0.params_.sectionProxy

	if not slot0.reserveParams_ then
		slot0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, 1)
	end

	if not slot0.sectionProxy_ then
		slot0.sectionProxy_ = ReserveProposalSelectHeroProxy.New({}, slot0.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)
	end

	slot0.curHeroList_ = slot0.params_.heroList
	slot0.curTrialList_ = slot0.params_.trialList
	slot0.curComboSkillID_ = slot0.params_.comboSkillID
	slot0.curMimirID_ = slot0.params_.mimirID
	slot0.curChipList_ = slot0.params_.chipList
	slot0.curLockHeroList_ = slot0.params_.lockHeroList

	slot0:CheckHeroList()

	if not slot0.params_.isBack then
		ReserveTools.CleanCacheData(ReserveConst.RESERVE_TYPE.PROPOSAL)
	end

	slot0:GetContIDList()
	slot0:UpdateTempContData()
end

function slot0.ResetTempData(slot0)
	slot0.selectHeroView_:ResetTempData()
end

function slot0.UpdateTempContData(slot0)
	if slot0.tempContID_ then
		if not slot0.params_.isBack then
			slot0.tempHeroList_ = clone(slot0.curHeroList_)
			slot0.tempTrialList_ = {
				0,
				0,
				0
			}
			slot0.tempComboSkillID_ = slot0.curComboSkillID_
			slot0.tempMimirID_ = slot0.curMimirID_
			slot0.tempChipList_ = clone(slot0.curChipList_)

			ReserveTools.SetTeam(ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, slot0.tempContID_), slot0.tempHeroList_, slot0.tempTrialList_, slot0.tempComboSkillID_, slot0.tempMimirID_, slot0.tempChipList_)
		elseif slot0.params_.lastTempContID ~= slot0.tempContID_ then
			slot2 = ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, slot0.params_.lastTempContID)
			slot0.tempHeroList_ = ReserveTools.GetHeroList(slot2)
			slot0.tempTrialList_ = {
				0,
				0,
				0
			}
			slot0.tempComboSkillID_ = ReserveTools.GetComboSkillID(slot2)
			slot0.tempMimirID_, slot0.tempChipList_ = ReserveTools.GetMimirData(slot2)

			ReserveTools.SetTeam(slot1, slot0.tempHeroList_, slot0.tempTrialList_, slot0.tempComboSkillID_, slot0.tempMimirID_, slot0.tempChipList_)
		else
			slot0.tempHeroList_ = ReserveTools.GetHeroList(slot1)
			slot0.tempComboSkillID_ = ReserveTools.GetComboSkillID(slot1)
			slot0.tempMimirID_, slot0.tempChipList_ = ReserveTools.GetMimirData(slot1)
		end
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReserveUI()
	slot0:RefreshSwitchList()
	slot0:RefreshBtnPanel()
end

function slot0.RefreshBtnPanel(slot0)
	if ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(slot0.curSelectContID_):GetIsDirty() == true then
		slot0.btnStateController_:SetSelectedState("save")
	elseif slot0:IsReserveProposalEqual(slot0.curSelectContID_, slot0.curHeroList_, slot0.curComboSkillID_, slot0.curMimirID_, slot0.curChipList_) then
		slot0.btnStateController_:SetSelectedState("cur")
	else
		slot0.btnStateController_:SetSelectedState("normal")
	end
end

function slot0.RefreshSwitchList(slot0)
	slot0.schemeSwitchList_:StartScroll(#slot0.contIDList_, table.indexof(slot0.contIDList_, slot0.curSelectContID_) or 1)

	slot0.progressText_.text = string.format(GetTips("RESERVE_PROPOSAL_NUM"), slot0.curSchemeNum_, GameSetting.default_formation_num_max.value[1])
end

function slot0.RefreshReserveUI(slot0)
	if slot0.params_.isEnter then
		slot0.params_.isEnter = false
		slot0.curSelectContID_ = slot0.contIDList_[1]
		slot0.params_.lastSelectContID = slot0.contIDList_[1]
	else
		slot0.curSelectContID_ = slot0.params_.lastSelectContID or slot0.contIDList_[1]
	end

	slot0.params_.lastSelectContID = slot0.curSelectContID_

	slot0.selectHeroView_:SetContID(slot0.curSelectContID_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot3, slot0.contIDList_[slot1] == slot0.tempContID_)
	slot2:RegisterClickCallback(slot0.clickSchemeHandler_)
	slot2:RegistRenameCallback(slot0.renameSchemeHandler_)
	slot2:SetSelect(slot0.curSelectContID_)
end

function slot0.OnClickScheme(slot0, slot1)
	if slot1 == slot0.curSelectContID_ then
		return
	end

	slot0.curSelectContID_ = slot1
	slot0.params_.lastSelectContID = slot0.curSelectContID_
	slot4 = slot0.schemeSwitchList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetSelect(slot0.curSelectContID_)
	end

	slot0:RefreshReserveUI()
	slot0:RefreshBtnPanel()
end

function slot0.GetContIDList(slot0)
	slot3 = {}
	slot0.params_.lastTempContID = slot0.tempContID_ or slot0.params_.lastTempContID
	slot0.tempContID_ = nil
	slot0.curUseProposalContID_ = nil

	for slot7, slot8 in ipairs(ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetProposalContIDList()) do
		if slot0:IsReserveProposalEqual(slot8, slot0.curHeroList_, slot0.curComboSkillID_, slot0.curMimirID_, slot0.curChipList_) then
			slot0.curUseProposalContID_ = slot8

			break
		end
	end

	if slot0.curUseProposalContID_ then
		slot3[1] = slot0.curUseProposalContID_
	else
		slot0.tempContID_ = slot1:GetTempContID()
		slot3[1] = slot0.tempContID_
	end

	for slot7, slot8 in ipairs(slot2) do
		if slot8 ~= slot3[1] then
			slot3[#slot3 + 1] = slot8
		end
	end

	slot0.contIDList_ = slot3
	slot0.curProposalContIDList_ = slot2
	slot0.curSchemeNum_ = #slot2
end

function slot0.SaveProposal(slot0)
	ReserveAction.SaveReserveProposal(slot0.saveContID_, handler(slot0, slot0.OnSaveProposal))
end

function slot0.SaveName(slot0, slot1)
	ReserveAction.RenameReserveProposal(slot0.saveContID_, slot1, handler(slot0, slot0.OnSaveProposal))
end

function slot0.OnSaveProposal(slot0)
	slot0:TryAutoApplyProposal(slot0.saveContID_)

	if slot0.saveContID_ == slot0.tempContID_ then
		slot0.tempContID_ = nil
	end

	slot0.saveContID_ = nil

	ShowTips("FORMATION_PLAN_SAVED")
	manager.notify:Invoke(INPUT_POP_BACK)
	slot0:GetContIDList()
	slot0:UpdateTempContData()
	slot0:RefreshSwitchList()
	slot0:RefreshBtnPanel()
end

function slot0.ApplyProposal(slot0)
	slot0.curUseProposalContID_ = slot0.curSelectContID_
	slot0.curHeroList_ = slot0.sectionProxy_:GetHeroIDList()
	slot0.curTrialList_ = {
		0,
		0,
		0
	}
	slot0.curComboSkillID_ = slot0.sectionProxy_:GetComboSkillID()
	slot0.curMimirID_ = slot0.sectionProxy_:GetMimirID()
	slot0.curChipList_ = slot0.sectionProxy_:GetMimirChipList()

	slot0.targetSectionProxy_:ApplyReserveProposal(slot0.curHeroList_, slot0.curTrialList_, slot0.curComboSkillID_, slot0.curMimirID_, slot0.curChipList_)
end

function slot0.TryAutoApplyProposal(slot0, slot1)
	if slot0.saveContID_ == slot0.curUseProposalContID_ or slot0.saveContID_ == slot0.tempContID_ then
		slot0:ApplyProposal()
	end
end

function slot0.OnSectionClickHero(slot0, slot1)
	slot0.sectionProxy_:GotoHeroInfoUI(slot1)
end

function slot0.OnChangeHeroTeam(slot0, slot1, slot2)
	if slot0.curSelectContID_ == slot0.tempContID_ then
		slot0.tempHeroList_ = clone(slot1)
		slot0.tempTrialList_ = clone(slot2)
	end

	slot0:RefreshSwitchList()
	slot0:RefreshBtnPanel()
end

function slot0.OnChangeComboSkill(slot0, slot1)
	if slot0.curSelectContID_ == slot0.tempContID_ then
		slot0.tempComboSkillID_ = slot1
	end

	slot0:RefreshBtnPanel()
end

function slot0.OnRenameScheme(slot0, slot1)
	slot0.saveContID_ = slot1

	JumpTools.OpenPageByJump("ProposalPopup")
end

function slot0.OnInput(slot0, slot1, slot2)
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

			uv2:SaveName(uv3)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function slot0.OnDeleteProposal(slot0, slot1, slot2)
	ShowTips("FORMATION_PLAN_DELETED")
	ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):DeleteProposal(slot2)

	slot0.params_.lastSelectContID = nil

	slot0:GetContIDList()
	slot0:UpdateTempContData()
	slot0:RefreshUI()
end

function slot0.IsReserveProposalEqual(slot0, slot1, slot2, slot3, slot4, slot5)
	for slot12, slot13 in ipairs(slot2) do
		if slot13 ~= ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL, true):GetHeroList(ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, slot1))[slot12] then
			return false
		end
	end

	if slot3 ~= slot7:GetComboSkillID(slot6) then
		return false
	end

	slot10, slot11 = slot7:GetMimirData(slot6)

	if slot4 ~= slot10 then
		return false
	end

	if #slot5 ~= #slot11 then
		return false
	end

	slot12 = {
		[slot17] = true
	}

	for slot16, slot17 in ipairs(slot11) do
		-- Nothing
	end

	for slot16, slot17 in ipairs(slot5) do
		if not slot12[slot17] then
			return false
		end
	end

	return true
end

function slot0.CheckHeroList(slot0)
	slot1 = false

	for slot5, slot6 in ipairs(slot0.curTrialList_) do
		if slot6 ~= 0 then
			slot1 = true
			slot0.curHeroList_[slot5] = 0
			slot0.curTrialList_[slot5] = 0
		end
	end

	if slot1 then
		for slot5 = 1, 2 do
			for slot9 = slot5 + 1, 3 do
				if slot0.curHeroList_[slot5] == 0 then
					slot0.curHeroList_[slot5] = slot0.curHeroList_[slot9]
					slot0.curHeroList_[slot9] = 0
					slot0.curTrialList_[slot5] = slot0.curTrialList_[slot9]
					slot0.curTrialList_[slot9] = 0

					break
				end
			end
		end

		if slot0.curComboSkillID_ == 0 or not ComboSkillTools.IsAllMatch(slot2, slot0.curHeroList_) then
			slot0.curComboSkillID_ = ComboSkillTools.GetRecommendSkillID(slot0.curHeroList_, true)
		end
	end
end

function slot0.GetSelectHeroViewClass(slot0)
	return slot0.sectionProxy_:GetSelectHeroViewClass()
end

function slot0.TryReload(slot0)
	if not slot0.createdSubview_ then
		slot0.createdSubview_ = true
		slot0.selectHeroView_ = slot0:GetSelectHeroViewClass().New(slot0.selectHeroGo_)
	end

	slot0.selectHeroView_ = SectionSelectHeroTools.ReloadView(slot0.selectHeroView_, slot0.sectionProxy_:GetSelectHeroViewClass())
end

return slot0
