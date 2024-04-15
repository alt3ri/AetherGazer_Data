slot0 = class("PushTheSnowBallSingleView", ReduxView)
slot1 = {
	BOSS = 3,
	SCORE = 1,
	BOWLING = 2
}
slot2 = {
	NORMAL = 1,
	HARD = 2
}

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballSingleModeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:BindController()

	slot0.taskItemList_ = {}

	for slot4 = 1, 3 do
		table.insert(slot0.taskItemList_, PushSnowBallWeeklyTaskItem.New(slot0["weeklyTaskItem" .. slot4]))
	end

	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.BindController(slot0)
	slot0.deviceController_ = ControllerUtil.GetController(slot0.deviceBtn_.transform, "equipped")
	slot0.rewardController_ = ControllerUtil.GetController(slot0.weeklyTaskTrs_, "state")
	slot0.modelSelectControllerList_ = {}
	slot0.modelLockControllerList_ = {}
	slot0.scoreSelectController_ = ControllerUtil.GetController(slot0.scoreModelBtn_.transform, "select")
	slot0.bowlingSelectController_ = ControllerUtil.GetController(slot0.bowlingModelBtn_.transform, "select")
	slot0.bossSelectController_ = ControllerUtil.GetController(slot0.bossModelBtn_.transform, "select")
	slot0.bowlingLockController_ = ControllerUtil.GetController(slot0.bowlingModelBtn_.transform, "lock")
	slot0.bossLockController_ = ControllerUtil.GetController(slot0.bossModelBtn_.transform, "lock")

	table.insert(slot0.modelSelectControllerList_, slot0.scoreSelectController_)
	table.insert(slot0.modelSelectControllerList_, slot0.bowlingSelectController_)
	table.insert(slot0.modelSelectControllerList_, slot0.bossSelectController_)
	table.insert(slot0.modelLockControllerList_, slot0.bowlingLockController_)
	table.insert(slot0.modelLockControllerList_, slot0.bossLockController_)

	slot0.levelSelectControllerList_ = {}
	slot0.normalSelectController_ = ControllerUtil.GetController(slot0.normalLevelBtn_.transform, "select")
	slot0.hardSelectController_ = ControllerUtil.GetController(slot0.hardLevelBtn_.transform, "select")
	slot0.hardLockController_ = ControllerUtil.GetController(slot0.hardLevelBtn_.transform, "lockByTime")
	slot0.normalLevelImgController_ = ControllerUtil.GetController(slot0.normalLevelBtn_.transform, "type")
	slot0.hardlLevelImgController_ = ControllerUtil.GetController(slot0.hardLevelBtn_.transform, "type")

	table.insert(slot0.levelSelectControllerList_, slot0.normalSelectController_)
	table.insert(slot0.levelSelectControllerList_, slot0.hardSelectController_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.heroBtn_, nil, function ()
		JumpTools.OpenPageByJump("pushSnowBallHeroChangePop", {
			type = 1
		})
	end)
	slot0:AddBtnListener(slot0.deviceBtn_, nil, function ()
		JumpTools.OpenPageByJump("pushSnowBallDevicePop")
	end)
	slot0:AddBtnListener(slot0.weeklyTaskRewardBtn_, nil, function ()
		TaskAction:SubmitTaskList({
			uv0.weeklyTaskID
		})
	end)
	slot0:AddBtnListener(slot0.touchHeroBtn_, nil, function ()
		uv0:OnTouchHero()
	end)
	slot0:AddBtnListener(slot0.scoreModelBtn_, nil, function ()
		uv0:SelectModel(uv1.SCORE)
	end)
	slot0:AddBtnListener(slot0.bowlingModelBtn_, nil, function ()
		uv0:SelectModel(uv1.BOWLING)
	end)
	slot0:AddBtnListener(slot0.bossModelBtn_, nil, function ()
		uv0:SelectModel(uv1.BOSS)
	end)
	slot0:AddBtnListener(slot0.modelDescBtn_, nil, function ()
		slot0 = GetTips(PushSnowBallData:GetSingleDescTipsByModelAndSubModel(uv0.modelType_ or 1))

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = slot0,
			key = slot0
		})
	end)
	slot0:AddBtnListener(slot0.normalLevelBtn_, nil, function ()
		uv0:SelectLevel(uv1.NORMAL)
	end)
	slot0:AddBtnListener(slot0.hardLevelBtn_, nil, function ()
		uv0:SelectLevel(uv1.HARD)
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("pushSnowBallReward")
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		slot0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(uv0.modelType_, uv0.levelType_)

		BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE, PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[slot0][1]].stageId, {
			activityID = slot0
		}))
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = PushSnowBallData:GetSingleActivityID()

	slot0:SelectModel(_G["pushSnowBallModel" .. slot0.activityID_] or slot0.modelType_ or uv0.SCORE)
	slot0:SetWindowBar()
	slot0:RefreshUI()
	slot0:AddTimer()
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE)
	manager.redPoint:bindUIandKey(slot0.deviceBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK)
	manager.redPoint:bindUIandKey(slot0.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 1)
	manager.redPoint:bindUIandKey(slot0.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 2)
	manager.redPoint:bindUIandKey(slot0.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 3)
	manager.redPoint:bindUIandKey(slot0.commonItemGo_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD)
