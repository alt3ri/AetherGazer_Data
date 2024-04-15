slot0 = singletonClass("ReserveData")

function slot0.Init(slot0)
	slot0.serverTeamTemplateDicByType_ = {}
	slot0.clientTeamTemplateDicByType_ = {}
end

function slot0.InitData(slot0, slot1)
	slot0:UpdateServerTeamTemplate(slot1.teams_info_list)
	slot0:UpdateServerTeamTemplate(slot1.formation_teams_info_list)
	slot0:UpdateServerTeamTemplate(slot1.chess_teams_info_list)
	slot0:UpdateServerTeamTemplate(slot1.solo_challenge_teams_info_list)
end

function slot0.UpdateServerTeamTemplate(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:UpdateSingleServerTeamTemplate(slot6.team_type, slot6)
	end
end

function slot0.UpdateSingleServerTeamTemplate(slot0, slot1, slot2)
	if not slot0.serverTeamTemplateDicByType_[slot1] then
		slot0.serverTeamTemplateDicByType_[slot1] = ReserveTools.GetReserveTemplateClass(slot1).New(slot1)
	end

	slot0.serverTeamTemplateDicByType_[slot1]:UpdateServerData(slot2)

	if slot0.clientTeamTemplateDicByType_[slot1] then
		slot0.clientTeamTemplateDicByType_[slot1]:UpdateServerData(slot2)
	end
end

function slot0.GetServerTeamTemplate(slot0, slot1)
	if not slot0.serverTeamTemplateDicByType_[slot1] then
		slot0.serverTeamTemplateDicByType_[slot1] = ReserveTools.GetReserveTemplateClass(slot1).New(slot1)
	end

	return slot0.serverTeamTemplateDicByType_[slot1]
end

function slot0.GetTeamTemplate(slot0, slot1)
	if not slot0.clientTeamTemplateDicByType_[slot1] then
		if slot0.serverTeamTemplateDicByType_[slot1] then
			slot0.clientTeamTemplateDicByType_[slot1] = slot0.serverTeamTemplateDicByType_[slot1]:Clone()
		else
			slot0.clientTeamTemplateDicByType_[slot1] = ReserveTools.GetReserveTemplateClass(slot1).New(slot1)
		end
	end

	return slot0.clientTeamTemplateDicByType_[slot1]
end

return slot0
