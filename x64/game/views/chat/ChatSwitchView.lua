local var_0_0 = class("ChatSwitchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Friends/HomeDialogueUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.toggleItemList_ = {}
	arg_3_0.chatToggleID_ = arg_3_0.params_.chatToggleID
	arg_3_0.worldChatMsgContent_ = nil
	arg_3_0.chatSeek_ = {}
	arg_3_0.historySeek_ = {}

	arg_3_0:AddListeners()

	arg_3_0.bgController_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
	arg_3_0.sendController_ = ControllerUtil.GetController(arg_3_0.transform_, "send")
	arg_3_0.worldController_ = ControllerUtil.GetController(arg_3_0.toggleWorld_.transform, "toggle")
	arg_3_0.guildLockController_ = ControllerUtil.GetController(arg_3_0.toggleGuild_.transform, "name")
	arg_3_0.guildRecruitLockContoller_ = ControllerUtil.GetController(arg_3_0.toggleGuildRecruit_.transform, "name")
	arg_3_0.worldView_ = ChatWorldView.New(arg_3_0.gameObject_)
	arg_3_0.chatStickerView_ = ChatStickerView.New(arg_3_0.goSticker_)

	arg_3_0:InitItemPool()

	local var_3_0 = arg_3_0.viewPort_.rect.height
	local var_3_1 = arg_3_0.goItemParent_:GetComponent("VerticalLayoutGroup").spacing

	arg_3_0.loopScrollView_ = LoopScrollView.New(arg_3_0, arg_3_0.scrollView_, arg_3_0.rectGrid_, arg_3_0.viewPort_, var_3_0, var_3_1, true)
	arg_3_0.switchChannelHandler_ = handler(arg_3_0, arg_3_0.OnSwitchChannel)
	arg_3_0.receiveHandler_ = handler(arg_3_0, arg_3_0.OnReceiveMessage)
	arg_3_0.sendStickerHandler_ = handler(arg_3_0, arg_3_0.OnSendSticker)
	arg_3_0.resetWorldChatHandler_ = handler(arg_3_0, arg_3_0.OnResetWorldChat)
	arg_3_0.resetGuildChatHandler_ = handler(arg_3_0, arg_3_0.OnResetGuildChat)
	arg_3_0.chatReportHandler_ = handler(arg_3_0, arg_3_0.OnChatReport)
	arg_3_0.chatReportHideHandler_ = handler(arg_3_0, arg_3_0.OnHideChatReport)
	arg_3_0.receiveGuildHandler_ = handler(arg_3_0, arg_3_0.OnReceiveGuildMessage)
	arg_3_0.guildExitHandler_ = handler(arg_3_0, arg_3_0.RefreshGuildToggle)
	arg_3_0.guildEnterHandler_ = handler(arg_3_0, arg_3_0.RefreshGuildToggle)
	arg_3_0.revertToggleHandler_ = handler(arg_3_0, arg_3_0.RevertToggle)
end

function var_0_0.SetCamera(arg_4_0)
	if PosterGirlConst.PosterGirlTag.t0 == manager.posterGirl:GetTag() then
		local var_4_0 = manager.posterGirl:GetViewDirect()
		local var_4_1 = HomeSceneSettingData:GetCurScene()

		if var_4_0 ~= 0 then
			local var_4_2 = string.format("chat_%d_%d", var_4_1, var_4_0)

			manager.ui:SetMainCamera(var_4_2)
		else
			local var_4_3 = "chat_" .. var_4_1

			if CameraCfg[var_4_3] then
				manager.ui:SetMainCamera(var_4_3)
			else
				manager.ui:SetMainCamera("chat")
			end
		end
	else
		manager.ui:SetMainCamera("chat")
	end
end

function var_0_0.OnEnter(arg_5_0)
	ChatAction.EnterChatUI(1)
	arg_5_0:RefreshPosterGirl()

	if arg_5_0.params_.ignoreBG ~= true then
		arg_5_0:SetCamera()

		arg_5_0.noNeedCreateModel_ = false
	end

	arg_5_0.bgController_:SetSelectedState(tostring(arg_5_0.params_.ignoreBG == true))

	local var_5_0 = arg_5_0.params_.chatToggleID

	arg_5_0:InitActivityToggleItem()
	arg_5_0:RefreshToggle(var_5_0)

	if arg_5_0.params_.isBack == nil then
		arg_5_0.historySeek_ = {}
	end

	arg_5_0:SwitchToggle()
	arg_5_0:RefreshGuildToggle()
	arg_5_0:RefreshGuildRecruitToggle()
	arg_5_0:RefreshCooperationToggle()
	arg_5_0.chatStickerView_:OnEnter()

	if arg_5_0.worldView_ then
		arg_5_0.worldView_:OnEnter(arg_5_0.params_.soloHeartChange)
	end

	manager.notify:RegistListener(CHAT_NEW_CHANNEL, arg_5_0.switchChannelHandler_)
	manager.notify:RegistListener(CHAT_NEW_MESSAGE, arg_5_0.receiveHandler_)
	manager.notify:RegistListener(CHAT_SEND_STICKER, arg_5_0.sendStickerHandler_)
	manager.notify:RegistListener(CHAT_WORLD_RESET, arg_5_0.resetWorldChatHandler_)
	manager.notify:RegistListener(CHAT_GUILD_RESET, arg_5_0.resetGuildChatHandler_)
	manager.notify:RegistListener(CHAT_REPORT, arg_5_0.chatReportHandler_)
	manager.notify:RegistListener(CHAT_REPORT_HIDE, arg_5_0.chatReportHideHandler_)
	manager.notify:RegistListener(CHAT_GUILD_NEW_MESSAGE, arg_5_0.receiveGuildHandler_)
	manager.notify:RegistListener(GUILD_EXIT, arg_5_0.guildExitHandler_)
	manager.notify:RegistListener(GUILD_ENTER, arg_5_0.guildEnterHandler_)
	manager.notify:RegistListener(CHAT_REVERT_TOGGLE, arg_5_0.revertToggleHandler_)
	arg_5_0:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, handler(arg_5_0, arg_5_0.OnReceiveCooperationMessage))
	arg_5_0:RegistEventListener(CHAT_COOPERATION_RESET, handler(arg_5_0, arg_5_0.OnResetCooperationChat))
	arg_5_0:OnHideChatReport()
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0:StopReguireMessageTimer()
	arg_6_0:SaveScrollPos()
	arg_6_0:RemoveAllEventListener()
	manager.notify:RemoveListener(CHAT_NEW_CHANNEL, arg_6_0.switchChannelHandler_)
	manager.notify:RemoveListener(CHAT_NEW_MESSAGE, arg_6_0.receiveHandler_)
	manager.notify:RemoveListener(CHAT_SEND_STICKER, arg_6_0.sendStickerHandler_)
	manager.notify:RemoveListener(CHAT_WORLD_RESET, arg_6_0.resetWorldChatHandler_)
	manager.notify:RemoveListener(CHAT_GUILD_RESET, arg_6_0.resetGuildChatHandler_)
	manager.notify:RemoveListener(CHAT_REPORT, arg_6_0.chatReportHandler_)
	manager.notify:RemoveListener(CHAT_REPORT_HIDE, arg_6_0.chatReportHideHandler_)
	manager.notify:RemoveListener(CHAT_GUILD_NEW_MESSAGE, arg_6_0.receiveGuildHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, arg_6_0.guildExitHandler_)
	manager.notify:RemoveListener(GUILD_ENTER, arg_6_0.guildEnterHandler_)
	manager.notify:RemoveListener(CHAT_REVERT_TOGGLE, arg_6_0.revertToggleHandler_)
	arg_6_0.chatStickerView_:OnExit()

	if arg_6_0.worldView_ then
		arg_6_0.worldView_:OnExit()
	end

	if arg_6_0.params_.ignoreBG ~= true then
		manager.ui:ResetMainCamera()
	end

	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
