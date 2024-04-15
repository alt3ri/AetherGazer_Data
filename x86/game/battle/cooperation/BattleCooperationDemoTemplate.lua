slot0 = class("BattleCooperationDemoTemplate", BattleBaseCooperationTemplate)

function slot0.Ctor(slot0, slot1)
	slot0.activityID_ = slot1
	slot3 = ActivityCooperationDemoCfg[slot1].stage_id

	uv0.super.Ctor(slot0)

	slot0.id_ = slot3
	slot0.cfg = BattleCooperationDemoCfg[slot3]
end

function slot0.GetStageId(slot0)
	return slot0.id_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetRevive(slot0)
	if type(slot0.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	return slot0.cfg.is_revive[1] and true or false, slot1[1] or 0, slot1[1] and ItemTools.getItemNum(slot1[1]) or 0, slot1[2] or 0
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs({
		{
			9491,
			3,
			3
		},
		{
			9492,
			3,
			3
		},
		{
			9493,
			3,
			3
		}
	} or {}) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

return slot0
