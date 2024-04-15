slot0 = class("BattlePushSnowBallSingleStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID = slot2.activityID
	slot0.activityCfg = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[slot0.activityID][1]]
	slot0.cfg = BattlePushSnowBallSingleStageCfg[slot0.id]
	slot0.heroList = {
		0,
		0,
		0
	}
	slot0.heroTrialList = {
		PushSnowBallData:GetSelectedBattleModelID(),
		0,
		0
	}
end

function slot0.GetActivityID(slot0)
	return slot0.activityID
end

function slot0.GetDest(slot0)
	return slot0.cfg.id
end

function slot0.GetRoleDatas(slot0)
	return slot0.roleDataInLua
end

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.roleDataInLua = {}
	slot2 = RoleDataForExchange.New()
	slot2.UID = slot1.playerID
	slot2.playerLevel = slot1.level
	slot2.ID = HeroStandardSystemCfg[PushSnowBallData:GetSelectedBattleModelID()].skin_id
	slot2.attributeID = {
		1,
		2,
		3
	}
	slot2.attributeValue = {
		1000,
		1000,
		1000
	}
	slot2.skillLevel = {
		1,
		1,
		1,
		1,
		1,
		1
	}

	table.insert(slot0.roleDataInLua, slot2)
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetName(slot0)
	return slot0.cfg.name
end

function slot0.GetSystemHeroTeam(slot0)
	return slot0.heroTrialList
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList
end

function slot0.GetStageAffix(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	if PushSnowBallDeviceCfg[PushSnowBallData:GetSelectedDeviceID()] then
		for slot9, slot10 in pairs(type(slot1.affixs) == "table" and slot1.affixs or {} or {}) do
			table.insert(slot2, slot10[1])
			table.insert(slot3, slot10[2])
			table.insert(slot4, slot10[3])
		end
	end

	return slot2, slot3, slot4
end

return slot0
