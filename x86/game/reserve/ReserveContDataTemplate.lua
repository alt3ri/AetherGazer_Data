slot0 = class("ReserveContDataTemplate")

function slot0.Ctor(slot0, slot1, slot2)
	slot0.team_type = slot1 or ReserveConst.RESERVE_TYPE.DEFAULT
	slot0.cont_id = slot2 or ReserveConst.DETAULT_CONT_ID
	slot0.teams = {}
	slot0.team_dic = {}
	slot0.is_dirty = false
end

function slot0.UpdateServerData(slot0, slot1)
	slot0.cont_id = slot1.cont_id

	for slot5, slot6 in ipairs(slot1.teams) do
		slot0:GetSingleTeamData(slot6.team_index):UpdateServerData(slot6)
	end
end

function slot0.SetTeamType(slot0, slot1)
	slot0.team_type = slot1
end

function slot0.GetTeamType(slot0)
	return slot0.team_type
end

function slot0.GetContID(slot0)
	return slot0.cont_id
end

function slot0.GetIsDirty(slot0)
	return slot0.is_dirty
end

function slot0.SetIsDirty(slot0, slot1)
	slot0.is_dirty = slot1
end

function slot0.GetHeroList(slot0, slot1)
	return slot0:GetSingleTeamData(slot1):GetHeroList()
end

function slot0.SetHeroList(slot0, slot1, slot2, slot3)
	slot0.is_dirty = true

	slot0:GetSingleTeamData(slot3):SetHeroList(slot1, slot2)
end

function slot0.GetComboSkillID(slot0, slot1)
	return slot0:GetSingleTeamData(slot1):GetComboSkillID()
end

function slot0.SetComboSkillID(slot0, slot1, slot2)
	slot0.is_dirty = true

	slot0:GetSingleTeamData(slot2):SetComboSkillID(slot1)
end

function slot0.GetMimirID(slot0, slot1)
	return slot0:GetSingleTeamData(slot1):GetMimirID()
end

function slot0.SetMimirID(slot0, slot1, slot2)
	slot0.is_dirty = true

	slot0:GetSingleTeamData(slot2):SetMimirID(slot1)
end

function slot0.GetMimirChipList(slot0, slot1)
	return slot0:GetSingleTeamData(slot1):GetMimirChipList()
end

function slot0.SetMimirChipList(slot0, slot1, slot2)
	slot0.is_dirty = true

	slot0:GetSingleTeamData(slot2):SetMimirChipList(slot1)
end

function slot0.ResetMimirChipList(slot0, slot1)
	slot0:GetSingleTeamData(slot1):ResetMimirChipList()
end

function slot0.GetTeamDataList(slot0)
	return slot0.teams
end

function slot0.GetSingleTeamData(slot0, slot1)
	if not slot0.team_dic[slot1 or slot0:GetTeamIndex()] then
		slot0.team_dic[slot1] = slot0:GetSingleTeamDataTemplateClass().New(slot0:GetTeamType(), slot1)
		slot0.teams[#slot0.teams + 1] = slot0.team_dic[slot1]
	end

	return slot0.team_dic[slot1]
end

function slot0.SwapTeam(slot0, slot1, slot2)
	slot3 = slot0:GetSingleTeamData(slot1)
	slot4 = slot0:GetSingleTeamData(slot2)

	slot3:SetTeamIndex(slot2)

	slot0.team_dic[slot2] = slot3

	slot4:SetTeamIndex(slot1)

	slot0.team_dic[slot1] = slot4
end

function slot0.GetTeamIndex(slot0)
	return ReserveConst.DEFAULT_TEAM_INDEX
end

function slot0.GetTeamCount(slot0)
	return #slot0.teams
end

function slot0.CleanCacheData(slot0)
	if not slot0:GetIsDirty() then
		return
	end

	for slot6, slot7 in pairs(slot0.team_dic) do
		slot7:UpdateServerData(ReserveTools.GetReserveTemplateByReserveType(slot0:GetTeamType(), true):GetContDataTemplateById(slot0:GetContID()):GetSingleTeamData(slot6))
	end

	slot0:SetIsDirty(false)
end

function slot0.Clone(slot0)
	return deepClone(slot0)
end

function slot0.GetSingleTeamDataTemplateClass(slot0)
	return ReserveTools.GetSingleTeamDataClass(slot0:GetTeamType())
end

function slot0.ConvertToSendData(slot0)
	slot1 = {
		cont_id = slot0:GetContID(),
		teams = {}
	}

	for slot5, slot6 in ipairs(slot0.team_dic) do
		slot1.teams[slot5] = slot6:ConvertToSendData()
	end

	return slot1
end

function slot0.ConverAllTeamToSendData(slot0)
	slot1 = {
		cont_id = slot0:GetContID(),
		teams = {}
	}

	for slot5, slot6 in ipairs(slot0.teams) do
		slot1.teams[slot5] = slot6:ConvertToSendData()
	end

	return slot1
end

function slot0.Reset(slot0)
	for slot4, slot5 in pairs(slot0.team_dic) do
		slot5:Reset()
	end

	slot0.teams = {}
	slot0.team_dic = {}
	slot0.is_dirty = false
end

return slot0
