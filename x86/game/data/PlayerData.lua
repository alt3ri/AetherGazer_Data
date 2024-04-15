slot0 = singletonClass("PlayerData")
slot0.INVALID_PLAYER = "0"
slot1 = {
	userID = 1,
	show_hero_flag = 1,
	remain_exp = 0,
	likes = 0,
	show_sticker_flag = 1,
	is_changed_nick = 0,
	plot_progress = 0,
	hero_num = 0,
	poster_girl = 1084,
	register_timestamp = 0,
	icon_frame = 2001,
	ip = "",
	extra_chang_nick_time = 0,
	timestamp = 0,
	card_bg_id = 0,
	total_exp = 0,
	birthday_day = 0,
	originalLevel = 1,
	birthday_month = 0,
	nick = "",
	signUserId = "",
	portrait = 1084,
	userLevel = 10,
	sticker_background = 0,
	sign = "",
	sticker_show = {},
	all_background_list = {},
	all_sticker_list = {},
	sticker_show_info = {},
	unlocked_portraits = {},
	icon_frame_list = {},
	heroes = {},
	storylist = {},
	levelUpInfos = {},
	likes_list = {},
	today_send_like = {},
	card_background_list = {},
	tag_info_list = {},
	used_tag_list = {},
	used_chat_buddle_id = GameSetting.profile_chat_bubble_default.value[1],
	chat_bubble_unlock_id_list = {
		GameSetting.profile_chat_bubble_default.value[1]
	}
}

function slot0.Init(slot0)
	uv0.levelUpInfos = {}
end

slot2 = {}
slot3 = {}
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = {}
slot8 = {}
slot9 = {}
slot10 = {}
slot11 = {}
slot12 = {}
slot13 = {}
slot14 = {}

function slot0.PlayInfoInit(slot0, slot1)
	uv0.total_exp = slot1.total_exp
	uv0.userLevel, uv0.remain_exp = LvTools.CheckExp(1, uv0.total_exp, "user_level_exp")
	uv0.is_changed_nick = slot1.is_changed_nick
	uv0.extra_chang_nick_time = slot1.system_change_nick_times or 0

	if uv0.nick ~= "" and uv0.nick ~= slot1.nick then
		manager.notify:CallUpdateFunc(CHANGE_NAME, slot1)
	end

	uv0.nick = slot1.nick
	uv0.hero_num = slot1.hero_num
	uv0.plot_progress = slot1.plot_progress

	manager.notify:Invoke(PLAYER_MODIFIED)

	if uv0.ip == "" then
		uv0.ip = GetTips("IP_UNKNOWN")
	end
end

function slot0.SetPlayerIP(slot0, slot1)
	uv0.ip = slot1.ip_location or GetTips("IP_UNKNOWN")
end

function slot0.SetPlayerBirthday(slot0, slot1)
	uv0.birthday_month = slot1.month
	uv0.birthday_day = slot1.day

	manager.redPoint:setTip(RedPointConst.BRITHDAY, slot1.month == 0 and 1 or 0)
end

function slot0.GetPlayerBrithday(slot0)
	return uv0.birthday_month, uv0.birthday_day
end

function slot0.GetPlayerInfo(slot0)
	uv0.icon_frame = slot0:GetCurFrame()
	uv0.card_bg_id = slot0:GetCurCardBg()

	return uv0
end

function slot0.GetStoryList(slot0)
	return uv0.storylist
end

function slot0.GetlevelUpInfos(slot0)
	return uv0.levelUpInfos and deepClone(uv0.levelUpInfos) or {}
end

function slot0.UserBaseInfoInit(slot0, slot1)
	uv0.userID = slot1.userID
	uv0.register_timestamp = slot1.register_timestamp
	uv0.signUserId = slot1.uid_sign
end

function slot0.UserLoginTimestampInit(slot0, slot1)
	uv0.timestamp = slot1.timestamp
end

function slot0.PlayerProtraitChange(slot0, slot1)
	uv0.portrait = slot1.portrait
end

function slot0.PlayerNicknameChange(slot0, slot1)
	uv0.nick = slot1
end

function slot0.GetExtraChangeNickTime(slot0)
	return uv0.extra_chang_nick_time
end

function slot0.UpdateNameChangeInfo(slot0, slot1)
	if not slot1 then
		return
	end

	uv0.extra_chang_nick_time = slot1.system_change_nick_times or 0
	uv0.is_changed_nick = slot1.is_changed_nick or 0
