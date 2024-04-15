slot0 = class("SailMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesGameUI"
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

	slot0.buildingList_ = {}
	slot2 = nil

	for slot6 = 1, slot0.buildingContentTrans_.childCount do
		slot0.buildingList_[slot6] = SailBuildingItem.New(slot0.buildingContentTrans_:GetChild(slot6 - 1).gameObject)
	end

	slot0.sailCountController_ = ControllerUtil.GetController(slot0.transform_, "sailCount")
	slot0.gameStatusCountController_ = ControllerUtil.GetController(slot0.transform_, "gameStatus")
	slot0.coinIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
	slot0.animTimerList_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SailGameData:SetSelectedSailBtn(uv0.activityID_)

		if SailGameData:GetCurGameData(uv0.activityID_).gameState ~= SailGameConst.GAME_STATUS.RUNNING then
			if SailGameData:GetSailCount(uv0.activityID_) < 1 then
				ShowTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_NOT_ENOUGH")

				return
			end

			SailGameAction.StartGame(uv0.activityID_)
		else
			SailGameTools.GoToGameView(uv0.activityID_)
		end
	end)
	slot0:AddBtnListener(slot0.upgradeBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if SailGameData:GetIslandLevel(uv0.activityID_) >= #SailGameIslandLevelCfg.get_id_list_by_activity_id[uv0.activityID_] then
			ShowTips("ACTIVITY_SKADI_SEA_LEVEL_MAX_TIP")

			return
		end

		JumpTools.OpenPageByJump("sailUpgradeIsland", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.islandRewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("sailIslandReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.coinBtn_, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id,
			0
		})
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.mainBtn_, nil, function ()
		gameContext:Go("/home", nil, , true)
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKADI_SEA_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:AddTimer()
	slot0:RefreshUI()
	slot0:BindRedPoint()
	SetActive(slot0.coinVaryGo_, false)
end

function slot0.OnTop(slot0)
	slot0.coinNumText_.text = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	slot0:StopSailTimer()
	slot0:StopAllAnimTimer()

	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end

	slot0:UnBindRedPoint()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.buildingList_) do
		slot5:Dispose()
	end

	slot0.buildingList_ = nil

	slot0:StopTimer()
	slot0:StopSailTimer()
	slot0:StopAllAnimTimer()

	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshBuilding()
	slot0:RefreshIslandLevel()
	slot0:RefreshSailCount()
	slot0.gameStatusCountController_:SetSelectedState(SailGameData:GetCurGameData(slot0.activityID_).gameState == SailGameConst.GAME_STATUS.RUNNING and "on" or "off")
end

function slot0.RefreshBuilding(slot0)
	for slot5, slot6 in ipairs(SailGameBuildingCfg.get_id_list_by_activity_id[slot0.activityID_]) do
		slot0.buildingList_[slot5]:SetData(slot6, slot0.activityID_)
	end
end

function slot0.RefreshIslandLevel(slot0)
	slot0.islandLevelText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_ISLAND_LEVEL_TIP"), NumberTools.IntToRomam(SailGameData:GetIslandLevel(slot0.activityID_)))
end

function slot0.RefreshSailCount(slot0)
	slot1 = false
	slot2 = SailGameData:GetSailCount(slot0.activityID_)
	slot3 = GameSetting.activity_skadi_sea_be_out_num_max.value[1]
	slot0.sailCountText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_TIP"), slot2, slot3)
	slot0.sailCountText2_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_TIP"), slot2, slot3)

	if slot2 < slot3 then
		slot0.nextRefreshSailCountTime_ = SailGameTools.GetNextRecoverTimeStep(slot0.activityID_)

		if slot0.nextRefreshSailCountTime_ ~= -1 and manager.time:GetServerTime() < slot0.stopTime_ then
			slot1 = true

			slot0:AddSailTimer()
		else
			slot1 = false
		end
	else
		slot1 = false

		slot0:StopSailTimer()
	end

	slot0.sailCountController_:SetSelectedState(slot1 and "on" or "off")
end

function slot0.OnBuildingUnlock(slot0)
	slot0:RefreshBuilding()
end

