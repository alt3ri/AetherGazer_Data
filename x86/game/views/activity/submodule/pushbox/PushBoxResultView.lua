slot0 = class("PushBoxResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/BoxGameResultPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.list_[slot1]))
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
			activityID = uv0.params_.activityID
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.list_ = slot0.params_.rewardList

	slot0.scrollHelper_:StartScroll(#slot0.list_)
	SetActive(slot0.rewardPanel_, #slot0.list_ > 0)
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
