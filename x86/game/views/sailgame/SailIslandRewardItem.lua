slot0 = class("SailIslandRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.rewardItemList_ = {}
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.taskID_ = slot1.id
	slot0.type_ = slot1.type

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.type_ == SailGameConst.TASK_TYPE.BUILDING then
			SailGameAction.ReceiveTask(uv0.activityID_, uv0.taskID_, uv0.type_)
		else
			SailGameAction.ReceiveTask(uv0.activityID_, SailGameIslandLevelCfg[uv0.taskID_].level, uv0.type_)
		end
	end)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTitle()
	slot0:RefreshReward()
	slot0:RefreshProgress()
end

function slot0.RefreshTitle(slot0)
	if slot0.type_ == SailGameConst.TASK_TYPE.BUILDING then
		slot0.contentText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_REWARD_TIP"), SailGameBuildingCfg[slot0.taskID_].name)
		slot0.rewardCfg_ = SailGameBuildingCfg[slot0.taskID_].reward_item_list
	else
		slot0.contentText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_LEVEL_REWARD_TIP"), NumberTools.IntToRomam(SailGameIslandLevelCfg[slot0.taskID_].level))
		slot0.rewardCfg_ = SailGameIslandLevelCfg[slot0.taskID_].reward_item_list
	end
end

function slot0.RefreshReward(slot0)
	for slot4, slot5 in ipairs(slot0.rewardCfg_) do
		if slot0.rewardItemList_[slot4] then
			slot0.rewardItemList_[slot4]:SetData(slot5, false)
		else
			slot0.rewardItemList_[slot4] = RewardPoolItem.New(slot0.goRewardPanel_, slot5, false)
		end
	end

	for slot4 = #slot0.rewardCfg_ + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot4]:Show(false)
	end
end

function slot0.RefreshProgress(slot0)
	slot1 = false
	slot2 = false

	if slot0.type_ == SailGameConst.TASK_TYPE.BUILDING then
		slot2 = SailGameData:GetRceivedBuilding(slot0.activityID_)[slot0.taskID_] == true
		slot1 = SailGameData:GetUnLockBuilding(slot0.activityID_)[slot0.taskID_] == true
	else
		slot2 = SailGameData:GetReceivedIslandLevel(slot0.activityID_)[SailGameIslandLevelCfg[slot0.taskID_].level] == true
		slot1 = slot3 <= SailGameData:GetIslandLevel(slot0.activityID_)
	end

	if slot2 == true then
		slot0.controller_:SetSelectedState("received")
	elseif slot1 == true then
		slot0.controller_:SetSelectedState("complete")
	else
		slot0.controller_:SetSelectedState("uncomplete")
	end
end

return slot0
