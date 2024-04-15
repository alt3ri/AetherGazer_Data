slot1 = class("ReserveGuildBossHeroPosTemplate", import("game.reserve.ReserveHeroPosTemplate"))

function slot1.Ctor(slot0, slot1)
	slot0.pos = slot1
	slot0.hero_type = 1
	slot0.trial_id = 0
	slot0.hero_id = 0
	slot0.owner_id = BattleTeamData.NO_OWNER
end

function slot1.SetOwnerID(slot0, slot1)
	slot0.owner_id = slot1
	slot0.hero_type = 3
end

function slot1.UpdateServerData(slot0, slot1, slot2)
	slot0.pos = slot2
	slot0.hero_type = slot1.hero_type or 1
	slot0.trial_id = 0
	slot0.hero_id = slot1.hero_id or 0
	slot0.owner_id = slot1.owner_id or BattleTeamData.NO_OWNER
end

function slot1.UpdateClientData(slot0, slot1, slot2)
	slot0.pos = slot2
	slot0.hero_type = slot1.hero_type or 1
	slot0.trial_id = slot1.trial_id
	slot0.hero_id = slot1.hero_id
	slot0.owner_id = slot1.owner_id or BattleTeamData.NO_OWNER
end

function slot1.GetOwnerID(slot0)
	return slot0.owner_id
end

function slot1.ConvertToSendData(slot0)
	if slot0.hero_type == 1 then
		-- Nothing
	else
		slot1.hero_id = slot0.trial_id
	end

	return {
		hero_type = slot0.hero_type,
		hero_id = slot0.hero_id,
		owner_id = slot0.owner_id
	}
end

return slot1
