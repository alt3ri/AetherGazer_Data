slot0 = class("PushSnowBallRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRewardsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rankTypeConst_ = AdvanceTestData:GetRankTypeConst()

	slot0:InitUI()

	slot0.controllerList_ = {}
	slot0.scoreController_ = ControllerUtil.GetController(slot0.scoreModelBtn_.transform, "toggle")
	slot0.bowlingController_ = ControllerUtil.GetController(slot0.bowlingModelBtn_.transform, "toggle")
	slot0.bossController_ = ControllerUtil.GetController(slot0.bossModelBtn_.transform, "toggle")

	table.insert(slot0.controllerList_, slot0.scoreController_)
	table.insert(slot0.controllerList_, slot0.bowlingController_)
	table.insert(slot0.controllerList_, slot0.bossController_)

	slot0.normalTaskItemList_ = {}
	slot0.hardTaskItemList_ = {}

	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.RefreshUIHandler_ = handler(slot0, slot0.Refresh)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.scoreModelBtn_, nil, function ()
		uv0:OnClickSubType(1)
	end)
	slot0:AddBtnListener(slot0.bowlingModelBtn_, nil, function ()
		uv0:OnClickSubType(2)
	end)
	slot0:AddBtnListener(slot0.bossModelBtn_, nil, function ()
		uv0:OnClickSubType(3)
	end)
end

function slot0.OnClickSubType(slot0, slot1)
	if slot0.index ~= slot1 then
		slot0.scroll_.enabled = false
		slot0.normalTaskDataList_ = PushSnowBallData:GetNormalTaskListByType(slot1)
		slot5 = slot1
		slot0.hardTaskDataList_ = PushSnowBallData:GetHardTaskListByType(slot5)

		for slot5, slot6 in ipairs(slot0.normalTaskDataList_) do
			if not slot0.normalTaskItemList_[slot5] then
				table.insert(slot0.normalTaskItemList_, PushSnowBallRewardItem.New(Object.Instantiate(slot0.taskItem_, slot0.normalTaskTrs_, false)))
			end

			slot0.normalTaskItemList_[slot5]:SetData(slot5, slot6)
		end

		for slot5, slot6 in ipairs(slot0.hardTaskDataList_) do
			if not slot0.hardTaskItemList_[slot5] then
				table.insert(slot0.hardTaskItemList_, PushSnowBallRewardItem.New(Object.Instantiate(slot0.taskItem_, slot0.hardTaskTrs_, false)))
			end

			slot0.hardTaskItemList_[slot5]:SetData(slot5, slot6)
		end

		slot0:RefreshToggle(slot1)

		slot0.scroll_.enabled = true
	end

	slot0.index = slot1
end

function slot0.RefreshToggle(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.controllerList_) do
		if slot5 == slot1 then
			slot6:SetSelectedState("on")
		else
			slot6:SetSelectedState("off")
		end
	end
end

function slot0.OnRewardedTask(slot0)
	slot0:Refresh()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.activityID_ = slot0.params_.activityID

	slot0:OnClickSubType(slot0.index or 1)
	slot0:Refresh()
	manager.redPoint:bindUIandKey(slot0.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 1)
	manager.redPoint:bindUIandKey(slot0.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 2)
	manager.redPoint:bindUIandKey(slot0.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 3)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 1)
	manager.redPoint:unbindUIandKey(slot0.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 2)
	manager.redPoint:unbindUIandKey(slot0.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. 3)
end

function slot0.Refresh(slot0)
	for slot4, slot5 in ipairs(slot0.normalTaskItemList_) do
		slot5:RefreshUI()
	end

	for slot4, slot5 in ipairs(slot0.hardTaskItemList_) do
		slot5:RefreshUI()
	end
end

function slot0.Dispose(slot0)
	if slot0.hardTaskItemList_ then
		for slot4, slot5 in ipairs(slot0.hardTaskItemList_) do
			slot5:Dispose()
		end

		slot0.hardTaskItemList_ = nil
	end

	if slot0.normalTaskItemList_ then
		for slot4, slot5 in ipairs(slot0.normalTaskItemList_) do
			slot5:Dispose()
		end

		slot0.normalTaskItemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
