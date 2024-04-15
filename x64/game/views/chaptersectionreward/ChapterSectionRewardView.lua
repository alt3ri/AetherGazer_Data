slot0 = class("ChapterSectionRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/ChapterSectionRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.rewardPanelItems_ = {}

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.chapterID_ = tonumber(slot0.params_.chapterID)

	for slot4, slot5 in ipairs(slot0.rewardPanelItems_) do
		slot5:SetData(slot0.chapterID_)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardPanelItems_) do
		slot5:Dispose()
	end

	slot0.rewardPanelItems_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	for slot4 = 1, 3 do
		slot0.rewardPanelItems_[slot4] = ChapterSectionRewardItemPanel.New(slot0[string.format("rewardPanelItem%s_", slot4)], slot4)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

return slot0