end

function var_0_0.OnUpdate(arg_7_0)
	if arg_7_0.chatToggleID_ == arg_7_0.params_.chatToggleID then
		return
	end

	arg_7_0:SaveScrollPos()
	arg_7_0:SwitchToggle()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:DisposeItemPool()

	arg_8_0.switchChannelHandler_ = nil
	arg_8_0.receiveHandler_ = nil
	arg_8_0.sendStickerHandler_ = nil
	arg_8_0.chatReportHandler_ = nil
	arg_8_0.chatReportHideHandler_ = nil
	arg_8_0.receiveGuildHandler_ = nil
	arg_8_0.resetWorldChatHandler_ = nil
	arg_8_0.resetGuildChatHandler_ = nil
	arg_8_0.guildExitHandler_ = nil
	arg_8_0.guildEnterHandler_ = nil
	arg_8_0.revertToggleHandler_ = nil

	if arg_8_0.loopScrollView_ then
		arg_8_0.loopScrollView_:Dispose()

		arg_8_0.loopScrollView_ = nil
	end

	if arg_8_0.worldView_ then
		arg_8_0.worldView_:Dispose()

		arg_8_0.worldView_ = nil
	end

	if arg_8_0.chatStickerView_ then
		arg_8_0.chatStickerView_:Dispose()

		arg_8_0.chatStickerView_ = nil
	end

	arg_8_0.noNeedCreateModel_ = true

	for iter_8_0, iter_8_1 in pairs(arg_8_0.toggleItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.toggleItemList_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.buttonClosePanel_, nil, function()
		arg_9_0:Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonClose_, nil, function()
		arg_9_0:Back()
	end)
	arg_9_0:AddToggleListener(arg_9_0.toggleWorld_, function(arg_12_0)
		if arg_12_0 then
			arg_9_0:Go("chat", {
				chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
			})
		end
	end)
	arg_9_0:AddToggleListener(arg_9_0.toggleGuild_, function(arg_13_0)
		if arg_13_0 then
			arg_9_0:Go("chat", {
				chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
			})
		end
	end)
	arg_9_0:AddToggleListener(arg_9_0.toggleCooperation_, function(arg_14_0)
		if arg_14_0 then
			arg_9_0:Go("chat", {
				chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
			})
		end
	end)
	arg_9_0:AddToggleListener(arg_9_0.toggleGuildRecruit_, function(arg_15_0)
		if arg_15_0 then
			local var_15_0 = PlayerData:GetPlayerInfo().userLevel
			local var_15_1 = GameSetting.club_recruit_unlock_level.value[1]

			if var_15_0 < var_15_1 then
				ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_15_1))
				arg_9_0:RefreshToggle(arg_9_0.chatToggleID_)
			else
				arg_9_0:Go("chat", {
					chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_RECRUIT
				})
			end
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonSend_, nil, function()
		if arg_9_0.inputField_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if ChatData:IsMuted() then
			arg_9_0.inputField_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		if IsAllSpace(arg_9_0.inputField_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			arg_9_0.inputField_.text = ""

			return
		end

		local var_16_0 = GameSetting.chat_length_max.value[1]
		local var_16_1, var_16_2 = textLimit(arg_9_0.inputField_.text, var_16_0)

		arg_9_0.inputField_.text = GetI18NText(var_16_1)

		if not var_16_2 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_16_0))

			return
		end

		if not nameRule(var_16_1, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(arg_9_0.inputField_.text, function(arg_17_0, arg_17_1)
			if not arg_17_0 then
				ShowTips("SENSITIVE_WORD")
			else
				if arg_9_0.inputField_.text == "" then
					return
				end

				if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
					ShowTips("SEND_MESSAGE_FREQUENTLY")

					return
				end

				if arg_9_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
					ChatAction.SendMsg(arg_9_0.inputField_.text, arg_17_1, function(arg_18_0)
						arg_9_0:SendMessageResult(arg_18_0)
					end)
				elseif arg_9_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
					if GuildData:GetGuildInfo().id == nil then
						ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

						return
					end

					ChatAction.SendGuildMsg(arg_9_0.inputField_.text, arg_17_1, function(arg_19_0)
						arg_9_0:SendMessageResult(arg_19_0)
					end)
				elseif arg_9_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
					ChatAction.SendGuildRecruitMsg(arg_9_0.inputField_.text, arg_17_1, function(arg_20_0)
						arg_9_0:SendMessageResult(arg_20_0)
					end)
				elseif arg_9_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
					if not CooperationData:CheckInRoom() then
						ShowTips("ERROR_INVALID_OPERATION")

						return
					end

					ChatAction.SendCooperationdMsg(arg_9_0.inputField_.text, arg_17_1, function(arg_21_0)
						arg_9_0:SendMessageResult(arg_21_0)
					end)
				else
					if ChatToggleCfg[arg_9_0.chatToggleID_] and not ChatTools.IsOpenChatChannel(arg_9_0.chatToggleID_) then
						ShowTips("TIME_OVER")

						return
					end

					ChatAction.SendChatNormalMsg(arg_9_0.chatToggleID_, arg_9_0.inputField_.text, arg_17_1, function(arg_22_0)
						arg_9_0:SendMessageResult(arg_22_0)
					end)
				end
			end
		end, arg_9_0:GetChatJudgeMessageType())
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonSticker_, nil, function()
		SetActive(arg_9_0.goStickerHide_, true)
		arg_9_0.chatStickerView_:Show(true)
		SetActive(arg_9_0.listBgGo_, true)
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonStickerHide_, nil, function()
		arg_9_0:HideStickerPanel()
		arg_9_0:OnHideChatReport()
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonNewMsg_, nil, function()
		arg_9_0.loopScrollView_:Scroll2End()

		if arg_9_0.chatSeek_[arg_9_0.chatToggleID_] == #arg_9_0:LsGetItemData() then
			SetActive(arg_9_0.goNewMsg_, false)

			if arg_9_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
				ChatGuildData:SaveRecordCnt()
			elseif ChatToggleCfg[arg_9_0.chatToggleID_] then
				ChatChannelData:SaveRecordCnt(arg_9_0.chatToggleID_)
			end
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonReport_, nil, function()
		arg_9_0:OnHideChatReport()
		SetActive(arg_9_0.goStickerHide_, false)
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.CONTENT,
			reportData = arg_9_0.reportData_
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonInfo_, nil, function()
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
end

function var_0_0.InitActivityToggleItem(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.toggleItemList_) do
		iter_28_1:Show(false)
	end

	for iter_28_2, iter_28_3 in pairs(ChatToggleCfg.all) do
		if iter_28_3 == ChatConst.CHAT_CHANNEL_MOON_CAKE and manager.windowBar:GetWhereTag() == "guildActivitySP" then
			-- block empty
		else
			local var_28_0 = ChatToggleCfg[iter_28_3]

			if ChatTools.IsOpenChatChannel(iter_28_3) then
				arg_28_0.toggleItemList_[iter_28_3] = arg_28_0.toggleItemList_[iter_28_3] or arg_28_0:GetToggleView(iter_28_3)

				arg_28_0.toggleItemList_[iter_28_3]:Show(true)
			end
		end
	end
end

function var_0_0.GetToggleView(arg_29_0, arg_29_1)
	if arg_29_1 == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		return ChatToggleGuildActivityView.New(arg_29_0.toggleItem_, arg_29_0.toggleParent_, arg_29_1)
	elseif arg_29_1 == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4 or arg_29_1 == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8 then
		return ChatToggleGuildActivitySPView.New(arg_29_0.toggleItem_, arg_29_0.toggleParent_, arg_29_1)
	else
		return ChatToggleBaseView.New(arg_29_0.toggleItem_, arg_29_0.toggleParent_, arg_29_1)
	end
end

function var_0_0.RevertToggle(arg_30_0)
	arg_30_0:RefreshToggle(arg_30_0.chatToggleID_)
end

function var_0_0.RefreshToggle(arg_31_0, arg_31_1)
	if arg_31_1 == ChatConst.CHAT_CHANNEL_WORLD then
		arg_31_0.toggleWorld_.isOn = true
	elseif arg_31_1 == ChatConst.CHAT_CHANNEL_GUILD then
		arg_31_0.toggleGuild_.isOn = true
	elseif arg_31_1 == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		arg_31_0.toggleGuildRecruit_.isOn = true
	elseif arg_31_1 == ChatConst.CHAT_CHANNEL_COOPERATION then
		arg_31_0.toggleCooperation_.isOn = true
	else
		arg_31_0.toggleItemList_[arg_31_1]:IsOn()
	end
end

function var_0_0.SwitchToggle(arg_32_0)
	arg_32_0.chatToggleID_ = arg_32_0.params_.chatToggleID

	if arg_32_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		arg_32_0.sendController_:SetSelectedState("false")
		arg_32_0:AddReguireMessageTimer()
	elseif ChatToggleCfg[arg_32_0.chatToggleID_] ~= nil then
		local var_32_0 = ChatToggleCfg[arg_32_0.chatToggleID_]

		if var_32_0.hide_send_btn == 1 then
			arg_32_0.sendController_:SetSelectedState("false")
		else
			arg_32_0.sendController_:SetSelectedState("true")
		end

		if var_32_0.require_type[1] == ChatConst.REQUIRE_TYPE.MANUAL then
			arg_32_0:AddReguireMessageTimer()
		end
	else
		arg_32_0.sendController_:SetSelectedState("true")
	end

	arg_32_0.loopScrollView_:SetContentHeight(arg_32_0.viewPort_.rect.height)
	SetActive(arg_32_0.goGuildTips_, false)
	arg_32_0.worldController_:SetSelectedState("off")

	if arg_32_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		arg_32_0.worldController_:SetSelectedState("on")
	elseif arg_32_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:InitCacheGuildContent()

		local var_32_1 = ChatGuildData:InitCacheGuildContent()

		if var_32_1 == 0 or var_32_1 == #ChatGuildData:GetCacheContent() then
			-- block empty
		else
			arg_32_0.historySeek_[arg_32_0.chatToggleID_] = {
				verticalNormalizedPosition = 1,
				index = var_32_1
			}
		end

		if not GuildData:GetGuildInfo().id then
			SetActive(arg_32_0.goGuildTips_, true)
			ShowTips("NEED_JOIN_CLUB")
		end
	elseif arg_32_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
	elseif ChatToggleCfg[arg_32_0.chatToggleID_] then
		ChatChannelData:InitCacheContent(arg_32_0.chatToggleID_)
	elseif arg_32_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		local var_32_2 = ChatCooperationData:InitCacheCooperationContent()

		if var_32_2 == 0 or var_32_2 == #ChatCooperationData:GetCacheContent() then
			-- block empty
		else
			arg_32_0.historySeek_[arg_32_0.chatToggleID_] = {
				verticalNormalizedPosition = 1,
				index = var_32_2
			}
		end

		arg_32_0.worldController_:SetSelectedState("off")
		SetActive(arg_32_0.goGuildTips_, false)
	end

	if arg_32_0.historySeek_[arg_32_0.chatToggleID_] then
		arg_32_0.loopScrollView_:RestoredScroll(arg_32_0.historySeek_[arg_32_0.chatToggleID_].index, arg_32_0.historySeek_[arg_32_0.chatToggleID_].verticalNormalizedPosition)
	else
		arg_32_0.loopScrollView_:Scroll2End()
	end

	arg_32_0.chatSeek_[arg_32_0.chatToggleID_] = arg_32_0.chatSeek_[arg_32_0.chatToggleID_] or 0

	SetActive(arg_32_0.goNewMsg_, arg_32_0.chatSeek_[arg_32_0.chatToggleID_] < #arg_32_0:LsGetItemData())
end

function var_0_0.OnSwitchChannel(arg_33_0)
	if arg_33_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		arg_33_0.loopScrollView_:Scroll2End()
	end
end

function var_0_0.OnChatReport(arg_34_0, arg_34_1)
	arg_34_0.transformReport_:SetParent(arg_34_1.parentRect.transform, false)

	arg_34_0.transformReport_.localPosition = Vector2(arg_34_1.x, arg_34_1.y)
	arg_34_0.reportData_ = arg_34_1.reportData

	SetActive(arg_34_0.goReportTips_, true)
	SetActive(arg_34_0.goStickerHide_, true)
end

function var_0_0.OnHideChatReport(arg_35_0)
	SetActive(arg_35_0.goReportTips_, false)
end

function var_0_0.OnReceiveMessage(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.chatToggleID

	if arg_36_0.chatToggleID_ ~= var_36_0 then
		return
	end

	if arg_36_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		arg_36_0:RefreshReceiveMessage()
	elseif arg_36_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		if #arg_36_0.loopScrollView_:GetItemList() <= 0 then
			arg_36_0.loopScrollView_:Scroll2End()
		else
			arg_36_0.loopScrollView_:RefreshScrollView(true, true)
		end
	elseif ChatToggleCfg[arg_36_0.chatToggleID_] then
		arg_36_0:RefreshReceiveMessage()
	end
end

function var_0_0.OnReceiveGuildMessage(arg_37_0)
	if arg_37_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		arg_37_0:RefreshReceiveMessage()
	end
end

function var_0_0.OnReceiveCooperationMessage(arg_38_0)
	if arg_38_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		arg_38_0:RefreshReceiveMessage()
	end
end

function var_0_0.RefreshReceiveMessage(arg_39_0)
	local var_39_0 = arg_39_0:LsGetItemData()[#arg_39_0:LsGetItemData()]

	if var_39_0 == nil then
		return
	end

	for iter_39_0 = arg_39_0.chatSeek_[arg_39_0.chatToggleID_] + 1, #arg_39_0:LsGetItemData() do
		if arg_39_0:LsGetItemData()[iter_39_0].id == USER_ID then
			arg_39_0.loopScrollView_:Scroll2End()

			return
		end
	end

	if var_39_0.id == USER_ID then
		arg_39_0.loopScrollView_:Scroll2End()

		return
	end

	if not arg_39_0.loopScrollView_:IsFillContent() or arg_39_0.scrollView_.verticalNormalizedPosition <= 0.01 then
		arg_39_0.loopScrollView_:Scroll2End()

		return
	end

	SetActive(arg_39_0.goNewMsg_, true)
end

function var_0_0.SendMessageResult(arg_40_0, arg_40_1)
	if isSuccess(arg_40_1.result) then
		ChatData:SetSendTextTimestamp()

		arg_40_0.inputField_.text = ""
	elseif arg_40_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function()
				arg_40_0:Back()
			end
		})
	elseif arg_40_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		arg_40_0.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(arg_40_1.result)
	end
end

function var_0_0.OnSendSticker(arg_42_0, arg_42_1)
	if ChatToggleCfg[arg_42_0.chatToggleID_] and not ChatTools.IsOpenChatChannel(arg_42_0.chatToggleID_) then
		ShowTips("TIME_OVER")

		return
	end

	arg_42_0:HideStickerPanel()

	if ChatData:IsMuted() then
		arg_42_0.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	end

	if manager.time:GetServerTime() - ChatData:GetSendStickerTimestamp() < 10 then
		ShowTips("SEND_STICKER_FREQUENTLY")

		return
	end

	if arg_42_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		ChatAction.SendSticker(arg_42_1, function(arg_43_0)
			arg_42_0:SendStickerResult(arg_43_0)
		end)
	elseif arg_42_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		if GuildData:GetGuildInfo().id == nil then
			ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

			return
		end

		ChatAction.SendGuildSticker(arg_42_1, function(arg_44_0)
			arg_42_0:SendStickerResult(arg_44_0)
		end)
	elseif arg_42_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatAction.SendGuildRecruitSticker(arg_42_1, function(arg_45_0)
			arg_42_0:SendStickerResult(arg_45_0)
		end)
	elseif ChatToggleCfg[arg_42_0.chatToggleID_] then
		ChatAction.SendChatNormalSticker(arg_42_0.chatToggleID_, arg_42_1, function(arg_46_0)
			arg_42_0:SendStickerResult(arg_46_0)
		end)
	elseif arg_42_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		if not CooperationData:CheckInRoom() then
			ShowTips("ERROR_INVALID_OPERATION")

			return
		end

		ChatAction.SendCooperationSticker(arg_42_1, function(arg_47_0)
			arg_42_0:SendStickerResult(arg_47_0)
		end)
	else
		ShowTips("SEND_MESSAGE_ERROR")
	end
end

function var_0_0.SendStickerResult(arg_48_0, arg_48_1)
	if isSuccess(arg_48_1.result) then
		ChatData:SetSendStickerTimestamp()
	elseif arg_48_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function()
				arg_48_0:Back()
			end
		})
	elseif arg_48_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		arg_48_0.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(arg_48_1.result)
	end
