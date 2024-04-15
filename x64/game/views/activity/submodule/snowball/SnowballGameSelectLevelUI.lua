slot0 = class("SnowballGameSelectLevelUI", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameSelectLevelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

slot1 = {
	hard = 2,
	inf = 3,
	normal = 1
}
slot2 = -1

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AdaptScreen()
	slot0:InitLevels()

	slot0.readyController = ControllerUtil.GetController(slot0.transform_, "levelSelected")
	slot0.hardLevelLockedController = ControllerUtil.GetController(slot0.transform_, "hardLevelLocked")
	slot0.modeController = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.hardLevelBonusController = ControllerUtil.GetController(slot0.transform_, "bonus")
	slot0.showLevelCostController = ControllerUtil.GetController(slot0.transform_, "cost")
	slot0.lastSelect = {}

	slot0:AddBtnListener(slot0.normalBtn_, nil, function ()
		if uv0.select == uv1 then
			return
		end

		if uv0.mode ~= uv2.normal then
			uv0.modeChangeAnimator_:Play("normal")
		end

		uv0.mode = uv2.normal
		uv0.select = nullable(uv0.lastSelect, uv2.normal) or 1

		uv0:RefreshLevelsUI()
	end)
	slot0:AddBtnListener(slot0.hardBtn_, nil, function ()
		if uv0.select == uv1 then
			return
		end

		if not uv0:CheckAnyHardLevelUnlocked() then
			ShowTips("ACTIVITY_SNOWBALL_LEVEL_MODE_TIPS")

			return
		end

		if uv0.mode ~= uv2.hard then
			uv0.modeChangeAnimator_:Play("hard")
		end

		uv0.mode = uv2.hard
		uv0.select = nullable(uv0.lastSelect, uv2.hard) or 1

		uv0:RefreshLevelsUI()
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, handler(slot0, slot0.GoToGame))
	slot0:AddBtnListener(slot0.iceBtn_, nil, function ()
		JumpTools.OpenPageByJump("/SnowBallInfinityMainView", {
			activityID = SnowballGameData.activityID
		})
	end)
	slot0:AddBtnListener(slot0.changePlayerBtn_, nil, function ()
		JumpTools.OpenPageByJump("/snowballGameChangePlayer")
	end)
	slot0:AddBtnListener(slot0.questBtn_, nil, function ()
		JumpTools.OpenPopUp("snowballQuestPopup")
	end)
end

function slot3(slot0, slot1, slot2)
	slot3 = {}

	slot0:BindCfgUI(slot1, slot3)

	slot3.idx = slot2
	slot3.difficultyController = ControllerUtil.GetController(slot1.transform, "difficulty")
	slot3.modeController = ControllerUtil.GetController(slot1.transform, "mode")
	slot3.selectController = ControllerUtil.GetController(slot1.transform, "select")

	slot0:AddBtnListener(slot3.btn_, nil, function ()
		if uv0.CheckLevel(uv1:GetLevel(uv2), false, true) then
			uv1.select = uv2

			if uv2 == uv3 then
				uv1.lastSelect[uv4.inf] = uv2
			else
				uv1.lastSelect[uv1.mode] = uv2
			end

			uv1:RefreshLevelsUI()
		end
	end)

	return slot3
end

function slot0.InitLevels(slot0)
	slot0.levels = {}

	for slot4 = 1, slot0.levelsRoot_.childCount do
		slot0.levels[slot4] = uv0(slot0, GameObject.Instantiate(slot0.levelPrefab_, slot0.levelsRoot_:GetChild(slot4 - 1)), slot4)
	end

	slot1 = uv0(slot0, slot0.infLevelBtn_.gameObject, uv1)
	slot1.lockByTime = ControllerUtil.GetController(slot0.infLevelBtn_.transform, "lockByTime")
	slot0.levels[uv1] = slot1
end

function slot0.StartTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTimeText()

	if slot0.infLevelStop < manager.time:GetServerTime() then
		return
	end

	slot1 = manager.time:GetServerTime() < slot0.infLevelStart
	slot0.timer = Timer.New(function ()
		if uv0.infLevelStop < manager.time:GetServerTime() then
			uv0:RefreshLevelsUI()
		elseif uv1 and uv0.infLevelStart <= slot0 then
			uv1 = false

			uv0:RefreshLevelsUI()
		end

		uv0:RefreshTimeText()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.RefreshTimeText(slot0)
	slot0.levels[uv0].lockByTime:SetSelectedState(ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SNOWBALL_INF_LEVEL) and "false" or "true")

	slot0.activityCountdown_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(SnowballGameData.activityID).stopTime, nil, true)

	if not slot2 and slot0.infLevelCountdown_ then
		slot0.infLevelCountdown_.text = manager.time:GetLostTimeStr2(slot0.infLevelStart)
	end
end

