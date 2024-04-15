CooperationConst = {
	State = {
		READY = 3,
		REPEAT = 2,
		COMMON = 4,
		ADJUSTMENT = 1
	},
	INVITE_TYPE = {
		RECENT = 3,
		FRIEND = 1,
		GUILD = 2
	},
	JOIN_ROOM_SOURCE = {
		INVET = 1,
		ROOM_ID = 0
	}
}
CooperationRoomTemplate = class("CooperationRoomTemplate")
slot0 = "0"

function CooperationRoomTemplate.Ctor(slot0)
	slot0.room_id = uv0
	slot0.dest = -1
	slot0.type = -1
	slot0.available = true
	slot0.activity_id = 0
	slot0.room_player_id_list = {}
	slot0.room_player_list = {}
end

function CooperationRoomTemplate.Init(slot0, slot1)
	slot0.room_id = slot1.room_id
	slot0.dest = slot1.dest
	slot0.available = slot1.available
	slot0.type = slot1.type
	slot0.activity_id = slot1.activity_id
	slot0.room_player_list = {}
	slot0.room_player_id_list = {}

	for slot5, slot6 in ipairs(slot1.player_list) do
		slot7 = BattleTeamPlayerTemplate.New(slot6)
		slot8 = slot7.playerID

		table.insert(slot0.room_player_id_list, slot8)

		slot0.room_player_list[slot8] = slot7
	end
end

function CooperationRoomTemplate.Update(slot0, slot1)
	slot0.room_id = slot1.room_id
	slot0.dest = slot1.dest
	slot0.available = slot1.available
	slot0.type = slot1.type

	for slot5, slot6 in ipairs(slot1.player_list) do
		if slot0.room_player_list[slot6.player_id] then
			slot8:UpdateRoomData(slot6.player_room_info)
		end
	end
end

function CooperationRoomTemplate.IsAvailable(slot0)
	return slot0.available
end

function CooperationRoomTemplate.GetRoomPlayerIdList(slot0)
	return clone(slot0.room_player_id_list)
end

function CooperationRoomTemplate.GetRoomPlayerData(slot0, slot1)
	return slot0.room_player_list[slot1]
end

function CooperationRoomTemplate.GetSelfHero(slot0)
	slot3 = slot0.room_player_list[PlayerData:GetPlayerInfo().userID].heroList

	return slot3[1].id, slot3[1].trialID
end

function CooperationRoomTemplate.GetMasetPlayerId(slot0)
	for slot4, slot5 in pairs(slot0.room_player_list) do
		if slot5.is_master == 1 then
			return slot5.playerID
		end
	end

	return 0
end

function CooperationRoomTemplate.IsFull(slot0)
	return #slot0.room_player_list >= 3
end

function CooperationRoomTemplate.RepeatHero(slot0, slot1)
	for slot6, slot7 in pairs(slot0.room_player_list) do
		if slot7.heroList[1].id == slot1 then
			slot2 = 0 + 1
		end
	end

	return slot2 > 1
end

function CooperationRoomTemplate.GetBeLikedPlayerIds(slot0, slot1)
	return slot0.room_player_list[slot1] and slot0.room_player_list[slot1].be_liked_uids or {}
end

CooperationInviteTemplate = class("CooperationInviteTemplate")

function CooperationInviteTemplate.Ctor(slot0, slot1)
	slot0.invite_type = slot1.type
	slot0.uid = slot1.uid
	slot0.nick = slot1.user_base_info.nick
	slot0.icon = slot1.user_base_info.icon
	slot0.icon_frame = slot1.user_base_info.icon_frame
	slot0.level = slot1.level
	slot0.dest = slot1.dest
	slot0.timestamp = slot1.timestamp
	slot0.room_id = slot1.room_id
	slot0.refuse = false
	slot0.battle_type = slot1.battle_type
	slot0.activity_id = slot1.activity_id
end

function CooperationInviteTemplate.Refuse(slot0)
	slot0.refuse = true
end

function CooperationInviteTemplate.IsOverdue(slot0)
	return manager.time:GetServerTime() > slot0.timestamp + 300
end

CooperationRecentVisitTemplate = class("CooperationRecentVisitTemplate")

function CooperationRecentVisitTemplate.Ctor(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.nick = slot1.user_base_info.nick
	slot0.icon = slot1.user_base_info.icon
	slot0.icon_frame = slot1.user_base_info.icon_frame
	slot0.level = slot1.level
	slot0.timestamp = slot1.timestamp
end
