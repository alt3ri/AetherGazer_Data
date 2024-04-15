require("game.data.CooperationDataTemplate")

slot0 = singletonClass("ComboSkillData")
slot1 = nil
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = nil
slot8 = false
slot9 = "0"

function slot0.Init(slot0)
	uv0 = nil
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
	uv5 = {}
	uv6 = nil
	uv7 = false
end

function slot0.InitRoomData(slot0, slot1)
	if not uv0 then
		uv0 = CooperationRoomTemplate.New()
	end

	uv0:Init(slot1)
end

function slot0.UpdateRoomData(slot0, slot1)
	if not uv0 then
		error("room info update error")

		return
	end

	uv0:Update(slot1)
end

function slot0.ClearRoomData(slot0)
	uv0 = nil
end

function slot0.GetRoomData(slot0)
	return uv0
end

function slot0.CheckInRoom(slot0)
	return uv0 ~= nil
end

function slot0.GetIsMatching(slot0)
	return uv0
end

function slot0.SetIsMatching(slot0, slot1)
	uv0 = slot1
end

function slot0.InitInviteInfo(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.invite_list) do
		slot8 = CooperationInviteTemplate.New(slot7)
		uv0[slot8.uid] = slot8
	end

	for slot7, slot8 in ipairs(slot1.type_list) do
		table.insert(uv1, slot8)
	end
end

function slot0.AddInviteInfo(slot0, slot1)
	slot3 = CooperationInviteTemplate.New(slot1.invite)
	uv0[slot3.uid] = slot3

	if not table.indexof(uv1, slot3.invite_type) then
		uv2 = {
			overdue_time = manager.time:GetServerTime() + 10,
			invite = slot3
		}

		manager.notify:Invoke(COOPERATION_NEW_INVITE)
	end
end

function slot0.GetNewInviteTip(slot0)
	return uv0
end

function slot0.ClearNewInviteTip(slot0)
	uv0 = nil
end

function slot0.GetAllInviteList(slot0)
	return uv0
end

function slot0.GetInvite(slot0, slot1)
	return uv0[slot1]
end

function slot0.RefuseInvite(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1]:Refuse()
	end
end

function slot0.DelectInvite(slot0, slot1)
	uv0[slot1] = nil
end

function slot0.ClearInvite(slot0, slot1)
	uv0 = {}
end

function slot0.GetInviteList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		slot9 = slot7.activity_id

		if table.indexof(slot1, slot7.invite_type) then
			if slot9 and slot9 ~= 0 then
				if ActivityData:GetActivityIsOpen(slot9) then
					table.insert(slot2, slot7)
				end
			else
				table.insert(slot2, slot7)
			end
		end
	end

	return slot2
end

function slot0.CheckInviteEntryShow(slot0)
	for slot4, slot5 in pairs(uv0) do
		if not slot5:IsOverdue() and not slot5.refuse then
			return true
		end
	end

	return false
end

function slot0.SetInviteRestrict(slot0, slot1, slot2)
	if slot2 == 1 and not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	elseif slot2 == 2 and slot3 then
		table.remove(uv0, slot3)
	end
end

function slot0.GetInviteRestrict(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.GetRecentVisitList(slot0)
	return uv0
end

function slot0.InitVisiteList(slot0, slot1)
	uv0 = {}

	for slot6, slot7 in ipairs(slot1.player_list) do
		table.insert(uv0, CooperationRecentVisitTemplate.New(slot7))
	end
end

function slot0.GetIsMaster(slot0)
	if uv0 and uv0:GetRoomPlayerData(PlayerData:GetPlayerInfo().userID) then
		return slot2.is_master == 1
	else
		return false
	end
end

function slot0.SetInviteVisible(slot0, slot1, slot2)
	uv0[slot1] = slot2

	saveData("CooperationVisible", tostring(slot1), slot2)
end

function slot0.GetInviteVisible(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = getData("CooperationVisible", tostring(slot1))
	end

	if type(uv0[slot1]) ~= "boolean" then
		uv0[slot1] = true
	end

	return uv0[slot1]
end

function slot0.SetHadInvited(slot0, slot1, slot2)
	table.insert(uv0, slot1)
end

function slot0.GetHadInvited(slot0, slot1, slot2)
	return table.indexof(uv0, slot1)
end

function slot0.ClearHadInvited(slot0)
	uv0 = {}
end

function slot0.GetCooperationHero(slot0, slot1, slot2, slot3)
	slot4 = CooperationTools.GetCooperationTeamHeroList(slot1, slot2, slot3)

	if getData("cooperation", "cooperation_hero_" .. slot1) and type(slot5) == "table" then
		slot7 = 0
		slot8 = 0

		if slot5.hero_type == 2 then
			slot7 = HeroStandardSystemCfg[slot5.hero_id] and slot9.hero_id
		else
			slot8 = 0
			slot7 = slot5.hero_id
		end

		for slot12, slot13 in ipairs(slot4) do
			if slot13.trialID == slot8 and slot13.id == slot7 then
				return slot5
			end
		end
	end

	if #slot4 == 0 then
		error("GetCooperationHero error")
	end

	if slot4[1].trialID ~= 0 then
		return {
			hero_type = 2,
			hero_id = slot6.trialID,
			owner_id = BattleTeamData.NO_OWNER
		}
	else
		return {
			hero_type = 1,
			hero_id = slot6.id,
			owner_id = BattleTeamData.NO_OWNER
		}
	end

	return slot4[1]
end

function slot0.SetCooperationHero(slot0, slot1)
	if CooperationData:GetRoomData() then
		slot4 = slot2.dest

		saveData("cooperation", "cooperation_hero_" .. slot2.type, slot1)
	end
end

return slot0
