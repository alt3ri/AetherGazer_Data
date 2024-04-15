slot0 = class("DormLinkGamePlayView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGPlay"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemScroll = LuaList.New(handler(slot0, slot0.indexSkillItemList), slot0.itemList_, DormLinkGameSkillItem)
	slot0.passTableStateController = ControllerUtil.GetController(slot0.statusGo_.transform, "status")
	slot0.countDowmController = ControllerUtil.GetController(slot0.countdownGo_.transform, "state")
	slot0.batterController = ControllerUtil.GetController(slot0.transform_, "batter")
	slot0.useItemController = ControllerUtil.GetController(slot0.transform_, "useItem")
	slot0.showCountController = ControllerUtil.GetController(slot0.transform_, "showCount")
	slot0.startCountController = ControllerUtil.GetController(slot0.transform_, "start")
	slot0.diffController = ControllerUtil.GetController(slot0.startgame1Go_.transform, "mode")
	slot0.maskController = ControllerUtil.GetController(slot0.transform_, "mask")
	slot0.reduceController = ControllerUtil.GetController(slot0.transform_, "reducePoint")
	slot0.listController = ControllerUtil.GetController(slot0.transform_, "listShow")
	slot0.numAnimaton = slot0.numGo_:GetComponent("Animation")
	slot0.comboAnimaton = slot0.comboGo_:GetComponent("Animation")
	slot0.extendAnimaton = slot0.extendNumGo_:GetComponent("Animation")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.startbtnBtn_, nil, function ()
		uv0:StartGame()
		manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_start", "")
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_LINKGAME_STOP_TIPS"),
			OkCallback = function ()
				uv0:DisposeTimer()
				DormLinkGameData:StopGame(DormLinkGameConst.StopGameType.fail)
			end,
			CancelCallback = function ()
			end
		})
	end)

	slot0.levelID = DormLinkGameData:GetCurLevelID()
	slot0.canInteractFlag = false

	slot0:RegisterEvents()
	slot0:RefreshStartView()
	slot0:RefreshCustomerBubble()
	slot0:ResetView()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_LINK_START_PLAY, function ()
		uv0.countDowmController:SetSelectedState("start")

		uv0.canInteractFlag = true
	end)
	slot0:RegistEventListener(DORM_LINK_END_GAME, function (slot0, slot1)
		uv0:DisposeTimer()

		if uv0.bubbleList then
			for slot5, slot6 in pairs(uv0.bubbleList) do
				slot6:SetActive(false)
			end
		end

		if slot0 == DormLinkGameConst.StopGameType.success then
			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.SuccssfulLevel)
			JumpTools.OpenPageByJump("/dormLinkGameSuccessView", {
				data = slot1
			})
		elseif slot0 == DormLinkGameConst.StopGameType.fail then
			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.FaileLevel)
			JumpTools.OpenPageByJump("/dormLinkGameFailView")
		end
	end)
	slot0:RegistEventListener(DORM_LINK_REFRESH_GAME_TIME, function (slot0)
		uv0:RefreshLastTime(slot0)
	end)
	slot0:RegistEventListener(LIANLIANKAN_ITEM_MATCH, function (slot0)
		DormLinkGameData:EliminateMaterial(slot0)
	end)
	slot0:RegistEventListener(DORM_LINK_REFRESH_BATTER_NUM, function ()
		uv0:RefreshBatterNum()
		uv0:RefreshExtendPoint()
	end)
	slot0:RegistEventListener(DORM_LINK_REFRESH_CUSTOMER_BUBBLE, function (slot0, slot1)
		if uv0.bubbleList and uv0.bubbleList[slot0] then
			uv0.bubbleList[slot0]:RefreshBubbleInfo(slot1)
		end
	end)
	slot0:RegistEventListener(LIANLIANKAN_ITEM_OVERFLOW, function (slot0)
		DormLinkGameData:DrainMaterial(slot0)
	end)
	slot0:RegistEventListener(LIANLIANKAN_GAME_CLEAR, function ()
		DormLinkGameData:StopGame(DormLinkGameConst.StopGameType.success)
	end)
	slot0:RegistEventListener(DORM_LINK_REFRESH_DRAIN_MATERIAL, function (slot0)
		uv0:RefreshExtendPoint()
		uv0:RefreshDrainPoint(slot0)
	end)
	slot0:RegistEventListener(DORM_LINK_REFRESH_EXTEND_ADDITION, function ()
		uv0:RefreshExtendAddition()
	end)
	slot0:RegistEventListener(DORM_LINK_REFRESH_MATERIAL_TIME, function (slot0)
		uv0:RefreshMaterialTime(slot0)
	end)
	slot0:RegistEventListener(DORM_LINK_REFRESH_CUSTOMER_SATIETY, function (slot0)
		uv0.bubbleList[slot0]:RefreshSatiety()
	end)