end

function slot0.SetWindowBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/pushSnowBallMain")
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/home")
	end)
end

function slot0.OnTouchHero(slot0)
	slot3 = PushSnowBallGameMgr.GetInstance():GetPlayerEID()
	slot5 = DormHeroTemplate.PickInteractAction(GameDisplayCfg.dorm_interaction_stroke.value)
	slot6 = DormInteractSequence[slot5].name

	Dorm.DormEntityManager.SendInteractToEntityCMD(slot3, slot3, slot5, false)
	SDKTools.SendMessageToSDK("backhome_dorm_stroke", {
		hero_id = PushSnowBallData:GetSelectedHeroID(),
		activity_id = PushSnowBallData:GetActivityID()
	})
end

function slot0.GetWeeklyTaskList(slot0)
	return PushSnowBallData:GetWeeklyTaskList() or {}
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTaskList()
	slot0:RefreshHeroIcon()
	slot0:RefreshDeviceIcon()
	slot0:RefreshLockState()
end

function slot0.RefreshTaskList(slot0)
	slot1 = slot0:GetWeeklyTaskList() or {}
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	if table.isEmpty(slot1) then
		for slot6 = 1, 3 do
			SetActive(slot0.taskItemList_[slot6].gameObject, false)
		end
	else
		slot0:RefreshWeeklyTask()

		for slot6 = 1, 3 do
			slot0.taskItemList_[slot6]:SetData(slot6, slot2[slot6 + 1])
		end
	end
end

function slot0.RefreshWeeklyTask(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(slot0:GetWeeklyTaskList()) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	slot0.weeklyTaskID = slot2[1].id
	slot3 = AssignmentCfg[slot0.weeklyTaskID]
	slot4 = AssignmentCfg[slot0.weeklyTaskID].reward

	slot0.commonItem_:RefreshData({
		id = slot4[1][1],
		number = slot4[1][2]
	})
	slot0.commonItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, {
			uv0[1][1]
		})
	end)

	slot0.taskNumText_.text = slot2[1].progress .. "/" .. AssignmentCfg[slot0.weeklyTaskID].need
	slot5 = TaskData2:GetTaskComplete(slot0.weeklyTaskID)

	if not (AssignmentCfg[slot0.weeklyTaskID].need <= slot2[1].progress) then
		slot0.rewardController_:SetSelectedState("unfinished")
	elseif not slot5 then
		slot0.rewardController_:SetSelectedState("complete")
	else
		slot0.rewardController_:SetSelectedState("rewarded")
	end
end

function slot0.RefreshHeroIcon(slot0)
	slot0.heroIconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/BackHouseUI/RoleHead/" .. PushSnowBallData:GetSelectedHeroID())
end

function slot0.RefreshDeviceIcon(slot0)
	slot0.deviceController_:SetSelectedState(tostring(PushSnowBallData:GetSelectedDeviceID() ~= 0))

	if slot1 ~= 0 then
		slot0.deviceIconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Item_l" .. PushSnowBallDeviceCfg[PushSnowBallData:GetSelectedDeviceID()].icon)
	end
end

function slot0.RefreshLockState(slot0)
	for slot4 = 2, 3 do
		if not slot0:IsActiveTimeWithoutTips(ActivityData:GetActivityData(PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(slot4, 1))) then
			slot0.modelLockControllerList_[slot4 - 1]:SetSelectedState("true")
		else
			slot0.modelLockControllerList_[slot4 - 1]:SetSelectedState("false")
		end
	end

	if not slot0:IsActiveTimeWithoutTips(ActivityData:GetActivityData(PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(slot0.modelType_ or 1, 2))) then
		slot0.hardLockController_:SetSelectedState("true")

		slot0.lockText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot2.startTime, nil, true))
	else
		slot0.hardLockController_:SetSelectedState("false")
	end
