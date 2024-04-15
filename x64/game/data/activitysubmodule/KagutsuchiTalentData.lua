slot0 = singletonClass("KagutsuchiTalentData")
slot1 = {}

function slot0.InitData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.talent_list) do
		uv0[slot6.id] = slot6.level
	end
end

function slot0.UpgradeTalent(slot0, slot1)
	uv0[slot1] = (uv0[slot1] or 0) + 1
end

function slot0.GetUnlockTalentIdList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		table.insert(slot1, slot5)
	end

	return slot1
end

function slot0.GetTalentIdList(slot0)
	return TalentTreeCfg.get_id_list_by_activity_id[slot0:GetActivityId()]
end

function slot0.GetTalentLevel(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.GetTalentMaxLevel(slot0, slot1)
	if TalentTreeCfg[slot1].activity_id ~= slot0:GetActivityId() then
		return 0
	end

	return TalentTreeCfg[slot1].max_level
end

function slot0.IsTalentMaxLevel(slot0, slot1)
	return slot0:GetTalentMaxLevel(slot1) <= slot0:GetTalentLevel(slot1)
end

function slot0.IsTalentLocked(slot0, slot1)
	return slot0:GetTalentLevel(slot1) == 0
end

function slot0.CanUpgrade(slot0, slot1)
	if TalentTreeCfg[slot1].activity_id ~= slot0:GetActivityId() then
		return false
	end

	if slot0:GetTalentMaxLevel(slot1) <= slot0:GetTalentLevel(slot1) then
		return false
	end

	return slot0:IsConditionAchieved(slot0:GetTalentConditionId(slot1, slot2 + 1))
end

function slot0.GetTalentConditionId(slot0, slot1, slot2)
	return TalentTreeCfg[slot1].unlock_condition[slot2]
end

function slot0.IsConditionAchieved(slot0, slot1)
	slot2 = ConditionCfg[slot1]
	slot4 = slot2.params

	if slot2.type == 1020 then
		if HeroData:GetHeroData(slot4[1]).unlock == 0 then
			return false
		end

		return slot4[2] <= slot5.star / 100
	elseif slot3 == 2510 then
		return slot4[1] <= KagutsuchiWorkData:GetTotalCoins()
	end

	return false
end

function slot0.GetActivityId(slot0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

return slot0
