local var_0_0 = class("DormLinkGamePlayView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGPlay"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.itemScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexSkillItemList), arg_5_0.itemList_, DormLinkGameSkillItem)
	arg_5_0.passTableStateController = ControllerUtil.GetController(arg_5_0.statusGo_.transform, "status")
	arg_5_0.countDowmController = ControllerUtil.GetController(arg_5_0.countdownGo_.transform, "state")
	arg_5_0.batterController = ControllerUtil.GetController(arg_5_0.transform_, "batter")
	arg_5_0.useItemController = ControllerUtil.GetController(arg_5_0.transform_, "useItem")
	arg_5_0.showCountController = ControllerUtil.GetController(arg_5_0.transform_, "showCount")
	arg_5_0.startCountController = ControllerUtil.GetController(arg_5_0.transform_, "start")
	arg_5_0.diffController = ControllerUtil.GetController(arg_5_0.startgame1Go_.transform, "mode")
	arg_5_0.maskController = ControllerUtil.GetController(arg_5_0.transform_, "mask")
	arg_5_0.reduceController = ControllerUtil.GetController(arg_5_0.transform_, "reducePoint")
	arg_5_0.listController = ControllerUtil.GetController(arg_5_0.transform_, "listShow")
	arg_5_0.numAnimaton = arg_5_0.numGo_:GetComponent("Animation")
	arg_5_0.comboAnimaton = arg_5_0.comboGo_:GetComponent("Animation")
	arg_5_0.extendAnimaton = arg_5_0.extendNumGo_:GetComponent("Animation")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListenerScale(arg_6_0.startbtnBtn_, nil, function()
		arg_6_0:StartGame()
		manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_start", "")
	end)
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_LINKGAME_STOP_TIPS"),
			OkCallback = function()
				arg_8_0:DisposeTimer()
				DormLinkGameData:StopGame(DormLinkGameConst.StopGameType.fail)
			end,
			CancelCallback = function()
				return
			end
		})
	end)

	arg_8_0.levelID = DormLinkGameData:GetCurLevelID()
	arg_8_0.canInteractFlag = false

	arg_8_0:RegisterEvents()
	arg_8_0:RefreshStartView()
	arg_8_0:RefreshCustomerBubble()
	arg_8_0:ResetView()
end

function var_0_0.RegisterEvents(arg_12_0)
	arg_12_0:RegistEventListener(DORM_LINK_START_PLAY, function()
		arg_12_0.countDowmController:SetSelectedState("start")

		arg_12_0.canInteractFlag = true
	end)
	arg_12_0:RegistEventListener(DORM_LINK_END_GAME, function(arg_14_0, arg_14_1)
		arg_12_0:DisposeTimer()

		if arg_12_0.bubbleList then
			for iter_14_0, iter_14_1 in pairs(arg_12_0.bubbleList) do
				iter_14_1:SetActive(false)
			end
		end

		if arg_14_0 == DormLinkGameConst.StopGameType.success then
			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.SuccssfulLevel)
			JumpTools.OpenPageByJump("/dormLinkGameSuccessView", {
				data = arg_14_1
			})
		elseif arg_14_0 == DormLinkGameConst.StopGameType.fail then
			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.FaileLevel)
			JumpTools.OpenPageByJump("/dormLinkGameFailView")
		end
	end)
	arg_12_0:RegistEventListener(DORM_LINK_REFRESH_GAME_TIME, function(arg_15_0)
		arg_12_0:RefreshLastTime(arg_15_0)
	end)
	arg_12_0:RegistEventListener(LIANLIANKAN_ITEM_MATCH, function(arg_16_0)
		DormLinkGameData:EliminateMaterial(arg_16_0)
	end)
	arg_12_0:RegistEventListener(DORM_LINK_REFRESH_BATTER_NUM, function()
		arg_12_0:RefreshBatterNum()
		arg_12_0:RefreshExtendPoint()
	end)
	arg_12_0:RegistEventListener(DORM_LINK_REFRESH_CUSTOMER_BUBBLE, function(arg_18_0, arg_18_1)
		if arg_12_0.bubbleList and arg_12_0.bubbleList[arg_18_0] then
			arg_12_0.bubbleList[arg_18_0]:RefreshBubbleInfo(arg_18_1)
		end
	end)
	arg_12_0:RegistEventListener(LIANLIANKAN_ITEM_OVERFLOW, function(arg_19_0)
		DormLinkGameData:DrainMaterial(arg_19_0)
	end)
	arg_12_0:RegistEventListener(LIANLIANKAN_GAME_CLEAR, function()
		DormLinkGameData:StopGame(DormLinkGameConst.StopGameType.success)
	end)
	arg_12_0:RegistEventListener(DORM_LINK_REFRESH_DRAIN_MATERIAL, function(arg_21_0)
		arg_12_0:RefreshExtendPoint()
		arg_12_0:RefreshDrainPoint(arg_21_0)
	end)
	arg_12_0:RegistEventListener(DORM_LINK_REFRESH_EXTEND_ADDITION, function()
		arg_12_0:RefreshExtendAddition()
	end)
	arg_12_0:RegistEventListener(DORM_LINK_REFRESH_MATERIAL_TIME, function(arg_23_0)
		arg_12_0:RefreshMaterialTime(arg_23_0)
	end)
	arg_12_0:RegistEventListener(DORM_LINK_REFRESH_CUSTOMER_SATIETY, function(arg_24_0)
		arg_12_0.bubbleList[arg_24_0]:RefreshSatiety()
	end)
