manager.net:Bind(10999, function (slot0)
	ReconnectLogic.ReconnectError(slot0.reason)
end)
manager.net:Bind(10051, function (slot0)
	if slot0.timestamp and slot0.verify_timestamp then
		manager.time:SetServerTime(slot0.timestamp, slot0.verify_timestamp)
	end
end)
manager.net:Bind(10501, function (slot0)
	uv0.OnRequestNewDayData(slot0)
end)
manager.net:Bind(10503, function (slot0)
	uv0.SyncSeverTime(slot0)
end)
manager.net:Bind(12019, function (slot0)
	uv0.OnClientModuleSwitch(slot0)
end)
manager.net:Bind(12023, function (slot0)
	PlayerData:SetUnclaimedListFromServer(slot0)
end)
manager.net:Bind(32051, function (slot0)
	PlayerData:InItReceivedSkinGift(slot0)
	uv0.RefreshSkinGiftRedPoint()
end)
manager.net:Bind(32201, function (slot0)
	PlayerData:AddLikeInfo(slot0.info)
end)
manager.net:Bind(32203, function (slot0)
	PlayerData:InitOverdueCardBgList(slot0.information_background_list)
end)
manager.net:Bind(32205, function (slot0)
	PlayerData:InitOverdueTagList(slot0.tags_list)
end)
manager.notify:RegistListener(ZERO_REFRESH, function ()
	PlayerData:ResetSendLikeList()
end)
manager.net:Bind(23009, function (slot0)
	uv0.PlayInfoInit(slot0)
end)
manager.net:Bind(23015, function (slot0)
	uv0.SetPlayerIP(slot0)
end)
manager.net:Bind(12001, function (slot0)
	uv0.StoryInit(slot0.story_list)
end)
manager.net:Bind(12033, function (slot0)
	uv0.PlayerBrithdayInit(slot0)
end)
manager.net:Bind(12009, function (slot0)
	uv0.PlayerOriginalLevel(slot0)
end)
manager.net:Bind(32009, function (slot0)
	uv0.PlayerCardInit(slot0)
end)
manager.net:Bind(32007, function (slot0)
	uv0.InitOverdueFrameList(slot0)
end)
manager.net:Bind(12099, function (slot0)
	HideInfoData:InitHideData(slot0)
	ComboSkillTools.InitComboList()
end)
manager.net:Bind(32211, function (slot0)
	PlayerData:UnlockTag(slot0.info.id)
end)
manager.net:Bind(81001, function (slot0)
	PlayerData:InitPlayerStoryTrigger(slot0)
end)

