slot0 = import("game.tools.KagutsuchiMapGenerator")
slot1 = import("manager.windowBar.WindowCurrencyItem")
slot2 = class("KagutsuchiWorkView", ReduxView)

function slot2.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkUI"
end

function slot2.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot2.OnCtor(slot0)
	slot0.mapGrids = {}
	slot0.mapGridGos = {}
	slot0.seed_ = 1
end

function slot2.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:RegistEventListener(NEW_DAY, handler(slot0, slot0.OnNewDay))

	slot0.transformList_ = slot0:GetTransformList()
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.rewardUiList_, CommonItem)
	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollViewGo_)

	slot0.scrollMoveView_:RemoveListeners()

	slot1 = slot0.workContentGo_.transform.localPosition
	slot0.leftX_ = slot1.x
	slot0.rightX_ = slot1.x + 1000
	slot2 = uv0.New(slot0.token1Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)

	slot2:SetActive(true)
	slot2:SetCanAdd(false)
	slot2:SetCanClick(true)

	slot0.token1_ = slot2
	slot3 = uv0.New(slot0.token2Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)

	slot3:SetActive(true)
	slot3:SetCanAdd(false)
	slot3:SetCanClick(true)

	slot0.token2_ = slot3
	slot0.clearController = ControllerUtil.GetController(slot0.dispatchInfoTrs_, "clear")
	slot0.battleController = ControllerUtil.GetController(slot0.battleBtnTrs_, "name")
	slot0.dispatchController = ControllerUtil.GetController(slot0.dispatchBtnTrs_, "name")
end

function slot2.OnEnter(slot0)
	slot0:InitBar()
	slot0:RefreshUI()

	slot1 = slot0:GetActivityID()

	manager.redPoint:bindUIandKey(slot0.talentBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, ActivityTools.GetRedPointKey(slot1) .. slot1))

	slot0.lastClickGrid_ = nil

	slot0:AddTimer()
	slot0:RefreshScrollRect(false, true)
end

function slot2.InitBar(slot0)
end

function slot2.OnExit(slot0)
	slot1 = slot0:GetActivityID()

	manager.redPoint:unbindUIandKey(slot0.talentBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, ActivityTools.GetRedPointKey(slot1) .. slot1))

	if slot0.lastClickGrid_ then
		slot0.lastClickGrid_:SetSelected(false)
	end

	slot0:StopTimer()
end

function slot2.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.mapGrids) do
		slot5:Dispose()
	end

	uv0:Clear()
	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil

	slot0.rewardList_:Dispose()
	slot0.token1_:Dispose()
	slot0.token2_:Dispose()
	uv1.super.Dispose(slot0)
end

function slot2.AddListeners(slot0)
	slot0:AddBtnListener(slot0.gachaBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("activity_kagutsuchi_draw2")
		JumpTools.OpenPageByJump("/kagutsuchiGacha", {})
	end)
	slot0:AddBtnListener(slot0.talentBtn_, nil, function ()
		slot0 = uv0:GetActivityID()

		if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, ActivityTools.GetRedPointKey(slot0) .. slot0)) then
			KagutsuchiTalentAction:BanRedPoint(slot2)
		end

		JumpTools.OpenPageByJump("/kagutsuchiTalent", {})
	end)
	slot0:AddBtnListener(slot0.workMaskBtn_, nil, function ()
		uv0:OnClickBackground()
	end)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0:GetActivityID()) then
			return
		end

		if uv0.lastClickGrid_ then
			if not uv0.lastClickGrid_:GetPlayGridData():IsBattle() then
				return
			end

			if KagutsuchiWorkData:GetStamina() < uv0.playGridParams_.battleCost then
				ShowTips("ACTIVITY_KAGUTSUCHI_BATTLE_COST_NOT_ENOUGH")

				return
			end

			gameContext:Go("/kagutsuchiSectionSelectHero", {
				section = uv0.playGridParams_.stageId,
				sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME,
				activityID = uv0.playGridParams_.activityId
			})
		end
	end)
	slot0:AddBtnListener(slot0.entrustBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0:GetActivityID()) then
			return
		end

		function uv0.playGridParams_.entrustFinishHandler_()
			if uv0.lastClickGrid_ then
				uv0.lastClickGrid_:RefreshUI()
			end

			uv0:OnClickBackground()
			uv0:RefreshUI()
		end

		if uv0.lastClickGrid_ then
			if uv0.lastClickGrid_:GetPlayGridData():IsCleared() then
				return
			end

			JumpTools.OpenPageByJump("kagutsuchiWorkPop", uv0.playGridParams_)
		end
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.homeBtn_, nil, function ()
		gameContext:Go("/home", nil, , true)
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		slot0 = "ACTIVITY_KAGUTSUCHI_BATTLE_DESCRIBE"

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

