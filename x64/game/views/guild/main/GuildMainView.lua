slot0 = class("GuildMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubHomeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chatTextExtension_ = slot0.textChat_:GetComponent(typeof(TextExtension))
	slot0.controller_ = slot0.clubInfo:GetController("edit")
	slot0.noticeController_ = slot0.clubInfo:GetController("noticeEmpty")
end

function slot0.OnEnter(slot0)
	if GuildData:GetGuildInfo().id == nil then
		slot0:Go("/home")

		return
	end

	CommunityAction:RefreshCurrencyA()
	slot0:RefreshGuildUI()
	slot0:RegisterEvents()
	slot0:ShowImpeachTips()
	slot0:BindUIRedPoint()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(GUILD_SWITCH_HEAD_ICON, handler(slot0, slot0.SwitchHeadIcon))
	slot0:RegistEventListener(GUILD_RENAME, handler(slot0, slot0.GuildRename))
	slot0:RegistEventListener(GUILD_NOTICE, handler(slot0, slot0.RefreshGuildNotice))
	slot0:RegistEventListener(GUILD_SWITCH_ICON_SERVER, handler(slot0, slot0.GuildSwitchIconServer))
	slot0:RegistEventListener(CHAT_GUILD_NEW_MESSAGE, handler(slot0, slot0.NewMessage))
	slot0:RegistEventListener(GUILD_REFRESH_MEMBER, handler(slot0, slot0.RefreshMember))
	slot0:RegistEventListener(GUILD_SHARE, handler(slot0, slot0.RefreshShareBtn))
	slot0:RegistEventListener(CHAT_GUILD_RESET, handler(slot0, slot0.RefreshMessage))
end

function slot0.OnTop(slot0)
	if GuildData:GetGuildInfo().id == nil then
		slot0:Go("/home")

		return
	end

	slot0:RefreshWindowBar()
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(2)
	end)
end

function slot0.BindUIRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.buttonManager_.transform, RedPointConst.GUILD_MANAGER)
	manager.redPoint:bindUIandKey(slot0.buttonTask_.transform, RedPointConst.CLUB_TASK)
	manager.redPoint:bindUIandKey(slot0.buttonWelfare_.transform, RedPointConst.CLUB_WELFARE)
	manager.redPoint:bindUIandKey(slot0.noticeContainer_, RedPointConst.GUILD_BOSS, {
		x = 0,
		y = 0
	})
end

function slot0.UnBindUIRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.buttonManager_.transform, RedPointConst.GUILD_MANAGER)
	manager.redPoint:unbindUIandKey(slot0.buttonTask_.transform, RedPointConst.CLUB_TASK)
	manager.redPoint:unbindUIandKey(slot0.buttonWelfare_.transform, RedPointConst.CLUB_WELFARE)
	manager.redPoint:unbindUIandKey(slot0.noticeContainer_, RedPointConst.GUILD_BOSS)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:UnBindUIRedPoint()
	slot0:StopTimer()
	slot0:StopShareTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnCopy_, nil, function ()
		UnityEngine.GUIUtility.systemCopyBuffer = GuildData:GetGuildInfo().id

		ShowTips("COPY_SUCCESS")
	end)
	slot0:AddBtnListener(slot0.buttonName_, nil, function ()
		JumpTools.OpenPageByJump("guildRename")
	end)
	slot0:AddBtnListener(slot0.buttonNotice_, nil, function ()
		JumpTools.OpenPageByJump("guildChangeNotice")
	end)
	slot0:AddBtnListener(slot0.buttonLogo_, nil, function ()
		if GuildConst.GUILD_POST.DEPUTY <= GuildData:GetGuildInfo().post then
			return
		end

		JumpTools.OpenPageByJump("guildHeadIconSelect", {
			selectID = slot0.icon
		})
	end)
	slot0:AddBtnListener(slot0.buttonManager_, nil, function ()
		GuildAction.RequiredGuildMemberList(function (slot0)
			uv0:Go("/guildManager")
		end)
	end)
	slot0:AddBtnListener(slot0.buttonShop_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.GUIDE_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.buttonTask_, nil, function ()
		JumpTools.OpenPageByJump("/communityTask")
	end)
	slot0:AddBtnListener(slot0.buttonWelfare_, nil, function ()
		JumpTools.OpenPageByJump("communityWelfare")
	end)
	slot0:AddBtnListener(slot0.buttonChat_, nil, function ()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	slot0:AddBtnListener(slot0.btnLevel_, nil, function ()
		uv0.textLimitExp_.text = string.format("%s/%s", GuildData:GetGuildInfo().curWeekExp, GuildData:GetMaxWeekExp())

		uv0:AddTimer()
	end)
	slot0:AddBtnListener(slot0.bossBtn_, nil, function ()
		if not GuildData:GetBossData().initedFromServer then
			ShowTips("GUILD_BOSS_CD_TIP")

			return
		end

		JumpTools.OpenPageByJump("/guildBossMain", {
			isEnter = 1
		}, ViewConst.SYSTEM_ID.GUILD_BOSS)
	end)
	slot0:AddBtnListener(slot0.guildShareBtn_, nil, function ()
		if manager.time:GetServerTime() < GuildData:GetShareTimestamp() then
			ShowTips(string.format(GetTips("CLUB_SHARE_CD_TIPS"), manager.time:GetLostTimeStr(slot0)))
		else
			JumpTools.OpenPageByJump("guildShareInfo")
		end
	end)
	slot0:AddBtnListener(slot0.spBtn_, nil, function ()
		ActivityTools.JumpBackToActivityMainViewByActivityID(GuildActivitySPData:GetCurMainActivityID())
	end)
end

function slot0.RefreshWindowBar(slot0)
	slot1 = {}
	slot2 = GameSetting.club_info_describe.value

	manager.windowBar:SwitchBar((GuildData:GetGuildInfo().post > GuildConst.GUILD_POST.DEPUTY or (#slot2 <= 0 or {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	}) and {
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	}) and (#slot2 <= 0 or {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	}) and {
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})

	if #slot2 > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = slot2
			}
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.RefreshGuildUI(slot0)
	slot1 = GuildData:GetGuildInfo()

	slot0:GuildRename(slot1.name)

	slot0.textID_.text = string.format("ID:%s", slot1.id)
	slot0.textCaptain_.text = GetI18NText(slot1.captain)

	slot0:RefreshGuildNotice(slot1.notice)
	slot0:GuildSwitchIconServer(slot1.icon)
	slot0:RefreshGuildExp()
	slot0:RefreshMember()
	slot0:RefreshMessage()
	slot0:RefreshSpActivityState()
	TimeTools.StartAfterSeconds(0.1, function ()
		uv0:UpdateTimer()
	end, {})
