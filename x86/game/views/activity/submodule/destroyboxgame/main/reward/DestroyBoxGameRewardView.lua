slot0 = class("DestroyBoxGameRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionBoxUI/JapanRegionBoxRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.refreshHandler_ = handler(slot0, slot0.RefreshPanel)
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, DestroyBoxGameRewardPanel)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "receiveAll")
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.rewardPanelList_ = DestroyBoxGameTools.GetRewardPanelList(slot0.mainActivityID_)

	slot0:RefreshPanel()
	manager.notify:RegistListener(DESTROY_BOX_GAME_REWARD_REFRESH, slot0.refreshHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(DESTROY_BOX_GAME_REWARD_REFRESH, slot0.refreshHandler_)
end

function slot0.Dispose(slot0)
	slot0.refreshHandler_ = nil

	slot0.uiList_:Dispose()

	slot0.uiList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.receiveAllBtn_, nil, function ()
		DestroyBoxGameAction.RequestReward(uv0.mainActivityID_, uv0.canReceiveRewardList_, function ()
			manager.notify:Invoke(DESTROY_BOX_GAME_REWARD_REFRESH)
		end)
	end)
end

function slot0.RefreshPanel(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshData(slot0)
	slot0.sortPanelList_ = DestroyBoxGameTools.GetSortRewardPanel(slot0.mainActivityID_, slot0.rewardPanelList_)
	slot0.canReceiveRewardList_ = DestroyBoxGameTools.GetCanReceiveRewardList(slot0.mainActivityID_)
end

function slot0.RefreshUI(slot0)
	for slot5, slot6 in ipairs(slot0.sortPanelList_) do
		slot1 = 0 + #slot0.rewardPanelList_[slot6]
	end

	slot0.m_receiveLab.text = string.format("%s/%s", DestroyBoxGameTools.GetFinishRewardCnt(slot0.mainActivityID_), slot1)

	slot0.uiList_:StartScroll(#slot0.sortPanelList_)

	if #slot0.canReceiveRewardList_ > 0 then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.sortPanelList_[slot1]

	slot2:SetData(slot3, slot0.rewardPanelList_[slot3])
end

return slot0
