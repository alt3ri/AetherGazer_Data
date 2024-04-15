slot1 = class("BattleChipManagerView", import("game.views.chip.manager.ChipManagerView"))

function slot1.SetViewParam(slot0)
	slot1 = nil

	slot0.chipManagerDataTemplate_:SetTeamInfo(slot0.params_.stageType, slot0.params_.stageID, (not slot0.params_.sectionProxy or slot0.params_.sectionProxy) and SectionSelectHeroTools.GetProxyClass(slot0.params_.stageType).New({
		section = slot0.params_.stageID,
		sectionType = slot0.params_.stageType
	}, slot0.params_.reserveParams or ReserveTools.GetReserveParams(slot0.params_.stageType, slot0.params_.stageID)))
end

function slot1.OnUpdate(slot0)
	slot0.defaultSelectID_ = slot0.params_.chipManagerID or slot0.chipManagerList_[1]

	slot0:RefreshUI()
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshList()
end

function slot1.RefreshList(slot0)
	slot0.chipManagerUIList_:Refresh()
end

function slot1.GetChipManagerItem(slot0)
	return BattleChipManagerItem
end

function slot1.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(slot0.chipManagerDataTemplate_.sectionProxy_:GetMimirID())
end

function slot1.GetChipDataTemplate(slot0)
	slot1 = ChipManagerDataTemplate.New({
		id = slot0.defaultSelectID_,
		unlockChipManagerIDList_ = slot0:GetUnlockChipManagerList(),
		unlockChipIDList_ = slot0:GetUnlockChipList()
	})

	slot1:SetChipInfoViewPath("/battleChipInfo")

	return slot1
end

function slot1.OnSchemeBtn(slot0)
	JumpTools.OpenPageByJump("battleChipScheme", {
		chipManagerID = slot0.chipManagerID_,
		template = slot0.chipManagerDataTemplate_
	})
end

function slot1.EnableChipManagerIDFunc(slot0, slot1)
	slot0.chipManagerDataTemplate_.sectionProxy_:SetMimirID(slot1)
	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
end

return slot1