end

function var_0_0.HideStickerPanel(arg_50_0)
	SetActive(arg_50_0.goStickerHide_, false)
	arg_50_0.chatStickerView_:Show(false)
	SetActive(arg_50_0.listBgGo_, false)
end

function var_0_0.OnResetWorldChat(arg_51_0)
	if arg_51_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[arg_51_0.chatToggleID_] then
		if ChatToggleCfg[arg_51_0.chatToggleID_] then
			ChatChannelData:InitCacheContent(arg_51_0.chatToggleID_)
		end

		arg_51_0.loopScrollView_:RefreshScrollView(true)
	end
end

function var_0_0.OnResetGuildChat(arg_52_0)
	if arg_52_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:InitCacheGuildContent()
		arg_52_0.loopScrollView_:RefreshScrollView(true)
	elseif arg_52_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
		arg_52_0.loopScrollView_:RefreshScrollView(true)
	end
end

function var_0_0.OnResetCooperationChat(arg_53_0)
	if arg_53_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		arg_53_0.loopScrollView_:RefreshScrollView(true)
	end
end

function var_0_0.RefreshGuildToggle(arg_54_0)
	local var_54_0 = GuildData:GetGuildInfo()

	arg_54_0.guildLockController_:SetSelectedState(tostring(var_54_0.id == nil))
