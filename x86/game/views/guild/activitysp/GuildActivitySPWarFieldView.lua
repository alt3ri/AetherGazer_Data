slot0 = class("GuildActivitySPWarFieldView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivitySPUI/GuildActivitySPWarFieldUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.newMessageHandler_ = handler(slot0, slot0.ChatNewMessage)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.hideLockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "canNext")
	slot0.chatTextExtension_ = slot0.chatText_:GetComponent(typeof(TextExtension))
end

function slot0.indexItem(slot0, slot1, slot2)
end

function slot0.AddUIListener(slot0)
	slot0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:GetGuildActivityManager():SetZoom(uv0.mapSlider_.value)
	end))
	slot0:GetGuildActivityManager():SetOnZoomByFingerHandler(handler(slot0, slot0.OnZoomChangeByFinger))
	slot0:GetGuildActivityManager():SetOnNodeClick(handler(slot0, slot0.OnNodeClick))
	slot0:GetGuildActivityManager():SetOnBonusClick(handler(slot0, slot0.OnBonusNodeClick))
	slot0:GetGuildActivityManager():SetOnBgClick(handler(slot0, slot0.OnBgClick))
	slot0:GetGuildActivityManager():SetOnLevelLoaded(handler(slot0, slot0.OnLevelLoaded))
	slot0:AddBtnListener(slot0.allGetBtn_, nil, function ()
		GuildActivitySPAction.GetCoin()
	end)
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		uv0:GoToPrevLevel()
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		uv0:GoToNextLevel()
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not uv0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivitySPReward", {
			activityID = uv0.params_.activityID
		})
	end)
	slot0:AddBtnListener(slot0.ratingBtn_, nil, function ()
		if not uv0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivitySPRate", {
			activityID = uv0.params_.activityID
		})
	end)
	slot0:AddBtnListener(slot0.setupBtn_, nil, function ()
		JumpTools.OpenPageByJump("guildActivitySPFightHeroSetting", {
			isEnter = true,
			activityID = uv0.params_.activityID
		})
	end)
	slot0:AddBtnListener(slot0.talentBtn_, nil, function ()
		if not uv0:IsTop() then
			gameContext:Back()
		end

		uv0:Go("/guildActivitySPAffixMain", {
			activityID = uv0.params_.activityID
		})
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, GuildActivitySPData:GetCurRunActivityID()), 0)
	end)
	slot0:AddBtnListener(slot0.storeBtn_, nil, function ()
		slot0 = {}

		for slot7, slot8 in ipairs(ShopListCfg.all) do
			if ShopListCfg[slot8].display_group == ShopListCfg[GuildActivitySpTools.GetCurActivityIDInfo(GuildActivitySPData:GetCurMainActivityID()).shopID].display_group then
				table.insert(slot0, slot8)
			end
		end

		JumpTools.GoToSystem("/activityShop", {
			hideHomeBtn = 1,
			shopId = slot2,
			showShops = slot0
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.chatBtn_, nil, function ()
		if not uv0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = GuildActivitySpTools.GetCurOpenActivityStateInfo().chatToggleID
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	slot0:AddBtnListener(slot0.currencyBtn_, nil, function ()
		if GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 1) then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1
			})
		end
	end)
	slot0:AddBtnListener(slot0.currency2Btn_, nil, function ()
		if GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 2) then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1
			})
		end
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(MATERIAL_MODIFY, function (slot0)
		slot1 = GuildActivitySPData:GetCurMainActivityID()

		if slot0 == GuildActivitySpTools.GetCurCurrencyID(slot1, 1) or slot0 == GuildActivitySpTools.GetCurCurrencyID(slot1, 2) then
			uv0:UpdateLevelView()
		end
	end)
	slot0:RegistEventListener(GUILD_ACTIVITY_SP_DISPATCHED, function ()
		uv0:UpdateLevelView()
	end)
	slot0:RegistEventListener(GUILD_ACTIVITY_SP_CANCEL_DISPATCH, function ()
		uv0:UpdateLevelView()
	end)
	slot0:RegistEventListener(GUILD_ACTIVITY_SP_SPAWN_ID_UPDATE, function ()
		uv0:UpdateRightBtn()
	end)
	slot0:RegistEventListener(GUILD_ACTIVITY_SP_COIN_GET_FINISH, function ()
		uv0:UpdateLevelView()
		uv0.currencyAnimator_:Play("currency", -1, 0)
	end)
end

function slot0.OnZoomChangeByFinger(slot0, slot1)
	slot0.mapSlider_.value = slot1
