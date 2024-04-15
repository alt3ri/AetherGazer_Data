function slot1(slot0, slot1, slot2, slot3)
	slot6 = slot1 or slot4.probability >= 100
	slot7 = {
		args = {},
		effect = IdolTraineeSkillEffectCfg[slot0].effect_type,
		target = slot4.object,
		delay = slot4.trigger_time
	}

	if not slot2 and slot4.trigger_time ~= 0 then
		-- Nothing
	end

	if not slot3 then
		slot7.round = slot4.round
	end

	if not slot6 then
		slot7.chance = slot4.probability
	end

	if slot5 == 1 then
		slot7.args[1] = GetTips("IDOL_SKILL_ATTRIBUTE_" .. slot4.unique[1])
		slot7.positive = slot4.unique[2] >= 0
		slot7.buffValue = slot4.unique[2]
	elseif slot5 == 2 then
		slot7.args[1] = GetTips("IDOL_DANCE_TYPE_TIPS_" .. slot4.unique[1])
		slot7.positive = slot4.unique[2] >= 0
		slot7.buffValue = slot4.unique[2]
	elseif slot5 == 3 or slot5 == 4 or slot5 == 5 or slot5 == 6 or slot5 == 7 then
		slot7.positive = slot4.unique[1] >= 0
		slot7.buffValue = slot4.unique[1]
	elseif slot5 == 8 then
		slot7.args[1] = GetTips("IDOL_SKILL_ATTRIBUTE_" .. slot4.unique[1])
		slot7.positive = slot4.unique[2] >= 0
		slot7.buffValue = slot4.unique[2]
	else
		Debug.LogError("idol_trainee_skill_desc表中有类型程序未指定拼接描述规则" .. descCfg.id)

		slot7.invalid = true
	end

	if slot7.buffValue then
		slot7.absBuffValue = math.abs(slot7.buffValue)
	end

	return slot7
end

function slot2(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0) do
		table.insert(slot2, slot1(slot7))
	end

	for slot6, slot7 in ipairs(slot2) do
		table.insert(slot0, slot7)
	end
end

function slot3(slot0)
	slot2 = "_" .. slot0.effect
	slot4 = "_DELAY"
	slot5 = "_ROUND"
	slot6 = "_RNG"
	slot7 = "_POS"
	slot8 = "_NEG"
	slot9 = "_FULL"

	if slot0.delay then
		uv0({
			"BUFF_EFFECT"
		}, function (slot0)
			return slot0 .. uv0
		end)
	end

	if slot0.round then
		uv0(slot3, function (slot0)
			return slot0 .. uv0
		end)
	end

	if slot0.chance then
		uv0(slot3, function (slot0)
			return slot0 .. uv0
		end)
	end

	if slot0.delay and slot0.round and slot0.chance then
		table.insert(slot3, slot1 .. slot9)
	end

	for slot14 = #slot3, 1, -1 do
		if IdolTraineeSkillDescCfg[slot3[slot14] .. (slot0.positive and slot7 or slot8) .. slot2] or IdolTraineeSkillDescCfg[slot15 .. slot2] then
			if not slot16.is_full_info and (slot0.chance or slot0.round) then
				slot18 = nil
				slot17 = LuaExchangeHelper.GetDescription((not slot0.chance or not slot0.round or IdolTraineeSkillDescCfg.DEFAULT_JOIN.pattern) and (not slot0.chance or IdolTraineeSkillDescCfg.DEFAULT_JOIN_NO_SUFFIX.pattern) and IdolTraineeSkillDescCfg.DEFAULT_JOIN_NO_PREFIX.pattern, {
					IdolTraineeSkillDescCfg.DEFAULT_PREFIX.pattern,
					slot16.pattern,
					IdolTraineeSkillDescCfg.DEFAULT_SUFFIX.pattern
				})
			end

			return slot17
		end
	end

	return ""
end

function slot4(slot0)
	if not slot0.invalid then
		return LuaExchangeHelper.GetDescription(uv0(slot1), {
			GetTips(slot1.target == 1 and "IDOL_SKILL_DESC_OBJ_0" or "IDOL_SKILL_DESC_OBJ_1"),
			slot1.buffValue,
			slot1.absBuffValue,
			slot1.chance or "",
			slot1.delay or "",
			slot1.round or "",
			unpack(slot1.args)
		})
	end

	return ""
end

