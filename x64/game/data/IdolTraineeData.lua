slot0 = import("game.dorm.DormEnum")
slot1 = singletonClass("IdolTraineeData")
slot2 = {}
slot3 = {}
slot4 = 0
slot5 = {}
slot6 = 0
slot7 = 0
slot8 = {}
slot9 = {}
slot10 = {}
slot11 = {}
slot12 = 0
slot13 = {}

function slot1.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = 0
	uv3 = {}
	uv4 = 0
	uv5 = 0
	uv6 = {}
	uv7 = 0
	uv8 = {}
	uv9 = {}
end

function slot1.ParseIdolProperty(slot0, slot1, slot2, slot3)
	if slot3 then
		if IdolTraineePveBattleCfg[slot3] then
			for slot11, slot12 in ipairs(IdolPveNpcCfg[slot4.npc_id].attribute) do
				-- Nothing
			end

			return {
				0,
				0,
				0,
				0,
				0,
				[slot11] = slot12
			}, slot5
		end
	elseif BackHomeHeroCfg[slot2] then
		for slot9, slot10 in ipairs({
			0,
			0,
			0,
			0,
			0
		}) do
			slot5[slot9] = slot4.idol_base_attribute[slot9][1]
		end

		if slot1 then
			for slot9, slot10 in ipairs(slot1) do
				slot5[slot9] = slot10
			end
		end

		return slot5
	else
		Debug.LogError("未获取角色配置信息" .. slot2)
	end
end

function slot1.InitDataFromServer(slot0, slot1)
	slot0:InitAttackHeroID(slot1)

	slot5 = slot1

	slot0:InitDefendHeroID(slot5)

	for slot5, slot6 in ipairs(slot1.hero_list) do
		DormData:GetHeroTemplateInfo(slot6.hero_id):InitDanceTrainData(slot6)
	end

	uv0 = slot1.exercise_times_info.use_times

	for slot5, slot6 in ipairs(slot1.exercise_times_info.camp_list) do
		uv1[slot6] = true
	end

	uv2 = slot1.pvp_stage_info.stage_id
	uv3 = slot1.pvp_stage_info.refresh_timestamp

	slot0:UpdateHeroPosList(slot1)
end

function slot1.UpdateHeroPosList(slot0, slot1)
	for slot6, slot7 in pairs(DormData:GetHeroInfoList()) do
		if slot7.dancePos then
			slot7:GoToDance(nil)
		end
	end

	for slot6, slot7 in ipairs(slot1.hero_pos_list) do
		slot8 = DormData:GetHeroTemplateInfo(slot7.hero_id)

		slot8:SetCurHeroID(slot7.hero_id)
		slot8:GoToDance(slot7.pos)
	end
end

function slot1.UpdateQuestRankInfo(slot0, slot1)
	uv0 = 1

	for slot5, slot6 in ipairs(slot1) do
		if uv0 < slot6 % 4 + 1 then
			uv0 = slot6 % 4 + 1
		end
	end
end

function slot1.InitAttackHeroID(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.attack_hero_id_list) do
		uv0[slot6] = true
	end
end

function slot1.InitDefendHeroID(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.defend_hero_id_list) do
		uv0[slot6] = true
	end
end

function slot1.UpdatePveChapterData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.chapter_list) do
		if not uv0[slot6.chapter_id] then
			uv0[slot6.chapter_id] = {}
		end

		for slot10, slot11 in ipairs(slot6.stage_list) do
			uv0[slot6.chapter_id][slot11.stage_id] = {
				score = 0,
				pass = false,
				score = slot11.score,
				pass = slot11.is_clear
			}
		end
	end
end

