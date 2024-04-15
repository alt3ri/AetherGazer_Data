slot0 = class("SoloHeartDemonMainView", ReduxView)
slot1 = 11

function slot0.UIName(slot0)
	return "Widget/System/Challenge_SoloHeartDemonUI/SoloHeartDemonMainUI"
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

	slot0.difficultyBtnControllerList = {
		ControllerUtil.GetController(slot0.difficultyBtn1_.transform, "state"),
		ControllerUtil.GetController(slot0.difficultyBtn2_.transform, "state"),
		ControllerUtil.GetController(slot0.difficultyBtn3_.transform, "state")
	}
	slot0.challengeController = slot0.fightBtnControllerEx_:GetController("state")
	slot0.rankController = ControllerUtil.GetController(slot0.rankGo_.transform, "state")
	slot0.textLimit_ = slot0.chatTxt_.gameObject:GetComponent("TextExtension")
	slot0.list = LuaList.New(handler(slot0, slot0.SetListItem), slot0.list_, SoloHeartDemonListItem)
end

function slot0.SetListItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rankData.rankList[slot1], slot1, 1)
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["difficultyBtn" .. slot4 .. "_"], nil, function ()
			uv0.selectDifficulty = uv1

			uv0:UpdateView()
			uv0:UpdateDifficultyControllerState(uv1)
		end)
	end

	slot0:AddBtnListener(slot0.fightBtn_, nil, function ()
		SoloHeartDemonAction.UpdateViewRedPoint()

		if uv0:CheckIsChallengeTime() then
			gameContext:Go("/sectionSelectHero", {
				section = SoloHeartDemonCfg[uv0.soloHeartDemonID].stage_id[uv0.selectDifficulty][2],
				sectionType = BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON,
				activityID = uv0.activityId
			})
		else
			ShowTips(GetTips("SOLO_HEART_DEMON_TIME_OUT"))
		end
	end)
	slot0:AddBtnListener(slot0.upBtn_, nil, function ()
		JumpTools.GoToSystem("/draw", {
			poolId = DrawTools:GetRoleUpPoolID(uv0.roleID)
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.GoToSystem("/soloHeartDemonReward", {
			activityId = uv0.activityId
		})
	end)
	slot0:AddBtnListener(slot0.chatBtn_, nil, function ()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			soloHeartChange = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	slot0:AddBtnListener(slot0.listGoBtn_, nil, function ()
		JumpTools.GoToSystem("/soloHeartDemonRank", {
			activityId = uv0.activityId
		})
	end)
end

function slot0.CheckIsChallengeTime(slot0)
	return slot0.challengeStage == 0
end

function slot0.UpdateView(slot0)
	if slot0.updateTimer2_ then
		slot0.updateTimer2_:Stop()

		slot0.updateTimer2_ = nil
	end

	for slot4, slot5 in pairs(ActivityCfg.get_id_list_by_activity_template[270]) do
		if ActivityData:GetActivityIsOpen(slot5) then
			slot0.activityId = slot5

			break
		end
	end

	if slot0.selectDifficulty == nil then
		slot0.selectDifficulty = SoloHeartDemonData:GetDataByPara("selectDifficulty") or 3

		SoloHeartDemonData:ResetSelectDifficulty()
	end

	slot0.difficultyData = SoloHeartDemonData:GetDataByPara("difficultyData")
	slot0.soloHeartDemonID = SoloHeartDemonData:GetDataByPara("openEditor")
	slot0.challengeStage = SoloHeartDemonData:GetDataByPara("challengeStage")
	slot0.remainTime = ActivityData:GetActivityRefreshTime(ActivityConst.SOLO_HEART_DEMON)
	slot0.maxCompleteDifficulty = SoloHeartDemonData:GetDataByPara("maxCompleteDifficulty")
	slot0.templateID = SoloHeartDemonCfg[slot0.soloHeartDemonID].heart_damon_id
	slot0.roleID = SoloHeartDemonUICfg[slot0.templateID].hero_id

	slot0:UpdateDifficultyControllerState(slot0.selectDifficulty)
	slot0:OnRankUpdate()
	slot0:LoadModel()

	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/SoloHeartDemonUI/" .. (slot0.selectDifficulty == 3 and "SoloHeartDemonUI_00026" or "SoloHeartDemonUI_00012"))

	if slot0.selectDifficulty == 3 and slot0.hardEffect_.activeSelf == false then
		manager.audio:PlayEffect("minigame_activity_2_4", "minigame_activity_2_4_xinmo_turn", "")
	end

	SetActive(slot0.list.gameObject, slot0.selectDifficulty == 3)
	SetActive(slot0.normalEffect_, slot0.selectDifficulty ~= 3)
	SetActive(slot0.hardEffect_, slot0.selectDifficulty == 3)

	slot0.timeTxt_.text = GetTips(slot0.challengeStage == 0 and "SOLO_HEART_DEMON_CHALLENGE_TIME" or "SOLO_HEART_DEMON_REFRESH_TIME")

	slot0.challengeController:SetSelectedState(slot0.challengeStage == 0 and "normal" or "lock")
	slot0:UpdateDrawView()

	slot0.remainTxt_.text = manager.time:GetLostTimeStr2(slot0.remainTime)
	slot0.updateTimer2_ = Timer.New(function ()
		uv0.remainTxt_.text = manager.time:GetLostTimeStr2(uv0.remainTime)

		if ActivityData:GetActivityIsOpen(ActivityConst.SOLO_HEART_DEMON) == false then
			uv0:Back()
			ShowTips("SOLO_HEART_DEMON_REFRESH_TIPS")

			uv0.currentBossTemplateID = nil
		end
	end, 1, -1, 1)

	slot0.updateTimer2_:Start()
end

function slot0.UpdateDrawView(slot0)
	SetActive(slot0.upBtn_.gameObject, DrawTools:GetRoleUpPoolID(slot0.roleID) ~= false)

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	if DrawTools:GetRoleUpPoolID(slot0.roleID) == false then
		return
	end

	slot1 = 0

	for slot6, slot7 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
		if ActivityData:GetActivityIsOpen(slot7) then
			for slot12, slot13 in ipairs(ActivityDrawPoolCfg[slot7].config_list) do
				if slot13 == DrawTools:GetRoleUpPoolID(slot0.roleID) then
					slot1 = ActivityData:GetActivityData(slot7).stopTime
				end
			end
		end
	end

	slot0.drawRemainTxt_.text = manager.time:GetLostTimeStr2(slot1)
	slot0.updateTimer_ = Timer.New(function ()
		uv0.drawRemainTxt_.text = manager.time:GetLostTimeStr2(uv1)

		if uv1 - manager.time:GetServerTime() <= -1 then
			SetActive(uv0.upBtn_.gameObject, false)
		end
	end, 1, slot1 - manager.time:GetServerTime(), 1)

	slot0.updateTimer_:Start()
end

function slot0.UpdateDifficultyControllerState(slot0, slot1)
	for slot5 = 1, 3 do
		if slot1 == slot5 then
			slot0.difficultyBtnControllerList[slot5]:SetSelectedState(slot0.difficultyData[slot5].challengeState == 2 and "selecfinish" or "select")
		else
			slot0.difficultyBtnControllerList[slot5]:SetSelectedState(slot6.challengeState == 2 and "finish" or "unSelect")
		end
	end
end

function slot0.OnEnter(slot0)
	slot0.exitView_ = false
	slot0.activityId = slot0.params_.activityId

	RankAction.QueryCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)
	manager.ui:SetMainCamera("soloHeartDemon")
	manager.windowBar:SetWhereTag("soloHeartDemon")
	slot0:InitBackScene()
	slot0:InitChat()
	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.InitChat(slot0)
	slot0.lastChatNumber = ChatData:GetWorldChannelNum()

	ChatAction.SetWorldChannelNum(uv0, function (slot0)
		if slot0 == 0 then
			ChatData:SetChannelTimestamp()
			ChatAction.EnterChatUI(3)
		end
	end)
	slot0:RefreshReceiveMessage()
end

function slot0.ClearMsgTimer(slot0)
	if slot0.msgTimer_ then
		slot0.msgTimer_:Stop()

		slot0.msgTimer_ = nil
	end
end

function slot0.RefreshReceiveMessage(slot0)
	slot0:ClearMsgTimer()
	slot0:RefreshWorldChat()

	slot0.msgTimer_ = Timer.New(function ()
		uv0:RefreshWorldChat()
	end, 2, -1)

	slot0.msgTimer_:Start()
end

function slot0.RefreshWorldChat(slot0)
	slot1 = ChatData:GetWorldChatData()

	if slot1[#slot1] then
		slot3 = ""
		slot4 = ""

		if slot2.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or slot2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			slot3 = slot2.id == USER_ID and (PlayerData:GetPlayerInfo().nick or "") or slot2.nick or ""
			slot4 = slot2.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and (slot2.content or "") or string.format("[%s]", ChatStickerCfg[tonumber(slot2.content)].name)
		end

		slot5 = ""

		if slot3 ~= "" then
			slot5 = slot3 .. ":" .. slot4
		end

		slot0.textLimit_:SetText(slot5)

		return
	end

	slot0.textLimit_:SetText("")
end

function slot0.IsShowRank(slot0)
	return manager.time:GetServerTime() < slot0.remainTime - 86400 and slot0.challengeStage == 1
end

function slot0.OnRankUpdate(slot0)
	slot0.rankData = RankData:GetCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

	slot0.rankController:SetSelectedState("mini")

	if slot0.selectDifficulty ~= 3 or slot0.rankData == nil then
		return
	end

	if slot0:IsShowRank() then
		return
	end

	if #slot0.rankData.rankList >= 5 then
		slot0.rankController:SetSelectedState("all")
	end

	slot0.list:StartScroll(5)
end

function slot0.OnSoloDemonHeartUpdate(slot0)
	slot0:UpdateView()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
	manager.redPoint:bindUIandKey(slot0.fightBtn_.transform, RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
	manager.redPoint:unbindUIandKey(slot0.fightBtn_.transform, RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW)
end

function slot0.OnExit(slot0)
	slot0.exitView_ = true

	slot0:ClearMsgTimer()
	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
	slot0:DestroyBackScene()
	slot0:UnloadModel()
	manager.ui:ResetMainCamera()

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	if slot0.updateTimer2_ then
		slot0.updateTimer2_:Stop()

		slot0.updateTimer2_ = nil
	end

	SetActive(slot0.hardEffect_, false)

	if slot0.lastChatNumber == 0 or slot0.lastChatNumber == uv0 then
		slot0.lastChatNumber = 1
	end

	if ChatData:GetWorldChannelNum() ~= uv0 then
		return
	end

	if manager.net.tcpConnection_:GetMachineState() == "connecting" or manager.net.tcpConnection_:GetMachineState() == "connected" then
		ChatAction.SetWorldChannelNum(slot0.lastChatNumber, function (slot0)
			if slot0 == 0 then
				ChatAction.EnterChatUI(2)
				ChatData:SetChannelTimestamp()
			end
		end)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
	manager.windowBar:SetGameHelpKey("SOLO_HEART_DEMON_EXPLAIN")
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot2 = GameDisplayCfg.solo_heart_demon_bg_pos.value
	slot0.backGroundTrs_.localPosition = Vector3(slot2[1], slot2[2], slot2[3])
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot3 = GameDisplayCfg.solo_heart_demon_bg_pos.scale
	slot0.backGroundTrs_.localScale = Vector3(slot3[1], slot3[2], slot3[3])
end

function slot0.DestroyBackScene(slot0)
	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)

		slot0.backGround_ = nil
	end
end

function slot0.UnloadModel(slot0)
	if slot0.bossModel ~= nil then
		manager.resourcePool:DestroyOrReturn(slot0.bossModel, ASSET_TYPE.TPOSE)

		slot0.bossModel = nil

		manager.resourcePool:StopAsyncQuest(slot0.loadIndex)

		slot0.loadIndex = nil
		slot0.currentBossTemplateID = nil
	end
end

function slot0.LoadModel(slot0)
	if slot0.currentBossTemplateID == slot0.templateID then
		return
	end

	slot0:UnloadModel()

	slot0.currentBossTemplateID = slot0.templateID
	slot0.loadIndex = manager.resourcePool:AsyncLoad("Char/" .. SoloHeartDemonUICfg[slot0.templateID].model, ASSET_TYPE.TPOSE, function (slot0)
		if uv0.exitView_ or uv0.currentBossTemplateID ~= uv0.templateID then
			manager.resourcePool:DestroyOrReturn(slot0, ASSET_TYPE.TPOSE)

			return
		end

		slot1 = uv1.model_pos
		slot2 = uv1.model_rot
		slot3 = uv1.model_scale
		uv0.bossModel = slot0
		slot0.transform.localPosition = Vector3(slot1[1], slot1[2], slot1[3])
		slot0.transform.localEulerAngles = Vector3(slot2[1], slot2[2], slot2[3])
		slot0.transform.localScale = Vector3(slot3[1], slot3[2], slot3[3])
	end)
end

return slot0
