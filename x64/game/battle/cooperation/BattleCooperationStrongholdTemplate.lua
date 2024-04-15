slot0 = class("BattleCooperationStrongholdTemplate", BattleBaseCooperationTemplate)

function slot0.Ctor(slot0, slot1)
	slot0.activityID_ = slot1
	slot3 = ActivityStrongholdCfg[slot1].stage_id

	uv0.super.Ctor(slot0)

	slot0.id_ = slot3
	slot0.cfg = BattleStrongholdStageCfg[slot3]
	slot0.roomSkill = StrongholdData:GetSelfRoomSkillType(slot0.roomId)
end

function slot0.GetDest(slot0)
	return slot0.activityID_
end

function slot0.GetStageId(slot0)
	return slot0.id_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STRONGHOLD, slot0.roomSkill
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetRevive(slot0)
	slot1 = StrongholdData:GetRoomPlayerIncreaseRevive(slot0.roomId)
	slot2 = ActivityStrongholdCfg[slot0.activityID_].initial_revive or 0

	return true, 0, slot1 + slot2, 1, slot1 + slot2
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(StrongholdData:GetRoomAffixList(slot0.roomId, slot0.playerList) or {}) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

return slot0
