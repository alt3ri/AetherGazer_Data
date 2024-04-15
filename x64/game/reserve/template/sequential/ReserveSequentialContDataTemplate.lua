slot1 = class("ReserveSequentialContDataTemplate", import("game.reserve.ReserveContDataTemplate"))

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

return slot1
