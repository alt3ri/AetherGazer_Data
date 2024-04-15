slot0 = class("MimirChipManagerInfoView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.ctrl = slot2

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.btnState = slot0.btnControllerexcollection_:GetController("btn")
	slot0.tabControl = slot0.tabControllerexcollection_:GetController("select")
	slot0.chipManagerLockView_ = ChipManagerLockView.New(slot0.lockPanel_)
end

function slot0.OnEnter(slot0)
end

function slot0.SetTemplateData(slot0, slot1)
	slot0.chipManagerDataTemplate_ = slot1
end

function slot0.RefreshData(slot0, slot1)
	slot0.chipManagerID = slot1
	slot2 = ChipCfg[slot0.chipManagerID]
	slot0.chipManagerName_.text = GetI18NText(slot2.suit_name)
	slot0.skillText_.text = GetI18NText(slot2.desc)
	slot0.isUnlock_, slot4, slot5 = IsConditionAchieved(slot2.new_condition)
	slot6 = slot0.chipManagerDataTemplate_:GetChipManagerIsUnLock(slot0.chipManagerID)

	slot0.chipManagerLockView_:SetChipManagerID(slot0.chipManagerID)
	slot0.chipManagerLockView_:SetActive(not slot6)

	if slot6 == false then
		if slot0.isUnlock_ then
			slot0.btnState:SetSelectedState("unLock2")
		else
			slot0.btnState:SetSelectedState("unLock1")
		end
	else
		slot0.btnState:SetSelectedState("unlocked")
	end

	if slot0.lastIndex then
		slot0:SelectTab(slot0.lastIndex)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_unlock2Btn_, nil, function ()
		if uv0.isUnlock_ then
			ChipAction.UnlockChipManager(uv0.chipManagerID)
		else
			ShowTips("CHIP_MANAGER_UNLOCK_FAILED")
		end
	end)

	slot4 = slot0.btn_unlock1Btn_

	slot0:AddBtnListener(slot4, nil, function ()
		ShowTips("CHIP_MANAGER_UNLOCK_FAILED")
	end)

	for slot4 = 1, 2 do
		slot0:AddBtnListener(slot0[string.format("btnTab%s_", slot4)], nil, function ()
			uv0:SelectTab(uv1)
		end)
	end
end

function slot0.SelectTab(slot0, slot1)
	if slot1 == 1 then
		OperationRecorder.Record("chipManager", "pageDetail")

		slot0.skillText_.text = GetI18NText(ChipCfg[slot0.chipManagerID].desc)
		slot0.lastIndex = slot1
	elseif slot1 == 2 then
		OperationRecorder.Record("chipManager", "pageStory")

		slot0.skillText_.text = GetI18NText(slot2.story)
		slot0.lastIndex = slot1
	end

	slot0.tabControl:SetSelectedState(string.format("select%s", slot1))
end

function slot0.RemoveListeners(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:RemoveListeners()

	if slot0.chipManagerLockView_ then
		slot0.chipManagerLockView_:Dispose()

		slot0.chipManagerLockView_ = nil
	end

	if slot0.chipManagerUnlockView_ then
		slot0.chipManagerUnlockView_:Dispose()

		slot0.chipManagerUnlockView_ = nil
	end

	slot0.ctrl = nil
end

return slot0
