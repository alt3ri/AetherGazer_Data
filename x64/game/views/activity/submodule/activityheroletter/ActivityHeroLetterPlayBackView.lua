slot0 = class("ActivityHeroLetterPlayBackView", ReduxView)

function slot0.UIName(slot0)
	return ActivityHeroLetterTools.GetPlayBackUIName(slot0.params_.activityID)
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

	slot0.rewardItem_ = {}
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:GotoWeb()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshReward()
	slot0:RefreshType()
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(GameSetting.activity_hero_task_reward_list.value) do
		if not slot0.rewardItem_[slot5] then
			slot0.rewardItem_[slot5] = CommonItemView.New(Object.Instantiate(slot0.rewardGo_, slot0.rewardContent_))
		end

		slot7 = clone(ItemTemplateData)
		slot7.id = slot6[1]
		slot7.number = slot6[2]

		function slot7.clickFun()
			ShowPopItem(POP_ITEM, {
				uv0.id
			})
		end

		slot0.rewardItem_[slot5]:SetData(slot7)
		slot0.rewardItem_[slot5]:Show(true)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItem_ do
		slot0.rewardItem_[slot5]:Show(false)
	end
end

function slot0.RefreshType(slot0)
	for slot5, slot6 in ipairs(slot0.rewardItem_) do
		slot6:RefreshCompleted(ActivityHeroLetterData:GetRewwardSign(slot0.activityID_) == 1)
	end
end

function slot0.GotoWeb(slot0)
	OperationAction.OpenOperationUrl("ACTIVITY_URL", {
		userId = PlayerData:GetPlayerInfo().userID,
		signUserId = PlayerData:GetPlayerInfo().signUserId
	})

	if ActivityHeroLetterData:GetRewwardSign(slot0.activityID_) ~= 1 then
		ActivityHeroLetterAction.GetReward(slot0.activityID_)
	end
end

function slot0.OnHeroLetterReward(slot0)
	slot0:RefreshReward()
	slot0:RefreshType()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.rewardItem_) do
		slot5:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
