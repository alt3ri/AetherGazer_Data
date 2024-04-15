slot0 = class("BattleBaseCooperationTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0)
	uv0.super.Ctor(slot0)

	slot0.room = CooperationData:GetRoomData()
	slot0.roomId = slot0.room.room_id
	slot0.heroList = {}
	slot0.heroTrialList = {}
	slot0.serverTeamPlayer = {}
	slot0.playerList = {}
end

function slot0.UpdateRoleDatas(slot0)
	slot0.roleDataInLua = {}
	slot0.heroList = {}
	slot0.heroTrialList = {}
	slot0.heroInfoList = {}
	slot0.playerList = {}
	slot1 = slot0:GetSystemHeroTeam()

	if not slot0.room then
		return
	end

	for slot7, slot8 in ipairs(slot2:GetRoomPlayerIdList()) do
		for slot13, slot14 in ipairs(slot2:GetRoomPlayerData(slot8).heroList) do
			table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetHeroData(slot14, slot14.trialID ~= 0 and slot14.trialID or slot1[slot13] or 0, slot9.playerID, slot9.level))
			table.insert(slot0.heroList, slot14.id)
			table.insert(slot0.heroTrialList, slot14.trialID)
			table.insert(slot0.heroInfoList, slot14)
		end

		table.insert(slot0.playerList, slot9)
	end

	slot0:SetMaxRaceData()
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList, slot0.heroTrialList
end

function slot0.GetHeroDataByPos(slot0, slot1)
	slot2, slot3 = slot0:GetHeroTeam()
	slot4 = slot0:GetSystemHeroTeam()

	if slot2[slot1] and slot2[slot1] ~= 0 then
		if slot4[slot1] or slot3[slot1] and slot3[slot1] ~= 0 then
			return GetVirtualData(slot4[slot1] or slot3[slot1])
		else
			if (slot0.heroInfoList and slot0.heroInfoList[slot1]) == nil then
				return nil
			end

			return GetPracticalData(slot5)
		end
	end

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

return slot0
