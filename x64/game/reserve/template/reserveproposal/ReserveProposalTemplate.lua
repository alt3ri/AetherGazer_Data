slot1 = class("ReserveProposalTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.UpdateServerData(slot0, slot1)
	slot5 = slot1

	uv0.super.UpdateServerData(slot0, slot5)

	for slot5, slot6 in ipairs(slot1.data) do
		if slot0.cont_dic[slot6.cont_id] then
			slot0:GetContDataTemplateById(slot7):SetName(slot6.name)
		end
	end
end

function slot1.GetProposalContIDList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.cont_teams) do
		if not slot6.isTemp and slot6:GetName() ~= "" then
			slot1[#slot1 + 1] = slot6.cont_id
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0 < slot1
	end)

	return slot1
end

function slot1.GetTempContID(slot0)
	for slot5 = 1, GameSetting.default_formation_num_max.value[1] + 1 do
		if not slot0.cont_dic[slot5] then
			return slot5
		elseif slot6.isTemp then
			return slot5
		elseif slot6:GetName() == "" then
			slot6.isTemp = true

			return slot5
		end
	end

	return slot1 + 1
end

function slot1.DeleteProposal(slot0, slot1)
	slot2 = slot0.cont_dic[slot1]

	table.remove(slot0.cont_teams, table.indexof(slot0.cont_teams, slot2))

	slot0.cont_teams[#slot0.cont_teams + 1] = slot2
end

return slot1
