slot0 = class("ReservesView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Formation/FormationReserveView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectHeroView_ = slot0:GetSelectHeroViewClass().New(slot0.selectHeroGo_)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ReservesItem)
	slot0.clickItemHandler_ = handler(slot0, slot0.OnClickItem)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.saveBtn_, nil, function ()
	end)
end

function slot0.OnEnter(slot0)
	slot0:ProcessCamera()
	slot0:UpdateBar()

	slot0.reserveParams_ = slot0.params_.reserveParams
	slot0.curList_, _, slot0.lockList_, slot0.trailList_ = ReserveTools.GetHeroList(slot0.reserveParams_)
	slot0.comboSkill_ = ReserveTools.GetComboSkillID(slot0.reserveParams_)
	slot0.chipInfo_ = {
		enabledID = ReserveTools.GetMimirID(slot0.reserveParams_),
		chipList = ReserveTools.GetMimirChipList(slot0.reserveParams_)
	}
	slot0.handler_ = handler(slot0, slot0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, slot0.handler_)
	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(1, {
			isSorted = true
		})
	end)
end

function slot0.OnExit(slot0)
	slot0.lastPos_ = slot0.scrollHelper_:GetScrolledPosition()

	if slot0.scrollHelper_ then
		slot0.scrollHelper_:StopRender()
	end

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, slot0.handler_)

	slot0.params_.isInit = false
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.ProcessCamera(slot0)
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
end

function slot0.RefreshUI(slot0)
	slot0:RefreshList()
	slot0:RefreshText()
end

function slot0.RefreshList(slot0)
	slot0.reservesTeams_ = BattleTeamData:GetReservesTeamList()
	slot0.setCurTeamIndex_ = slot0.setCurTeamIndex_ or 0

	if slot0.params_.isInit then
		slot0.reservesTempTeams_ = BattleTeamData:InitTempList()
		slot1 = slot0:IsTrial()

		if not slot0:IsExist() and not slot1 and slot0:IsNotEmpty() then
			slot0.setCurTeamIndex_ = BattleTeamData:SetCurTeam(slot0.curList_, slot0.comboSkill_, slot0.chipInfo_)
		end

		if slot1 then
			ShowTips("CHARACTOR_ON_TRIAL")
		end

		slot0.scrollHelper_:StartScroll(#slot0.reservesTempTeams_)
	else
		slot0.reservesTempTeams_ = BattleTeamData:GetReservesTempTeamList()

		if slot0.setCurTeamIndex_ ~= 0 and not slot0:IsCurTeam(slot0.reservesTempTeams_[slot0.setCurTeamIndex_]) then
			slot0.setCurTeamIndex_ = 0
		end

		slot0.scrollHelper_:StartScrollByPosition(#slot0.reservesTempTeams_, slot0.lastPos_)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.reservesTempTeams_[slot1].hero_list

	slot2:RefreshUI(slot0.reservesTempTeams_[slot1], slot0:IsCurTeam(slot0.reservesTempTeams_[slot1]), slot0:IsInList(slot1, slot0.reservesTempTeams_[slot1]), slot1 == slot0.setCurTeamIndex_, slot0.isAdvanceTest_)
	slot2:RegistClickCallback()
	slot2:RegistChangeBtn(function (slot0)
		for slot5, slot6 in ipairs(BattleTeamData:GetReservesTeam(slot0)) do
			if slot6 ~= 0 and table.indexof(uv0.lockList_, slot6) then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end
		end

		slot2 = BattleTeamData:GetReservesTeamList()[slot0]

		ReserveTools.SetTeam(uv0.reserveParams_, slot1, {
			0,
			0,
			0
		}, slot2.comboSkill, slot2.chipInfo.id, slot2.chipInfo.list)
		uv0:Back(1, {
			isReserves = true,
			index = slot0
		})
		ShowTips("FORMATION_PLAN_CHANGED")
	end)
end

function slot0.RefreshText(slot0)
	for slot5, slot6 in ipairs(slot0.reservesTeams_) do
		if slot6.name ~= "" then
			slot1 = 0 + 1
		end
	end

	slot0.text_.text = slot1 .. "/10"
end

function slot0.IsCurTeam(slot0, slot1)
	if slot1.hero_list[1] == slot0.curList_[1] and slot2[2] == slot0.curList_[2] and slot2[3] == slot0.curList_[3] and slot1.comboSkill == slot0.comboSkill_ and slot1.chipInfo.id == slot0.chipInfo_.enabledID and #slot1.chipInfo.list == #slot0.chipInfo_.chipList then
		for slot6, slot7 in ipairs(slot1.chipInfo.list) do
			if not table.indexof(slot0.chipInfo_.chipList, slot7) then
				return false
			end
		end

		return true
	end

	return false
end

function slot0.IsInList(slot0, slot1, slot2)
	if slot2.hero_list[1] == slot0.reservesTeams_[slot1].hero_list[1] and slot3[2] == slot5[2] and slot3[3] == slot5[3] and slot2.comboSkill == slot4.comboSkill and slot2.chipInfo.id == slot4.chipInfo.id and #slot2.chipInfo.list == #slot4.chipInfo.list then
		for slot9, slot10 in ipairs(slot2.chipInfo.list) do
			if not table.indexof(slot4.chipInfo.list, slot10) then
				return false
			end
		end

		return true
	end

	return false
end

function slot0.GetSelectHeroViewClass(slot0)
	return ReservesSelectHeroView
end

function slot0.OnReservesSaveTeam(slot0)
	slot0:RefreshText()
	slot0.scrollHelper_:Refresh()
end

function slot0.OnReservesDelectTeam(slot0)
	slot0:RefreshText()
	slot0.scrollHelper_:Refresh()
	ShowTips("FORMATION_PLAN_DELETED")
end

function slot0.OnComboSkillSelect(slot0)
	slot0.setCurTeamIndex_ = 0

	slot0.scrollHelper_:Refresh()
end

function slot0.OnClickItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot6:SetSelect(slot1)
	end
end

function slot0.IsExist(slot0)
	slot1 = false

	for slot5, slot6 in ipairs(slot0.reservesTempTeams_) do
		if slot0:IsCurTeam(slot6) then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.IsTrial(slot0)
	slot1 = false

	for slot5, slot6 in ipairs(slot0.trailList_) do
		if slot6 ~= 0 then
			slot0.curList_ = {
				0,
				0,
				0
			}
			slot0.comboSkill_ = 0
			slot0.chipInfo_ = {
				enabledID = 0,
				chipList = {}
			}
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.IsNotEmpty(slot0)
	slot1 = false

	for slot5, slot6 in ipairs(slot0.curList_) do
		if slot6 ~= 0 then
			slot1 = true

			break
		end
	end

	return slot1
end

return slot0