end

function slot0.RefreshRunView(slot0)
	if slot0.bubbleList then
		for slot4, slot5 in pairs(slot0.bubbleList) do
			slot5:SetActive(true)
			slot5:RefreshTransPosition()
			slot5:RefreshBubbleInfo()
			slot5:RefreshSatiety()
		end
	end

	slot0.levelText_.text = ActivityLinkGameCfg[slot0.levelID].name

	slot0:RefreshLastTime()
	slot0:RefreshExtendPoint()
	slot0:RefreshExtendAddition()
	slot0:RefreshBatterNum()
	slot0:RefreshMaterialTime()
	slot0:RefreshSkillItemList(false)
end

function slot0.RefreshStartView(slot0)
	slot0.startCountController:SetSelectedState("true")
	slot0.reduceController:SetSelectedState("false")

	slot0.startTitleText.text = ActivityLinkGameCfg[slot0.levelID].name
	slot0.startTimeText.text = string.format(GetTips("ACTIVITY_LINKGAME_TIME"), tostring(ActivityLinkGameCfg[slot0.levelID].time_limit))

	if DormLinkGameData:GetSceneData().difficultyLevel == 1 then
		slot0.diffController:SetSelectedState("eazy")
	elseif slot2 == 2 then
		slot0.diffController:SetSelectedState("hard")
	elseif slot2 == 9 then
		slot0.diffController:SetSelectedState("SP")
	end

	slot0:RefreshSkillItemList(true)
end

function slot0.RefreshLastTime(slot0, slot1)
	slot0.lastTimeText_.text = string.format(GetTips("ACTIVITY_LINKGAME_REST_TIME"), slot1 or DormLinkGameData:GetSceneData().limitTime)
end

function slot0.RefreshSkillItemList(slot0, slot1)
	slot0.skillItemState = slot1

	if ActivityLinkGameCfg[slot0.levelID].property_limit == 1 then
		slot0.listController:SetSelectedState("true")

		slot0.skillItemList = ActivityLinkGameGoodsCfg.all

		slot0.itemScroll:StartScroll(#slot0.skillItemList)
	else
		slot0.listController:SetSelectedState("false")
	end
end

function slot0.indexSkillItemList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.skillItemList[slot1], slot0.skillItemState)
	slot2:UseItem(function (slot0)
		if uv0.canInteractFlag then
			if ActivityLinkGameGoodsCfg[slot0].coin_num <= DormLinkGameData:GetCurCnaUseTokenNum() then
				DormLinkGameTools:UseSkillItem(slot0)
				uv0:ShowUseItemTips(slot0)
				uv0.itemScroll:Refresh()
			else
				ShowTips(GetTips("ACTIVITY_LINKGAME_COIN_NOT_ENOUGH"))
			end
		end
	end)
end

function slot0.RefreshMaterialTime(slot0, slot1)
	if slot1 then
		slot0.countdownText_.text = string.format(GetTips("ACTIVITY_LINKGAME_CELL_PUSH"), slot1)
	else
		slot0.countdownText_.text = string.format(GetTips("ACTIVITY_LINKGAME_CELL_PUSH"), GameSetting.linkgame_count_down.value[1] + DormLinkGameData:GetGameCacheInfo().generateInterval)
	end
end

function slot0.RefreshExtendPoint(slot0)
	slot1 = slot0.extendNum or 0
	slot2 = DormLinkGameData:GetGameCacheInfo()
	slot0.extendNum = slot2.extendPoint - slot2.drainPoint
	slot0.extendNumText_.text = slot2.extendPoint - slot2.drainPoint
end

function slot0.RefreshDrainPoint(slot0, slot1)
	slot0.reduceController:SetSelectedState("true")
	slot0.extendAnimaton:Play()

	slot0.reduceNum.text = -1 * slot1

	if not slot0.reduceTimer then
		slot0.reduceTimer = Timer.New(function ()
			uv0.reduceController:SetSelectedState("false")
		end, GameSetting.linkgame_score_tips_time.value[1], 1)
	else
		slot0.reduceTimer:Reset()
	end

	slot0.reduceTimer:Start()