end

function slot0.GetIP(slot0)
	return uv0.ip
end

function slot0.EXPChange(slot0, slot1)
	uv0.total_exp = slot1
	uv0.userLevel, uv0.remain_exp = LvTools.CheckExp(1, uv0.total_exp, "user_level_exp")

	if uv0.userLevel ~= uv0.userLevel then
		manager.notify:Invoke(PLAYER_LEVEL_UP, slot2, slot3)
		SDKTools.SetDefaultPublicAttribute()
		SendMessageManagerToSDK("role_level", {
			level = slot3
		})
	end
end

function slot0.PlayerCardInit(slot0, slot1)
	uv0.sign = slot1.sign
	uv0.heroes = cleanProtoTable(slot1.heroes)
	uv0.sticker_show = cleanProtoTable(slot1.sticker_show, {
		"sticker_id",
		"location"
	})
	uv0.all_background_list = cleanProtoTable(slot1.all_background_list)
	uv0.sticker_show_info = uv1:InitStickerShowList(slot1.sticker_show_info or {})
	uv0.sticker_background = slot1.sticker_background or GameSetting.sticker_background_default.value[1]
	uv0.all_sticker_list = cleanProtoTable(slot1.all_sticker_list)
	uv0.unlocked_portraits = cleanProtoTable(slot1.icon_list)
	uv0.icon_frame_list = cleanProtoTable(slot1.icon_frame_list, {
		"id",
		"lasted_time"
	})
	uv0.likes = slot1.likes
	uv0.likes_list = cleanProtoTable(slot1.info_list, {
		"id",
		"time"
	})
	uv0.today_send_like = cleanProtoTable(slot1.today_send_like)
	uv0.card_background_list = cleanProtoTable(slot1.information_background_list, {
		"id",
		"lasted_time"
	})
	uv0.tag_info_list = cleanProtoTable(slot1.tag_info_list, {
		"id",
		"lasted_time",
		"obtain_time"
	})
	uv0.used_tag_list = cleanProtoTable(slot1.used_tag_list or {})
	uv0.card_bg_id = slot1.information_background_id
	uv0.used_chat_buddle_id = slot1.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]
	uv0.chat_bubble_unlock_id_list = cleanProtoTable(slot1.chat_bubble_list or {
		GameSetting.profile_chat_bubble_default.value[1]
	})

	if slot1.poster_girl and slot1.poster_girl ~= 0 then
		uv0.poster_girl = slot1.poster_girl
	else
		uv0.poster_girl = 1084
	end

	if slot1.icon and slot1.icon ~= 0 and slot1.icon ~= 1 then
		uv0.portrait = slot1.icon
	else
		uv0.portrait = GameSetting.profile_avatar_default.value[1]
	end

	if slot1.icon_frame and slot1.icon_frame ~= 0 and slot1.icon_frame ~= 1 then
		uv0.icon_frame = slot1.icon_frame
	else
		uv0.icon_frame = GameSetting.profile_avatar_frame_default.value[1]
	end

	uv1:InitStickerList()
	uv1:InitStickerBgList()
	uv1:InitPortraitList()
	uv1:InitFrameList()
	uv1:InitCardBgList()
	uv1:InitTagInfoList()

	uv2 = {}
	uv3 = {}
	uv4 = {}
end

function slot0.InitStickerShowList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		for slot12, slot13 in ipairs(slot7.sticker_display_info) do
			-- Nothing
		end

		slot2[slot7.page_id] = {
			index = slot7.page_id,
			viewID = slot7.template_id,
			sticker = {
				[slot13.location] = {
					stickerID = slot13.sticker_id,
					size = slot13.size
				}
			}
		}
	end

	return slot2
end

function slot0.InitOverdueFrameList(slot0, slot1)
	if #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(uv0, {
				id = slot6.id,
				num = slot6.num,
				timeValid = slot6.time_valid
			})
		end
	end
end

function slot0.InitOverdueCardBgList(slot0, slot1)
	if #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(uv0, {
				num = 1,
				id = slot6.id,
				timeValid = slot6.time_valid
			})
		end
	end
end

function slot0.InitOverdueTagList(slot0, slot1)
	if #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(uv0, {
				num = 1,
				id = slot6.id,
				time_valid = slot6.time_valid
			})
		end
	end
end

function slot0.PlayerSignChange(slot0, slot1)
	uv0.sign = slot1
