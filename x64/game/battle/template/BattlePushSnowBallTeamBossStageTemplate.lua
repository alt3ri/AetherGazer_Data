slot0 = class("BattlePushSnowBallTeamBossStageTemplate", BattleBaseCooperationTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.dest = slot2.dest
	slot0.activityID_ = slot2.activityID
	slot0.cfg = BattlePushSnowBallTeamBossStageCfg[slot0.id]
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
	return slot0.activityID_
end

function slot0.GetDest(slot0)
	return slot0.dest
end

function slot0.GetRoleDatas(slot0)
	return slot0.roleDataInLua
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

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList
end

function slot0.UpdateRoleDatas(slot0)
	slot0.roleDataInLua = {}
	slot0.heroList = {}
	slot0.heroTrialList = {}
	slot0.heroInfoList = {}
	slot0.playerList = PushSnowBallData:GetPlayerList()

	for slot4, slot5 in ipairs(slot0.playerList) do
		slot6 = RoleDataForExchange.New()
		slot6.UID = slot5.uid
		slot6.ID = HeroStandardSystemCfg[slot5.heroID].skin_id
		slot6.attributeID = {
			1,
			2,
			3
		}
		slot6.attributeValue = {
			1000,
			1000,
			1000
		}
		slot6.skillLevel = {
			1,
			1,
			1,
			1,
			1,
			1
		}

		table.insert(slot0.roleDataInLua, slot6)
		table.insert(slot0.heroTrialList, slot6.ID)
	end
end

function slot0.GetSystemHeroTeam(slot0)
	return slot0.heroTrialList
end

function slot0.GetMaxRaceData(slot0)
	return 0, 0
end

function slot0.GetHeroDataByPos(slot0, slot1)
	return nil
end

function slot0.GetIsCooperation(slot0)
	return true, slot0.playerList
end

function slot0.GetChipList(slot0)
	return {}
end

function slot0.GetComboSkillID(slot0)
	return 0
end

function slot0.GetComboSkillLevel(slot0)
	return 0
end

function slot0.GetResurrectImmediately(slot0)
	return true
end

function slot0.GetName(slot0)
	return slot0.cfg.name
end

return slot0
