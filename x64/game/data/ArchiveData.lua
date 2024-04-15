require("game.data.ArchiveDataTemplate")

slot0 = singletonClass("ArchiveData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
end

function slot0.InitArchive(slot0, slot1)
	uv0 = {}
	slot6 = slot1

	for slot5, slot6 in ipairs(cleanProtoTable(slot6)) do
		slot10 = {}
		uv0[slot6.archive_id] = {
			archive_id = slot6.archive_id,
			exp = slot6.exp,
			lv = LvTools.LoveExpToLevel(slot6.exp),
			gift_list = {},
			text_list = {},
			video_list = {},
			selected_picture = slot6.selected_picture,
			hero_story_list = {},
			super_heart_link_list = slot10
		}
		slot11 = slot6.gift_list

		for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
			uv0[slot6.archive_id].gift_list[slot11.id] = slot11.num
		end

		slot11 = slot6.text_list

		for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
			uv0[slot6.archive_id].text_list[slot11] = true
		end

		slot11 = slot6.video_list

		for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
			uv0[slot6.archive_id].video_list[slot11] = true
		end

		slot11 = slot6.hero_story_list

		for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
			uv0[slot6.archive_id].hero_story_list[slot11.hero_id] = slot11
		end

		slot11 = slot6.super_heart_link_list

		for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
			uv0[slot6.archive_id].super_heart_link_list[slot10] = slot11
		end
	end
end

function slot0.SortHeartArchiveList(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		slot0.unlocked, slot0.read_all_biography, slot0.watched_all_heartchain, slot0.trust, slot0.has_super_heartchain = uv0:GetSortAttribute(slot0)
		slot1.unlocked, slot1.read_all_biography, slot1.watched_all_heartchain, slot1.trust, slot1.has_super_heartchain = uv0:GetSortAttribute(slot1)

		if slot0.unlocked and not slot1.unlocked then
			return true
		elseif not slot0.unlocked and slot1.unlocked then
			return false
		end

		if not slot0.read_all_biography and slot1.read_all_biography then
			return true
		elseif slot0.read_all_biography and not slot1.read_all_biography then
			return false
		end

		if not slot0.watched_all_heartchain and slot1.watched_all_heartchain then
			return true
		elseif slot0.watched_all_heartchain and not slot1.watched_all_heartchain then
			return false
		end

		if slot1.trust < slot0.trust then
			return true
		elseif slot0.trust < slot1.trust then
			return false
		end

		if slot1.lv < slot0.lv then
			return true
		elseif slot0.lv < slot1.lv then
			return false
		end

		if slot0.has_super_heartchain and not slot1.has_super_heartchain then
			return true
		elseif not slot0.has_super_heartchain and slot1.has_super_heartchain then
			return false
		end

		return slot0.archive_id < slot1.archive_id
	end)
end

function slot0.GetSortAttribute(slot0, slot1)
	slot4 = false
	slot5 = false
	slot6 = false
	slot7 = 0
	slot8 = false

	for slot12, slot13 in ipairs(HeroRecordCfg[slot1.archive_id].hero_id) do
		if HeroData:GetHeroData(slot3[slot12]).unlock == 1 then
			slot4 = true
		end
	end

	slot5 = #ArchiveData:GetAnedoteList(slot3) == #ArchiveData:GetIsViewedArhiveStoryList(slot1.archive_id)

	for slot15, slot16 in pairs(slot1.video_list) do
		slot11 = 0 + 1
	end

	slot13 = slot11 + #ArchiveData:GetHasViewedSuperHeartList(slot1.archive_id) == #slot2.plot_id + #slot2.super_plot_id

	for slot17, slot18 in ipairs(slot3) do
		if slot7 < slot0:GetTrustLevel(HeroData:GetHeroData(slot3[slot17]).id) then
			slot7 = slot0:GetTrustLevel(slot19.id)
		end
	end

	return slot4, slot5, slot13, slot7, #slot2.super_plot_id > 0
end

function slot0.GetContinuousHeartArchiveList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if HeroRecordCfg[slot6.archive_id] and not table.isEmpty(HeroRecordCfg[slot6.archive_id].plot_id) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.GetContinuousSuperHeartArchiveList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if HeroRecordCfg[slot6.archive_id] and not table.isEmpty(HeroRecordCfg[slot6.archive_id].super_plot_id) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.GetContinuousHeartArchiveListByType(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if HeroRecordCfg[slot7.archive_id] and HeroCfg[slot8.id].race == slot1 and not table.isEmpty(slot8.plot_id) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetContinuousSuperHeartArchiveListByType(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if HeroCfg[HeroRecordCfg[slot7.archive_id].id].race == slot1 and not table.isEmpty(HeroRecordCfg[slot7.archive_id].super_plot_id) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetIsViewedArhiveStoryList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0[slot1].hero_story_list) do
		if slot7.is_viewed then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetSelectPicture(slot0, slot1)
	return slot0:GetArchive(slot1).selected_picture
end

function slot0.SetSelectPictrue(slot0, slot1, slot2, slot3)
	uv0[slot1].selected_picture = {
		id = slot2,
		type = slot3
	}
end

function slot0.GetHasViewedSuperHeartList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0[slot1].super_heart_link_list) do
		if slot7.is_viewed then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetHasViewedHeartList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0[slot1].video_list) do
		table.insert(slot2, slot6)
	end

	return slot2
