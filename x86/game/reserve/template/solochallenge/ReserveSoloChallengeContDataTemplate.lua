slot1 = class("ReserveSoloChallengeContDataTemplate", import("game.reserve.ReserveContDataTemplate"))

function slot1.SetAffix(slot0, slot1, slot2, slot3)
	if slot0.team_dic[slot1] then
		slot0.team_dic[slot1]:SetAffix(slot2, slot3)
	end
end

function slot1.SetAffixList(slot0, slot1, slot2)
	if slot0.team_dic[slot1] then
		slot0.team_dic[slot1]:SetAffixList(slot2)
	end
end

function slot1.GetAffixList(slot0, slot1)
	if slot0.team_dic[slot1] then
		return slot0.team_dic[slot1]:GetAffixList()
	else
		return {}
	end
end

function slot1.GetSummaryHeroList(slot0)
	for slot6, slot7 in pairs(slot0.team_dic) do
		slot8 = slot7:GetTeamIndex()
		slot9 = slot7:GetHeroList()
	end

	return {
		[slot8] = slot9[1]:GetHeroID()
	}, {
		[slot8] = slot9[1]:GetTrialID()
	}
end

function slot1.GetLockHeroList(slot0, slot1, slot2)
	slot3 = {}
	slot4, slot5 = slot0:GetSummaryHeroList()

	for slot11 = 1, #ActivitySoloChallengeCfg[slot1].stage_id[slot2][2] do
		if table.indexof(SoloChallengeData:GetCompletedStageList(slot1)[slot2] or {}, slot7[slot11]) then
			if slot5[slot11] ~= 0 then
				table.insert(slot3, slot5[slot11])
			elseif slot4[slot11] ~= 0 then
				table.insert(slot3, slot4[slot11])
			end
		end
	end

	return slot3
end

function slot1.SetSummaryHeroList(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.team_dic) do
		slot7:SetHeroPosData(1, slot1[slot7:GetTeamIndex()] or 0, slot2[slot8] or 0)
	end
end

return slot1