end

function slot0.PlayerShowHeroChange(slot0, slot1)
	uv0.heroes = cleanProtoTable(slot1)
end

function slot0.PlayerPosterGirlChange(slot0, slot1)
	uv0.poster_girl = slot1
end

function slot0.StoryInit(slot0, slot1)
	uv0.storylist = {}

	for slot5, slot6 in ipairs(slot1) do
		uv0.storylist[slot6] = true
	end
end

function slot0.StoryModify(slot0, slot1)
	uv0.storylist[slot1] = true
end

function slot0.PlayerOriginalLevel(slot0, slot1)
	uv0.originalLevel = slot1.user_level
end

function slot0.ChangeLevel(slot0, slot1)
	if not uv0.levelUpInfos then
		uv0.levelUpInfos = {}
	end

	if #uv0.levelUpInfos > 0 then
		slot2 = math.min(uv0.levelUpInfos[1].fromLevel, slot1.fromLevel)
		slot3 = math.max(uv0.levelUpInfos[1].toLevel, slot1.toLevel)
	end

	uv0.levelUpInfos[1] = {
		fromLevel = slot2,
		toLevel = slot3
	}
end

function slot0.LevelUpFinish(slot0, slot1)
	if uv0.levelUpInfos then
		while table.getn(uv0.levelUpInfos) > 0 do
			table.remove(uv0.levelUpInfos, 1)
		end
	end
end

function slot0.InitModuleSwitchData(slot0, slot1)
end

function slot0.GetModuleSwitchData(slot0, slot1)
	return uv0[slot1]
end

function slot0.InitStickerList(slot0)
	uv0 = {
		get_sticker_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER]) do
		uv0[slot6] = {
			unlock = 0,
			id = slot6
		}

		table.insert(uv0.get_sticker_id_list, slot6)
	end

	for slot5, slot6 in ipairs(uv1.all_sticker_list) do
		if uv0[slot6] then
			uv0[slot6].unlock = 1
		end
	end
end

function slot0.InitStickerBgList(slot0)
	uv0 = {
		get_sticker_bg_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER_BG]) do
		uv0[slot6] = {
			unlock = 0,
			id = slot6
		}

		table.insert(uv0.get_sticker_bg_id_list, slot6)
	end

	for slot5, slot6 in ipairs(uv1.all_background_list) do
		if uv0[slot6] then
			uv0[slot6].unlock = 1
		end
	end
end

function slot0.InitPortraitList(slot0)
	uv0 = {
		get_portrait_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.PORTRAIT]) do
		uv0[slot6] = {
			unlock = 0,
			id = slot6
		}

		table.insert(uv0.get_portrait_id_list, slot6)
	end

	for slot5, slot6 in ipairs(uv1.unlocked_portraits) do
		if uv0[slot6] then
			uv0[slot6].unlock = 1
		end
	end
end

function slot0.InitFrameList(slot0)
	uv0 = {
		get_frame_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.FRAME]) do
		if ItemCfg[slot6].sub_type ~= ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT then
			uv0[slot6] = {
				lasted_time = 0,
				unlock = 0,
				id = slot6
			}

			table.insert(uv0.get_frame_id_list, slot6)
		end
	end

	slot2 = nil

	for slot6, slot7 in ipairs(uv1.icon_frame_list) do
		if uv0[slot7.id] then
			uv0[slot2].unlock = 1
			uv0[slot2].lasted_time = slot7.lasted_time
		end
	end
end

function slot0.InitCardBgList(slot0)
	uv0 = {
		get_cardBg_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.CARD_BG]) do
		if ItemCfg[slot6].sub_type ~= ItemConst.ITEM_SUB_TYPE.CARD_BG_LIMIT then
			uv0[slot6] = {
				lasted_time = 0,
				unlock = 0,
				id = slot6
			}

			table.insert(uv0.get_cardBg_id_list, slot6)
		end
	end

	for slot5, slot6 in ipairs(uv1.card_background_list) do
		if uv0[slot6.id] then
			uv0[slot7].unlock = 1
			uv0[slot7].lasted_time = slot6.lasted_time
		end
	end
end

