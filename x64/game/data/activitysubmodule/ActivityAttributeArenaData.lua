slot0 = singletonClass("ActivityAttributeArenaData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.activity_id
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.arena_list) do
		slot9 = {}

		for slot13, slot14 in ipairs(slot8.team_list) do
			table.insert(slot9, {
				hero_id = slot14.hero_id,
				hero_type = slot14.hero_type
			})
		end

		table.insert(slot3, {
			index = slot8.index,
			id = slot8.id,
			score = slot8.score,
			team_list = slot9
		})
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.index < slot1.index
	end)

	uv0[slot2] = slot3
	uv1[slot2] = slot1.rounds
end

function slot0.ResetData(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(uv0[slot1] or {}) do
		if slot2 == slot8.id then
			slot8.score = 0
			slot8.team_list = {}

			break
		end
	end
end

function slot0.GetArenaList(slot0, slot1)
	return uv0[slot1] or {}
end

function slot0.GetArenaScore(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(uv0[slot1] or {}) do
		if slot2 == slot8.id then
			return slot8.score
		end
	end

	return 0
end

function slot0.GetLockHero(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(uv0[slot1] or {}) do
		for slot12, slot13 in ipairs(slot8.team_list) do
			if slot13.hero_type == 2 then
				table.insert(slot2, HeroStandardSystemCfg[slot13.hero_id].hero_id)
			else
				table.insert(slot2, slot13.hero_id)
			end
		end
	end

	return slot2
end

function slot0.GetRound(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.SetRead(slot0, slot1)
	slot2 = uv0[slot1] or 0
	uv1[slot1] = slot2

	saveData("ActivityAttributeArena", tostring(slot1), slot2)
end

function slot0.GetRead(slot0, slot1)
	if not uv0[slot1] then
		if type(getData("ActivityAttributeArena", tostring(slot1))) ~= "number" then
			uv0[slot1] = 0
		else
			uv0[slot1] = slot2
		end
	end

	if (uv1[slot1] or 0) == uv0[slot1] then
		return true
	else
		return false
	end
end

return slot0