end

function var_0_0.RefreshGuildRecruitToggle(arg_55_0)
	local var_55_0 = PlayerData:GetPlayerInfo().userLevel
	local var_55_1 = GameSetting.club_recruit_unlock_level.value[1]

	arg_55_0.guildRecruitLockContoller_:SetSelectedState(tostring(var_55_0 < var_55_1))
end

function var_0_0.RefreshCooperationToggle(arg_56_0)
	if arg_56_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		SetActive(arg_56_0.toggleCooperation_.gameObject, true)
	else
		SetActive(arg_56_0.toggleCooperation_.gameObject, false)
	end
end

function var_0_0.SaveScrollPos(arg_57_0)
	local var_57_0 = arg_57_0.loopScrollView_:GetItemList()[1]

	if var_57_0 then
		arg_57_0.historySeek_[arg_57_0.chatToggleID_] = {
			index = var_57_0.itemView:GetIndex(),
			verticalNormalizedPosition = arg_57_0.scrollView_.verticalNormalizedPosition
		}
	end
end

function var_0_0.RefreshPosterGirl(arg_58_0)
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.chat)
end

function var_0_0.AddReguireMessageTimer(arg_59_0)
	arg_59_0:TryToRequireMsg()

	if arg_59_0.reguireMessageTimer_ ~= nil then
		return
	end

	arg_59_0.reguireMessageTimer_ = Timer.New(function()
		arg_59_0:TryToRequireMsg()
	end, 1, -1)

	arg_59_0.reguireMessageTimer_:Start()
