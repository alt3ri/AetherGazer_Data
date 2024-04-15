slot1 = {
	[ActivityConst.GUILD_ACTIVITY_SP_2_4] = {
		helpKey = "CLUB_ACTIVITY_SP_AFFIX_DESC",
		application_1 = "ACTIVITY_CLUB_SP_APPLICATION_INTRODUCTION1",
		activityName = "",
		introduction = "ACTIVITY_CLUB_SP_INTRODUCTION",
		exitClub = "ACTIVITY_CLUB_SP_ACTIVITYING_EXIT_CLUB_TIP",
		application_2 = "ACTIVITY_CLUB_SP_APPLICATION_INTRODUCTION2",
		isPrefabInfoType = false,
		removeMenber = "ACTIVITY_CLUB_SP_ACTIVITYING_REMOVE_MEMBER_TIP",
		nextMapLock = "ACTIVITY_CLUB_SP_NEXT_MAP_LOCK_TIP",
		secondOpen = "ACTIVITY_CLUB_SP_SECOND_STAGE_OPEN_TIP",
		register = ActivityConst.GUILD_ACTIVITY_SP_2_4_REGISTER,
		start = ActivityConst.GUILD_ACTIVITY_SP_2_4_START,
		currencyID = {
			MaterialConst.GUILD_ACTIVITY_SP_COIN1,
			MaterialConst.GUILD_ACTIVITY_SP_COIN2
		},
		shopID = ShopConst.SHOP_ID.SUPPORT_SHOP,
		pages = GameSetting.activity_club_sp_describe.value,
		chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4
	},
	[ActivityConst.GUILD_ACTIVITY_SP_2_8] = {
		helpKey = "CLUB_ACTIVITY_SP2_AFFIX_DESC",
		application_1 = "ACTIVITY_CLUB_SP2_APPLICATION_INTRODUCTION1",
		activityName = "ACTIVITY_CLUB_SP2_NAME",
		introduction = "ACTIVITY_CLUB_SP2_INTRODUCTION",
		exitClub = "ACTIVITY_CLUB_SP2_ACTIVITYING_EXIT_CLUB_TIP",
		application_2 = "ACTIVITY_CLUB_SP2_APPLICATION_INTRODUCTION2",
		isPrefabInfoType = true,
		removeMenber = "ACTIVITY_CLUB_SP2_ACTIVITYING_REMOVE_MEMBER_TIP",
		nextMapLock = "ACTIVITY_CLUB_SP2_NEXT_MAP_LOCK_TIP",
		secondOpen = "ACTIVITY_CLUB_SP2_SECOND_STAGE_OPEN_TIP",
		register = ActivityConst.GUILD_ACTIVITY_SP_2_8_REGISTER,
		start = ActivityConst.GUILD_ACTIVITY_SP_2_8_START,
		currencyID = {
			MaterialConst.GUILD_ACTIVITY_SP_2_8_COIN1,
			MaterialConst.GUILD_ACTIVITY_SP_2_8_COIN2
		},
		shopID = ShopConst.SHOP_ID.SUPPORT_SHOP_2_8,
		pages = GameSetting.activity_club_sp2_describe.value,
		chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8
	}
}

return {
	GetActivityEnterViewPrefab = function (slot0)
		slot1 = nil

		return (slot0 ~= ActivityConst.GUILD_ACTIVITY_SP_2_4 or Asset.Load("UI/GuildActivitySPUI/GuildActivitySPEnterUI")) and Asset.Load("UI/VersionUI/IndiaUI_2_8/IndiaGuildUI/IndiaGuildActivitySPEnterUI")
	end,
	GetCurActivityIDInfo = function (slot0)
		return uv0[slot0]
	end,
	GetCurActivityDescribe = function ()
		if uv0[GuildActivitySPData:GetCurMainActivityID()] then
			return uv0[slot0].pages, uv0[slot0].isPrefabInfoType
		else
			CustomLog.Log("未获取到对应活动的玩法说明配置信息" .. slot0)
		end
	end,
	GetActivityState = function ()
		return uv0
	end,
	GetCurOpenActivityStateInfo = function ()
		return uv0[GuildActivitySPData:GetCurMainActivityID()]
	end,
	CheckGuildActivitySPIsOpen = function ()
		if GuildActivitySPData:GetCurMainActivityID() then
			slot1 = ActivityData:GetActivityData(slot0)

			if slot1.startTime <= manager.time:GetServerTime() and slot4 < slot1.stopTime then
				return true, slot0
			end
		end

		return false
	end,
	CheckActivityCurState = function (slot0)
		if uv0[slot0] then
			if uv1.CheckActivityIsOpen(slot1.start) then
				return "start", slot1.start
			end

			if uv1.CheckActivityIsOpen(slot1.register) then
				return "register", slot1.register
			end
		end
	end,
	CheckActivityIsOpen = function (slot0)
		slot1 = ActivityData:GetActivityData(slot0)

		if slot1.startTime <= manager.time:GetServerTime() and slot4 < slot1.stopTime then
			return true
		end
	end,
	GetCurActivityTimeStage = function (slot0)
		slot2 = ActivityData:GetActivityData(slot0)

		if slot2.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
			return 2, slot2.stopTime, slot4
		else
			return 1, slot5, slot4
		end
	end,
	GetTopUserLevel = function (slot0)
		if ActivityClubLevelSettingCfg.get_id_list_by_activity[slot0] then
			return #slot1
		end
	end,
	GetCurCurrencyID = function (slot0, slot1)
		if slot0 and slot1 then
			return uv0[slot0].currencyID[slot1]
		end
	end,
	GetCantUseHeroList = function ()
		for slot5, slot6 in ipairs(GuildActivitySPData:GetFightHeroList()) do
			table.insert({}, slot6.id)
		end

		slot3 = {}

		for slot7, slot8 in ipairs(HeroData:GetUnlockHeros()) do
			if not table.indexof(slot1, slot8) then
				table.insert(slot3, slot8)
			end
		end

		return slot3
	end
}