end

function var_0_0.RefreshRunView(arg_25_0)
	if arg_25_0.bubbleList then
		for iter_25_0, iter_25_1 in pairs(arg_25_0.bubbleList) do
			iter_25_1:SetActive(true)
			iter_25_1:RefreshTransPosition()
			iter_25_1:RefreshBubbleInfo()
			iter_25_1:RefreshSatiety()
		end
	end

	arg_25_0.levelText_.text = ActivityLinkGameCfg[arg_25_0.levelID].name

	arg_25_0:RefreshLastTime()
	arg_25_0:RefreshExtendPoint()
	arg_25_0:RefreshExtendAddition()
	arg_25_0:RefreshBatterNum()
	arg_25_0:RefreshMaterialTime()
	arg_25_0:RefreshSkillItemList(false)
end

function var_0_0.RefreshStartView(arg_26_0)
	arg_26_0.startCountController:SetSelectedState("true")
	arg_26_0.reduceController:SetSelectedState("false")

	arg_26_0.startTitleText.text = ActivityLinkGameCfg[arg_26_0.levelID].name

	local var_26_0 = ActivityLinkGameCfg[arg_26_0.levelID].time_limit

	arg_26_0.startTimeText.text = string.format(GetTips("ACTIVITY_LINKGAME_TIME"), tostring(var_26_0))

	local var_26_1 = DormLinkGameData:GetSceneData().difficultyLevel

	if var_26_1 == 1 then
		arg_26_0.diffController:SetSelectedState("eazy")
	elseif var_26_1 == 2 then
		arg_26_0.diffController:SetSelectedState("hard")
	elseif var_26_1 == 9 then
		arg_26_0.diffController:SetSelectedState("SP")
	end

	arg_26_0:RefreshSkillItemList(true)
end