end

function var_0_0.StopReguireMessageTimer(arg_61_0)
	if arg_61_0.reguireMessageTimer_ then
		arg_61_0.reguireMessageTimer_:Stop()

		arg_61_0.reguireMessageTimer_ = nil
	end
end

function var_0_0.TryToRequireMsg(arg_62_0)
	if arg_62_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT and manager.time:GetServerTime() - ChatGuildRecruitData:GetLastTimestamp() > GameSetting.chat_club_refresh_time.value[1] then
		ChatAction.RequireGuildShareInfo()
	elseif ChatToggleCfg[arg_62_0.chatToggleID_] and ChatToggleCfg[arg_62_0.chatToggleID_].require_type[1] == ChatConst.REQUIRE_TYPE.MANUAL and ChatToggleCfg[arg_62_0.chatToggleID_].require_type[2][1] < manager.time:GetServerTime() - ChatChannelData:GetLastRequireMsgTimestamp(arg_62_0.chatToggleID_) then
		ChatAction.RequireChatNormalMsg(arg_62_0.chatToggleID_)
	end
end

function var_0_0.LsGetItemData(arg_63_0)
	if arg_63_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		return ChatData:GetWorldChatData()
	elseif arg_63_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		return ChatGuildData:GetCacheContent()
	elseif arg_63_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		return ChatGuildRecruitData:GetChatData()
	elseif ChatToggleCfg[arg_63_0.chatToggleID_] then
		return ChatChannelData:GetCacheContent(arg_63_0.chatToggleID_)
	elseif arg_63_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		return ChatCooperationData:GetCacheContent()
	else
		return {}
	end
