slot0 = class("BattleAbyssTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.cfg = BattleAbyssCfg[slot1]
	slot0.activityID_ = slot2.activityID
	slot0.curActivityID_ = slot2.curActivityID

	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.SetStageData(slot0, slot1, slot2)
	slot0.stageIndex_ = slot2
	slot0.layerCfg_ = AbyssData:GetAbyssCfg(slot1)
	slot0.layer_ = slot0.layerCfg_.level
	slot0.stageCfg_ = slot0.layerCfg_.stage_list[slot2]
end

function slot0.SetCurActivityID(slot0, slot1)
	slot0.curActivityID_ = slot1
end

function slot0.GetActivityID(slot0)
	return slot0.curActivityID_
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

function slot0.IsBoss(slot0)
	return slot0.stageCfg_[1] == 3
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ABYSS
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

function slot0.GetAttributeFactor(slot0)
	if slot0.cfg.attribute_factor and slot1.attribute_factor[3] then
		slot2 = slot1.attribute_factor[1] / 1000
		slot3 = slot1.attribute_factor[2] / 1000
		slot4 = slot1.attribute_factor[3] / 1000

		if slot0.layerCfg_.stage_list[slot0.stageIndex_][1] == 3 then
			slot6 = AbyssData:GetStageData(slot0.layer_, slot0.stageIndex_)
			slot7 = AbyssBossHpCfg[slot5[2]].boss_hp[slot6.phase]
			slot4 = math.ceil(slot7 * slot6.boss_hp_rate / 1000) / slot7
		end

		return Vector3.New(slot2, slot3, slot4)
	end

	return Vector3.New(1, 1, 1)
end

return slot0
