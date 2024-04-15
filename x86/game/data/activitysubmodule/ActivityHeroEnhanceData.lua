slot0 = singletonClass("ActivityHeroEnhanceData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
	read_list = {}
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.activity_id
	uv0[slot2] = slot1.day
	uv1[slot2] = slot1.mission_list
	uv2[slot2] = slot1.talent_list
end

function slot4(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if ActivityHeroEnhanceTools.IsTalentLock(slot0, slot6) then
			table.removebyvalue(uv0[slot0], slot6)
		end
	end
end

function slot0.ActivateTalent(slot0, slot1, slot2)
	if table.keyof(uv0[slot1], slot2) then
		return
	end

	for slot10, slot11 in ipairs(ActivityHeroEnhanceTools.GetCfgTalentListByStage(ActivityHeroEnhanceTools.GetCfgByTalentId(slot1, slot2), TalentTreeCfg[slot2].stage)) do
		table.removebyvalue(slot3, slot11)
	end

	table.insert(slot3, slot2)
	uv1(slot1, slot4.talent_list)
end

function slot0.DeactivateTalent(slot0, slot1, slot2)
	if uv0[slot1] == nil then
		return
	end

	table.removebyvalue(slot3, slot2)
	uv1(slot1, ActivityHeroEnhanceTools.GetCfgByTalentId(slot1, slot2).talent_list)
end

function slot0.AddClearedStage(slot0, slot1, slot2)
	if table.indexof(uv0[slot1], slot2) then
		return
	end

	table.insert(slot3, slot2)
end

function slot0.IsTalentActivated(slot0, slot1, slot2)
	if uv0[slot1] == nil then
		return false
	end

	return table.indexof(slot3, slot2) ~= false
end

function slot0.IsStageClear(slot0, slot1, slot2)
	if uv0[slot1] == nil then
		return false
	end

	return table.indexof(slot3, slot2) ~= false
end

function slot0.GetDay(slot0, slot1)
	return uv0[slot1] or -1
end

return slot0