end

function slot0.OnBgClick(slot0)
	if gameContext.routes_[#gameContext.routes_] == "guildActivitySPNormalPop" or slot1 == "guildActivitySPElitePop" or slot1 == "guildActivitySPBossPop" or slot1 == "guildActivitySPSmallBossPop" then
		gameContext:Back()
	end
end

function slot0.OnLevelLoaded(slot0, slot1)
	slot0.curMapIndex_ = slot1

	slot0:UpdateLevelView()
end

function slot0.OnNodeClick(slot0, slot1)
	slot0.curNodeId = slot1

	if not ActivityClubSPCfg[slot1] then
		CustomLog.Log(debug.traceback(string.format("找不到指定id为节点：%d", slot1)))

		return
	end

	if not slot0:IsTop() then
		gameContext:Back()
	end

	if slot0.animTimer_ ~= nil then
		return
	end

	if slot2.type == 0 then
		-- Nothing
	elseif slot2.type == 1 then
		JumpTools.OpenPageByJump("guildActivitySPNormalPop", {
			nodeId = slot1
		})
	elseif slot2.type == 2 then
		JumpTools.OpenPageByJump("guildActivitySPElitePop", {
			nodeId = slot1
		})
	elseif slot2.type == 3 then
		JumpTools.OpenPageByJump("guildActivitySPSmallBossPop", {
			nodeId = slot1
		})
	elseif slot2.type == 4 then
		JumpTools.OpenPageByJump("guildActivitySPBossPop", {
			nodeId = slot1
		})
	end
end

function slot0.OnBonusNodeClick(slot0, slot1)
	GuildActivitySPAction.GetCoin()
end

function slot0.OnTop(slot0)
	if not manager.story.player_ then
		slot0:GetGuildActivityManager():SetOnWarField(false)
		slot0:GetGuildActivityManager():SetOnWarField(true)
	end

	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot1, slot2 = GuildActivitySpTools.GetCurActivityDescribe()

	if slot1 and #slot1 > 0 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey({
			view = "gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				pages = slot1,
				isPrefab = slot2
			}
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:RegistBackCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		slot0 = ActivityCfg.get_id_list_by_sub_activity_list[uv0.params_.activityID][1]

		JumpTools.OpenPageUntilLoaded(SystemLinkCfg[ActivityEntraceCfg[slot0].jump_system[1]].link, {
			activityID = slot0,
			subActivityID = GuildActivitySPData:GetCurMainActivityID()
		})
		GuildActivitySPAction.ExitGuildActivity()
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		JumpTools.OpenPageUntilLoaded("/home")
		GuildActivitySPAction.ExitGuildActivity()
	end)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("GuildActivitySP", true, false)

	slot0.curNodeId = slot0.params_.nodeID or slot0.curNodeId
	slot0.params_.nodeID = nil

	slot0:AddEventListeners()

	slot0.curMapIndex_ = slot0.params_.level or slot0.curMapIndex_

	slot0:GetGuildActivityManager():SetOnWarField(true)
	slot0:UpdateLevelView()
	slot0:RegisterRedPoint()
	slot0:StartTimer()
	slot0:UpdateTimer()
	slot0:OnGuildActivitySpCheckRateUpgrade()

	slot1 = GuildActivitySPData:GetCurMainActivityID()
	slot0.currency1Img.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(slot1, 1))
	slot0.currency2Img.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(slot1, 2))
	slot0.getCurrencyImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(slot1, 1))

	manager.notify:RegistListener(CHAT_NEW_MESSAGE, slot0.newMessageHandler_)
	slot0:ChatNewMessage()
	slot0:UpdataRedPoint()

	slot0.curNodeId = slot0.curNodeId or GuildActivitySPData:GetCurrentGrid()

	if not GuildActivityTools:CheckCanPlayStory(slot0.curMapIndex_) then
		slot0:PlayBossNodeAniamtion()
	else
		GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)
		GuildActivityTools:PlayGuildActivitySpStoryList(handler(slot0, slot0.SetNoteState), nil, slot0.curMapIndex_)
	end
end