function slot0.OnIslandUpgrade(slot0)
	slot0:RefreshBuilding()
	slot0:RefreshIslandLevel()
end

slot1 = 0.6

function slot0.OnReceivedBuildingReward(slot0, slot1)
	slot0:RefreshBuilding()

	slot0.coinVaryText_.text = "+" .. slot1

	SetActive(slot0.coinVaryGo_, true)

	slot0.coinAnim_.enabled = true

	slot0:PlayAnim("XH3rdVoyagesGameUI_text", slot0.coinAnim_, function ()
		SetActive(uv0.coinVaryGo_, false)
		uv0:PlayCurrencyRollAnim(uv1)
		uv0:PlayAnim("XH3rdVoyagesGameUI_coin", uv0.coinAnim_, function ()
			uv0.coinAnim_.enabled = false
		end)
	end)
end

function slot0.PlayCurrencyRollAnim(slot0, slot1)
	slot2 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id) - slot1
	slot0.tween_ = LeanTween.value(0, 1, uv0):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv2.coinNumText_.text = tostring(math.floor((uv0 or 0) + uv1 * slot0))
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.tween_ then
			uv0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(uv0.tween_.id)

			uv0.tween_ = nil
		end

		uv0.coinNumText_.text = uv1 + uv2
	end)):setEase(LeanTweenType.easeOutQuad)
end

function slot0.PlayAnim(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	slot2:Play(slot1, -1, 0)
	slot2:Update(0)
	slot0:StopAnimTimer(slot1)

	slot0.animTimerList_[slot1] = Timer.New(function ()
		if uv0:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			uv2:StopAnimTimer(uv1)

			if uv3 then
				uv3()
			end
		end
	end, 0.033, -1)

	slot0.animTimerList_[slot1]:Start()
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.remainTimeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		slot1 = manager.time
		slot3 = slot1
		slot4 = uv0.stopTime_
		uv0.remainTimeText_.text = slot1.GetLostTimeStr(slot3, slot4)

		for slot3, slot4 in ipairs(uv0.buildingList_) do
			slot4:RefreshTime()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddSailTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() or slot0.nextRefreshSailCountTime_ <= manager.time:GetServerTime() then
		return
	end

	slot0.leftTime_ = slot0.nextRefreshSailCountTime_ - manager.time:GetServerTime()
	slot0.sailCountTimeText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_ADD_TIP"), manager.time:DescCDTime(slot0.leftTime_))

	slot0:StopSailTimer()

	slot0.sailCountTimer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() or uv0.nextRefreshSailCountTime_ <= manager.time:GetServerTime() then
			uv0:StopSailTimer()
			uv0:RefreshSailCount()

			return
		end

		uv0.sailCountTimeText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_ADD_TIP"), manager.time:DescCDTime(uv0.leftTime_))
		uv0.leftTime_ = uv0.leftTime_ - 1
	end, 1, -1)

	slot0.sailCountTimer_:Start()
end

function slot0.StopSailTimer(slot0)
	if slot0.sailCountTimer_ then
		slot0.sailCountTimer_:Stop()

		slot0.sailCountTimer_ = nil
	end
end

function slot0.StopAllAnimTimer(slot0)
	for slot4, slot5 in pairs(slot0.animTimerList_) do
		slot0.animTimerList_[slot4]:Stop()

		slot0.animTimerList_[slot4] = nil
	end
end

function slot0.StopAnimTimer(slot0, slot1)
	if slot0.animTimerList_[slot1] then
		slot0.animTimerList_[slot1]:Stop()

		slot0.animTimerList_[slot1] = nil
	end
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, string.format("%s_%s", RedPointConst.SAIL_GAME_COUNT, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.islandRewardBtn_.transform, string.format("%s_%s", RedPointConst.SAIL_GAME_TASK, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.upgradeBtn_.transform, string.format("%s_%s", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, slot0.activityID_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, string.format("%s_%s", RedPointConst.SAIL_GAME_COUNT, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.islandRewardBtn_.transform, string.format("%s_%s", RedPointConst.SAIL_GAME_TASK, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.upgradeBtn_.transform, string.format("%s_%s", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, slot0.activityID_))
end

return slot0