end

function var_0_0.LsAddItem(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0

	if arg_64_1.contentType == ChatConst.CHAT_CONTENT_TYPE.CHANNEL then
		var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemChannelPool_, function()
			return ChatChannelView.New(arg_64_0.goChannelTitle_, arg_64_0.goItemParent_)
		end)
	elseif arg_64_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
		var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemTimePool_, function()
			return ChatTimeView.New(arg_64_0.goTimeStamp_, arg_64_0.goItemParent_)
		end)
	elseif arg_64_1.contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
		var_64_0 = arg_64_0:GetFreeItem(arg_64_0.historyTipsPool_, function()
			return ChatFriendHistoryTipsItem.New(arg_64_0.goHistoryTips_, arg_64_0.goItemParent_)
		end)
	elseif arg_64_1.contentType == ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT then
		if arg_64_1.id == tostring(PlayerData:GetPlayerInfo().userID) then
			var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemSelfGuildRecruitPool_, function()
				return ChatGuildRecruitItemView.New(arg_64_0.goSelfGuildRecruitItem_, arg_64_0.goItemParent_)
			end)
		else
			var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemFriendGuildRecruitPool_, function()
				return ChatGuildRecruitItemView.New(arg_64_0.goFriendGuildRecruitItem_, arg_64_0.goItemParent_)
			end)
		end
	elseif arg_64_1.contentType == ChatConst.CHAT_CONTENT_TYPE.JUMP then
		local var_64_1 = arg_64_1.id == tostring(PlayerData:GetPlayerInfo().userID)
		local var_64_2 = arg_64_0:GetJumpItemClass()

		if var_64_1 then
			var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemSelfJumpPool_, function()
				return var_64_2.New(arg_64_0.goSelfJumpItem_, arg_64_0.goItemParent_)
			end)
		else
			var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemFriendJumptPool_, function()
				return var_64_2.New(arg_64_0.goFriendJumpItem_, arg_64_0.goItemParent_)
			end)
		end
	elseif arg_64_1.id == tostring(PlayerData:GetPlayerInfo().userID) then
		var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemSelfPool_, function()
			return ChatItemView.New(arg_64_0.goSelfItem_, arg_64_0.goItemParent_, arg_64_0.scrollView_)
		end)
	else
		var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemFriendPool_, function()
			return ChatItemView.New(arg_64_0.goFriendItem_, arg_64_0.goItemParent_, arg_64_0.scrollView_)
		end)
	end

	var_64_0.itemView:SetData(arg_64_1, arg_64_2)

	arg_64_0.chatSeek_[arg_64_0.chatToggleID_] = arg_64_0.chatSeek_[arg_64_0.chatToggleID_] or 0

	if arg_64_2 > arg_64_0.chatSeek_[arg_64_0.chatToggleID_] then
		arg_64_0.chatSeek_[arg_64_0.chatToggleID_] = arg_64_2
	end

	if arg_64_2 >= #arg_64_0:LsGetItemData() then
		SetActive(arg_64_0.goNewMsg_, false)
	end

	if arg_64_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:SaveRecordCnt()
	elseif ChatToggleCfg[arg_64_0.chatToggleID_] then
		ChatChannelData:SaveRecordCnt(arg_64_0.chatToggleID_)
	end

	return var_64_0
