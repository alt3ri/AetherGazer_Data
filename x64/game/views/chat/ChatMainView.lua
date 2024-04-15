slot0 = class("ChatMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Chat/HomeDialogueUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.chatToggleID_ = 0
	slot0.curfriendID_ = nil
	slot0.activityTabItemList_ = {}
	slot0.chatSeek_ = {}
	slot0.historySeek_ = {}

	slot0:InitItemPool()

	slot0.bugText_.text = GetI18NText("招募")
	slot0.loopScrollView_ = LoopScrollView.New(slot0, slot0.diaScrollEx_, slot0.diaGridTrs_, slot0.diaViewPortTrs_, slot0.diaViewPortTrs_.rect.height, slot0.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing, true)
	slot0.friendsLuaUIlist_ = LuaList.New(handler(slot0, slot0.IndexFriendsItem), slot0.friendsUIlist_, ChatFriendsTabItem)
	slot0.chatStickerView_ = ChatStickerView.New(slot0.stickerGo_)
	slot0.emptyStateController_ = slot0.mainControllerEx_:GetController("emptyState")
	slot0.tabStateController_ = slot0.mainControllerEx_:GetController("tabState")
	slot0.blurStateController_ = slot0.mainControllerEx_:GetController("blurState")
	slot0.worldTabStateController_ = slot0.mainControllerEx_:GetController("worldTabState")
	slot0.guildTabStateController_ = slot0.mainControllerEx_:GetController("guildTabState")
	slot0.recruitTabStateController_ = slot0.mainControllerEx_:GetController("recruitTabState")
	slot0.cooperTabStateController_ = slot0.mainControllerEx_:GetController("cooperTabState")
	slot0.onlineStateController_ = slot0.mainControllerEx_:GetController("friendOnlineState")
	slot0.soloStateController_ = slot0.mainControllerEx_:GetController("soloState")
	slot0.sendCDStateController_ = slot0.mainControllerEx_:GetController("sendCD")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.worldTabBtn_, nil, function ()
		uv0:RefreshToggle(ChatConst.CHAT_CHANNEL_WORLD)
	end)
	slot0:AddBtnListener(slot0.guildTabBtn_, nil, function ()
		uv0:RefreshToggle(ChatConst.CHAT_CHANNEL_GUILD)
	end)
	slot0:AddBtnListener(slot0.recruitTabBtn_, nil, function ()
		if PlayerData:GetPlayerInfo().userLevel < GameSetting.club_recruit_unlock_level.value[1] then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1))
		else
			uv0:RefreshToggle(ChatConst.CHAT_CHANNEL_GUILD_RECRUIT)
		end
	end)
	slot0:AddBtnListener(slot0.cooperTabBtn_, nil, function ()
		uv0:RefreshToggle(ChatConst.CHAT_CHANNEL_COOPERATION)
	end)
	slot0:AddBtnListener(slot0.sendCDBtn_, nil, function ()
		if uv0.sendInputfield_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if IsAllSpace(uv0.sendInputfield_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			uv0.sendInputfield_.text = ""

			return
		end

		ShowTips("SEND_MESSAGE_FREQUENTLY")
	end)
	slot0:AddBtnListener(slot0.sendBtn_, nil, function ()
		if uv0.sendInputfield_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if ChatData:IsMuted() then
			uv0.sendInputfield_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		if IsAllSpace(uv0.sendInputfield_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			uv0.sendInputfield_.text = ""

			return
		end

		slot1, slot2 = textLimit(uv0.sendInputfield_.text, GameSetting.chat_length_max.value[1])
		uv0.sendInputfield_.text = GetI18NText(slot1)

		if not slot2 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), slot0))

			return
		end

		if not nameRule(slot1, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(uv0.sendInputfield_.text, function (slot0, slot1)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")
			else
				if uv0.sendInputfield_.text == "" then
					return
				end

				Debug.Log("当前时间：" .. manager.time:GetServerTime())
				Debug.Log("最近发言时间：" .. ChatData:GetSendTextTimestamp())

				if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
					ShowTips("SEND_MESSAGE_FREQUENTLY")

					return
				end

				if uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
					ChatAction.SendMsg(uv0.sendInputfield_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
					if GuildData:GetGuildInfo().id == nil then
						ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

						return
					end

					ChatAction.SendGuildMsg(uv0.sendInputfield_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
					ChatAction.SendGuildRecruitMsg(uv0.sendInputfield_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
					if not CooperationData:CheckInRoom() then
						ShowTips("ERROR_INVALID_OPERATION")

						return
					end

					ChatAction.SendCooperationdMsg(uv0.sendInputfield_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
					ChatAction.SendFriendMsg(uv0.curfriendID_, uv0.sendInputfield_.text, slot1, function (slot0)
						if isSuccess(slot0.result) then
							ChatData:SetSendTextTimestamp()

							uv0.sendInputfield_.text = ""
						elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
							uv0.sendInputfield_.text = ""

							JumpTools.OpenPageByJump("chatMuted")

							return
						else
							ShowTips(slot0.result)
						end
					end)
				else
					if ChatToggleCfg[uv0.chatToggleID_] and not ChatTools.IsOpenChatChannel(uv0.chatToggleID_) then
						ShowTips("TIME_OVER")

						return
					end

					ChatAction.SendChatNormalMsg(uv0.chatToggleID_, uv0.sendInputfield_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				end
			end
		end, uv0:GetChatJudgeMessageType())
	end)
	slot0:AddBtnListener(slot0.stickerBtn_, nil, function ()
		uv0.chatStickerView_:Show(true)
	end)
	slot0:AddBtnListener(slot0.stickerHideBtn_, nil, function ()
		uv0:HideStickerPanel()
		uv0:OnHideChatReport()
	end)
	slot0:AddBtnListener(slot0.newJumpBtn_, nil, function ()
		uv0.loopScrollView_:Scroll2End()

		if uv0.chatSeek_[uv0.chatToggleID_] == #uv0:LsGetItemData() then
			SetActive(uv0.newJumpBtn_.gameObject, false)

			if uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
				ChatGuildData:SaveRecordCnt()
			elseif ChatToggleCfg[uv0.chatToggleID_] then
				ChatChannelData:SaveRecordCnt(uv0.chatToggleID_)
			end
		end
	end)
	slot0:AddBtnListener(slot0.reportBtn_, nil, function ()
		uv0:OnHideChatReport()
		uv0:HideStickerPanel()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.CONTENT,
			reportData = uv0.reportData_
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	slot0:AddBtnListener(slot0.userSettingBtn_, nil, function ()
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	slot0:AddToggleListener(slot0.channelSelectDd_, function (slot0)
		if slot0 + 1 == ChatData:GetWorldChannelNum() then
			return
		end

		if manager.time:GetServerTime() - ChatData:GetChannelTimestamp() < 5 then
			ShowTips("SWITCH_CHANNEL_FREQUENTLY")

			uv0.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1

			return
		end

		ChatAction.SetWorldChannelNum(slot1, function (slot0)
			if slot0 == 0 then
				ChatData:SetChannelTimestamp()
			else
				uv0.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1

				ShowTips(slot0)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.friendCloseBtn_, nil, function ()
		SetActive(uv0.friendCancelBtn_.gameObject, true)
	end)
	slot0:AddBtnListener(slot0.friendCancelBtn_, nil, function ()
		SetActive(uv0.friendCancelBtn_.gameObject, false)
	end)
	slot0:AddBtnListener(slot0.friendRemoveBtn_, nil, function ()
		SetActive(uv0.friendCancelBtn_.gameObject, false)
		uv0:CloseCurFriendChat()
	end)
	slot0:AddBtnListener(slot0.publicTabBtn_, nil, function ()
		uv0:UpdatePublicMainTab()
	end)
	slot0:AddBtnListener(slot0.friendsTabBtn_, nil, function ()
		uv0:UpdateFriendsMainTab()
	end)
	slot0:AddBtnListener(slot0.avatarsystemBtn_, nil, function ()
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	slot0:AddBtnListener(slot0.addFriendChatBtn_, nil, function ()
		JumpTools.OpenPageByJump("/friendsUI", {
			friendPage = FriendsConst.FRIEND_TYPE.MY_FRIENDS
		}, ViewConst.SYSTEM_ID.FRIEND)
	end)
end

function slot0.OnEnter(slot0)
	FriendsAction:TryToRefreshFriendsView(1)

	if slot0.params_.ignoreBG ~= true then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.chat)
		slot0:SetCamera()
	end

	slot0.blurStateController_:SetSelectedState(slot0.params_.ignoreBG and "blur" or "none")
	slot0.chatStickerView_:OnEnter()

	slot0.curfriendID_ = nil

	if slot0.params_.chatToggleID ~= ChatConst.CHAT_CHANNEL_FRIEND then
		slot0:UpdatePublicMainTab()
	else
		slot0:UpdateFriendsMainTab()
	end

	if not slot0.sendTipsCD_ then
		slot0.sendTipsCD_ = 0
	end

	slot0.sendTipsTimer_ = Timer.New(function ()
		if uv0.sendTipsCD_ > 0 then
			uv0.sendTipsText_.text = uv0.sendTipsCD_ .. GetTips("SECOND")
			uv0.sendTipsCD_ = uv0.sendTipsCD_ - 1
		else
			uv0.sendCDStateController_:SetSelectedState("false")
		end
	end, 1, -1)

	slot0.sendTipsTimer_:Start()
	slot0:RegistEventListener(CHAT_NEW_CHANNEL, handler(slot0, slot0.OnSwitchChannel))
	slot0:RegistEventListener(CHAT_REPORT, handler(slot0, slot0.OnChatReport))
	slot0:RegistEventListener(CHAT_REPORT_HIDE, handler(slot0, slot0.OnHideChatReport))
	slot0:RegistEventListener(CHAT_NEW_MESSAGE, handler(slot0, slot0.OnReceiveMessage))
	slot0:RegistEventListener(CHAT_GUILD_NEW_MESSAGE, handler(slot0, slot0.OnReceiveGuildMessage))
	slot0:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, handler(slot0, slot0.OnReceiveCooperationMessage))
	slot0:RegistEventListener(CHAT_SEND_STICKER, handler(slot0, slot0.OnSendSticker))
	slot0:RegistEventListener(CHAT_WORLD_RESET, handler(slot0, slot0.OnResetWorldChat))
	slot0:RegistEventListener(CHAT_GUILD_RESET, handler(slot0, slot0.OnResetGuildChat))
	slot0:RegistEventListener(CHAT_COOPERATION_RESET, handler(slot0, slot0.OnResetCooperationChat))
	slot0:RegistEventListener(CHAT_FRIEND_NEW_MESSAGE, handler(slot0, slot0.OnReceiveFriendMsg))
	slot0:RegistEventListener(CHAT_FRIEND_CHAT_RESET, handler(slot0, slot0.OnRecallFriendMsg))
	manager.redPoint:bindUIandKey(slot0.friendsTabBtn_.transform, RedPointConst.FRIEND_MY_FRIENDS)
end

function slot0.OnExit(slot0)
	slot0.params_.chatToggleID = slot0.chatToggleID_
	slot0.params_.friendID = slot0.curfriendID_

	if slot0.sendTipsTimer_ then
		slot0.sendTipsTimer_:Stop()

		slot0.sendTipsTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.friendsTabBtn_.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.notify:Invoke(CHAT_REPORT_HIDE)
	slot0.chatStickerView_:OnExit()
	slot0:StopReguireMessageTimer()
	slot0:RemoveAllEventListener()
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
end

function slot0.UpdateSendTimeCD(slot0)
	if manager.time:GetServerTime() - ChatData:GetLevelTextTimeStamp(slot0.chatToggleID_) < GameSetting.chat_speech_interval.value[3] then
		slot0.sendTipsCD_ = GameSetting.chat_speech_interval.value[3] - manager.time:GetServerTime() + slot1
		slot0.sendTipsText_.text = slot0.sendTipsCD_ .. GetTips("SECOND")

		slot0.sendCDStateController_:SetSelectedState("true")
	else
		slot0.sendTipsCD_ = 0

		slot0.sendCDStateController_:SetSelectedState("false")
	end
end

function slot0.GetPlayBackwardsAnimator(slot0)
	return {
		{
			slot0.mainAnimator_,
			"view_out",
			false
		}
	}, nil
end

function slot0.IndexFriendsItem(slot0, slot1, slot2)
	slot2:SetData(ChatFriendData:GetCacheHeroList()[slot1], slot1, slot0.curfriendID_, function ()
		if uv0 == uv1.curfriendID_ then
			return
		end

		if uv1.curfriendID_ and uv1.curfriendID_ ~= 0 then
			uv1.friendsLuaUIlist_:GetItemByIndex(table.keyof(ChatFriendData:GetCacheHeroList(), uv1.curfriendID_)):SetSelectState(false)
		end

		uv2:SetSelectState(true)
		uv1:RefreshFriends(uv0)
	end)
end

function slot0.SetCamera(slot0)
	if PosterGirlConst.PosterGirlTag.t0 == manager.posterGirl:GetTag() then
		if manager.posterGirl:GetViewDirect() ~= 0 then
			manager.ui:SetMainCamera(string.format("chat_%d_%d", HomeSceneSettingData:GetCurScene(), slot2))
		elseif CameraCfg["chat_" .. slot1] then
			manager.ui:SetMainCamera(slot3)
		else
			manager.ui:SetMainCamera("chat")
		end
	elseif CameraCfg["chat_" .. slot1] then
		manager.ui:SetMainCamera(slot2)
	else
		manager.ui:SetMainCamera("chat")
	end
end

function slot0.UpdatePublicMainTab(slot0)
	slot0.tabStateController_:SetSelectedState("publicChannel")

	if slot0.params_.soloHeartChange then
		slot0.soloStateController_:SetSelectedState("true")
	else
		slot0.soloStateController_:SetSelectedState("false")

		slot0.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1
		slot0.channelText_.text = ChatData:GetWorldChannelNum()

		ChatAction.EnterChatUI(1)
	end

	if slot0.params_.chatToggleID == ChatConst.CHAT_CHANNEL_FRIEND then
		slot1 = ChatConst.CHAT_CHANNEL_WORLD
	end

	slot0:InitActivitySubTab()

	if slot0.params_.isBack == nil then
		slot0.historySeek_ = {}
	end

	if slot1 == ChatConst.CHAT_CHANNEL_COOPERATION then
		SetActive(slot0.cooperTabBtn_.gameObject, true)
	else
		SetActive(slot0.cooperTabBtn_.gameObject, false)
	end

	slot0:RefreshToggle(slot1)
	slot0:OnHideChatReport()
end

function slot0.InitActivitySubTab(slot0)
	for slot4, slot5 in pairs(slot0.activityTabItemList_) do
		slot5:Show(false)
	end

	for slot4, slot5 in pairs(ChatToggleCfg.all) do
		if slot5 == ChatConst.CHAT_CHANNEL_MOON_CAKE and manager.windowBar:GetWhereTag() == "guildActivitySP" then
			-- Nothing
		elseif ChatTools.IsOpenChatChannel(slot5) then
			slot0.activityTabItemList_[slot5] = slot0.activityTabItemList_[slot5] or ChatSubTabItem.New(slot0.activityTabGo_, slot0.subTabRootTrs_, slot5, function ()
				uv0:RefreshToggle(uv1)
			end)

			slot0.activityTabItemList_[slot5]:Show(true)
		end
	end
end

function slot0.RefreshToggle(slot0, slot1)
	slot0.worldTabStateController_:SetSelectedState("cancel")
	slot0.guildTabStateController_:SetSelectedState(GuildData:GetGuildInfo().id == nil and "lock" or "unlock")
	slot0.recruitTabStateController_:SetSelectedState(PlayerData:GetPlayerInfo().userLevel < GameSetting.club_recruit_unlock_level.value[1] and "lock" or "unlock")
	slot0.cooperTabStateController_:SetSelectedState("cancel")

	for slot7, slot8 in pairs(slot0.activityTabItemList_) do
		slot8:SetTabState(false)
	end

	if slot1 == ChatConst.CHAT_CHANNEL_WORLD then
		slot0.worldTabStateController_:SetSelectedState("select")
	elseif slot1 == ChatConst.CHAT_CHANNEL_GUILD then
		slot0.guildTabStateController_:SetSelectedState("select")
	elseif slot1 == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		slot0.recruitTabStateController_:SetSelectedState("select")
	elseif slot1 == ChatConst.CHAT_CHANNEL_COOPERATION then
		slot0.cooperTabStateController_:SetSelectedState("select")
	else
		slot0.activityTabItemList_[slot1]:SetTabState(true)
	end

	slot0:SwitchChannel(slot1)
end

function slot0.SwitchChannel(slot0, slot1)
	slot0.chatToggleID_ = slot1

	slot0:UpdateSendTimeCD()

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD and GuildData:GetGuildInfo().id == nil then
		slot0.emptyStateController_:SetSelectedState("noguild")
		ShowTips("NEED_JOIN_CLUB")
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		slot0.emptyStateController_:SetSelectedState("nosend")
	elseif ChatToggleCfg[slot0.chatToggleID_] ~= nil then
		slot0.emptyStateController_:SetSelectedState(ChatToggleCfg[slot0.chatToggleID_].hide_send_btn == 1 and "nosend" or "normal")
	else
		slot0.emptyStateController_:SetSelectedState("normal")
	end

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT or slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		slot0:AddReguireMessageTimer()
	elseif ChatToggleCfg[slot0.chatToggleID_] ~= nil and ChatToggleCfg[slot0.chatToggleID_].require_type[1] == ChatConst.REQUIRE_TYPE.MANUAL then
		slot0:AddReguireMessageTimer()
	end

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		if ChatGuildData:InitCacheGuildContent() ~= 0 and slot2 ~= #ChatGuildData:GetCacheContent() then
			slot0.historySeek_[slot0.chatToggleID_] = {
				verticalNormalizedPosition = 1,
				index = slot2
			}
		end
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		if ChatCooperationData:InitCacheCooperationContent() ~= 0 and slot2 ~= #ChatCooperationData:GetCacheContent() then
			slot0.historySeek_[slot0.chatToggleID_] = {
				verticalNormalizedPosition = 1,
				index = slot2
			}
		end
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		ActivityRecallData:InitCacheContent()
	elseif ChatToggleCfg[slot0.chatToggleID_] then
		ChatChannelData:InitCacheContent(slot0.chatToggleID_)
	end

	slot0.loopScrollView_:SetContentHeight(slot0.diaViewPortTrs_.rect.height)

	if slot0.historySeek_[slot0.chatToggleID_] then
		slot0.loopScrollView_:RestoredScroll(slot0.historySeek_[slot0.chatToggleID_].index, slot0.historySeek_[slot0.chatToggleID_].verticalNormalizedPosition)
	else
		slot0.loopScrollView_:Scroll2End()
	end

	slot0.chatSeek_[slot0.chatToggleID_] = slot0.chatSeek_[slot0.chatToggleID_] or 0

	SetActive(slot0.newJumpBtn_.gameObject, slot0.chatSeek_[slot0.chatToggleID_] < #slot0:LsGetItemData())
end

function slot0.UpdateFriendsMainTab(slot0)
	slot0.chatToggleID_ = ChatConst.CHAT_CHANNEL_FRIEND

	slot0:UpdateSendTimeCD()
	slot0.tabStateController_:SetSelectedState(#ChatFriendData:GetCacheHeroList() > 0 and "friendsChannel" or "friendsEmpty")
	slot0.emptyStateController_:SetSelectedState(#slot1 > 0 and "normal" or "nothing")
	SetActive(slot0.friendCancelBtn_.gameObject, false)

	if #slot1 > 0 then
		slot0:RefreshFriends(slot0.params_.friendID or slot1[1])
	else
		slot0.friendsLuaUIlist_:StartScroll(0)
	end
end

function slot0.RefreshFriends(slot0, slot1)
	slot0.curfriendID_ = slot1
	slot2 = 1

	if slot0.curfriendID_ and slot0.curfriendID_ ~= 0 then
		ChatFriendData:LockFriendID(slot0.curfriendID_)
		slot0.friendsLuaUIlist_:StartScroll(#ChatFriendData:GetCacheHeroList())
		slot0.friendsLuaUIlist_:ScrollToIndex(table.keyof(ChatFriendData:GetCacheHeroList(), slot0.curfriendID_), false, false)
		slot0:RefreshFriendTitle()
		slot0.loopScrollView_:Scroll2End()
	else
		slot0.friendsLuaUIlist_:StartScroll(0)
	end
end

function slot0.RefreshFriendTitle(slot0)
	if FriendsData:GetInfoByID(slot0.curfriendID_) == false then
		print("unfind friend data", slot0.curfriendID_)

		return
	end

	slot0.friendsIpText_.text = slot1.ip
	slot0.friendNameText_.text = GetI18NText(slot1.nick)
	slot0.friendSignText_.text = GetI18NText(slot1.sign)

	slot0.onlineStateController_:SetSelectedState(slot1.online_state == 0 and "on" or "off")
end

function slot0.OnReceiveFriendMsg(slot0, slot1)
	slot0.friendsLuaUIlist_:StartScroll(#ChatFriendData:GetCacheHeroList())

	if slot0.curfriendID_ ~= slot1 then
		return
	end

	slot3 = ChatFriendData
	slot5 = slot3

	for slot5 = 0, slot3.GetUnreadMsgCnt(slot5, slot1) - 1 do
		if slot0:LsGetItemData()[#slot0:LsGetItemData() - slot5].senderID == USER_ID then
			slot0.loopScrollView_:Scroll2End()
			ChatFriendData:UpdateSeek(slot0.curfriendID_)

			return
		end
	end

	if not slot0.loopScrollView_:IsFillContent() or slot0.diaScrollEx_.verticalNormalizedPosition <= 0.0001 then
		slot0.loopScrollView_:Scroll2End()
		ChatFriendData:UpdateSeek(slot0.curfriendID_)

		return
	end

	SetActive(slot0.newJumpBtn_.gameObject, true)
	slot0.loopScrollView_:RefreshScrollView()
end

function slot0.CloseCurFriendChat(slot0)
	ChatFriendData:RemoveCacheHero(slot0.curfriendID_)
	ChatFriendData:SaveRecordCnt(slot0.curfriendID_)
	FriendsAction:RefreshUnread(slot0.curfriendID_, 0)

	if #ChatFriendData:GetCacheHeroList() > 0 then
		slot0:RefreshFriends(slot1[1])
	else
		slot0.tabStateController_:SetSelectedState("friendsEmpty")
		slot0.emptyStateController_:SetSelectedState("nothing")
		slot0:RefreshFriends()
	end
end

function slot0.AddReguireMessageTimer(slot0)
	slot0:TryToRequireMsg()

	if slot0.reguireMessageTimer_ ~= nil then
		return
	end

	slot0.reguireMessageTimer_ = Timer.New(function ()
		uv0:TryToRequireMsg()
	end, 1, -1)

	slot0.reguireMessageTimer_:Start()
end

function slot0.StopReguireMessageTimer(slot0)
	if slot0.reguireMessageTimer_ then
		slot0.reguireMessageTimer_:Stop()

		slot0.reguireMessageTimer_ = nil
	end
end

function slot0.TryToRequireMsg(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT and GameSetting.chat_club_refresh_time.value[1] < manager.time:GetServerTime() - ChatGuildRecruitData:GetLastTimestamp() then
		ChatAction.RequireGuildShareInfo()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL and GameSetting.chat_club_refresh_time.value[1] < manager.time:GetServerTime() - ActivityRecallData:GetLastTimestamp() then
		ChatAction.RequireRecallInfo()
	elseif ChatToggleCfg[slot0.chatToggleID_] and ChatToggleCfg[slot0.chatToggleID_].require_type[1] == ChatConst.REQUIRE_TYPE.MANUAL and ChatToggleCfg[slot0.chatToggleID_].require_type[2][1] < manager.time:GetServerTime() - ChatChannelData:GetLastRequireMsgTimestamp(slot0.chatToggleID_) then
		ChatAction.RequireChatNormalMsg(slot0.chatToggleID_)
	end
end

function slot0.GetChatJudgeMessageType(slot0, slot1)
	if ({
		[ChatConst.CHAT_CHANNEL_WORLD] = JUDGE_MESSAGE_TYPE.CHAT_WORLD,
		[ChatConst.CHAT_CHANNEL_FRIEND] = JUDGE_MESSAGE_TYPE.CHAT_FRIEND,
		[ChatConst.CHAT_CHANNEL_GUILD] = JUDGE_MESSAGE_TYPE.CHAT_GUILD,
		[ChatConst.CHAT_CHANNEL_GUILD_RECRUIT] = JUDGE_MESSAGE_TYPE.GUILD_SHARE,
		[ChatConst.CHAT_CHANNEL_COOPERATION] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_MOON_CAKE] = JUDGE_MESSAGE_TYPE.ACTIVITY_MOON_CAKE
	})[slot1] then
		return slot3
	end
end

function slot0.LsGetItemData(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		return ChatData:GetWorldChatData()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		return ChatGuildData:GetCacheContent()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		return ChatGuildRecruitData:GetChatData()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		return ChatCooperationData:GetCacheContent()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		return ActivityRecallData:GetChatData()
	elseif ChatToggleCfg[slot0.chatToggleID_] then
		return ChatChannelData:GetCacheContent(slot0.chatToggleID_)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
		return ChatFriendData:GetCacheContent(slot0.curfriendID_)
	else
		return {}
	end
end

function slot0.ParseFriendData(slot0, slot1)
	if not slot1.senderID then
		return slot1
	end

	if slot1.senderID == USER_ID then
		slot4 = PlayerData:GetPlayerInfo()
	else
		slot2.bubbleID = FriendsData:GetInfoByID(slot3).bubbleID or GameSetting.profile_chat_bubble_default.value[1]
		slot2.icon = slot4.icon
		slot2.iconFrame = slot4.icon_frame
		slot2.ip = slot4.ip
		slot2.nick = slot4.nick
	end

	return {
		id = slot1.senderID,
		content = slot1.content,
		contentType = slot1.contentType,
		msgID = slot1.msgID,
		timestamp = slot1.timestamp,
		roomID = 0,
		bubbleID = PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1],
		icon = slot4.portrait,
		iconFrame = slot4.icon_frame,
		ip = slot4.ip,
		nick = slot4.nick
	}
end

function slot0.LsAddItem(slot0, slot1, slot2)
	slot4 = nil

	if slot0:ParseFriendData(slot1).contentType == ChatConst.CHAT_CONTENT_TYPE.CHANNEL then
		slot4 = slot0:GetFreeItem(slot0.itemChannelPool_, function ()
			return ChatChannelView.New(uv0.channelTitleGo_, uv0.diaGridGo_)
		end)
	elseif slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
		slot4 = slot0:GetFreeItem(slot0.itemTimePool_, function ()
			return ChatTimeView.New(uv0.timeStampGo_, uv0.diaGridGo_)
		end)
	elseif slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
		slot4 = slot0:GetFreeItem(slot0.historyTipsPool_, function ()
			return ChatFriendHistoryTipsItem.New(uv0.historyTipsGo_, uv0.diaGridGo_)
		end)
	elseif slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT then
		if slot3.id == tostring(PlayerData:GetPlayerInfo().userID) then
			slot4 = slot0:GetFreeItem(slot0.itemSelfGuildRecruitPool_, function ()
				return ChatGuildRecruitItemView.New(uv0.recruitSelfGo_, uv0.diaGridGo_)
			end)
		else
			slot4 = slot0:GetFreeItem(slot0.itemFriendGuildRecruitPool_, function ()
				return ChatGuildRecruitItemView.New(uv0.recruitOtherGo_, uv0.diaGridGo_)
			end)
		end
	elseif slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.JUMP then
		slot6 = slot0:GetJumpItemClass()
		slot4 = (not (slot3.id == tostring(PlayerData:GetPlayerInfo().userID)) or slot0:GetFreeItem(slot0.itemSelfJumpPool_, function ()
			return uv0.New(uv1.jumpSelfGo_, uv1.diaGridGo_)
		end)) and slot0:GetFreeItem(slot0.itemFriendJumptPool_, function ()
			return uv0.New(uv1.jumpOtherGo_, uv1.diaGridGo_)
		end)
	else
		slot4 = (slot3.contentType ~= ChatConst.CHAT_CONTENT_TYPE.RECALL or (slot3.id ~= tostring(PlayerData:GetPlayerInfo().userID) or slot0:GetFreeItem(slot0.itemSelfRecallPool_, function ()
			return ChatRecallItemView.New(uv0.recallSelfGo_, uv0.diaGridGo_)
		end)) and slot0:GetFreeItem(slot0.itemFriendRecallPool_, function ()
			return ChatRecallItemView.New(uv0.recallOtherGo_, uv0.diaGridGo_)
		end)) and (slot3.id ~= tostring(PlayerData:GetPlayerInfo().userID) or slot0:GetFreeItem(slot0.itemSelfPool_, function ()
			return ChatItemView.New(uv0.chatSelfGo_, uv0.diaGridGo_, uv0.diaScrollEx_)
		end)) and slot0:GetFreeItem(slot0.itemFriendPool_, function ()
			return ChatItemView.New(uv0.chatOtherGo_, uv0.diaGridGo_, uv0.diaScrollEx_)
		end)
	end

	slot4.itemView:SetData(slot3, slot2)

	slot0.chatSeek_[slot0.chatToggleID_] = slot0.chatSeek_[slot0.chatToggleID_] or 0

	if slot0.chatSeek_[slot0.chatToggleID_] < slot2 then
		slot0.chatSeek_[slot0.chatToggleID_] = slot2
	end

	if slot2 >= #slot0:LsGetItemData() then
		SetActive(slot0.newJumpBtn_.gameObject, false)
	end

	if slot0.curfriendID_ and slot0.curfriendID_ ~= 0 then
		slot5 = ChatFriendData:GetUnreadMsgCnt(slot0.curfriendID_)

		if slot2 >= #slot0:LsGetItemData() then
			ChatFriendData:SaveRecordCnt(slot0.curfriendID_)
			FriendsAction:RefreshUnread(slot0.curfriendID_, 0)
		elseif slot5 > #slot0:LsGetItemData() - slot2 then
			ChatFriendData:SaveRecordCnt(slot0.curfriendID_, slot6)
			FriendsAction:RefreshUnread(slot0.curfriendID_, slot6)
		end
	end

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:SaveRecordCnt()
	elseif ChatToggleCfg[slot0.chatToggleID_] then
		ChatChannelData:SaveRecordCnt(slot0.chatToggleID_)
	end

	return slot4
end

function slot0.LsUpdateItem(slot0, slot1, slot2, slot3)
	slot1.itemView:SetData(slot0:ParseFriendData(slot2), slot3)
end

function slot0.LsRemoveItem(slot0, slot1)
	slot1.itemView:Show(false)

	slot1.isFree = true
end

function slot0.GetJumpItemClass(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_MOON_CAKE then
		return MoonCakeChatJumpItemView
	else
		return ChatJumpItemView
	end
end

function slot0.InitItemPool(slot0)
	slot0.itemChannelPool_ = {}
	slot0.itemTimePool_ = {}
	slot0.itemSelfPool_ = {}
	slot0.itemFriendPool_ = {}
	slot0.itemSelfGuildRecruitPool_ = {}
	slot0.itemFriendGuildRecruitPool_ = {}
	slot0.historyTipsPool_ = {}
	slot0.itemSelfJumpPool_ = {}
	slot0.itemFriendJumptPool_ = {}
	slot0.itemSelfRecallPool_ = {}
	slot0.itemFriendRecallPool_ = {}
end

function slot0.GetFreeItem(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7.isFree == true then
			slot7.isFree = false

			return slot7
		end
	end

	slot3 = {
		isFree = false,
		itemView = slot2()
	}

	table.insert(slot1, slot3)

	return slot3
end

function slot0.DisposeItemPool(slot0)
	for slot4, slot5 in ipairs(slot0.itemChannelPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemChannelPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemTimePool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemTimePool_ = nil

	for slot4, slot5 in ipairs(slot0.itemSelfPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemSelfPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemFriendPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemFriendPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemSelfGuildRecruitPool_) do
		slot5.itemView:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.itemFriendGuildRecruitPool_) do
		slot5.itemView:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.historyTipsPool_) do
		slot5.itemView:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.itemSelfJumpPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemSelfJumpPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemFriendJumptPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemFriendJumptPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemSelfRecallPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemSelfRecallPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemFriendRecallPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemFriendRecallPool_ = nil
end

function slot0.RefreshReceiveMessage(slot0)
	if slot0:LsGetItemData()[#slot0:LsGetItemData()] == nil then
		return
	end

	slot5 = slot0

	for slot5 = slot0.chatSeek_[slot0.chatToggleID_] + 1, #slot0.LsGetItemData(slot5) do
		if slot0:LsGetItemData()[slot5].id == USER_ID then
			slot0.loopScrollView_:Scroll2End()

			return
		end
	end

	if slot1.id == USER_ID then
		slot0.loopScrollView_:Scroll2End()

		return
	end

	if not slot0.loopScrollView_:IsFillContent() or slot0.diaScrollEx_.verticalNormalizedPosition <= 0.01 then
		slot0.loopScrollView_:Scroll2End()

		return
	end

	SetActive(slot0.newJumpBtn_.gameObject, true)
end

function slot0.SendMessageResult(slot0, slot1)
	if isSuccess(slot1.result) then
		if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[slot0.chatToggleID_] and ChatToggleCfg[slot0.chatToggleID_].limit_type == 1 then
			ChatData:SetLevelTextTimeStamp(slot0.chatToggleID_)
		end

		ChatData:SetSendTextTimestamp()
		slot0:UpdateSendTimeCD()

		slot0.sendInputfield_.text = ""
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function ()
				uv0:Back()
			end
		})
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		slot0.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnSwitchChannel(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		slot0.loopScrollView_:Scroll2End()
	end
end

function slot0.OnRecallFriendMsg(slot0, slot1)
	if slot0.curfriendID_ ~= slot1 then
		return
	end

	slot0.loopScrollView_:RefreshScrollView(true)
	SetActive(slot0.newJumpBtn_.gameObject, ChatFriendData:GetUnreadMsgCnt(slot1) > 0)
end

function slot0.OnChatReport(slot0, slot1)
	slot0.reportTrs_:SetParent(slot1.parentRect.transform, false)

	slot0.reportTrs_.localPosition = Vector2(slot1.x, slot1.y)
	slot0.reportData_ = slot1.reportData

	SetActive(slot0.reportGo_, true)
end

function slot0.OnHideChatReport(slot0)
	SetActive(slot0.reportGo_, false)
end

function slot0.OnReceiveMessage(slot0, slot1)
	if slot0.chatToggleID_ ~= slot1.chatToggleID then
		return
	end

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		slot0:RefreshReceiveMessage()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		if #slot0.loopScrollView_:GetItemList() <= 0 then
			slot0.loopScrollView_:Scroll2End()
		else
			slot0.loopScrollView_:RefreshScrollView(true, true)
		end
	elseif ChatToggleCfg[slot0.chatToggleID_] then
		slot0:RefreshReceiveMessage()
	end
end

function slot0.OnReceiveGuildMessage(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		slot0:RefreshReceiveMessage()
	end
end

function slot0.OnReceiveCooperationMessage(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		slot0:RefreshReceiveMessage()
	end
end

function slot0.OnSendSticker(slot0, slot1)
	if ChatToggleCfg[slot0.chatToggleID_] and not ChatTools.IsOpenChatChannel(slot0.chatToggleID_) then
		ShowTips("TIME_OVER")

		return
	end

	slot0:HideStickerPanel()

	if ChatData:IsMuted() then
		slot0.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	end

	if slot0.sendTipsCD_ > 0 or manager.time:GetServerTime() - ChatData:GetSendStickerTimestamp() < 10 then
		ShowTips("SEND_MESSAGE_FREQUENTLY")

		return
	end

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		ChatAction.SendSticker(slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		if GuildData:GetGuildInfo().id == nil then
			ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

			return
		end

		ChatAction.SendGuildSticker(slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatAction.SendGuildRecruitSticker(slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif ChatToggleCfg[slot0.chatToggleID_] then
		ChatAction.SendChatNormalSticker(slot0.chatToggleID_, slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		if not CooperationData:CheckInRoom() then
			ShowTips("ERROR_INVALID_OPERATION")

			return
		end

		ChatAction.SendCooperationSticker(slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
		ChatAction.SendFriendSticker(slot0.curfriendID_, slot1, function (slot0)
			if isSuccess(slot0.result) then
				ChatData:SetSendStickerTimestamp()

				uv0.sendInputfield_.text = ""
			end
		end)
	else
		ShowTips("SEND_MESSAGE_ERROR")
	end
end

function slot0.SendStickerResult(slot0, slot1)
	if isSuccess(slot1.result) then
		if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[slot0.chatToggleID_] and ChatToggleCfg[slot0.chatToggleID_].limit_type == 1 then
			ChatData:SetLevelTextTimeStamp(slot0.chatToggleID_)
		end

		ChatData:SetSendStickerTimestamp()
		slot0:UpdateSendTimeCD()
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function ()
				uv0:Back()
			end
		})
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		slot0.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(slot1.result)
	end
end

function slot0.HideStickerPanel(slot0)
	slot0.chatStickerView_:Show(false)
end

function slot0.OnResetWorldChat(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[slot0.chatToggleID_] then
		if ChatToggleCfg[slot0.chatToggleID_] then
			ChatChannelData:InitCacheContent(slot0.chatToggleID_)
		end

		slot0.loopScrollView_:RefreshScrollView(true)
	end
end

function slot0.OnResetGuildChat(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:InitCacheGuildContent()
		slot0.loopScrollView_:RefreshScrollView(true)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
		slot0.loopScrollView_:RefreshScrollView(true)
	end
end

function slot0.OnResetCooperationChat(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		slot0.loopScrollView_:RefreshScrollView(true)
	end
end

function slot0.OnBehind(slot0)
	slot0:OnHideChatReport()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.activityTabItemList_) do
		slot5:Dispose()
	end

	slot0.activityTabItemList_ = nil

	slot0.loopScrollView_:Dispose()
	slot0.friendsLuaUIlist_:Dispose()
	slot0:DisposeItemPool()

	if slot0.chatStickerView_ then
		slot0.chatStickerView_:Dispose()

		slot0.chatStickerView_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnExitInput(slot0)
	slot0:Back()
end

return slot0