end

function slot0.RefreshSpActivityState(slot0)
	slot1, slot0.activitySpID = GuildActivitySPTools.CheckGuildActivitySPIsOpen()

	if slot1 then
		SetActive(slot0.spBtn_.gameObject, true)

		slot0.spbtnImg_.sprite = getSpriteViaConfig("ActivityClubSPEnterIcon", slot2)

		if GuildActivitySpTools.GetCurOpenActivityStateInfo().activityName ~= "" then
			slot0.activityName.text = GetTips(slot3.activityName)
		end
	else
		slot0.activitySpID = nil

		SetActive(slot0.spBtn_.gameObject, false)
	end
end

function slot0.ShowImpeachTips(slot0)
	if GuildData:GetGuildInfo().post == GuildConst.GUILD_POST.CAPTAIN and slot1.impeachTime - manager.time:GetServerTime() > 0 and not GuildData:GetImpeachFlag() then
		JumpTools.OpenPageByJump("guildImpeachTips")
	end
end

function slot0.RefreshMessage(slot0)
	ChatGuildData:InitCacheGuildContent()
	slot0:NewMessage()
end

function slot0.UpdateTimer(slot0)
	slot1, slot2 = GuildData:GetLastTime()
	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(slot2)

	if slot0.statusName_ ~= slot1 then
		if slot1 == "prepose" then
			slot0.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
			slot0.lastTimeText_.text = GetTips("GONGHUIBOSS_LIEXIZHENGZHAO")
			slot0.bossBtnImage_.sprite = getSpriteWithoutAtlas("TextureConfig/ClubUI/Boss_btn_002")
		else
			slot0.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
			slot0.lastTimeText_.text = GetTips("GONGHUIBOSS_LIEXIKAIFANG")
			slot0.bossBtnImage_.sprite = getSpriteWithoutAtlas("TextureConfig/ClubUI/Boss_btn_001")
		end

		slot0.statusName_ = slot1
	end

	slot3 = manager.time:GetServerTime()

	if slot0.activitySpID then
		slot4, slot5 = GuildActivitySPTools.CheckActivityCurState(slot0.activitySpID)

		if slot4 == "start" then
			slot6, slot7, slot8 = GuildActivitySPTools.GetCurActivityTimeStage(slot5)

			if slot6 == 2 then
				slot0.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(slot7)
				slot0.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
			elseif slot6 == 1 then
				slot0.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(slot8)
				slot0.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
			end
		end

		if slot4 == "register" then
			slot0.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(slot5).stopTime)
			slot0.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP0"))
		end
	end
end