function slot0.InitTagInfoList(slot0)
	uv0 = {
		get_tagList_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.TAG]) do
		if ItemCfg[slot6].sub_type ~= ItemConst.ITEM_SUB_TYPE.TAG_LIMIT then
			uv0[slot6] = {
				obtain_time = 0,
				lasted_time = 0,
				unlock = 0,
				id = slot6
			}

			table.insert(uv0.get_tagList_id_list, slot6)
		end
	end

	for slot5, slot6 in ipairs(uv1.tag_info_list) do
		if uv0[slot6.id] then
			uv0[slot7].unlock = 1
			uv0[slot7].lasted_time = slot6.lasted_time
			uv0[slot7].obtain_time = slot6.obtain_time
		end
	end
end

function slot0.InItReceivedSkinGift(slot0, slot1)
	uv0 = {
		all = {}
	}

	for slot5, slot6 in ipairs(slot1.list) do
		uv0[slot6.skin_id] = slot6.gift_acquire

		table.insert(uv0.all, slot6.skin_id)
	end
end

function slot0.ReceiveSkinGift(slot0, slot1)
	uv0[slot1] = true

	if not table.indexof(uv0.all, slot1) then
		table.insert(uv0.all, slot1)
	end
end

function slot0.IsNotReceived(slot0, slot1)
	if not uv0[slot1] or uv0[slot1] == false then
		return true
	end

	return false
end

function slot0.ChangeHeros(slot0, slot1)
	for slot5 = 1, 3 do
		uv0.heroes[slot5] = slot1[slot5]
	end
end

function slot0.ChangeHeroShow(slot0, slot1)
	uv0.show_hero_flag = slot1
end

function slot0.ChangeStickerShow(slot0, slot1)
	uv0.show_sticker_flag = slot1
end

function slot0.ChangeStickerList(slot0, slot1, slot2)
	uv0.sticker_show_info = uv1:InitStickerShowList(slot1)
	uv0.sticker_background = slot2

	manager.notify:CallUpdateFunc(CHANGE_STICKER_LIST, uv0.sticker_show_info, uv0.sticker_background)
end

function slot0.ChangePortrait(slot0, slot1)
	uv0.portrait = slot1
end

function slot0.ChangeFrameIcon(slot0, slot1)
	uv0.icon_frame = slot1
end

function slot0.GetHeroShowList(slot0)
	return uv0.heroes
end

function slot0.GetCurPortrait(slot0)
	return uv0.portrait
end

function slot0.GetCurFrame(slot0)
	if uv0[uv1.icon_frame] and slot1.lasted_time > 0 and slot1.unlock == 1 and slot1.lasted_time < manager.time:GetServerTime() then
		slot0:RefreshFrameList(function ()
			return uv0.icon_frame
		end)
	end

	return uv1.icon_frame
end

function slot0.GetCurCardBg(slot0)
	if uv0[uv1.card_bg_id] and slot1.unlock == 1 and slot1.lasted_time > 0 and slot1.lasted_time < manager.time:GetServerTime() then
		slot0:LockCardBg(uv1.card_bg_id)
		PlayerAction.ChangeCardBg(GameSetting.profile_business_card_default.value[1])

		return uv1.card_bg_id
	end

	return uv1.card_bg_id
end

function slot0.GetStickerShow(slot0)
	return uv0.sticker_show_info
end

function slot0.GetStickerList(slot0)
	return uv0.get_sticker_id_list
end