function slot0.SetNoteState(slot0, slot1)
	if not getData("GuildActivitySP", "note") then
		saveData("GuildActivitySP", "note", true)

		slot3, slot4 = GuildActivitySpTools.GetCurActivityDescribe()

		JumpTools.OpenPageByJump("gameHelpPro", {
			hideHomeBtn = 1,
			pages = slot3,
			isPrefab = slot4
		})
	end

	if slot1 then
		slot0.curNodeId = slot0.curNodeId or GuildActivitySPData:GetCurrentGrid()

		GuildActivitySPLuaBridge.GetManager():SetOnWarField(true)

		manager.ui.mainCamera:GetComponent("CameraExtension").shadowRotationImmediately = true

		slot0:GetGuildActivityManager():SetZoom(1)

		if not slot0:PlayBossNodeAniamtion() then
			GuildActivitySPLuaBridge.MoveCameraAimAtNode(slot0.curNodeId)
		end
	end
end

function slot0.PlayBossNodeAniamtion(slot0)
	slot3 = ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()][slot0.curMapIndex_]
	slot4, slot5 = GuildActivitySPData:GetBigBossNode(slot3)
	slot7 = GuildActivitySPData:IsAllLittleBossPass(slot3)
	slot8 = nil
	slot7 = 1

	if (GuildActivitySPData:HaveBigBossBeKilled(slot3) and 1 or 0) == 1 then
		slot8 = slot3 .. "_" .. slot4 .. "dead"
	elseif slot7 == 1 then
		slot8 = slot3 .. "_" .. slot4 .. "unlock"
	end

	if slot8 then
		if not getData("GuildActivitySP", slot8) then
			slot10 = 0

			GuildActivitySPLuaBridge.PlayNodeAnimation(slot4, slot7 == 1 and 1 or 0, function ()
				saveData("GuildActivitySP", uv0, 1)
				uv1:CheckSecondStageTip()
			end, GameDisplayCfg.activity_club_sp_camera_move_time.value[1] / 100)

			return true
		else
			slot0:CheckSecondStageTip()
		end
	else
		slot0:CheckSecondStageTip()
	end
end

function slot0.CheckSecondStageTip(slot0)
	slot3 = ActivityData:GetActivityData(GuildActivitySPData:GetCurRunActivityID())
	slot6 = slot3.stopTime

	if slot3.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() and not getData("GuildActivitySP", "SecondStageTip") then
		saveData("GuildActivitySP", "SecondStageTip", 1)
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips(GuildActivitySpTools.GetCurOpenActivityStateInfo().secondOpen),
			OkCallback = function ()
			end
		})
	end
end

function slot0.UpdataRedPoint(slot0)
	GuildActivitySPAction.UpdataHadAwardRedPoint(slot0.params_.activityID)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	LeanTween.cancel(manager.ui.mainCameraCom_.gameObject)
	slot0:GetGuildActivityManager():SetOnWarField(false)
	slot0:UnRegisterRedPoint()
	slot0:StopTimer()
	manager.notify:RemoveListener(CHAT_NEW_MESSAGE, slot0.newMessageHandler_)
	manager.ui:ResetMainCamera()
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	slot3 = ActivityData:GetActivityData(GuildActivitySPData:GetCurRunActivityID())

	if slot3.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
		slot0.lastDayTitleLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr2(slot3.stopTime)
	else
		slot0.lastDayTitleLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr2(slot5)
	end

	if GuildActivitySPData:GetTotalCoinToGet() > 0 then
		SetActive(slot0.allGetBtn_.gameObject, true)
	else
		SetActive(slot0.allGetBtn_.gameObject, false)
	end
end

function slot0.GoToPrevLevel(slot0)
	if slot0.animTimer_ ~= nil then
		return
	end

	slot0.curMapIndex_ = slot0.curMapIndex_ - 1

	slot0:GotoLevel(slot0.curMapIndex_)
end

function slot0.GoToNextLevel(slot0)
	if slot0.animTimer_ ~= nil then
		return
	end

	if GuildActivitySPData:GetMySpawnNodeId(slot0.curMapIndex_ + 1) == nil or slot1 == 0 then
		ShowTips(GuildActivitySpTools.GetCurOpenActivityStateInfo().nextMapLock)

		return
	end

	slot0.curMapIndex_ = slot0.curMapIndex_ + 1

	slot0:GotoLevel(slot0.curMapIndex_)
end

function slot0.OnGuildActivitySpEnterNewLevel(slot0)
	if slot0.animTimer_ ~= nil then
		return
	end

	slot0.curMapIndex_ = slot0.curMapIndex_ + 1

	slot0:GotoLevel(slot0.curMapIndex_)
end

slot1 = nil

