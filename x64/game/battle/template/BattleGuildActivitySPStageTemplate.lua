slot0 = class("BattleGuildActivitySPStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleClubActivitySPCfg[slot1]
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.SetNodeId(slot0, slot1)
	slot0.nodeId_ = slot1
end

function slot0.GetNodeId(slot0)
	return slot0.nodeId_
end

function slot0.GetDest(slot0)
	return slot0.nodeId_
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level or 0
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level or 0
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetAddUserExp(slot0)
	return slot0.cfg.user_exp or 0
end

function slot0.GetAddHeroExp(slot0)
	return slot0.cfg.hero_exp or 0
end

function slot0.GetCost(slot0)
	return slot0.cfg.cost or 0
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in pairs(slot0.roleDataInLua) do
		if SkinCfg[slot10.ID].hero ~= 0 then
			slot5[slot12] = slot5[HeroCfg[slot11].race] or 0
			slot5[slot12] = slot5[slot12] + 1
		end
	end

	for slot10, slot11 in pairs(GuildActivitySPData:GetUnLockAffixList()) do
		if slot5[TalentTreeCfg[slot10].race] ~= nil then
			slot1[slot10] = slot5[slot12]

			table.insert(slot2, TalentTreeCfg[slot10].affix_id)
			table.insert(slot3, slot11.level)
			table.insert(slot4, TalentTreeCfg[slot10].affix_user)
		end
	end

	slot0.nodeCfg_ = ActivityClubSPCfg[slot0.nodeId_]

	if slot0.nodeCfg_.id == GuildActivitySPData:GetMaxNodeId() and GuildActivitySPData:GetNowStage() == 1 and BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].affix_type ~= nil and slot7 ~= "" then
		for slot11, slot12 in ipairs(slot7) do
			table.insert(slot2, slot12[1])
			table.insert(slot3, slot12[2])
			table.insert(slot4, slot12[3])
		end
	end

	GuildActivitySPData:SetTempEffectiveAffixList(slot1)

	return slot2, slot3, slot4
end

function slot0.SetPathList(slot0, slot1)
	slot0.pathList_ = slot1
end

function slot0.GetPathList(slot0)
	return slot0.pathList_ or {}
end

function slot0.GetAttributeFactor(slot0)
	if BattleClubActivitySPCfg[ActivityClubSPCfg[slot0.nodeId_].stage_id] then
		slot4 = slot1.attribute_factor[1] / 1000
		slot5 = slot1.attribute_factor[2] / 1000
		slot6 = slot1.attribute_factor[3] / 1000
		slot7 = 1
		slot8 = 1

		if 10 - GuildActivitySPData:GetNodeData(slot0.nodeId_).occupied_num < 1 then
			slot10 = 1
		end

		slot8 = slot8 * slot10 / 10
		slot7 = slot7 * slot10 / 10

		if GuildActivitySPData:GetSelfNodeData(slot0.nodeId_) then
			if slot11.elite_health_rate == 0 then
				slot12 = 100
			end

			slot7 = slot7 * slot12 / 100
		end

		return Vector3.New(slot4 * slot8, slot5 * slot8, slot6 * slot7)
	end

	return Vector3.New(1, 1, 1)
end

return slot0
