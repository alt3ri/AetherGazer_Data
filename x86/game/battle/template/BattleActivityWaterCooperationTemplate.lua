BattleBaseCooperationTemplate = import("game.battle.cooperation.BattleBaseCooperationTemplate")
slot0 = class("BattleActivityWaterCooperationTemplate", BattleBaseCooperationTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.cfg = BattleActivityWaterCooperationCfg[slot1]
	slot0.activityID_ = slot2

	uv0.super.Ctor(slot0)

	slot0.id = slot1

	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.InitComboSkillID(slot0)
	slot0.comboSkillID_ = BattleTeamData:GetComboInfo(slot0:GetType(), slot0.activityID_)
end

function slot0.GetLayerId(slot0)
	return slot0.layer_
end

function slot0.GetLayer(slot0)
	return slot0.layer_
end

function slot0.GetStageIndex(slot0)
	return slot0.stageIndex_
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetHeroDataByPos(slot0, slot1)
	return uv0.super.GetHeroDataByPos(slot0, slot1)
end

function slot0.GetAttributeFactor(slot0)
	if slot0.cfg.attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.SetMainActivityId(slot0, slot1)
	slot0.mainActivityId_ = slot1
end

function slot0.GetMainActivityId(slot0)
	return slot0.mainActivityId_
end

return slot0