end

function var_0_0.LsRemoveItem(arg_74_0, arg_74_1)
	arg_74_1.itemView:Show(false)

	arg_74_1.isFree = true
end

function var_0_0.GetJumpItemClass(arg_75_0)
	if arg_75_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_MOON_CAKE then
		return MoonCakeChatJumpItemView
	else
		return ChatJumpItemView
	end
end

function var_0_0.InitItemPool(arg_76_0)
	arg_76_0.itemChannelPool_ = {}
	arg_76_0.itemTimePool_ = {}
	arg_76_0.itemSelfPool_ = {}
	arg_76_0.itemFriendPool_ = {}
	arg_76_0.itemSelfGuildRecruitPool_ = {}
	arg_76_0.itemFriendGuildRecruitPool_ = {}
	arg_76_0.historyTipsPool_ = {}
	arg_76_0.itemSelfJumpPool_ = {}
	arg_76_0.itemFriendJumptPool_ = {}
end

function var_0_0.GetFreeItem(arg_77_0, arg_77_1, arg_77_2)
	for iter_77_0, iter_77_1 in pairs(arg_77_1) do
		if iter_77_1.isFree == true then
			iter_77_1.isFree = false

			return iter_77_1
		end
	end

	local var_77_0 = {
		isFree = false,
		itemView = arg_77_2()
	}

	table.insert(arg_77_1, var_77_0)

	return var_77_0