function slot2.OnClickBackground(slot0)
	if slot0.lastClickGrid_ then
		slot0.lastClickGrid_:SetSelected(false)

		slot0.lastClickGrid_ = nil
	end

	slot0:RefreshScrollRect(false)
end

function slot2.GetTransformList(slot0)
	slot1 = {}

	slot0.mapGridsGo_:InjectUI(slot1)

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, slot7)
	end

	return slot2
end

function slot2.UpdateMap(slot0)
	uv0:SetMapSize(20, 20)
	uv0:SetMapSeed(KagutsuchiWorkData:GetMapSeed() + slot0.seed_)
	uv0:SetMapGrids(slot0.transformList_, handler(slot0, slot0.CreateMapItem), handler(slot0, slot0.Transform2Xy))
	uv0:GeneratePlaceableGrids(KagutsuchiWorkData:GetPlayGridNum(), handler(slot0, slot0.ModifyMapItem))
end

function slot2.ResetMap(slot0)
	slot0:OnClickBackground()

	for slot4, slot5 in pairs(slot0.mapGrids) do
		slot5:Dispose()
	end

	for slot4, slot5 in pairs(slot0.mapGridGos) do
		Object.Destroy(slot5)
	end

	slot0.mapGrids = {}
	slot0.mapGridGos = {}

	uv0:Clear()
end

function slot2.CreateMapItem(slot0, slot1)
	slot2 = slot1.transform.gameObject

	slot2:SetActive(true)

	slot3 = KagutsuchiWorkMapGrid.New(slot2, handler(slot0, slot0.CreatePlayGridGo))

	slot3:SetClickHandler(handler(slot0, slot0.OnClickPlayGrid))
	table.insert(slot0.mapGrids, slot3)

	return slot3
end

function slot2.CreatePlayGridGo(slot0, slot1, slot2)
	slot3 = Object.Instantiate(slot0.playGridGo_, slot1)

	slot3:SetActive(true)
	table.insert(slot0.mapGridGos, slot3)

	return slot3
end

function slot2.ModifyMapItem(slot0, slot1)
	slot1.grid:BindPlayGrid(slot1.index)
end

function slot2.OnClickPlayGrid(slot0, slot1, slot2)
	if slot0.lastClickGrid_ == slot1 then
		return
	end

	if slot0.lastClickGrid_ then
		slot0.lastClickGrid_:SetSelected(false)
	end

	slot0.playGridParams_ = slot2
	slot0.lastClickGrid_ = slot1

	slot0:RefreshGridInfo()
end

function slot2.IndexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number,
			0
		})
	end)

	slot3 = ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id]

	slot2:RefreshData({
		id = slot3.id,
		type = slot3.type,
		number = slot0.rewardNumber_
	})
end

function slot2.RefreshUI(slot0)
	KagutsuchiTalentAction:UpdateRedPoint(slot0:GetActivityID())

	slot0.coinText_.text = KagutsuchiWorkData:GetCoins()
	slot0.staminaText_.text = KagutsuchiWorkData:GetStamina()
	slot0.coinImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)
	slot0.staminaImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
	slot0.upgradeConditionText_.text = KagutsuchiWorkData:GetUpgradeConditionText()

	SetActive(slot0.unclearTextGo_, not KagutsuchiWorkData:IsUpgraded())
	SetActive(slot0.clearTextGo_, KagutsuchiWorkData:IsUpgraded())
	SetActive(slot0.upgradeBoxGo_, not KagutsuchiWorkData:IsMaxLevel())
	slot0:UpdateMap()
end

