slot0 = class("PushTheSnowBallHomeView", PushSnowBallSingleView)
slot1 = {
	SURVIVAL = 2,
	BOSS = 1
}

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballTeamModeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:BindController()

	slot0.taskItemList_ = {}

	for slot4 = 1, 4 do
		table.insert(slot0.taskItemList_, PushSnowBallTeamWinTaskItem.New(slot0["weeklyTaskItem" .. slot4]))
	end
end

function slot0.BindController(slot0)
	slot0.rewardController_ = ControllerUtil.GetController(slot0.transform_, "dailyRewardState")
	slot0.modelSelectControllerList_ = {}
	slot0.survivalSelectController_ = ControllerUtil.GetController(slot0.survivalModelBtn_.transform, "select")
	slot0.bossSelectController_ = ControllerUtil.GetController(slot0.bossModelBtn_.transform, "select")

	table.insert(slot0.modelSelectControllerList_, slot0.bossSelectController_)
	table.insert(slot0.modelSelectControllerList_, slot0.survivalSelectController_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.heroBtn_, nil, function ()
		JumpTools.OpenPageByJump("pushSnowBallHeroChangePop", {
			type = 2
		})
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		JumpTools.OpenPageByJump("pushSnowBallRank")
	end)
	slot0:AddBtnListener(slot0.touchHeroBtn_, nil, function ()
		uv0:OnTouchHero()
	end)
	slot0:AddBtnListener(slot0.modelDescBtn_, nil, function ()
		slot0 = GetTips(PushSnowBallData:GetTeamDescTipsByModelAndSubModel(uv0.modelType_))

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = slot0,
			key = slot0
		})
	end)
	slot0:AddBtnListener(slot0.survivalModelBtn_, nil, function ()
		uv0:SelectModel(uv1.SURVIVAL)
	end)
	slot0:AddBtnListener(slot0.bossModelBtn_, nil, function ()
		uv0:SelectModel(uv1.BOSS)
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		slot1 = PushSnowBallData:GetTeamModelActivityIDByModel(uv0.modelType_)
		slot4 = nil

		PushSnowBallAction.SendStartMatching(PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[slot1][1]].stageId, (PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[slot1][1]].mode ~= 4 or BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS) and BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL, PushSnowBallData:GetSelectedBattleModelID(), slot1)
	end)
	slot0:AddBtnListener(slot0.dailyRewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("pushSnowBallTeamTaskPop")
	end)
end

function slot0.OnEnter(slot0)
	slot0.modelType_ = _G.PushSnowBallTeamMode or 2
	slot0.activityID_ = PushSnowBallData:GetTeamActivityID()

	slot0:AddTimer()
	slot0:RefreshUI()
	slot0:SetWindowBar()
	slot0:SelectModel(_G["pushSnowBallModel" .. slot0.activityID_] or slot0.modelType_ or 1)
	manager.redPoint:bindUIandKey(slot0.dailyRewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE)
end

function slot0.OnTop(slot0)
	slot0:SetWindowBar()
	slot0:RefreshUI()
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.dailyRewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTaskList()
	slot0:RefreshHeroIcon()
end

function slot0.RefreshTaskList(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(PushSnowBallData:GetTeamWinTaskList()) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	if table.isEmpty(slot1) then
		for slot6 = 1, 4 do
			SetActive(slot0.taskItemList_[slot6].gameObject, false)
		end
	else
		for slot6 = 4, 1, -1 do
			slot0.taskItemList_[slot6]:SetData(slot6, slot2[slot6])
		end
	end

	slot6 = PushSnowBallData:GetHasAllRewardedTeamTask()
	slot0.dailyTaskScoreText_.text = PushSnowBallData:GetCompeletedTeamTaskNum() .. "<color=#86443C>/" .. #PushSnowBallData:GetTeamParticipateTaskList() .. "</color>"

	if not PushSnowBallData:GetHasCompeletedTeamTask() then
		slot0.rewardController_:SetSelectedState("uncomplete")
	elseif not slot6 then
		slot0.rewardController_:SetSelectedState("unreceive")
	else
		slot0.rewardController_:SetSelectedState("received")
	end
end

function slot0.SelectModel(slot0, slot1)
	if not slot0:IsActiveTime(ActivityData:GetActivityData(PushSnowBallData:GetTeamModelActivityIDByModel(slot1))) then
		return
	end

	slot0.modelType_ = slot1
	_G.PushSnowBallTeamMode = slot1

	for slot7, slot8 in ipairs(slot0.modelSelectControllerList_) do
		slot8:SetSelectedState(tostring(slot7 == slot1))
	end
end

function slot0.AddTimer(slot0)
	slot0.leftTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0.activityID_).stopTime, nil, true)
	slot0.timer_ = Timer.New(function ()
		if uv0 < manager.time:GetServerTime() then
			return
		end

		uv1.leftTimeText_.text = manager.time:GetLostTimeStr2(uv0, nil, true)
	end, 1, -1)

	slot0.timer_:Start()
end

return slot0
