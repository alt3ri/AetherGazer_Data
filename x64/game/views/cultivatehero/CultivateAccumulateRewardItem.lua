slot0 = class("CultivateAccumulateRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.rewardItemList_ = {}
	slot0.itemDataList_ = {}
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.index_ = slot1
	slot0.taskID_ = slot2
	slot0.activityID_ = slot3
	slot0.maxRewardNum_ = slot4

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.titleText_.text = string.format(GetTips("CULTIVATE_HERO_REWARD"), slot0.index_)
	slot1 = nil
	slot0.indexText_.text = slot0.index_ < 10 and "0" .. slot0.index_ or slot0.index_
	slot0.needText_.text = ActivityPointRewardCfg[slot0.taskID_].need
	slot0.icon_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[slot0.activityID_].coin_id)

	slot0:RefreshReward()
end

function slot0.RefreshReward(slot0)
	for slot5 = 1, slot0.maxRewardNum_ do
		slot6 = ActivityPointRewardCfg[slot0.taskID_].reward_item_list[slot5]

		if not slot0.itemDataList_[slot5] then
			slot0.itemDataList_[slot5] = clone(ItemTemplateData)

			slot0.itemDataList_[slot5].clickFun = function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end
		end

		slot7 = true

		if slot6 then
			slot0.itemDataList_[slot5].id = slot6[1]
			slot0.itemDataList_[slot5].number = slot6[2]
			slot7 = false
		end

		if slot0.rewardItemList_[slot5] == nil then
			slot0.rewardItemList_[slot5] = CommonItemPool.New(slot0.goRewardPanel_, nil, true)
		end

		slot0.rewardItemList_[slot5]:Show(true)

		if not slot7 then
			slot0.rewardItemList_[slot5]:SetData(slot0.itemDataList_[slot5])
		else
			slot0.rewardItemList_[slot5]:SetData(nil)
		end
	end

	if (CultivateHeroData:GetAccumulateTaskInfoList(slot0.activityID_)[slot0.taskID_] and slot2[slot0.taskID_].isReceived) == true then
		slot0.rewardState_:SetSelectedState("received")
	else
		slot0.rewardState_:SetSelectedState("none")
	end
end

function slot0.RefreshItem(slot0)
	slot0.rewardCfg_ = ActivityPointRewardCfg[slot0.taskID_].reward_item_list

	slot0.itemList_:StartScroll(#slot0.rewardCfg_)
end

function slot0.Dispose(slot0)
	if slot0.rewardItemList_ then
		for slot4, slot5 in ipairs(slot0.rewardItemList_) do
			slot5:Dispose()
		end

		slot0.rewardItemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
