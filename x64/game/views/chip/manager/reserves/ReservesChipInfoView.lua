slot0 = class("ReservesChipInfoView", ChipInfoView)

function slot0.OnEnter(slot0)
	slot0.chipManagerDataTemplate_ = slot0.params_.chipDataTemplate
	slot0.index = slot0.chipManagerDataTemplate_.reservesIndex_

	slot0.super.OnEnter(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		BattleTeamData:SetReservesTempTeamChipList(uv0.index, uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		ChipAction.UnlockChip(uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		BattleTeamData:UnloadReservesTempTeamChipList(uv0.index, uv0.defaultSelectID_)
	end)
end

function slot0.OnEnabledChip(slot0)
	slot0.currentChipList_ = slot0:GetChipData()

	slot0:RefreshUI()
	slot0.chipUIList_:Refresh()
end

function slot0.GetChipItem(slot0)
	return ChipItem
end

function slot0.GetChipData(slot0)
	return BattleTeamData:GetReservesTempTeamList()[slot0.index].chipInfo.list
end

return slot0
