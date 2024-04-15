slot1 = class("BattleChipManagerInfoView", import("game.views.chip.manager.MimirChipManagerInfoView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.chipManagerUnlockView_ = ChipManagerUnlockView.New(slot0.chipGo_)
end

function slot1.RefreshData(slot0, slot1)
	slot0.chipManagerID = slot1
	slot2 = ChipCfg[slot0.chipManagerID]
	slot0.chipManagerName_.text = GetI18NText(slot2.suit_name)
	slot0.skillText_.text = GetI18NText(slot2.desc)
	slot0.isUnlock_, slot4, slot5 = IsConditionAchieved(slot2.new_condition)
	slot6 = slot0.chipManagerDataTemplate_:GetChipManagerIsUnLock(slot0.chipManagerID)

	slot0.chipManagerLockView_:SetActive(not slot6)
	slot0.chipManagerUnlockView_:SetActive(slot6)

	if slot6 == false then
		if slot0.isUnlock_ then
			slot0.btnState:SetSelectedState("unLock2")
		else
			slot0.btnState:SetSelectedState("unLock1")
		end

		slot0.chipManagerLockView_:SetChipManagerID(slot0.chipManagerID)
	else
		if slot0.chipManagerDataTemplate_:GetISUseChipmanager(slot0.chipManagerID) then
			slot0.btnState:SetSelectedState("unUse")
		else
			slot0.btnState:SetSelectedState("use")
		end

		slot0.chipManagerUnlockView_:SetDataTemplate(slot0.chipManagerDataTemplate_)
		slot0.chipManagerUnlockView_:SetChipManagerID(slot0.chipManagerID)
	end

	if slot0.lastIndex then
		slot0:SelectTab(slot0.lastIndex)
	end
end

function slot1.AddListeners(slot0)
	slot0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_unuseBtn_, nil, function ()
		uv0.chipManagerDataTemplate_:SetUseChipmanagerId(0)

		if uv0.enableIDFunc_ then
			uv0.enableIDFunc_(0)
		end

		ShowTips("CHIP_MANAGER_UNLOAD_SUCCESS")
	end)
	slot0:AddBtnListener(slot0.btn_useBtn_, nil, function ()
		uv0.chipManagerDataTemplate_:SetUseChipmanagerId(uv0.chipManagerID)

		if uv0.enableIDFunc_ then
			uv0.enableIDFunc_(uv0.chipManagerID)
		end

		ShowTips("CHIP_MANAGER_USE_SUCCESS")
	end)
end

function slot1.RegistEnableIDFunc(slot0, slot1)
	slot0.enableIDFunc_ = slot1
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.chipManagerUnlockView_ then
		slot0.chipManagerUnlockView_:Dispose()

		slot0.chipManagerUnlockView_ = nil
	end
end

return slot1