function slot1.UpdateOpponentList(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		if slot6.user_id then
			uv0[slot6.user_id] = {
				nick = slot6.profile_base.nick,
				icon = slot6.profile_base.icon,
				icon_frame = slot6.profile_base.icon_frame,
				hero_id = slot6.hero_list[1].hero_id,
				property = slot0:ParseIdolProperty(slot6.hero_list[1].attribute_list, slot6.hero_list[1].hero_id)
			}
		end
	end
end

function slot1.UpdateFriendList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6.user_id then
			uv0[slot6.user_id] = {
				nick = slot6.profile_base.nick,
				icon = slot6.profile_base.icon,
				icon_frame = slot6.profile_base.icon_frame,
				hero_id = slot6.hero_list[1].hero_id,
				property = slot0:ParseIdolProperty(slot6.hero_list[1].attribute_list, slot6.hero_list[1].hero_id)
			}
		end
	end
end

function slot1.GetNpcPropertyByStageID(slot0, slot1)
	slot2, slot3 = slot0:ParseIdolProperty(nil, , slot1)

	return slot2, slot3
end

function slot1.UpdateTrainData(slot0, slot1, slot2)
	uv0 = uv0 + 1
	slot3 = DormData:GetHeroTemplateInfo(slot1.hero_id)

	slot3:SetFatigue(slot2.fatigue)
	slot3:UpdataDanceTrainData(slot2, slot1)
end

function slot1.GetIdolHeroList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(DormHeroTools:GetUnLockBackHomeHeroIDList()) do
		if BackHomeHeroCfg[slot7].idol_usable == 1 then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot1.GetIdolHeroSkillList(slot0, slot1)
	if IdolPveNpcCfg[slot1] then
		for slot7, slot8 in ipairs(IdolPveNpcCfg[slot1].idol_active_skill_list) do
			table.insert({}, {
				skill = slot8
			})
		end

		for slot7, slot8 in ipairs(slot3.idol_passive_skill_list) do
			table.insert(slot2, {
				skill = slot8
			})
		end

		return slot2
	else
		if not uv0[slot1] then
			uv0[slot1] = {}

			for slot5, slot6 in ipairs(BackHomeHeroCfg[slot1].idol_active_skill_list) do
				table.insert(uv0[slot1], {
					skill = slot6[1],
					property = slot6[2]
				})
			end

			for slot5, slot6 in ipairs(BackHomeHeroCfg[slot1].idol_passive_skill_list) do
				table.insert(uv0[slot1], {
					skill = slot6[1],
					property = slot6[2]
				})
			end

			table.sort(uv0[slot1], function (slot0, slot1)
				return slot0.property < slot1.property
			end)
		end

		return uv0[slot1]
	end
end

function slot1.GetCurAttackHero(slot0)
	return uv0
end

function slot1.GetCurAttackHeroInfo(slot0)
	slot1 = nil

	for slot5, slot6 in pairs(uv0) do
		if slot6 == true then
			slot1 = slot5
		end
	end

	return DormData:GetHeroTemplateInfo(slot1).property, slot1
end

function slot1.GetCurDefendHero(slot0)
	return uv0
end

function slot1.GetIdolHeroData(slot0, slot1)
	return DormData:GetHeroTemplateInfo(slot1):GetDanceProperty(slot1)
end

function slot1.GetCurTrainTimes(slot0)
	return uv0
end

function slot1.GetCurBuffCamp(slot0)
	return uv0
end

function slot1.GetPveChapterData(slot0)
	return uv0
end

function slot1.GetCacheOpponentList(slot0)
	return uv0
end

function slot1.GetCacheFriendList(slot0)
	return uv0
end

function slot1.GetCurPVPStage(slot0)
	return uv0
end

function slot1.GetQuestRankInfo(slot0)
	return uv0
end

function slot1.GetHeroPosList(slot0)
	for slot6, slot7 in pairs(DormData:GetHeroInfoList()) do
		if slot7.dancePos then
			-- Nothing
		end
	end

	return {
		[slot7.dancePos] = slot7:GetHeroId()
	}
end

function slot1.InitHistoryBattleData(slot0, slot1)
	uv0 = slot1
end

function slot1.GetHistoryBattleData(slot0)
	return uv0
end

return slot1