function slot0.SwitchHeadIcon(slot0, slot1)
	GuildAction.GuildSwitchIcon(slot1, function (slot0)
		if isSuccess(slot0.result) then
			ShowTips("CLUB_CHANGED_ICON_SUCCESS")
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.GuildRename(slot0, slot1)
	slot0.textName_.text = GetI18NText(slot1)
end

function slot0.RefreshGuildNotice(slot0, slot1)
	if slot1 and #slot1 > 0 then
		slot0.noticeController_:SetSelectedState("full")
	else
		slot0.noticeController_:SetSelectedState("empty")
	end

	slot0.textNotice_.text = GetI18NText(slot1)
end

function slot0.GuildSwitchIconServer(slot0, slot1)
	slot0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[slot1].icon_bg)
end

function slot0.NewMessage(slot0)
	slot2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)
	slot3, slot4 = nil

	if #ChatGuildData:GetCacheContent() > 0 then
		for slot8 = #slot1, 1, -1 do
			if slot1[slot8].id and not table.keyof(slot2, slot3.id) then
				if slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
					slot4 = string.format("[%s]", ChatStickerCfg[tonumber(slot3.content)].name)

					break
				end

				slot4 = slot3.content

				break
			end
		end

		if slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			slot4 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(slot3.content)].name))
		end

		slot0.chatTextExtension_:SetText(string.format("%s:%s", slot3.nick, slot4))
	else
		slot0.textChat_.text = ""
	end
end

function slot0.RefreshGuildExp(slot0)
	slot1 = GuildData:GetGuildInfo()

	for slot7 = slot1.level - 1, 1, -1 do
		slot3 = slot1.exp - ClubLevelCfg[slot7].club_level_exp
	end

	slot4 = ClubLevelCfg[slot2].club_level_exp

	if GameSetting.club_max_level.value[1] <= slot2 then
		slot0.textExp_.text = "-/-"
		slot0.imageProcess_.value = 1
	else
		slot0.textExp_.text = string.format("%s/%s", slot3, slot4)
		slot0.imageProcess_.value = slot3 / slot4
	end

	slot0.textLevel_.text = string.format(GetTips("CLUB_LEVEL"), slot2)
end

function slot0.RefreshMember(slot0)
	slot1 = GuildData:GetGuildInfo()
	slot0.textMember_.text = string.format("%s/%s", slot1.memberCnt, ClubLevelCfg[slot1.level].user_num_max)

	if slot1.post == GuildConst.GUILD_POST.CAPTAIN then
		slot0.controller_:SetSelectedState("CAPTAIN")

		slot0.mangerText.text = GetTips("CLUB_BOSS_MANAGER")
	elseif slot1.post == GuildConst.GUILD_POST.DEPUTY then
		slot0.controller_:SetSelectedState("DEPUTY")

		slot0.mangerText.text = GetTips("CLUB_BOSS_MANAGER")
	else
		slot0.controller_:SetSelectedState("MEMBER")

		slot0.mangerText.text = GetTips("CLUB_BOSS_MEMBER")
	end

	slot0:RefreshShareBtn()
	slot0:RefreshWindowBar()
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	SetActive(slot0.goLevelTips_, true)

	slot0.timer_ = Timer.New(function ()
		uv0:StopTimer()
	end, 3, 1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	SetActive(slot0.goLevelTips_, false)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddShareTimer(slot0)
	slot0:StopShareTimer()

	slot1 = GuildData:GetGuildInfo()

	if GuildData:GetShareTimestamp() < manager.time:GetServerTime() then
		slot0:RefreshShareBtn()

		return
	end

	slot3 = manager.time:GetServerTime() - slot2
	slot0.timeText_.text = manager.time:GetLostTimeStr(slot2)
	slot0.shareTimer_ = Timer.New(function ()
		uv1.timeText_.text = manager.time:GetLostTimeStr(uv0)

		if manager.time:GetServerTime() - uv0 >= 0 then
			uv1:StopShareTimer()
			uv1:RefreshShareBtn()

			return
		end
	end, 1, -1)

	slot0.shareTimer_:Start()
end

function slot0.StopShareTimer(slot0)
	if slot0.shareTimer_ then
		slot0.shareTimer_:Stop()

		slot0.shareTimer_ = nil
	end
end

function slot0.RefreshShareBtn(slot0)
	if table.keyof(GameSetting.club_share_member_list.value, GuildData:GetGuildInfo().post) then
		SetActive(slot0.guildShareGo_, true)
	else
		SetActive(slot0.guildShareGo_, false)

		return
	end

	if GuildData:GetShareTimestamp() <= manager.time:GetServerTime() then
		SetActive(slot0.timeGo_, false)

		slot0.guildShareBtn_.interactable = true
	else
		SetActive(slot0.timeGo_, true)

		slot0.guildShareBtn_.interactable = false

		slot0:AddShareTimer()
	end
end

return slot0