return {
	RequestNewDayData = function ()
		manager.net:SendWithLoadingNew(10500, {}, 10501, uv0.OnRequestNewDayData)
	end,
	OnRequestNewDayData = function (slot0, slot1)
		uv0.SyncSeverTime(slot0)

		if isSuccess(slot0.result) then
			manager.notify:Invoke(NEW_DAY)
		end
	end,
	SyncSeverTime = function (slot0)
		manager.time:SetServerTime(slot0.timestamp, slot0.verify_timestamp)
		_G.gameTimer:SetNextDayFreshTime(slot0.next_refresh_time)
		_G.gameTimer:SetNextWeekFreshTime(slot0.next_weekly_refresh_time)
		_G.gameTimer:SetNextMonthFreshTime(slot0.next_monthly_refresh_time)
	end,
	ChangeNickname = function (slot0, slot1)
		manager.net:SendWithLoadingNew(23012, {
			nick = slot0
		}, 23013, function (slot0)
			if isSuccess(slot0.result) then
				PlayerData:PlayerNicknameChange(uv0)
				PlayerData:UpdateNameChangeInfo(slot0)
				manager.notify:CallUpdateFunc(CHANGE_NAME, {
					nick = uv0
				})
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ChangeSign = function (slot0, slot1)
		uv0.isEnter = slot1

		manager.net:SendWithLoadingNew(32012, {
			sign = slot0
		}, 32013, uv0.OnChangeSign)
	end,
	OnChangeSign = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:PlayerSignChange(slot1.sign)
			manager.notify:CallUpdateFunc(CHANGE_SIGN, slot0, slot1, uv0.isEnter)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeHeros = function (slot0)
		manager.net:SendWithLoadingNew(32014, {
			heroes = slot0
		}, 32015, uv0.OnChangeHeros)
	end,
	OnChangeHeros = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ChangeHeros(slot1.heroes)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangePosterGirl = function (slot0)
		HomeSceneSettingAction.CheckMatchPosterGirl(slot0)
		manager.net:SendWithLoadingNew(32016, {
			poster_girl = slot0
		}, 32017, uv0.OnChangePosterGirl)
	end,
	OnChangePosterGirl = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:PlayerPosterGirlChange(slot1.poster_girl)

			if SkinSceneActionCfg[HeroTools.HeroUsingSkinInfo(slot1.poster_girl).id] and HomeSceneSettingData:GetCurScene() ~= slot4.special_scene_id and HomeSceneSettingAction.CheckPosterSceneCanUse(slot4.special_scene_id) then
				HomeSceneSettingAction.SetHomeScene(slot4.special_scene_id)

				return true
			end

			manager.notify:CallUpdateFunc(CHANGE_POSTER_GIRL, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	TouchPosterGirl = function ()
		manager.net:SendWithLoadingNew(32054, {}, 32055, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end,
	ChangeStoryList = function (slot0, slot1)
		if PlayerData:GetStoryList()[slot0] then
			PlayerData:StoryModify(slot0)
			IllustratedAction.ModifyPlot(slot0)

			if slot1 then
				slot1({
					result = 1
				}, {
					story_id = slot0
				})
			end
		else
			uv0.OnChangeStoryListCallBack = slot1

			manager.net:SendWithLoadingNew(12002, slot3, 12003, uv0.OnChangeStoryList)
		end
	end,
	OnChangeStoryList = function (slot0, slot1)
		PlayerData:StoryModify(slot1.story_id)
		IllustratedAction.ModifyPlot(slot1.story_id)

		if uv0.OnChangeStoryListCallBack then
			uv0.OnChangeStoryListCallBack(slot0, slot1)

			uv0.OnChangeStoryListCallBack = nil
		end
	end,
	ChangePortrait = function (slot0)
		manager.net:SendWithLoadingNew(32032, {
			icon_id = slot0
		}, 32033, uv0.OnChangePortrait)
	end,
	OnChangePortrait = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ChangePortrait(slot1.icon_id)
			manager.notify:CallUpdateFunc(CHANGE_PORTRAIT)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangePlayerBirthday = function (slot0, slot1)
		manager.net:SendWithLoadingNew(12030, {
			month = slot0,
			day = slot1
		}, 12031, uv0.OnChangeBirthday)
	end,
	OnChangeBirthday = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:SetPlayerBirthday(slot1)
			manager.notify:CallUpdateFunc(CHANGE_BIRTHDAY)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeFrameIcon = function (slot0)
		manager.net:SendWithLoadingNew(32034, {
			iconframe_id = slot0
		}, 32035, uv0.OnChangeFrameIcon)
	end,
	OnChangeFrameIcon = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ChangeFrameIcon(slot1.iconframe_id)
			manager.notify:CallUpdateFunc(CHANGE_FRAME)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeStickerList = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0.info) do
			for slot12, slot13 in ipairs(StickViewTemplateCfg[slot6.viewID].range_list) do
				slot14 = slot6.sticker[slot12]
			end

			table.insert(slot1, {
				page_id = slot6.index,
				template_id = slot6.viewID,
				sticker_display_info = {
					[slot12] = {
						sticker_id = slot14.stickerID,
						location = slot12,
						size = slot14.size
					}
				}
			})
		end

		manager.net:SendWithLoadingNew(32038, {
			sticker_show_info = slot1,
			sticker_background = slot0.stickerBg
		}, 32039, uv0.OnChangeStickerList)
	end,
	OnChangeStickerList = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ChangeStickerList(slot1.sticker_show_info, slot1.sticker_background)
		else
			ShowTips(slot0.result)
		end
	end,
	ReceiveSkinGift = function (slot0)
		manager.net:SendWithLoadingNew(32052, {
			skin_id = slot0
		}, 32053, uv0.OnReceiveSkinGift)
	end,
	OnReceiveSkinGift = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ReceiveSkinGift(slot1.skin_id)
			manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. slot1.skin_id, 0)
			getReward(formatRewardCfgList(SkinCfg[slot1.skin_id].gift))
			manager.notify:Invoke(GET_SKIN_GIFT)
		else
			ShowTips(slot0.result)
		end
	end,
	RefreshSkinGiftRedPoint = function ()
		for slot3, slot4 in ipairs(SkinCfg.all) do
			if #SkinCfg[slot4].gift > 0 and HeroTools.IsSkinUnlock(slot4) then
				if HeroData:GetHeroList()[SkinCfg[slot4].hero].unlock > 0 and PlayerData:IsNotReceived(slot4) then
					manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. slot4, 1)
				else
					manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. slot4, 0)
				end
			else
				manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. slot4, 0)
			end
		end
	end,
	PlayInfoInit = function (slot0)
		PlayerData:PlayInfoInit(slot0)
	end,
	PlayerBrithdayInit = function (slot0)
		PlayerData:SetPlayerBirthday({
			month = slot0.month,
			day = slot0.day
		})
	end,
	SetPlayerIP = function (slot0)
		PlayerData:SetPlayerIP(slot0)
	end,
	UserBaseInfoInit = function (slot0)
		PlayerData:UserBaseInfoInit(slot0)
	end,
	UserLoginTimestampInit = function (slot0)
		PlayerData:UserLoginTimestampInit(slot0)
	end,
	LevelUpFinish = function (slot0)
		PlayerData:LevelUpFinish(slot0)
	end,
	ChangeLevel = function (slot0, slot1)
		PlayerData:ChangeLevel({
			fromLevel = slot0,
			toLevel = slot1
		})
		ActivityNewbieAction.PlayerUpgradeRedPoint()
		BattleStageAction.UpdateSubPlotRedPoint()
		BattleStageAction.UpdateActivityRedPoint()
		EquipSeizureAction.InitRedPointEveryDay()
		BattleEquipAction.UpdateRedPoint()
		DailyNewRedPoint:InitNewTagData()
	end,
	EXPChange = function (slot0)
		PlayerData:EXPChange(slot0)
	end,
	ModifyHeroNick = function (slot0)
		PlayerData:ModifyHeroNick(slot0)
	end,
	PlayerOriginalLevel = function (slot0)
		PlayerData:PlayerOriginalLevel(slot0)
	end,
	StoryModify = function (slot0)
		PlayerData:StoryModify(slot0)
	end,
	StoryInit = function (slot0)
		PlayerData:StoryInit(slot0)
	end,
	PlayerShowHeroChange = function (slot0)
		PlayerData:PlayerShowHeroChange(slot0)
	end,
	PlayerCardInit = function (slot0)
		PlayerData:PlayerCardInit(slot0)

		for slot5, slot6 in ipairs(PlayerData:GetPlayerInfo().all_background_list) do
			slot7 = PlayerData:GetStickerBg(slot6)

			if slot6 ~= 4002 and slot7 and slot7.unlock == 1 and not RedPointData:GetIsRedPointOpen(RedPointConst.STICKER_BG_RANGE + slot6) then
				manager.redPoint:setTip(RedPointConst.STICKER_BG .. "_" .. slot6, 1)
			end
		end

		PlayerRedPoint:DispatchAllStickerUnlock()
		HomeSceneSettingData:InitData(slot0.poster_background_list, slot0.poster_background_id)
	end,
	InitOverdueFrameList = function (slot0)
		PlayerData:InitOverdueFrameList(slot0.icon_frame_list or {})
	end,
	PlayerProtraitChange = function (slot0)
		PlayerData:PlayerProtraitChange(slot0)
	end,
	UnlockSticker = function (slot0)
		PlayerData:UnlockSticker(slot0)
	end,
	UnlockStickerBg = function (slot0)
		PlayerData:UnlockStickerBg(slot0)
	end,
	UnlockPortrait = function (slot0)
		PlayerData:UnlockPortrait(slot0)
	end,
	UnlockFrame = function (slot0)
		PlayerData:UnlockFrame(slot0)
	end,
	LockFrame = function (slot0, slot1)
		PlayerData:LockFrame(slot1)
	end,
	OnClientModuleSwitch = function (slot0)
		PlayerData:InitModuleSwitchData(slot0)
	end,
	AwakeName = function (slot0, slot1)
		manager.net:SendWithLoadingNew(23012, {
			nick = slot0
		}, 23013, function (slot0)
			if isSuccess(slot0.result) then
				PlayerData:PlayerNicknameChange(uv0)
				PlayerData:UpdateNameChangeInfo(slot0)
				uv1()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	DealOverdueFrame = function ()
		manager.net:SendWithLoadingNew(32040, {}, 32041, uv0.OnDealOverdueFrame)
	end,
	OnDealOverdueFrame = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	DealOverdueCardBgList = function ()
		manager.net:SendWithLoadingNew(32206, {}, 32207, uv0.OnDealOverdueCardBgList)
	end,
	OnDealOverdueCardBgList = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	DealOverdueTagList = function ()
		manager.net:SendWithLoadingNew(32208, {
			nothing = 1
		}, 32209, uv0.OnDealOverdueTagList)
	end,
	OnDealOverdueTagList = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	ReadUnclaimedMessage = function (slot0)
		manager.net:SendWithLoadingNew(12024, {
			id = slot0
		}, 12025, uv0.OnReadUnclaimedMessageCallback)
	end,
	OnReadUnclaimedMessageCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ReadUnclaimed(slot1.id)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	CheckRecommendEquip = function (slot0, slot1)
		manager.net:SendWithLoadingNew(32042, {
			role_id = slot0
		}, 32043, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	CheckHeroVoice = function (slot0, slot1)
		manager.net:SendWithLoadingNew(32044, {
			role_id = slot0
		}, 32045, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	ChangeCardBg = function (slot0)
		manager.net:SendWithLoadingNew(32114, {
			id = slot0
		}, 32115, uv0.OnChangeCardBg)
	end,
	OnChangeCardBg = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:SetCardBg(slot1.id)
			manager.notify:CallUpdateFunc(CHANGE_CARD_BG, slot1.id)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangTagList = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(slot0) do
			if PlayerData:GetTagInfo(slot7).lasted_time == 0 or manager.time:GetServerTime() < slot8.lasted_time then
				table.insert(slot1, slot7)
			end
		end

		manager.net:SendWithLoadingNew(32116, {
			tags = slot1
		}, 32117, uv0.OnChangTagList)
	end,
	OnChangTagList = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:SetUsingTagList(slot1.tags)
			manager.notify:CallUpdateFunc(CHANGE_TAG_LIST)
		else
			ShowTips(slot0.result)
		end
	end,
	SendLikeSrc = {
		MidAutumnActivity = 5,
		MultiPlayerGameRoom = 1,
		MultiPlayerGameResult = 2,
		AddFriend = 0,
		DormInfo = 4,
		PlayerInfo = 3,
		Activity = 6,
		IdolDanceGame = 7
	},
	SendLike = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(32118, {
			uid = slot0,
			source = slot1,
			activity_id = slot2 or 0
		}, 32119, uv0.OnSendLike)
	end,
	OnSendLike = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ForeignInfoData:OnSendLike()
			PlayerData:OnSendLike(slot1.uid)
			manager.notify:CallUpdateFunc(SEND_LIKE)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeChatBubble = function (slot0, slot1)
		manager.net:SendWithLoadingNew(32120, {
			chat_bubble = slot0
		}, 32121, function (slot0)
			if isSuccess(slot0.result) then
				PlayerData:SetCurChatBubbleID(uv0)
				uv1()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitChatBubbleRedPoint = function ()
		slot3 = PlayerData
		slot5 = slot3

		for slot4, slot5 in ipairs(slot3.GetUnlockChatBubbleIDList(slot5)) do
			if slot5 ~= GameSetting.profile_chat_bubble_default.value[1] and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAT_BUBBLE_RANGE + slot5) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAT_BUBBLE, slot5), 1)
			end
		end
	end,
	UseStoryTrigger = function (slot0, slot1, slot2, slot3)
		manager.net:Push(81002, {
			trigger_id = slot0,
			trigger_story = slot1,
			trigger_text = slot2,
			trigger_select = slot3
		})
		PlayerData:AddPlayerStoryTrigger(slot0)
	end
}
