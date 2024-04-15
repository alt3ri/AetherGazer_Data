slot0 = class("MoonCakeBagGroupItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, MoonCakeItem)
	slot0.rewardItems_ = {}
	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.ReceiveCakeCollectReward(uv0.activityID_, uv0.groupID_)
	end)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	slot0.itemList_:Dispose()

	slot0.itemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.groupID_ = slot1
	slot0.activityID_ = slot2
	slot0.groupCfg_ = MoonCakeGroupCfg[slot0.groupID_]
	slot0.groupName_.text = slot0.groupCfg_.group_name

	slot0:RefreshItem()
	slot0:RefreshReward()
end

function slot0.RefreshItem(slot0)
	slot0.unlockMoonCakeDic_ = MoonCakeData:GetUnlockCakeDic(slot0.activityID_)
	slot0.itemIdList_ = slot0.groupCfg_.collect_condition

	slot0.itemList_:StartScroll(#slot0.itemIdList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.itemIdList_[slot1]

	slot2:SetData(MoonCakeCfg[slot3].moon_cakes)
	slot2:SetUnlock(slot0.unlockMoonCakeDic_[slot3])
end

function slot0.RefreshReward(slot0)
	slot0.taskNeed_ = #slot0.itemIdList_
	slot0.taskProgress_ = 0

	for slot4, slot5 in ipairs(slot0.itemIdList_) do
		if slot0.unlockMoonCakeDic_[slot5] then
			slot0.taskProgress_ = slot0.taskProgress_ + 1
		end
	end

	slot5 = slot0.taskProgress_
	slot6 = slot0.taskNeed_
	slot0.descText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_COLLECT"), slot5, slot6)

	for slot5, slot6 in ipairs(slot0.groupCfg_.reward) do
		if slot0.rewardItems_[slot5] == nil then
			slot0.rewardItems_[slot5] = RewardPoolItem.New(slot0.rewardPanelTrans_)
		end

		slot0.rewardItems_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end

	slot0:RefreshStatus()
end

function slot0.RefreshStatus(slot0)
	slot1 = slot0.taskNeed_ <= slot0.taskProgress_

	if MoonCakeData:GetReceivedGroupDic(slot0.activityID_)[slot0.groupID_] == true == true then
		slot0.statusController_:SetSelectedState("received")
	elseif slot1 == true then
		slot0.statusController_:SetSelectedState("completed")
	else
		slot0.statusController_:SetSelectedState("uncomplete")
	end
end

return slot0