function slot0.GetSticker(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetStickerBg(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetPortraitList(slot0)
	return uv0.get_portrait_id_list
end

function slot0.GetPortrait(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetFrameList(slot0)
	return uv0.get_frame_id_list
end

function slot0.GetFrame(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetCardBgList(slot0)
	return uv0.get_cardBg_id_list
end

function slot0.GetCardBg(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetIsStickerShow(slot0)
	return uv0.show_sticker_flag
end

function slot0.UnlockSticker(slot0, slot1)
	if uv0[slot1] then
		if uv0[slot1].unlock == 0 then
			PlayerRedPoint:SetStickerUnlock(slot1)
		end

		uv0[slot1].unlock = 1

		table.insert(uv1.all_sticker_list, slot1)
	end
end

function slot0.UnlockStickerBg(slot0, slot1)
	if uv0[slot1] and uv0[slot1].unlock == 0 then
		uv0[slot1].unlock = 1

		manager.redPoint:setTip(RedPointConst.STICKER_BG .. "_" .. slot1, 1)
	end
end

function slot0.UnlockPortrait(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].unlock = 1

		table.insert(uv1.unlocked_portraits, slot1)
	end
end

function slot0.UnlockFrame(slot0, slot1)
	if uv0[ItemCfg[slot1].param[1]] then
		if slot2.sub_type == ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT or slot2.sub_type == ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT_COVER then
			if uv0[slot3].unlock == 0 then
				uv0[slot3].unlock = 1
				uv0[slot3].lasted_time = manager.time:GetServerTime() + slot2.param[2] * 86400

				table.insert(uv1.icon_frame_list, {
					id = slot3,
					lasted_time = uv0[slot3].lasted_time
				})
			elseif uv0[slot3].lasted_time == 0 then
				return
			else
				uv0[slot3].lasted_time = uv0[slot3].lasted_time + slot4 * 86400
			end
		else
			uv0[slot3].unlock = 1
			uv0[slot3].lasted_time = 0
		end
	end
end

function slot0.LockFrame(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].unlock = 0
		slot2 = nil

		for slot6, slot7 in ipairs(uv1.icon_frame_list) do
			if slot7.id == slot1 then
				table.remove(uv1.icon_frame_list, slot6)
			end
		end
	end
end

function slot0.UnlockTag(slot0, slot1)
	slot2 = manager.time:GetServerTime()

	if uv0[ItemCfg[slot1].param[1]] then
		if slot3.sub_type == ItemConst.ITEM_SUB_TYPE.TAG_LIMIT then
			slot6 = 0

			if slot3.param[2] == 0 then
				slot6 = 0
			elseif slot5 == 1 then
				slot6 = 7
			elseif slot5 == 2 then
				slot6 = 14
			elseif slot5 == 3 then
				slot6 = 30
			end

			if uv0[slot4].unlock == 0 then
				uv0[slot4].unlock = 1
				uv0[slot4].lasted_time = manager.time:GetServerTime() + slot6 * 86400

				table.insert(uv1.tag_info_list, {
					id = slot4,
					lasted_time = uv0[slot4].lasted_time,
					obtain_time = uv0[slot4].obtain_time
				})
				manager.redPoint:setTip(RedPointConst.TAG .. "_" .. slot4, 1)
				saveData("limitRed", "tag_" .. slot4, 1)
			elseif uv0[slot4].lasted_time == 0 then
				return
			else
				uv0[slot4].lasted_time = uv0[slot4].lasted_time + slot6 * 86400
			end
		else
			if uv0[slot4].unlock == 0 then
				uv0[slot4].obtain_time = slot2

				saveData("limitRed", "tag_" .. slot4, 1)
				manager.redPoint:setTip(RedPointConst.TAG .. "_" .. slot4, 1)
			end

			uv0[slot4].unlock = 1
			uv0[slot4].lasted_time = 0
		end
	end
end

function slot0.LockTag(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].unlock = 0

		for slot5, slot6 in ipairs(uv1.tag_info_list) do
			if slot6.id == slot1 then
				table.remove(uv1.tag_info_list, slot5)
			end
		end
	end
end

function slot0.UnlockCardBg(slot0, slot1)
	if uv0[ItemCfg[slot1].param[1]] then
		if slot2.sub_type == ItemConst.ITEM_SUB_TYPE.CARD_BG_LIMIT then
			slot5 = 0

			if slot2.param[2] == 0 then
				slot5 = 0
			elseif slot4 == 1 then
				slot5 = 7
			elseif slot4 == 2 then
				slot5 = 14
			elseif slot4 == 3 then
				slot5 = 30
			end

			if uv0[slot3].unlock == 0 then
				uv0[slot3].unlock = 1
				uv0[slot3].lasted_time = manager.time:GetServerTime() + slot5 * 86400

				table.insert(uv1.card_background_list, {
					id = slot3,
					lasted_time = uv0[slot3].lasted_time
				})
				manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. slot3, 1)
				saveData("limitRed", "cardBg_" .. slot3, 1)
			elseif uv0[slot3].lasted_time == 0 then
				return
			else
				uv0[slot3].lasted_time = uv0[slot3].lasted_time + slot5 * 86400
			end
		else
			if uv0[slot3].unlock == 0 then
				saveData("limitRed", "cardBg_" .. slot3, 1)
				manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. slot3, 1)
			end

			uv0[slot3].unlock = 1
			uv0[slot3].lasted_time = 0
		end
	end
end

function slot0.LockCardBg(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].unlock = 0

		for slot5, slot6 in ipairs(uv1.card_background_list) do
			if slot6.id == slot1 then
				table.remove(uv1.card_background_list, slot5)
			end
		end
	end
end

function slot0.RefreshFrameList(slot0, slot1)
	slot2 = nil
	slot3 = false

	for slot9, slot10 in ipairs(uv1.get_frame_id_list) do
		if uv1[slot10].unlock == 1 and slot2.lasted_time > 0 and slot2.lasted_time < manager.time:GetServerTime() then
			slot0:LockFrame(slot10)

			if slot10 == uv0.icon_frame then
				slot3 = true
			end
		end
	end

	if slot3 then
		PlayerAction.ChangeFrameIcon(GameSetting.profile_avatar_frame_default.value[1])
	end

	if slot1 then
		slot1()
	end
end

function slot0.DealOverdueFrame(slot0)
	if uv0 and #uv0 > 0 then
		JumpTools.OpenPageByJump("FrameExpired", {
			expiredList = uv0,
			type = ItemConst.ITEM_TYPE.FRAME
		})
		PlayerAction.DealOverdueFrame()

		uv0 = {}
	end
end

function slot0.DealOverdueCardBgList(slot0)
	if uv0 and #uv0 > 0 then
		JumpTools.OpenPageByJump("FrameExpired", {
			expiredList = uv0,
			type = ItemConst.ITEM_TYPE.CARD_BG
		})
		PlayerAction.DealOverdueCardBgList()

		uv0 = {}
	end
end

function slot0.DealOverdueTagList(slot0)
	if uv0 and #uv0 > 0 then
		JumpTools.OpenPageByJump("FrameExpired", {
			expiredList = uv0,
			type = ItemConst.ITEM_TYPE.TAG
		})
		PlayerAction.DealOverdueTagList()

		uv0 = {}
	end
end

function slot0.SetUnclaimedListFromServer(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.reward) do
		uv0[slot6.id] = slot6.stage
	end
end

function slot0.GetUnclaimed(slot0, slot1)
	return uv0[slot1] or nil
end

function slot0.ReadUnclaimed(slot0, slot1)
	uv0[slot1] = nil
end

function slot0.SetUsingTagList(slot0, slot1)
	uv0.used_tag_list = slot1
end

function slot0.GetUnlockTagListInfo(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(uv0.get_tagList_id_list) do
		if uv0[slot7] and slot8.unlock == 1 then
			if slot8.lasted_time == 0 or manager.time:GetServerTime() < slot8.lasted_time then
				table.insert(slot1, slot8)
			else
				slot0:LockTag(slot7)
			end
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if ProfileLabelCfg[slot0.id].type ~= ProfileLabelCfg[slot1.id].type then
			return slot3.type < slot2.type
		end

		if slot0.obtain_time ~= slot0.obtain_time then
			return slot0.obtain_time < slot0.obtain_time
		end

		return slot0.id < slot1.id
	end)

	return slot1
end

function slot0.GetUsingTagListInfo(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(uv0.used_tag_list) do
		if uv1[slot7] and slot8.unlock == 1 and (slot8.lasted_time == 0 or manager.time:GetServerTime() < slot8.lasted_time) then
			table.insert(slot1, slot7)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if ProfileLabelCfg[slot0].type ~= ProfileLabelCfg[slot1].type then
			return slot3.type < slot2.type
		end

		if uv0[slot0].obtain_time ~= uv0[slot1].obtain_time then
			return uv0[slot0].obtain_time < uv0[slot1].obtain_time
		end

		return slot0 < slot1
	end)

	return slot1
end

function slot0.GetTagInfo(slot0, slot1)
	return uv0[slot1]
end

function slot0.ResetSendLikeList(slot0)
	uv0.today_send_like = {}
end

function slot0.GetTodaySendLikeList(slot0)
	return uv0.today_send_like
end

function slot0.SetCardBg(slot0, slot1)
	uv0.card_bg_id = slot1
end

function slot0.OnSendLike(slot0, slot1)
	table.insert(uv0.today_send_like, slot1)
end

function slot0.GetLikeInfo(slot0)
	slot1 = {}

	for slot5 = 1, GameSetting.profile_like_record.value[1] do
		if uv0.likes_list[slot5] then
			table.insert(slot1, uv0.likes_list[slot5])
		else
			break
		end
	end

	return slot1
end

function slot0.AddLikeInfo(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		return slot1.time < slot0.time
	end)

	slot2 = {}

	table.insertto(slot2, slot1)
	table.insertto(slot2, uv0.likes_list)

	for slot6 = #slot2, GameSetting.profile_like_record.value[1] + 1, -1 do
		table.remove(slot2, slot6)
	end

	uv0.likes_list = slot2
	uv0.likes = uv0.likes + #slot1

	manager.notify:CallUpdateFunc(GET_LIKE)
end

slot15 = nil

function slot0.RefreshTagRed(slot0)
	slot0:StopTagRed()

	uv0 = Timer.New(function ()
		for slot5, slot6 in ipairs(uv0.get_tagList_id_list) do
			if uv0[slot6].unlock == 1 and slot7.lasted_time > 0 and (getData("limitRed", "tag_" .. slot6) or 0) == 1 then
				slot0 = 0 + 1

				if manager.time:GetServerTime() < slot7.lasted_time then
					uv1:LockTag(slot6)
					saveData("limitRed", "tag_" .. slot6, 0)
					manager.redPoint:setTip(RedPointConst.TAG .. "_" .. slot6, 0)
				else
					manager.redPoint:setTip(RedPointConst.TAG .. "_" .. slot6, 1)
				end
			end
		end

		if slot0 == 0 then
			uv1:StopTagRed()
		end
	end, 1, -1)

	uv0:Start()
end

function slot0.ClearTagRed(slot0)
	for slot4, slot5 in ipairs(uv0.get_tagList_id_list) do
		saveData("limitRed", "tag_" .. slot5, 0)
		manager.redPoint:setTip(RedPointConst.TAG .. "_" .. slot5, 0)
	end
end

function slot0.StopTagRed(slot0)
	if uv0 then
		uv0:Stop()

		uv0 = nil
	end
end

slot16 = nil

function slot0.RefreshCardBgRed(slot0)
	slot0:StopCardRed()

	uv0 = Timer.New(function ()
		for slot5, slot6 in ipairs(uv0.get_cardBg_id_list) do
			if uv0[slot6].unlock == 1 and slot7.lasted_time > 0 and (getData("limitRed", "cardBg_" .. slot6) or 0) == 1 then
				slot0 = 0 + 1

				if manager.time:GetServerTime() < slot7.lasted_time then
					uv1:LockCardBg(slot6)
					saveData("limitRed", "cardBg_" .. slot6, 0)
					manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. slot6, 0)
				else
					manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. slot6, 1)
				end
			end
		end

		if slot0 == 0 then
			uv1:StopCardRed()
		end
	end, 1, -1)

	uv0:Start()
end

function slot0.ClearCardBgRed(slot0)
	for slot4, slot5 in ipairs(uv0.get_cardBg_id_list) do
		saveData("limitRed", "cardBg_" .. slot5, 0)
		manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. slot5, 0)
	end