function slot0.GotoLevel(slot0, slot1)
	if not slot0:IsTop() then
		gameContext:Back()
	end

	uv0 = slot1

	SetActive(slot0.cloudGo_, true)

	slot0.animTimer_ = 1

	AnimatorTools.PlayAnimationWithCallback(slot0.cloudAnimator_, "cloud", function ()
		SetActive(uv0.cloudGo_, false)

		uv0.animTimer_ = nil

		if GuildActivityTools:CheckCanPlayStory(uv0.curMapIndex_) then
			GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)
			GuildActivityTools:PlayGuildActivitySpStoryList(handler(uv0, uv0.SetNoteState), nil, uv0.curMapIndex_)
		end
	end)
	slot0.cloudAnimator_:Play("cloud", -1, 0)
end

function slot0.OnEnterNewLevel(slot0)
	slot0:GetGuildActivityManager():LoadLevel(uv0, GuildActivitySPData:GetCurMainActivityID())

	slot0.params_.level = uv0
end

function slot0.UpdateLevelView(slot0)
	slot0.mapNameLabel_.text = ActivityClubSPMapCfg[ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()][slot0.curMapIndex_]].map_name

	SetActive(slot0.leftBtn_.gameObject, true)
	SetActive(slot0.rightBtn_.gameObject, true)

	if slot0.curMapIndex_ == 1 then
		SetActive(slot0.leftBtn_.gameObject, false)
	end

	if slot0.curMapIndex_ == #ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()] then
		SetActive(slot0.rightBtn_.gameObject, false)
	end

	slot0.footPrintLabel_.text = string.format("%d/%d", GuildActivitySPData:GetDispatchCatNum(), #GuildActivitySPData:GetCanDispatchCatList())
	slot6 = GuildActivitySPData:GetCurMainActivityID()
	slot0.profitLabel_.text = string.format("%d(+%d/%s)", ItemTools.getItemNum(GuildActivitySpTools.GetCurCurrencyID(slot6, 1)), GuildActivitySPData:GetCoinGain(), GetTips("HOUR"))
	slot0.profit2Label_.text = ItemTools.getItemNum(GuildActivitySpTools.GetCurCurrencyID(slot6, 2))

	slot0:UpdateRightBtn()
end

function slot0.UpdateRightBtn(slot0)
	slot1 = GuildActivitySPData:GetMySpawnNodeId(slot0.curMapIndex_ + 1)

	if slot0.curMapIndex_ == #ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()] then
		slot0.hideLockController_:SetSelectedState("true")
	elseif slot1 == nil or slot1 == 0 then
		slot0.hideLockController_:SetSelectedState("false")
	else
		slot0.hideLockController_:SetSelectedState("true")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.GetGuildActivityManager(slot0)
	return GuildActivitySPLuaBridge.GetManager()
end

function slot0.Dispose(slot0)
	slot0.newMessageHandler_ = nil

	slot0.mapSlider_.onValueChanged:RemoveAllListeners()
	slot0:GetGuildActivityManager():SetOnZoomByFingerHandler(nil)

	if slot0.timer_ then
		slot0.timer_:Dispose()

		slot0.timer_ = nil
	end

	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

function slot0.RegisterRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_BONUS, slot0.params_.activityID))
	manager.redPoint:bindUIandKey(slot0.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, slot0.params_.activityID))
	manager.redPoint:bindUIandKey(slot0.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_ON_FIGHT_NOT_FULL, slot0.params_.activityID))
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_BONUS, slot0.params_.activityID))
	manager.redPoint:unbindUIandKey(slot0.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, slot0.params_.activityID))
	manager.redPoint:unbindUIandKey(slot0.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_ON_FIGHT_NOT_FULL, slot0.params_.activityID))
end

function slot0.OnGuildActivitySpCheckRateUpgrade(slot0)
	slot1, slot2 = GuildActivitySPData:CheckRateUpgrade(slot0.params_.activityID)

	if slot1 == true then
		JumpTools.OpenPageByJump("guildActivitySPRateUpgrad", {
			rateID = slot2
		})
		GuildActivitySPData:RefreshRateRedPoint(slot0.params_.activityID)
		slot0:UpdateLevelView()
	end
end

function slot0.ChatNewMessage(slot0)
	if #ChatChannelData:GetCacheContent(GuildActivitySpTools.GetCurOpenActivityStateInfo().chatToggleID) > 0 then
		slot3 = slot2[#slot2]
		slot4 = slot3.content

		if slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			slot4 = string.format("[%s]", ChatStickerCfg[tonumber(slot3.content)].name)
		end

		slot0.chatTextExtension_:SetText(string.format("%s:%s", slot3.nick, slot4))
	else
		slot0.chatText_.text = ""
	end
end

return slot0