end

function slot0.SelectModel(slot0, slot1)
	if not slot0:IsActiveTime(ActivityData:GetActivityData(PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(slot1, 1))) then
		return
	end

	if slot0.modelType_ then
		manager.redPoint:unbindUIandKey(slot0.hardLevelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. slot0.modelType_)
	end

	slot8 = slot1
	slot7 = RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. slot8

	manager.redPoint:bindUIandKey(slot0.hardLevelBtn_.transform, slot7)

	slot0.modelType_ = slot1

	for slot7, slot8 in ipairs(slot0.modelSelectControllerList_) do
		slot8:SetSelectedState(tostring(slot7 == slot1))
	end

	slot0.normalLevelImgController_:SetSelectedState(slot1)
	slot0.hardlLevelImgController_:SetSelectedState(slot1)

	slot0.modelNameText_.text = GetTips("ACTIVITY_SNOWBALL_PUSH_SINGLE_MOD_" .. slot0.modelType_)
	_G["pushSnowBallModel" .. slot0.activityID_] = slot0.modelType_
	slot0.levelType_ = _G["pushSnowBallLevel" .. slot0.modelType_ .. slot0.activityID_] or 1

	slot0:SelectLevel(slot0.levelType_)
	slot0.levelAni_:Play("Fx_panelItem_cx 1", 0, 0)
	slot0.levelAni_:Update(0)
end

function slot0.SelectLevel(slot0, slot1)
	if not slot0:IsActiveTime(ActivityData:GetActivityData(PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(slot0.modelType_, slot1))) then
		return
	end

	slot0.levelType_ = slot1
	slot7 = slot0.activityID_
	_G["pushSnowBallLevel" .. slot0.modelType_ .. slot7] = slot1

	for slot7, slot8 in ipairs(slot0.levelSelectControllerList_) do
		slot8:SetSelectedState(tostring(slot7 == slot1))
	end

	slot0:RefreshLockState()
	saveData("PushSnowBall", "Level" .. slot0.modelType_ .. PlayerData:GetPlayerInfo().userID, true)

	if slot1 == 2 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. slot0.modelType_, 0)
	end
end

function slot0.IsActiveTime(slot0, slot1)
	slot3 = slot1.stopTime

	if manager.time:GetServerTime() < slot1.startTime then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot2, nil, true)))

		return false
	end

	if slot3 <= manager.time:GetServerTime() then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function slot0.IsActiveTimeWithoutTips(slot0, slot1)
	slot3 = slot1.stopTime

	if manager.time:GetServerTime() < slot1.startTime then
		return false
	end

	if slot3 <= manager.time:GetServerTime() then
		return false
	end

	return true
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE)
	manager.redPoint:unbindUIandKey(slot0.deviceBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK)

	if slot0.modelType_ then
		manager.redPoint:unbindUIandKey(slot0.hardLevelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. slot0.modelType_)
	end

	manager.redPoint:unbindUIandKey(slot0.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 1)
	manager.redPoint:unbindUIandKey(slot0.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 2)
	manager.redPoint:unbindUIandKey(slot0.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 3)
	manager.redPoint:unbindUIandKey(slot0.commonItemGo_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD)
end

function slot0.OnTop(slot0)
	slot0:SetWindowBar()
	slot0:RefreshUI()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.AddTimer(slot0)
	slot3, slot4 = nil
	slot0.leftTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0.activityID_).stopTime, nil, true)

	if slot0.taskLeftTimeText_ then
		slot0.taskLeftTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(AssignmentCfg[slot0.weeklyTaskID].activity_id).stopTime, nil, true)
	end

	slot5 = PushSnowBallData:GetRefreshTimeStamp()
	slot0.timer_ = Timer.New(function ()
		if uv0 < manager.time:GetServerTime() then
			return
		end

		uv1:RefreshLockState()

		for slot3, slot4 in ipairs(uv2) do
			if manager.time:GetServerTime() == slot4 then
				uv1:RefreshTaskList()
			end
		end

		uv1.leftTimeText_.text = manager.time:GetLostTimeStr2(uv0, nil, true)

		if uv1.taskLeftTimeText_ then
			uv1.taskLeftTimeText_.text = manager.time:GetLostTimeStr2(uv3, nil, true)
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.taskItemList_) do
		slot5:Dispose()
	end

	slot0.taskItemList_ = nil

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
