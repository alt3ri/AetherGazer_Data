slot1 = class("BattleChipInfoView", import("game.views.chip.info.ChipInfoView"))

function slot1.OnEnter(slot0)
	slot0.chipManagerDataTemplate_ = slot0.params_.chipDataTemplate
	slot0.sectionProxy_ = slot0.chipManagerDataTemplate_.sectionProxy_

	slot0.super.OnEnter(slot0)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		uv0.chipManagerDataTemplate_:SetUseChipId(uv0.defaultSelectID_)
		manager.notify:Invoke(ENABLED_CHIP, uv0.defaultSelectID)
		uv0.sectionProxy_:InsertMimirChip(uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		ChipAction.UnlockChip(uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		uv0.chipManagerDataTemplate_:SetNoUseChipId(uv0.defaultSelectID_, uv0.params_.selectChipIndex)
		manager.notify:CallUpdateFunc(UNUSE_BATTLECHIP, uv0.defaultSelectID_)
		uv0.sectionProxy_:RemoveMimirChip(uv0.defaultSelectID_)
	end)
end

function slot1.OnEnabledChip(slot0)
	slot0.currentChipList_ = slot0:GetChipData()

	slot0:RefreshUI()
	slot0.chipUIList_:Refresh()
end

function slot1.GetChipData(slot0)
	return slot0.sectionProxy_:GetMimirChipList()
end

function slot1.SortChip(slot0)
	return ChipTools.SortChip((slot0:GetChipTypeCntList() or {})[-1], slot0.params_.chipManagerID)
end

return slot1
