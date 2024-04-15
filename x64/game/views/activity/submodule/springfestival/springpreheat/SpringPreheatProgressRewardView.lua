slot0 = class("SpringPreheatRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeRewardsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, SpringPreheatProgressRewardItem)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnBehind(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	slot0.rewardList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot0.rewardList_:StartScroll(#SpringPreheatData:GetProgressRewardList())
	slot0:RefreshProgressUI()
end

function slot0.RefreshProgressUI(slot0)
	slot0.progressText_.text = string.format("%d/%d", SpringPreheatData:GetProgressRewardScore(), SpringPreheatData:GetMaxPrgressRewardScore())
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(SpringPreheatData:GetProgressRewardList()[slot1].id)
	slot2:SetClickHandler(function (slot0)
		uv0:OnClickRewardItem(uv1, slot0)
	end)
	slot2:RefreshUI()
end

function slot0.OnClickRewardItem(slot0, slot1, slot2)
	slot4 = SpringPreheatData:GetProgressRewardList()[slot1]

	if not SpringPreheatData:CanAcquire(slot4.id) or SpringPreheatData:IsAcquired(slot4.id) then
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = slot4.reward_item_list
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)

		return
	end

	SpringPreheatAction:RequestProgressReward(slot4.id, function (slot0)
		uv0:RefreshProgressUI()
		uv1:RefreshUI()
		getReward2(slot0.reward_list)
	end)
end

return slot0
