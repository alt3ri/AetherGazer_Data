slot0 = class("SpringPreheatPrayBranchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishUIRewardsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.branch_ = SpringPreheatPrayBubbleView.New(slot0.branchGo_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.day_ = slot0.params_.day or SpringPreheatData:GetNextSelectionIndex()

	slot0.branch_:SetData(slot0.day_)
	slot0.branch_:SetClickHandler(function (slot0, slot1, slot2, slot3)
		uv0:OnClickBubble(slot0, slot1, slot2, slot3)
	end)
	slot0.branch_:OnEnter()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0.branch_:OnExit()
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnBehind(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	slot0.branch_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
end

function slot0.OnClickBubble(slot0, slot1, slot2, slot3, slot4)
	if slot4 then
		ShowPopItem(POP_ITEM, {
			slot3:GetItemId()
		})
	end
end

return slot0