end

function slot0.StopCardRed(slot0)
	if uv0 then
		uv0:Stop()

		uv0 = nil
	end
end

function slot0.SetCurChatBubbleID(slot0, slot1)
	uv0.used_chat_buddle_id = slot1
end

function slot0.GetCurChatBubbleID(slot0)
	return uv0.used_chat_buddle_id
end

function slot0.UnlockChatBubble(slot0, slot1)
	table.insert(uv0.chat_bubble_unlock_id_list, slot1)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAT_BUBBLE, slot1), 1)
end

function slot0.GetUnlockChatBubbleIDList(slot0)
	return uv0.chat_bubble_unlock_id_list
end

function slot0.InitPlayerStoryTrigger(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.info_list) do
		uv0[slot6.trigger_group_id] = {}

		for slot10, slot11 in ipairs(slot6.completed_trigger_list) do
			table.insert(uv0[slot6.trigger_group_id], slot11)
		end
	end
end

function slot0.AddPlayerStoryTrigger(slot0, slot1)
	if uv0[StoryTriggerCfg[slot1].trigger_group] then
		if table.indexof(uv0[slot2.trigger_group], slot1) == false then
			table.insert(uv0[slot2.trigger_group], slot1)
		end
	else
		uv0[slot2.trigger_group] = {
			slot1
		}
	end
end

function slot0.GetPlayerStoryTriggerGroupInfo(slot0, slot1)
	slot2 = StoryTriggerCfg[slot1]
	slot3 = #StoryTriggerCfg.get_id_list_by_trigger_group[slot2.trigger_group]
	slot4 = 0

	if uv0[slot2.trigger_group] then
		slot4 = #uv0[slot2.trigger_group]
	end

	return slot4, slot3
end

return slot0
