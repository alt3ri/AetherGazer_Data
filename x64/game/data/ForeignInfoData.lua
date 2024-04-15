slot0 = singletonClass("ForeignInfoData", BaseHeroViewData)
slot1 = {}
slot2 = nil

function slot0.SetForeignHeroInfo(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.hero_base_info
		slot8 = ForeignHeroDataTemplate.New(slot7.id)

		slot8:Init(slot6)

		uv0[slot7.id] = slot8
	end
end

function slot0.GetHeroList(slot0)
	return uv0
end

function slot0.GetHeroNO(slot0, slot1)
	return table.indexof(slot0:GetHeroIDList(), slot1) or 0
end

function slot0.GetEquipDataList(slot0, slot1)
	return uv0[slot1].equip_list
end

function slot0.SetCurForeignDetailInfo(slot0, slot1)
	uv0 = {
		user_id = slot1.user_id,
		level = slot1.level,
		nick = slot1.base_info.nick,
		icon = slot1.base_info.icon,
		icon_frame = slot1.base_info.icon_frame,
		sign = slot1.sign,
		sticker_show_info = PlayerData:InitStickerShowList(slot1.sticker_show_info),
		sticker_background = slot1.sticker_background,
		hero_list = slot1.hero_list or {},
		is_online = slot1.is_online,
		ip = (slot1.ip_location == nil or slot1.ip_location == "") and GetTips("IP_UNKNOWN") or slot1.ip_location,
		guildID = slot1.club_id,
		guildName = slot1.club_name,
		guildIcon = slot1.club_icon,
		postGril = slot0:GetPostID(slot1.poster_hero),
		birthdayMonth = slot1.birthday.month,
		birthdayDay = slot1.birthday.day,
		backhome_architecture_id = slot1.backhome_architecture_id,
		hero_id_list = cleanProtoTable(slot1.hero_id_list),
		likes = slot1.likes,
		used_tag_list = cleanProtoTable(slot1.used_tag_list),
		card_bg_id = slot1.information_background_id,
		post_background_id = slot1.post_background_id,
		achievement_static_info = slot1.achievement_static_info,
		hero_static_info = slot1.hero_static_info,
		weapon_servant_static_info = slot1.weapon_servant_static_info,
		sticker_static_info = slot1.sticker_static_info
	}
end

function slot0.GetPostID(slot0, slot1)
	if slot1.hero_id ~= 0 then
		if slot1.using_skin ~= 0 then
			return slot1.using_skin
		else
			return slot1.hero_id
		end
	end

	return 1084
end

function slot0.GetCurForeignDetailInfo(slot0)
	return uv0
end

function slot0.OnSendLike(slot0)
	if uv0 and uv0.likes then
		uv0.likes = uv0.likes + 1
	end
end

function slot0.GetExFilterSorterFunc(slot0)
	return function (slot0, slot1)
		return true, ForeignInfoData:GetHeroNO(slot0.id) < ForeignInfoData:GetHeroNO(slot1.id)
	end
end

return slot0
