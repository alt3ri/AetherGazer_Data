slot0 = class("CombineGameMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfModeUI_2"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.dailyController = ControllerUtil.GetController(slot0.dailyGo_.transform, "daily")
	slot0.endlessController = ControllerUtil.GetController(slot0.endlessGo_.transform, "endless")
	slot0.rewardController = ControllerUtil.GetController(slot0.dailyGo_.transform, "reward")
	slot0.commonItem = CommonItem.New(slot0.commonGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.poolBtn_, nil, function ()
		JumpTools.GoToSystem("/CombineGamePoolView")
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameTaskView")
	end)
	slot0:AddBtnListener(slot0.factorBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = uv0.endlessId
		})
	end)
	slot0:AddBtnListener(slot0.roleBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameRoleView", {
			lv = 999
		})
	end)
	slot0:AddBtnListener(slot0.tutorialBtn_, nil, function ()
		JumpTools.GoToSystem("/CombineGameTeachView")
	end)
	slot0:AddBtnListener(slot0.dailyBtn_, nil, function ()
		if uv0.isLock then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[uv0.idList[1]].name)))

			return
		end

		JumpTools.GoToSystem("/CombineGameDailyView")
	end)
	slot0:AddBtnListener(slot0.endlessBtn_, nil, function ()
		if uv0.isLock then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[uv0.idList[1]].name)))

			return
		end

		JumpTools.GoToSystem("/CombineGameEndlessView")
	end)
	slot0:AddBtnListener(slot0.tipsBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_COMBINE_GAME_DESC")
		})
	end)
	slot0.commonItem:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(slot0.activityId) then
		gameContext:Go("/home", nil, , true)
		ShowTips("TIME_OVER")

		return
	end

	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.UpdateView(slot0)
	slot1 = ActivityData:GetActivityData(CombineGameData:GetDataByPara("activityId"))
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime
	slot6 = nil
	slot0.remainTime_.text = manager.time:GetLostTimeStr2(slot0.stopTime_, slot6, true)
	slot5 = -1
	slot0.timer_ = Timer.New(function ()
		uv0.remainTime_.text = manager.time:GetLostTimeStr2(uv0.stopTime_, nil, true)
	end, 1, slot5)

	slot0.timer_:Start()

	slot0.idList = {}

	for slot5, slot6 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[slot5].type == CombineGameConst.TypeConst.TEACH then
			table.insert(slot0.idList, slot5)
		end

		if slot7.type == CombineGameConst.TypeConst.ENDLESS then
			slot0.endlessId = slot5
		end
	end

	slot0.isLock = false

	for slot6, slot7 in ipairs(slot0.idList) do
		if CombineGameData:GetDataByPara("stageDataTable")[slot7] ~= true then
			slot0.isLock = true
		end
	end

	slot0.id = CombineGameData:GetDataByPara("nowDay")
	slot0.cfg = ActivityCombineLevelCfg[slot0.id]
	slot3 = slot0.cfg.reward_list

	slot0.commonItem:RefreshData({
		id = slot3[1][1],
		number = slot3[1][2]
	})
	slot0.dailyController:SetSelectedState(slot0.isLock and "false" or "true")
	slot0.endlessController:SetSelectedState(slot0.isLock and "false" or "true")
	slot0.rewardController:SetSelectedState(CombineGameData:GetDataByPara("stageDataTable")[slot0.id] and "true" or "false")

	slot0.techTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_1")
	slot0.dailyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_2")
	slot0.endlessTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_3")
	slot0.poolTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
	slot0.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	slot0.titleName_.text = GetTips("ACTIVITY_COMBINE_GAME_NAME")
	slot0.titleDesc_.text = GetTips("ACTIVITY_COMBINE_GAME_CONTENT")
	slot0.dailyLockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[slot0.idList[1]].name))
	slot0.endlessLockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[slot0.idList[1]].name))
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.dailyBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId), {
		x = 360,
		y = 225
	})
	manager.redPoint:bindUIandKey(slot0.tutorialBtn_.transform, string.format("%s%s_TEACH", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId), {
		x = 170,
		y = 225
	})
	manager.redPoint:bindUIandKey(slot0.poolBtn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL, {
		x = 110,
		y = 35
	})
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK), {
		x = 110,
		y = 35
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.dailyBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId))
	manager.redPoint:unbindUIandKey(slot0.tutorialBtn_.transform, string.format("%s%s_TEACH", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId))
	manager.redPoint:unbindUIandKey(slot0.poolBtn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL)
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK))
end

function slot0.OnCombineGameRefresh(slot0)
	slot0.id = CombineGameData:GetDataByPara("nowDay")

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	slot0.commonItem:Dispose()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