end

function slot0.RefreshExtendAddition(slot0)
	slot0.extendAdditionText_.text = string.format("+%d", DormLinkGameData:GetExtendAddition()) .. "%"
end

function slot0.RefreshBatterNum(slot0)
	if DormLinkGameData:GetBatterNum() > 0 then
		slot0.batterController:SetSelectedState("true")

		slot0.BatterNum.text = string.format(GetTips("ACTIVITY_LINKGAME_HIT"), DormLinkGameData:GetBatterNum())

		slot0.comboAnimaton:Play()
	else
		slot0.batterController:SetSelectedState("false")
	end
end

function slot0.RefreshCustomerBubble(slot0)
	if not slot0.bubbleList then
		slot0.bubbleList = {}

		for slot5, slot6 in pairs(DormLinkGameData:GetCustomerList()) do
			slot0.bubbleList[slot5] = DormLinkGameBubbleItem.New(slot0.bubbleGo_, slot5, slot0.transform_)

			slot0.bubbleList[slot5]:RefreshBubbleInfo()
		end
	end
end

function slot0.ShowUseItemTips(slot0, slot1)
	if ActivityLinkGameGoodsCfg[slot1] then
		slot0.useItemController:SetSelectedState("true")

		slot0.revokeIcon.sprite = ItemTools.getItemSprite(DormLinkGameTools:GetCurrencyID(DormLinkGameData:GetMainActivityID()))
		slot0.revokeText.text = string.format(GetTips("ACTIVITY_LINKGAME_COST_TIPS"), slot2.coin_num, slot2.name)

		if slot0.itemShowTimer then
			slot0.itemShowTimer:Stop()

			slot0.itemShowTimer = nil
		end

		slot0.itemShowTimer = Timer.New(function ()
			uv0.useItemController:SetSelectedState("false")
		end, GameSetting.linkgame_tips_time.value[1], 1)

		slot0.itemShowTimer:Start()
	end
end

function slot0.StartGame(slot0)
	manager.notify:Invoke(LIANLIANKAN_GAME_START)
	slot0.startCountController:SetSelectedState("false")
	slot0:RefreshRunView()
	slot0:StartCountDownShow()
end

function slot0.StartCountDownShow(slot0)
	slot0.showCountController:SetSelectedState("true")
	slot0.numAnimaton:Play()
	slot0.countDowmController:SetSelectedState("num")

	if not slot0.countTimer then
		slot0.countDownTime = GameSetting.linkgame_start_time.value[1]
		slot0.countDownText.text = slot0.countDownTime
		slot0.countTimer = Timer.New(function ()
			uv0.countDownTime = uv0.countDownTime - 1

			if uv0.countDownTime > 0 then
				uv0.countDownText.text = uv0.countDownTime

				uv0.numAnimaton:Play()
			else
				uv0.countDowmController:SetSelectedState("start")
				uv0:StartCountDownTextShow()
			end
		end, 1, -1)
	else
		slot0.countTimer:Reset()
	end

	slot0.countTimer:Start()
end

function slot0.DisposeTimer(slot0)
	if slot0.countTimer then
		slot0.countTimer:Stop()

		slot0.countTimer = nil
	end

	if slot0.textCountTimer then
		slot0.textCountTimer:Stop()

		slot0.textCountTimer = nil
	end
end

function slot0.ResetView(slot0)
	slot0.showCountController:SetSelectedState("false")
	slot0.batterController:SetSelectedState("false")
	slot0.useItemController:SetSelectedState("false")
	slot0.maskController:SetSelectedState("true")
	slot0.reduceController:SetSelectedState("false")
end

function slot0.StartCountDownTextShow(slot0)
	if slot0.countTimer then
		slot0.countTimer:Stop()
	end

	if not slot0.textCountTimer then
		slot0.textCountDownTime = GameSetting.linkgame_word_disappear_time.value[1] / 100
		slot0.textCountTimer = Timer.New(function ()
			uv0.showCountController:SetSelectedState("false")
			uv0.maskController:SetSelectedState("false")
			DormLinkGameData:PlayerStartGame()
		end, slot0.textCountDownTime, 1)
	else
		slot0.textCountTimer:Reset()
	end

	slot0.textCountTimer:Start()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:DisposeTimer()

	if slot0.itemScroll then
		slot0.itemScroll:Dispose()

		slot0.itemScroll = nil
	end

	if slot0.bubbleList then
		for slot4, slot5 in pairs(slot0.bubbleList) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