function var_0_0.RefreshLastTime(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or DormLinkGameData:GetSceneData().limitTime
	arg_27_0.lastTimeText_.text = string.format(GetTips("ACTIVITY_LINKGAME_REST_TIME"), arg_27_1)
end

function var_0_0.RefreshSkillItemList(arg_28_0, arg_28_1)
	arg_28_0.skillItemState = arg_28_1

	if ActivityLinkGameCfg[arg_28_0.levelID].property_limit == 1 then
		arg_28_0.listController:SetSelectedState("true")

		arg_28_0.skillItemList = ActivityLinkGameGoodsCfg.all

		arg_28_0.itemScroll:StartScroll(#arg_28_0.skillItemList)
	else
		arg_28_0.listController:SetSelectedState("false")
	end
end

function var_0_0.indexSkillItemList(arg_29_0, arg_29_1, arg_29_2)
	arg_29_2:RefreshUI(arg_29_0.skillItemList[arg_29_1], arg_29_0.skillItemState)
	arg_29_2:UseItem(function(arg_30_0)
		if arg_29_0.canInteractFlag then
			if ActivityLinkGameGoodsCfg[arg_30_0].coin_num <= DormLinkGameData:GetCurCnaUseTokenNum() then
				DormLinkGameTools:UseSkillItem(arg_30_0)
				arg_29_0:ShowUseItemTips(arg_30_0)
				arg_29_0.itemScroll:Refresh()
			else
				ShowTips(GetTips("ACTIVITY_LINKGAME_COIN_NOT_ENOUGH"))
			end
		end
	end)
end

function var_0_0.RefreshMaterialTime(arg_31_0, arg_31_1)
	if arg_31_1 then
		arg_31_0.countdownText_.text = string.format(GetTips("ACTIVITY_LINKGAME_CELL_PUSH"), arg_31_1)
	else
		arg_31_1 = DormLinkGameData:GetGameCacheInfo().generateInterval
		arg_31_0.countdownText_.text = string.format(GetTips("ACTIVITY_LINKGAME_CELL_PUSH"), GameSetting.linkgame_count_down.value[1] + arg_31_1)
	end
end

function var_0_0.RefreshExtendPoint(arg_32_0)
	if not arg_32_0.extendNum then
		local var_32_0 = 0
	end

	local var_32_1 = DormLinkGameData:GetGameCacheInfo()

	arg_32_0.extendNum = var_32_1.extendPoint - var_32_1.drainPoint
	arg_32_0.extendNumText_.text = var_32_1.extendPoint - var_32_1.drainPoint
end

function var_0_0.RefreshDrainPoint(arg_33_0, arg_33_1)
	arg_33_0.reduceController:SetSelectedState("true")
	arg_33_0.extendAnimaton:Play()

	arg_33_0.reduceNum.text = -1 * arg_33_1

	if not arg_33_0.reduceTimer then
		local var_33_0 = GameSetting.linkgame_score_tips_time.value[1]

		arg_33_0.reduceTimer = Timer.New(function()
			arg_33_0.reduceController:SetSelectedState("false")
		end, var_33_0, 1)
	else
		arg_33_0.reduceTimer:Reset()
	end

	arg_33_0.reduceTimer:Start()
end

function var_0_0.RefreshExtendAddition(arg_35_0)
	arg_35_0.extendAdditionText_.text = string.format("+%d", DormLinkGameData:GetExtendAddition()) .. "%"
end

function var_0_0.RefreshBatterNum(arg_36_0)
	if DormLinkGameData:GetBatterNum() > 0 then
		arg_36_0.batterController:SetSelectedState("true")

		arg_36_0.BatterNum.text = string.format(GetTips("ACTIVITY_LINKGAME_HIT"), DormLinkGameData:GetBatterNum())

		arg_36_0.comboAnimaton:Play()
	else
		arg_36_0.batterController:SetSelectedState("false")
	end
end

function var_0_0.RefreshCustomerBubble(arg_37_0)
	if not arg_37_0.bubbleList then
		arg_37_0.bubbleList = {}

		local var_37_0 = DormLinkGameData:GetCustomerList()

		for iter_37_0, iter_37_1 in pairs(var_37_0) do
			arg_37_0.bubbleList[iter_37_0] = DormLinkGameBubbleItem.New(arg_37_0.bubbleGo_, iter_37_0, arg_37_0.transform_)

			arg_37_0.bubbleList[iter_37_0]:RefreshBubbleInfo()
		end
	end
end

function var_0_0.ShowUseItemTips(arg_38_0, arg_38_1)
	local var_38_0 = ActivityLinkGameGoodsCfg[arg_38_1]

	if var_38_0 then
		arg_38_0.useItemController:SetSelectedState("true")

		local var_38_1 = var_38_0.name
		local var_38_2 = var_38_0.coin_num
		local var_38_3 = DormLinkGameData:GetMainActivityID()
		local var_38_4 = DormLinkGameTools:GetCurrencyID(var_38_3)

		arg_38_0.revokeIcon.sprite = ItemTools.getItemSprite(var_38_4)
		arg_38_0.revokeText.text = string.format(GetTips("ACTIVITY_LINKGAME_COST_TIPS"), var_38_2, var_38_1)

		if arg_38_0.itemShowTimer then
			arg_38_0.itemShowTimer:Stop()

			arg_38_0.itemShowTimer = nil
		end

		local var_38_5 = GameSetting.linkgame_tips_time.value[1]

		arg_38_0.itemShowTimer = Timer.New(function()
			arg_38_0.useItemController:SetSelectedState("false")
		end, var_38_5, 1)

		arg_38_0.itemShowTimer:Start()
	end
end

function var_0_0.StartGame(arg_40_0)
	manager.notify:Invoke(LIANLIANKAN_GAME_START)
	arg_40_0.startCountController:SetSelectedState("false")
	arg_40_0:RefreshRunView()
	arg_40_0:StartCountDownShow()
end

function var_0_0.StartCountDownShow(arg_41_0)
	arg_41_0.showCountController:SetSelectedState("true")
	arg_41_0.numAnimaton:Play()
	arg_41_0.countDowmController:SetSelectedState("num")

	if not arg_41_0.countTimer then
		arg_41_0.countDownTime = GameSetting.linkgame_start_time.value[1]
		arg_41_0.countDownText.text = arg_41_0.countDownTime
		arg_41_0.countTimer = Timer.New(function()
			arg_41_0.countDownTime = arg_41_0.countDownTime - 1

			if arg_41_0.countDownTime > 0 then
				arg_41_0.countDownText.text = arg_41_0.countDownTime

				arg_41_0.numAnimaton:Play()
			else
				arg_41_0.countDowmController:SetSelectedState("start")
				arg_41_0:StartCountDownTextShow()
			end
		end, 1, -1)
	else
		arg_41_0.countTimer:Reset()
	end

	arg_41_0.countTimer:Start()
end

function var_0_0.DisposeTimer(arg_43_0)
	if arg_43_0.countTimer then
		arg_43_0.countTimer:Stop()

		arg_43_0.countTimer = nil
	end

	if arg_43_0.textCountTimer then
		arg_43_0.textCountTimer:Stop()

		arg_43_0.textCountTimer = nil
	end
end

function var_0_0.ResetView(arg_44_0)
	arg_44_0.showCountController:SetSelectedState("false")
	arg_44_0.batterController:SetSelectedState("false")
	arg_44_0.useItemController:SetSelectedState("false")
	arg_44_0.maskController:SetSelectedState("true")
	arg_44_0.reduceController:SetSelectedState("false")
end

function var_0_0.StartCountDownTextShow(arg_45_0)
	if arg_45_0.countTimer then
		arg_45_0.countTimer:Stop()
	end

	if not arg_45_0.textCountTimer then
		arg_45_0.textCountDownTime = GameSetting.linkgame_word_disappear_time.value[1] / 100
		arg_45_0.textCountTimer = Timer.New(function()
			arg_45_0.showCountController:SetSelectedState("false")
			arg_45_0.maskController:SetSelectedState("false")
			DormLinkGameData:PlayerStartGame()
		end, arg_45_0.textCountDownTime, 1)
	else
		arg_45_0.textCountTimer:Reset()
	end

	arg_45_0.textCountTimer:Start()
end

function var_0_0.OnExit(arg_47_0)
	arg_47_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_48_0)
	arg_48_0:DisposeTimer()

	if arg_48_0.itemScroll then
		arg_48_0.itemScroll:Dispose()

		arg_48_0.itemScroll = nil
	end

	if arg_48_0.bubbleList then
		for iter_48_0, iter_48_1 in pairs(arg_48_0.bubbleList) do
			iter_48_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_48_0)
end

return var_0_0
