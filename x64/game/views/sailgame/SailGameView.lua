slot0 = class("SailBuildingView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.coinIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
	slot0.animTimerList_ = {}
	slot0.maxTime_ = GameSetting.activity_skadi_sea_total_time.value[1]
	slot0.pauseHandler_ = handler(slot0, slot0.OnPause)
	slot0.triggerEventHandler_ = handler(slot0, slot0.OnTriggerEvent)
	slot0.triggerTipsHandler_ = handler(slot0, slot0.OnTriggerTips)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	if isNil(SailGameManager.Instance) then
		SailGameTools.GoToGameView(slot0.activityID_)
	end

	manager.ui:SetMainCamera("sailGame")

	manager.ui.mainCameraCom_.orthographic = true

	slot0:RegistEventListener(ACTIVITY_UPDATE, handler(slot0, slot0.OnActivityUpdate))
end

function slot0.OnTop(slot0)
	SetActive(slot0.eventTriggerGo_, false)
	SetActive(slot0.tipsGo_, false)
	SetActive(slot0.coinVaryGo_, false)
	slot0:GameStart()

	slot0.curGameData_ = SailGameData:GetCurGameData(slot0.activityID_)

	slot0:UpdateBar()

	if SailGameData:GetEventEndMark(slot0.activityID_).isEnd == true then
		slot0:OnEventEnd(slot1)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopAllAnimTimer()
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		SailGameManager.Instance:SetGamePause(true)

		slot0 = uv0.activityID_

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_SKADI_SEA_BE_OUT_EXIT"),
			OkCallback = function ()
				SailGameAction.GiveUp(uv0)
			end,
			CancelCallback = function ()
				SailGameManager.Instance:SetGamePause(false)
			end,
			MaskCallback = function ()
				SailGameManager.Instance:SetGamePause(false)
			end
		})
	end)
end

function slot0.UpdateBar(slot0)
	slot0.coinNumText_.text = SailGameData:GetTempCurrency(slot0.activityID_).lastNum
end

function slot0.Dispose(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end

	slot0:StopAllAnimTimer()
	SailGameTools.ShutDown()

	slot0.pauseHandler_ = nil
	slot0.triggerEventHandler_ = nil
	slot0.triggerTipsHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitGame(slot0)
	SailGameManager.Instance:SetGamePauseHandler(slot0.pauseHandler_)
	SailGameManager.Instance:SetTriggerEventHandler(slot0.triggerEventHandler_)
	SailGameManager.Instance:SetTriggerTipsHandler(slot0.triggerTipsHandler_)
end

function slot0.GameStart(slot0)
	if not SailGameManager.Instance:IsRunning() then
		slot0:InitGame()
		SailGameManager.Instance:GameStart()
	else
		SailGameManager.Instance:SetGamePause(false)
	end

	slot0:RecoverAnim()
end

function slot0.GoToEventView(slot0)
	slot4 = 0

	JumpTools.OpenPageByJump(SailGameConst.EVENT_VIEW_ROUTE[(not SailGameEventCfg[slot0.curGameData_.eventList[slot0.curGameData_.curStageIndex].id] or SailGameEventCfg[slot3].type) and 0], {
		activityID = slot0.activityID_,
		stageIndex = slot1,
		eventID = slot3
	})
end

function slot0.OnPause(slot0, slot1)
	if slot1 == true then
		slot0:PauseAnim()
	else
		slot0:RecoverAnim()
	end
end

function slot0.OnTriggerTips(slot0, slot1)
	if SailGameConst.GAME_TIME_TIPS[slot1] then
		slot0.gameTipsText_.text = GetTips(SailGameConst.GAME_TIME_TIPS[slot1])

		slot0:PlayTipsAnim()
	end
end

function slot0.OnTriggerEvent(slot0, slot1)
	slot0:PlayEventAnim(slot0.curGameData_.curStageIndex == #slot0.curGameData_.eventList and 0 or slot0.curGameData_.eventList[slot2].id, function ()
		uv0:GoToEventView()
	end)
end

function slot0.OnEventEnd(slot0, slot1)
	slot0:UpdateCurrency()

	if slot1.tipsIndex then
		slot0.gameTipsText_.text = SailGameEventCfg[slot0.curGameData_.eventList[slot1.stageIndex].id].tip[slot2]

		slot0:PlayTipsAnim()
	end
end

function slot0.UpdateCurrency(slot0)
	slot1 = SailGameData:GetTempCurrency(slot0.activityID_)

	if slot1.curNum - slot1.lastNum > 0 then
		slot0.coinVaryText_.text = "+" .. slot4

		SetActive(slot0.coinVaryGo_, true)

		slot0.coinAnim_.enabled = true

		slot0:PlayAnim("XH3rdVoyagesGameUI_text", slot0.coinAnim_, function ()
			SetActive(uv0.coinVaryGo_, false)
			uv0:PlayCurrencyRollAnim()
			uv0:PlayAnim("XH3rdVoyagesGameUI_coin", uv0.coinAnim_, function ()
				uv0.coinAnim_.enabled = false
			end)
		end)
	end
end

function slot0.PlayCurrencyRollAnim(slot0)
	slot1 = SailGameData:GetTempCurrency(slot0.activityID_)
	slot2 = slot1.lastNum
	slot3 = slot1.curNum

	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end

	slot0.tween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		slot1 = uv0 or 0
		uv2.coinNumText_.text = tostring(math.floor(slot1 + (uv1 - slot1) * slot0))
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.tween_ then
			uv0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			uv0.tween_ = nil
		end

		uv0.coinNumText_.text = uv1
	end)):setEase(LeanTweenType.easeOutQuad)
end

function slot0.PlayEventAnim(slot0, slot1, slot2)
	SetActive(slot0.eventTriggerGo_, true)
	SetActive(slot0.tipsGo_, false)

	slot0.tipsAnim_.enabled = false

	if slot1 ~= 0 then
		slot0.eventRoleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. SailGameEventCfg[slot1].picture)
	else
		slot0.eventRoleImg_.sprite = getSprite(GameDisplayCfg.activity_skadi_sea_box_picture.value[1], GameDisplayCfg.activity_skadi_sea_box_picture.value[2])
	end

	slot0.eventRoleImg_:SetNativeSize()
	slot0:PlayAnim("XH3rdVoyagesUI_role", slot0.eventAnim_, slot2)
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_pop1", "")
end

function slot0.PlayTipsAnim(slot0)
	SetActive(slot0.tipsGo_, true)

	slot0.tipsAnim_.enabled = true

	slot0:PlayAnim("XH3rdVoyagesUI_pop", slot0.tipsAnim_, function ()
		SetActive(uv0.tipsGo_, false)

		uv0.tipsAnim_.enabled = false
	end)
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

				uv3 = nil
			end
		end
	end, 0.033, -1)

	slot0.animTimerList_[slot1]:Start()
end

function slot0.PauseAnim(slot0)
	slot0.tipsAnim_.speed = 0
	slot0.coinAnim_.speed = 0

	if slot0.tween_ then
		LeanTween.pause(slot0.tween_.id)
	end
end

function slot0.RecoverAnim(slot0)
	slot0.tipsAnim_.speed = 1
	slot0.coinAnim_.speed = 1

	if slot0.tween_ then
		LeanTween.resume(slot0.tween_.id)
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

function slot0.OnActivityUpdate(slot0, slot1)
	if slot1 == slot0.activityID_ and not ActivityData:GetActivityIsOpen(slot1) then
		ShowTips("TIME_OVER")
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = slot0.activityID_
		})
	end
end

return slot0