return {
	CheckHeroIsAttack = function (slot0, slot1)
		return IdolTraineeData:GetCurAttackHero()[slot1]
	end,
	CheckHeroIsDefine = function (slot0, slot1)
		return IdolTraineeData:GetCurDefendHero()[slot1]
	end,
	CheckHeroRaceBuff = function (slot0, slot1)
		return IdolTraineeData:GetCurBuffCamp()[HeroCfg[slot1].race]
	end,
	GetHeroIdolMaxProperty = function (slot0, slot1)
		slot2 = {}

		for slot7, slot8 in pairs(BackHomeHeroCfg[slot1].idol_base_attribute) do
			table.insert(slot2, slot8[2])
		end

		return slot2
	end,
	GetChapterProgress = function (slot0, slot1)
		slot3 = #IdolTraineeChapterCfg[slot1].section_id_list
		slot5 = 0

		if IdolTraineeData:GetPveChapterData()[slot1] then
			for slot9, slot10 in pairs(slot4) do
				if slot10.pass then
					slot5 = slot5 + 1
				end
			end
		end

		return slot5, slot3
	end,
	GetChapterScoreList = function (slot0, slot1)
		return IdolTraineeData:GetPveChapterData()[slot1]
	end,
	GetOpponentData = function (slot0, slot1, slot2, slot3)
		if slot2 == IdolTraineeConst.friendType.friend then
			return IdolTraineeData:GetCacheFriendList()[slot1]
		elseif slot2 == IdolTraineeConst.friendType.stranger then
			return IdolTraineeData:GetCacheOpponentList()[slot1]
		end

		return {}
	end,
	GetEnemyUserData = function (slot0, slot1)
		if not (IdolTraineeData:GetCacheFriendList()[slot1] or IdolTraineeData:GetCacheOpponentList()[slot1]) then
			for slot7, slot8 in pairs(IdolTraineeData:GetHistoryBattleData()) do
				if slot8.userID == slot1 then
					slot2 = slot8

					break
				end
			end
		end

		return slot2
	end,
	GetBuffDescString = function (slot0, slot1, slot2, slot3, slot4)
		return uv1(uv0(slot1, slot2, slot3, slot4))
	end,
	GetSkillDescString = function (slot0, slot1)
		slot3 = ""

		for slot7, slot8 in ipairs(IdolTraineeSkillCfg[slot1].skill_effect) do
			slot9 = ""

			if slot7 ~= #slot2.skill_effect then
				slot9 = "\n"
			end

			slot3 = slot3 .. (slot0:GetBuffDescString(slot8) .. slot9)
		end

		return slot3
	end,
	GetSkillEffect = function (slot0, slot1)
		if IdolTraineeSkillEffectCfg[slot1].effect_type == 1 then
			return slot2.unique[1], slot2.unique[2]
		end

		return nil
	end,
	GetCurQuestRankInfo = function (slot0)
		slot1 = IdolTraineeData:GetQuestRankInfo()
		slot2 = IdolTraineeRewardRankCfg[slot1]

		return slot1, ItemTools.getItemNum(slot2.item_id[1]), slot2.item_id[2]
	end,
	GetCurTrainMaxTimes = function (slot0)
		slot2 = 0

		for slot6, slot7 in pairs(GameSetting.dorm_idol_hero_exercise_times_limit.value) do
			if slot7[1] <= DormRoomTools:GetUnlockRoomNum() then
				slot2 = slot7[2]
			end
		end

		return slot2
	end,
	GetOpponentList = function (slot0, slot1)
		slot2 = {}
		slot3 = {}

		if slot1 == IdolTraineeConst.friendType.friend then
			slot3 = IdolTraineeData:GetCacheFriendList()
		elseif slot1 == IdolTraineeConst.friendType.stranger then
			slot3 = IdolTraineeData:GetCacheOpponentList()
		end

		for slot7, slot8 in pairs(slot3) do
			table.insert(slot2, slot7)
		end

		return slot2
	end,
	GetHeroBattleInfoTemplate = function (slot0, slot1, slot2, slot3, slot4)
		if IdolTraineeConst.friendType.npc == slot3 then
			slot6, slot7 = IdolTraineeData:GetNpcPropertyByStageID(slot4)

			return {
				heroIcon = "",
				heroID = 0,
				propertyData = {},
				propertyMax = {},
				skill = {},
				heroID = slot7,
				heroIcon = DormHeroTools.GetBackHomeHeadSprite(slot7),
				propertyData = slot6,
				propertyMax = slot6,
				skill = IdolTraineeData:GetIdolHeroSkillList(slot7)
			}
		end

		if slot2 then
			slot6 = nil
			slot6 = (slot3 ~= IdolTraineeConst.friendType.friend or IdolTraineeData:GetCacheFriendList()[slot2]) and IdolTraineeData:GetCacheOpponentList()[slot2]
			slot5.heroID = slot6.hero_id
			slot5.heroIcon = DormHeroTools.GetBackHomeHeadSprite(slot6.hero_id)
			slot5.propertyData = slot6.property
			slot5.propertyMax = IdolTraineeTools:GetHeroIdolMaxProperty(slot6.hero_id)
			slot5.skill = IdolTraineeData:GetIdolHeroSkillList(slot6.hero_id)
		else
			slot5.heroID = slot1
			slot5.heroIcon = DormHeroTools.GetBackHomeHeadSprite(slot1)
			slot5.propertyData = IdolTraineeData:GetIdolHeroData(slot1)
			slot5.propertyMax = IdolTraineeTools:GetHeroIdolMaxProperty(slot1)
			slot5.skill = IdolTraineeData:GetIdolHeroSkillList(slot1)
		end

		return slot5
	end,
	GetAbilityIcon = function (slot0, slot1)
	end,
	GetBuffIcon = function (slot0, slot1)
		if not IdolTraineeSkillEffectCfg[slot1].effect_icon then
			return nil
		end

		return getSpriteWithoutAtlas(SpritePathCfg.IdolDanceBuffIcon.path .. slot2.effect_icon)
	end,
	GetSkillIcon = function (slot0, slot1)
		if not IdolTraineeSkillCfg[slot1].icon then
			return nil
		end

		return getSpriteWithoutAtlas(SpritePathCfg.IdolDanceSkillIcon.path .. slot2.icon)
	end,
	CheckDanceTaskComplete = function (slot0)
		for slot5, slot6 in pairs(TaskTools:GetIdolTraineeTaskSortList()) do
			if AssignmentCfg[slot6].need <= TaskData2:GetTaskProgress(slot6) and not TaskData2:GetTaskComplete(slot6) then
				return true
			end
		end
	end,
	GetPveStageChapter = function (slot0, slot1)
		for slot5, slot6 in ipairs(IdolTraineeChapterCfg.all) do
			if table.keyof(IdolTraineeChapterCfg[slot6].section_id_list, slot1) ~= nil then
				return slot6
			end
		end

		return nil
	end
}