end

function slot0.GetAnedoteList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		if HeroAnedoteCfg[slot7] then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0.GetArchiveList(slot0)
	return uv0
end

function slot0.IsHeartRead(slot0, slot1, slot2)
	if uv0[slot1] == nil then
		return true
	end

	return uv0[slot1].text_list[slot2]
end

function slot0.IsStoryRead(slot0, slot1, slot2)
	return uv0[slot1].video_list[slot2]
end

function slot0.SetHeartRead(slot0, slot1, slot2)
	uv0[slot1].text_list[slot2] = true
end

function slot0.SetStoryRead(slot0, slot1, slot2)
	uv0[slot1].video_list[slot2] = true
end

function slot0.IsArchiveStoryRead(slot0, slot1, slot2)
	for slot6, slot7 in pairs(uv0[slot1].hero_story_list) do
		if slot7.hero_id == slot2 then
			return slot7.is_viewed
		end
	end

	return false
end

function slot0.SetArchiveStoryRead(slot0, slot1, slot2)
	uv0[slot1].hero_story_list[slot2] = {
		is_viewed = true,
		hero_id = slot2
	}
end

function slot0.IsSuperHeartRead(slot0, slot1, slot2)
	if not uv0[slot1].super_heart_link_list[slot2] then
		return false
	end

	return uv0[slot1].super_heart_link_list[slot2].is_viewed
end

function slot0.SetSuperHeartRead(slot0, slot1, slot2)
	uv0[slot1].super_heart_link_list[slot2] = {
		is_viewed = true,
		index = slot2
	}
end

function slot0.GetUnlockHeartListInfoLengthByHeroId(slot0, slot1)
	slot3 = HeroRecordCfg[slot0:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[slot1][1]).archive_id].hero_id
	slot5 = 0
	slot6 = 0

	for slot10 = 1, 4 do
		slot12, slot13, slot14 = IsConditionAchieved(GameSetting.hero_plot_unlock_condition.value[slot10], {
			heroId = slot2.archive_id
		})

		if slot12 then
			slot4 = 0 + 1
		end
	end

	if #HeroRecordCfg[slot2.archive_id].super_plot_id > 0 then
		for slot10, slot11 in ipairs(slot3) do
			for slot16 = 1, 2 do
				slot18, slot19, slot20 = IsConditionAchieved(GameSetting.hero_super_plot_unlock_condition.value[slot16], {
					heroId = slot11
				})

				if slot18 then
					slot12 = 0 + 1
				end
			end

			slot5 = math.max(slot5, slot12)
		end
	end

	for slot10, slot11 in ipairs(slot3) do
		if HeroAnedoteCfg[slot11] then
			slot13, slot14, slot15 = IsConditionAchieved(GameSetting.hero_anecdote_unlock_condition.value[1], {
				heroId = slot11
			})

			if slot13 then
				slot6 = slot6 + 1
			end
		end
	end

	return slot4, slot5, slot6
end

function slot0.GetArchive(slot0, slot1)
	if slot1 == 0 then
		return {
			archive_id = 0,
			exp = 0,
			lv = 1,
			gift_list = {},
			text_list = {},
			video_list = {},
			selected_picture = {},
			hero_story_list = {},
			super_heart_link_list = {}
		}
	end

	if not uv0[slot1] then
		uv0[slot1] = {
			exp = 0,
			lv = 1,
			archive_id = slot1,
			gift_list = {},
			text_list = {},
			video_list = {},
			selected_picture = {},
			hero_story_list = {},
			super_heart_link_list = {}
		}
	end

	return uv0[slot1]
end

function slot0.AddExp(slot0, slot1, slot2)
	slot4 = slot0:GetArchive(slot1).exp + slot2
	uv0[slot1].lv, slot6 = LvTools.LoveExpToLevel(slot4)
	uv0[slot1].exp = slot4
end

function slot0.AddGift(slot0, slot1, slot2)
	slot3 = uv0[slot1].gift_list

	for slot7, slot8 in pairs(slot2) do
		slot3[slot8.id] = (slot3[slot8.id] or 0) + slot8.num
	end
end

function slot0.GetTrustLevel(slot0, slot1)
	slot2 = HeroData:GetHeroData(slot1)

	return slot2.trust.level, slot2.trust.exp, slot2.trust.mood
end

function slot0.InitRelationStory(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.got_reward_id_list) do
		table.insert(uv0, slot6)
	end
end

function slot0.UpdateRelationStory(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.GetRelationStoryRead(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.InitTrustGiftDisplaceCount(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.limit_list) do
		uv0[slot6.item_id] = slot6.use
	end
end

function slot0.ClearTrustGiftDisplaceCount(slot0)
	uv0 = {}
end

function slot0.UpdateTrustGiftDisplaceCount(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1] = uv0[slot1] + slot2
	else
		uv0[slot1] = slot2
	end
end

function slot0.GetTrustGiftDisplaceCount(slot0, slot1)
	return uv0[slot1] or 0
end

return slot0
