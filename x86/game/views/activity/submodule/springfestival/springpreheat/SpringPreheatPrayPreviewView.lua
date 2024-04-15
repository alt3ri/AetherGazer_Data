slot0 = class("SpringPreheatPrayPreviewView", ReduxView)

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
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0.stateController_:SetSelectedState("preview")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.itemIdList_ = slot0:GetSortedList()

	slot0.itemUiList_:StartScroll(#slot0.itemIdList_)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.itemUiList_:GetItemList()) do
		slot5:OnExit()
	end
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnBehind(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	slot0.itemUiList_:Dispose()
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
end

function slot0.OnClickRewardItem(slot0, slot1, slot2)
	ShowPopItem(POP_ITEM, {
		slot2:GetItemId()
	})
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

return slot0
