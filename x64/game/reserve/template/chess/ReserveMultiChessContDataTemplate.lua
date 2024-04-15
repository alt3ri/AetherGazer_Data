slot1 = class("ReserveMultiChessContDataTemplate", import("game.reserve.ReserveContDataTemplate"))

function slot1.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot0.posDataList_ = {}
end

function slot1.UpdatePosData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0.posDataList_[slot5] then
			slot0.posDataList_[slot5] = ReserveMultiChessPosData.New()
		end

		slot0.posDataList_[slot5]:UpdateServerData(slot6)
	end
end

function slot1.UpdateAiChip(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.team_dic[slot6.team_index] then
			slot0.team_dic[slot7]:UpdateAiChip(slot6)
		end
	end
end

return slot1