function slot2.RefreshGridInfo(slot0)
	SetActive(slot0.workContentGo_, true)

	if slot0.playGridParams_.isBattle then
		slot0.titleText_.text = slot0.playGridParams_.battleName
		slot0.levelText_.text = "Lv." .. slot0.playGridParams_.battleLevel
		slot0.summaryText_.text = slot0.playGridParams_.battleSummary
		slot0.costImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
		slot0.costText_.text = "x" .. slot0.playGridParams_.battleCost
		slot3 = slot1:GetBattleMinTime()
		slot0.minTimeText_.text = string.format("%02d:%02d", math.floor(slot3 / 60), math.fmod(slot3, 60))

		slot0.clearController:SetSelectedState(slot0.lastClickGrid_:GetPlayGridData():IsCleared() and "true" or "false")
		slot0.battleController:SetSelectedState("false")

		slot0.rewardNumber_ = slot0.playGridParams_.battleReward

		SetActive(slot0.battleGo_, true)
		SetActive(slot0.costGo_, true)
		SetActive(slot0.levelGo_, true)
		SetActive(slot0.entrustGo_, false)
	else
		slot0.titleText_.text = slot0.playGridParams_.entrustName
		slot0.levelText_.text = ""
		slot0.summaryText_.text = slot0.playGridParams_.entrustSummary
		slot0.rewardNumber_ = slot0.playGridParams_.entrustReward

		slot0.clearController:SetSelectedState("false")
		slot0.battleController:SetSelectedState(slot2 and "true" or "false")
		SetActive(slot0.battleGo_, false)
		SetActive(slot0.costGo_, false)
		SetActive(slot0.levelGo_, false)
		SetActive(slot0.entrustGo_, not slot2)
	end

	slot0.rewardList_:StartScroll(slot0.rewardNumber_ > 0 and 1 or 0)
	slot0:RefreshScrollRect(true)
end

function slot2.RefreshScrollRect(slot0, slot1, slot2)
	if slot1 then
		if not slot0.mapTimer_ then
			slot0.mapTimer_ = Timer.New(function ()
				uv0:StopMapTimer()
				uv0.scrollMoveView_:RefreshUI(uv1 and uv0:GetScrollPos() or uv0:GetScrollWidth() / 2, uv0:GetScrollWidth(), uv2)
			end, 0.2, 1)

			slot0.mapTimer_:Start()
		end
	else
		slot3()
	end

	if slot0.workContentAni_ and slot0.workContentAni_.runtimeAnimatorController then
		slot0.workContentAni_:SetFloat("Direction", slot1 and 1 or -1)
		slot0.workContentAni_:Play("Fx_right_cx", -1, math.min(math.max(slot0.workContentAni_:GetCurrentAnimatorStateInfo(0).normalizedTime, 0), 1))
	else
		LeanTween.moveLocalX(slot0.workContentGo_, slot1 and slot0.leftX_ or slot0.rightX_, 0.2)
	end
end

function slot2.RefreshTimeUI(slot0)
	slot0.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0:GetActivityID()).stopTime)
	slot0.mapUpdateText_.text = manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime())
	slot0.bossTimeText_.text = manager.time:GetLostTimeStr2(KagutsuchiWorkData:GetNextBossTime())

	SetActive(slot0.bossTimeGo_, not KagutsuchiWorkData:IsBossDay())
end

function slot2.IsOpenSectionInfo(slot0)
	return false
end

function slot2.GetScrollWidth(slot0)
	return slot0.mapGridsGo_.transform.rect.width
end

function slot2.GetScrollPos(slot0)
	return slot0.lastClickGrid_:GetPosition().x
end

function slot2.OnNewDay(slot0)
	slot0:ResetMap()
	slot0:RefreshUI()
end

function slot2.OnKagutsuchiWorkDataInit(slot0)
	slot0:OnNewDay()
end

function slot2.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTimeUI()

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshTimeUI()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot2.StopTimer(slot0)
	slot0:StopMapTimer()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot2.StopMapTimer(slot0)
	if slot0.mapTimer_ ~= nil then
		slot0.mapTimer_:Stop()

		slot0.mapTimer_ = nil
	end
end

function slot2.GetActivityID(slot0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function slot2.Transform2Xy(slot0, slot1)
	slot2 = slot1.anchoredPosition
	slot3 = slot1.rect
	slot4 = {
		slot1.rect.width / 2,
		slot1.rect.height / 2
	}

	return math.floor(slot2.x / (slot3.width + slot4[1])) + 1, math.floor(slot2.y / (slot3.height + slot4[2])) + 1
end

return slot2
