slot0 = class("SpringPreheatPraySelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishSelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemUiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, SpringPreheatPrayRewardItem)
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "Notoptional")
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0.stateController_:SetSelectedState("select")

	slot0.branch_ = SpringPreheatPrayBubbleView.New(slot0.branchGo_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:OnClickCancelBtn()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:OnClickCancelBtn()
	end)
	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		uv0:OnClickConfirmBtn()
	end)
end

function slot0.OnEnter(slot0)
	slot0.day_ = SpringPreheatData:GetNextSelectionIndex()

	slot0.branch_:SetData(slot0.day_)
	slot0.branch_:SetClickHandler(function (slot0, slot1, slot2, slot3)
		uv0:OnClickBubble(slot0, slot1, slot2, slot3)
	end)
	slot0.branch_:OnEnter()

	slot0.itemIdList_ = slot0:GetSortedList()

	slot0.itemUiList_:StartScroll(#slot0.itemIdList_)
	slot0:ResetSelectItems()
	slot0.selectController_:SetSelectedState("no")
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot3 = slot0.itemUiList_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	slot0.branch_:OnExit()
end

function slot0.Dispose(slot0)
	slot0.itemUiList_:Dispose()
	slot0.branch_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.itemIdList_[slot1]

	slot2:SetClickHandler(function (slot0)
		uv0:OnClickRewardItem(uv1, slot0)
	end)
	slot2:SwitchToSelecting()
	slot2:SetSelectable(not SpringPreheatData:IsSelected(slot3))
	slot2:SetSelected(false)
	slot2:SetData(slot3)
end

function slot0.RefreshUI(slot0)
	slot0.branch_:UpdateItemIdList(slot0:GetSelectRewardList())
	slot0.branch_:RefreshItemUiList()

	slot0.tipsText_.text = GetTips(string.format("SPRING_PREHEAT_EDIT_REWARD_DAY_%d", slot0.day_))
	slot0.selectNumText_.text = string.format("%d/%d", slot0.selectedCount, slot0.params_.maxSelectCount)
end

function slot0.OnClickRewardItem(slot0, slot1, slot2)
	if slot0.itemSelected[slot1] then
		slot2:SetSelected(false)
		slot0:RemoveSelectItem(slot1)
	elseif slot0.params_.maxSelectCount <= slot0.selectedCount then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")
	elseif not SpringPreheatData:IsSelected(slot0.itemIdList_[slot1]) then
		slot2:SetSelected(true)
		slot0:AddSelectItem(slot1)
	end

	slot0.selectController_:SetSelectedState(slot0.params_.maxSelectCount <= slot0.selectedCount and "yes" or "no")
	slot2:RefreshUI()
	slot0:RefreshUI()
end

function slot0.OnClickCancelBtn(slot0)
	if slot0.isAniPlaying_ then
		return
	end

	slot0:Back()
end

function slot0.OnClickConfirmBtn(slot0)
	if slot0.selectedCount ~= 2 then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")

		return
	end

	slot0:TryUploadSelection()
end

function slot0.TryUploadSelection(slot0)
	if #slot0:GetSelectRewardList() ~= 2 then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")

		return
	end

	if slot0.isAniPlaying_ then
		return
	end

	SpringPreheatAction:UploadPraySelection(SpringPreheatData:GetNextSelectionIndex(), slot1, function ()
		uv0:PlayEffect(function ()
			if uv0.params_.onSelectionConfirmed then
				uv0.params_.onSelectionConfirmed(uv1)
			end

			uv0:Back()
		end)
	end)
end

function slot0.GetSortedList(slot0)
	slot1 = SpringPreheatData:GetPoolItemList()
	slot2 = SpringPreheatData:GetPraySelectionFullList()

	table.sort(slot1, function (slot0, slot1)
		if SpringPreheatData:IsSelected(slot0) and SpringPreheatData:IsSelected(slot1) then
			return table.indexof(uv0, slot0) < table.indexof(uv0, slot1)
		elseif slot2 or slot3 then
			return not slot2
		end

		return slot0 < slot1
	end)

	return slot1
end

function slot0.AddSelectItem(slot0, slot1)
	slot0.itemSelected[slot1] = true
	slot0.selectedCount = slot0.selectedCount + 1

	table.insert(slot0.selectIndexList_, slot1)
end

function slot0.RemoveSelectItem(slot0, slot1)
	slot0.itemSelected[slot1] = false
	slot0.selectedCount = slot0.selectedCount - 1

	table.removebyvalue(slot0.selectIndexList_, slot1)
end

function slot0.ResetSelectItems(slot0)
	slot0.itemSelected = {}
	slot0.selectedCount = 0

	for slot4, slot5 in ipairs(slot0.itemIdList_) do
		slot0.itemSelected[slot4] = false
	end

	slot0.selectIndexList_ = {}
end

function slot0.GetSelectRewardList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.selectIndexList_) do
		table.insert(slot2, SpringPreheatData:GetPoolItemList()[slot7])
	end

	for slot6 = #slot2 + 1, slot0.params_.maxSelectCount do
		table.insert(slot2, 0)
	end

	return slot2
end

function slot0.OnClickBubble(slot0, slot1, slot2, slot3, slot4)
	if slot4 then
		ShowPopItem(POP_ITEM, {
			slot3:GetItemId()
		})
	end
end

function slot0.PlayEffect(slot0, slot1)
	if slot0.selectAni_ then
		slot0.isAniPlaying_ = true

		slot0.selectAni_:Play("IndiaWishingTreeWishSelUI02", -1, 0)
		slot0.selectAni_:Update(0)
		AnimatorTools.PlayAnimationWithCallback(slot0.selectAni_, "IndiaWishingTreeWishSelUI02", function ()
			uv0.isAniPlaying_ = false

			uv1()
		end)
	else
		slot1()
	end
end

return slot0
