slot0 = class("KagutsuchiGachaPreviewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionJackpotRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.poolRewardItem_ = {}
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgmask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId_ = slot0.params_.activityId
	slot0.poolId_ = slot0.params_.poolId

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.poolRewardItem_) do
		slot0.poolRewardItem_[slot4]:OnExit()
	end
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnBehind(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshPoolRewardItems(slot0.poolId_)
end

function slot0.RefreshPoolRewardItems(slot0, slot1)
	for slot6, slot7 in ipairs(KagutsuchiGachaData:GetAllDrawItemIds(slot1)) do
		if not slot0.poolRewardItem_[slot6] then
			slot0.poolRewardItem_[slot6] = KagutsuchiGachaRewardItem.New(Object.Instantiate(slot0.templateItem_, slot0.contentParent_))
		end

		slot0.poolRewardItem_[slot6]:SetData(slot0.activityId_, slot1, slot7)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.poolRewardItem_) do
		slot0.poolRewardItem_[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