end

function var_0_0.DisposeItemPool(arg_78_0)
	for iter_78_0, iter_78_1 in ipairs(arg_78_0.itemChannelPool_) do
		iter_78_1.itemView:Dispose()
	end

	arg_78_0.itemChannelPool_ = nil

	for iter_78_2, iter_78_3 in ipairs(arg_78_0.itemTimePool_) do
		iter_78_3.itemView:Dispose()
	end

	arg_78_0.itemTimePool_ = nil

	for iter_78_4, iter_78_5 in ipairs(arg_78_0.itemSelfPool_) do
		iter_78_5.itemView:Dispose()
	end

	arg_78_0.itemSelfPool_ = nil

	for iter_78_6, iter_78_7 in ipairs(arg_78_0.itemFriendPool_) do
		iter_78_7.itemView:Dispose()
	end

	arg_78_0.itemFriendPool_ = nil

	for iter_78_8, iter_78_9 in ipairs(arg_78_0.itemSelfGuildRecruitPool_) do
		iter_78_9.itemView:Dispose()
	end

	for iter_78_10, iter_78_11 in ipairs(arg_78_0.itemFriendGuildRecruitPool_) do
		iter_78_11.itemView:Dispose()
	end

	for iter_78_12, iter_78_13 in ipairs(arg_78_0.historyTipsPool_) do
		iter_78_13.itemView:Dispose()
	end

	for iter_78_14, iter_78_15 in ipairs(arg_78_0.itemSelfJumpPool_) do
		iter_78_15.itemView:Dispose()
	end

	arg_78_0.itemSelfJumpPool_ = nil

	for iter_78_16, iter_78_17 in ipairs(arg_78_0.itemFriendJumptPool_) do
		iter_78_17.itemView:Dispose()
	end

	arg_78_0.itemFriendJumptPool_ = nil
end

function var_0_0.OnExitInput(arg_79_0)
	JumpTools.Back()

	return true
end

function var_0_0.GetChatJudgeMessageType(arg_80_0, arg_80_1)
	local var_80_0 = ({
		[ChatConst.CHAT_CHANNEL_WORLD] = JUDGE_MESSAGE_TYPE.CHAT_WORLD,
		[ChatConst.CHAT_CHANNEL_GUILD] = JUDGE_MESSAGE_TYPE.CHAT_GUILD,
		[ChatConst.CHAT_CHANNEL_GUILD_RECRUIT] = JUDGE_MESSAGE_TYPE.GUILD_SHARE,
		[ChatConst.CHAT_CHANNEL_COOPERATION] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_MOON_CAKE] = JUDGE_MESSAGE_TYPE.ACTIVITY_MOON_CAKE
	})[arg_80_1]

	if var_80_0 then
		return var_80_0
	end
end

return var_0_0
