slot0 = class("ReserveSingleTeamDataTemplate")

function slot0.Ctor(slot0, slot1, slot2)
	slot0.team_type = slot1 or ReserveConst.RESERVE_TYPE.DEFAULT
	slot0.team_index = slot2 or ReserveConst.DEFAULT_TEAM_INDEX
	slot0.hero_list = {}
	slot0.cooperate_unique_skill_id = ReserveConst.DEFAULT_COMBO_SKILL_ID
	slot0.mimir_info = slot0:GetMimirDataClass().New()

	for slot6 = 1, ReserveConst.MAX_HERO_POS_COUNT do
		slot0.hero_list[slot6] = slot0:GetHeroPosClass().New(slot6)
	end
end

function slot0.UpdateServerData(slot0, slot1)
	slot0.team_index = slot1.team_index
	slot0.hero_list = slot0.hero_list or {}

	for slot5, slot6 in ipairs(slot1.hero_list) do
		slot0.hero_list[slot5]:UpdateServerData(slot6, slot5)
	end

	slot0.cooperate_unique_skill_id = slot1.cooperate_unique_skill_id

	slot0.mimir_info:UpdateServerData(slot1.mimir_info)
end

function slot0.GetTeamIndex(slot0)
	return slot0.team_index
end

function slot0.SetTeamIndex(slot0, slot1)
	slot0.team_index = slot1 or ReserveConst.DEFAULT_TEAM_INDEX
end

function slot0.SetTeamType(slot0, slot1)
	slot0.team_type = slot1
end

function slot0.GetTeamType(slot0)
	return slot0.team_type
end

function slot0.SetHeroList(slot0, slot1, slot2)
	slot1 = slot1 or {}
	slot3 = {
		[slot9:GetHeroID()] = true
	}
	slot4 = true
	slot9 = slot0

	for slot8, slot9 in ipairs(slot0.GetHeroList(slot9)) do
		slot0:SetHeroPosData(slot8, slot1[slot8], (slot2 or {})[slot8])
	end

	for slot8, slot9 in ipairs(slot1) do
		if not slot3[slot9] then
			slot4 = false
		end
	end

	if not slot4 then
		slot0:RefreshComboSkillID()
	end
end

function slot0.GetHeroList(slot0)
	return slot0.hero_list
end

function slot0.GetHeroPosData(slot0, slot1)
	if not slot0.hero_list[slot1] then
		slot0.hero_list[slot1] = slot0:GetHeroPosClass().New(slot1)
	end

	return slot0.hero_list[slot1]
end

function slot0.SetHeroPosData(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetHeroPosData(slot1)

	slot4:SetHeroID(slot2)
	slot4:SetTrialID(slot3)
end

function slot0.GetComboSkillID(slot0)
	return slot0.cooperate_unique_skill_id
end

function slot0.SetComboSkillID(slot0, slot1)
	slot0.cooperate_unique_skill_id = slot1 or ReserveConst.DEFAULT_COMBO_SKILL_ID
end

function slot0.RefreshComboSkillID(slot0)
	slot6 = slot0

	for slot5, slot6 in ipairs(slot0.GetHeroList(slot6)) do
		-- Nothing
	end

	slot0:SetComboSkillID(ComboSkillTools.GetRecommendSkillID({
		[slot5] = slot6:GetHeroID()
	}, true))
end

function slot0.GetMimirInfo(slot0)
	return slot0.mimir_info
end

function slot0.GetMimirID(slot0)
	return slot0.mimir_info.mimir_id
end

function slot0.SetMimirID(slot0, slot1)
	slot0.mimir_info.mimir_id = slot1 or 0
end

function slot0.GetMimirChipList(slot0)
	return clone(slot0.mimir_info.chip_list)
end

function slot0.SetMimirChipList(slot0, slot1)
	slot0.mimir_info.chip_list = (slot1 or {}) and clone()
end

function slot0.ResetMimirChipList(slot0)
	slot0.mimir_info.chip_list = {}
end

function slot0.GetHeroPosClass(slot0)
	return ReserveTools.GetHeroPosDataClass(slot0:GetTeamType())
end

function slot0.GetMimirDataClass(slot0)
	return ReserveTools.GetMimirDataClass(slot0:GetTeamType())
end

function slot0.Clone(slot0)
	return deepClone(slot0)
end

function slot0.ConvertToSendData(slot0)
	slot1 = {
		team_index = slot0:GetTeamIndex(),
		hero_list = {}
	}
	slot6 = slot0

	for slot5, slot6 in ipairs(slot0.GetHeroList(slot6)) do
		slot1.hero_list[slot5] = slot6:ConvertToSendData()
	end

	slot1.cooperate_unique_skill_id = slot0:GetComboSkillID()
	slot1.mimir_info = slot0:GetMimirInfo():ConvertToSendData()

	return slot1
end

function slot0.Reset(slot0)
	for slot4, slot5 in ipairs(slot0.hero_list) do
		slot5:Reset()
	end

	slot0.cooperate_unique_skill_id = ReserveConst.DEFAULT_COMBO_SKILL_ID

	slot0.mimir_info:Reset()
end

return slot0
