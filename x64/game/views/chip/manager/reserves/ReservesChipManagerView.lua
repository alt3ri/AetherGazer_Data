slot0 = class("ReservesChipManagerView", ChipManagerView)

function slot0.OnEnter(slot0)
	slot0.index_ = slot0.params_.index

	uv0.super.OnEnter(slot0)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(1, {
			isInit = false
		})
	end)
end

function slot0.RefreshChipManagerItem(slot0, slot1, slot2)
	slot3 = slot0.chipManagerList_[slot1]

	slot2:SetIndex(slot0.index_)
	slot2:SetTemplateData(slot0.chipManagerDataTemplate_)
	slot2:SetChipManagerID(slot3)
	slot2:RefreshUI(slot3 == slot0.defaultSelectID_)
end

function slot0.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(BattleTeamData:GetReservesTempTeamList()[slot0.index_].chipInfo.id)
end

function slot0.GetChipManagerInfoView(slot0)
	return BattleChipManagerInfoView
end

function slot0.GetChipDataTemplate(slot0)
	slot1 = ChipManagerDataTemplate.New({
		id = slot0.defaultSelectID_,
		unlockChipManagerIDList_ = slot0:GetUnlockChipManagerList(),
		unlockChipIDList_ = slot0:GetUnlockChipList()
	})

	slot1:SetUseChipmanagerId(slot0.defaultSelectID_)
	slot1:SetReservesIndex(slot0.index_)
	slot1:SetUseChipmanagerId(BattleTeamData:GetReservesTempTeamList()[slot0.index_].chipInfo.id or 0)
	slot1:SetChipInfoViewPath("/reservesChipInfo")

	slot1.useChipIdList = BattleTeamData:GetReservesTempTeamList()[slot0.index_].chipInfo.list

	return slot1
end

function slot0.EnableChipManagerIDFunc(slot0, slot1)
	BattleTeamData:SetReservesTempTeamChip(slot0.index_, slot1)
	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
end

function slot0.GetChipManagerItem(slot0)
	return ReservesChipManagerItem
end

function slot0.OnSchemeBtn(slot0)
	slot0:Go("/reservesChipScheme", {
		chipManagerID = slot0.chipManagerID_,
		template = slot0.chipManagerDataTemplate_,
		index = slot0.index_
	})
end

return slot0