function slot0.OnEnter(slot0)
	slot2 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SNOWBALL_INF_LEVEL)
	slot0.infLevelStart = slot2.startTime
	slot0.infLevelStop = slot2.stopTime
	slot0.mode = slot0.mode or uv0.normal

	if uv1.CheckLevel(slot0:GetLevel(slot0.select or 1), false, false) then
		slot0.select = slot3
	else
		slot0.select = nil
	end

	slot0:RefreshLevelsUI()
	slot0:StartTimer()
	slot0:RegistEventListener(ACTIVITY_UPDATE, handler(slot0, slot0.OnActivityUpdate))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_UNCOMPLETE_LEVEL, 0)
	manager.redPoint:bindUIandKey(slot0.iceBtn_.transform, SnowballGameData:GetInfPoolRedPointKey(1))
	manager.redPoint:bindUIandKey(slot0.questBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:StopTimer()
	manager.redPoint:unbindUIandKey(slot0.iceBtn_.transform, SnowballGameData:GetInfPoolRedPointKey(1))
	manager.redPoint:unbindUIandKey(slot0.questBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN,
		MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN
	})
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN, true)
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SNOWBALL_DESC")
	manager.windowBar:RegistBackCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		ActivityTools.JumpBackToActivityMainViewByActivityID(SnowballGameData.activityID)
	end)
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.GetLevel(slot0, slot1)
	if slot1 == uv0 then
		return nullable(SnowballGameCfg.get_id_list_by_level_mode, uv1.inf, 1)
	end

	return nullable(SnowballGameCfg.get_id_list_by_level_mode[slot0.mode], slot1)
end

function slot0.LevelLocked(slot0, slot1)
	return not SnowballGameData:IsLevelUnlocked(slot1)
end

function slot0.LevelComplted(slot0, slot1)
	return SnowballGameData:GetLevelHighScore(slot1)
end

function slot0.OnActivityUpdate(slot0, slot1)
	if ActivityTools.GetActivityType(slot1) == ActivityTemplateConst.MINIGAME_STAGE then
		slot0:RefreshLevelsUI()
	end
end

function slot0.RefreshLevelsUI(slot0)
	slot1 = slot0:GetLevel(slot0.select)

	slot0.hardLevelLockedController:SetSelectedState(slot0:CheckAnyHardLevelUnlocked() and "false" or "true")

	if slot0.select ~= uv0 then
		slot0.modeController:SetSelectedState(slot0.mode == uv1.normal and "normal" or "hard")
	else
		slot0.modeController:SetSelectedState("lock")
	end

	for slot5, slot6 in pairs(slot0.levels) do
		if slot6.difficultyController then
			slot6.difficultyController:SetSelectedState(slot0.mode == uv1.normal and "normal" or "hard")
		end

		slot6.selectController:SetSelectedState(slot0.select == slot5 and "true" or "false")

		slot7 = slot0:GetLevel(slot5)
		slot8 = slot0:LevelComplted(slot7)

		if slot7 == nil or slot0:LevelLocked(slot7) then
			slot6.modeController:SetSelectedState("lock")
		elseif slot8 then
			slot6.modeController:SetSelectedState("completed")

			slot6.score_.text = slot8
		else
			slot6.modeController:SetSelectedState("unlock")

			if SnowballGameData:IsLevelFirstUnlocked(slot7) then
				DormUtils.CallOnNextUpdate(function ()
					uv0.unlockAnimator_:Play("unlock")
				end)
				SnowballGameData:CacheLevelAlreadyUnlocked(slot7)
			end
		end

		slot6.name_.text = SnowballGameCfg[slot7].level_name
	end

	slot0.readyController:SetSelectedState(slot1 == nil and "false" or "true")

	if slot1 then
		slot2 = SnowballGameCfg[slot1]
		slot4 = slot2.level_mode

		if slot2.level_cost[1] == nil then
			slot0.showLevelCostController:SetSelectedState("hide")
		else
			slot0.showLevelCostController:SetSelectedState("show")

			slot0.consumeIcon_.sprite = ItemTools.getItemLittleSprite(slot3[1])
			slot0.consumeText_.text = "x" .. slot3[2]
		end

		slot5 = GameSetting.activity_snowball_score_difficulty_factor.value[slot4] or 1

		slot0.hardLevelBonusController:SetSelectedState(slot5 ~= 1 and "on" or "off")

		slot0.bonus_.text = "x" .. slot5
	end
end

function slot0.CheckLevel(slot0, slot1, slot2)
	slot3, slot4, slot5 = SnowballGameData:IsLevelUnlocked(slot0, slot2)

	if slot3 then
		if not slot1 or SnowballGameData:CheckLevelCost(slot0) then
			return true
		elseif slot2 then
			manager.tips:ShowTips(GetTipsF("ACTIVITY_SNOWBALL_LEVEL_COST_FAILED", ItemTools.getItemName(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN)))
		end
	elseif slot2 and slot4 == SnowballGameData.LevelLockReason.NEED_UNLOCK_OTHER_LEVEL then
		manager.tips:ShowTips(GetTipsF("ACTIVITY_SNOWBALL_LEVEL_LOCKED", SnowballGameCfg[slot5].level_desc))
	end

	return false
end

function slot0.CheckAnyHardLevelUnlocked(slot0)
	slot4 = uv0.hard

	for slot4, slot5 in ipairs(SnowballGameCfg.get_id_list_by_level_mode[slot4]) do
		if uv1.CheckLevel(slot5) then
			return true
		end
	end

	return false
end

function slot0.GoToGame(slot0)
	if uv0.CheckLevel(slot0:GetLevel(slot0.select), true, true) then
		JumpTools.OpenPageByJump("/snowballGameEnterUI", {
			level = slot1
		})
	end
end

return slot0
