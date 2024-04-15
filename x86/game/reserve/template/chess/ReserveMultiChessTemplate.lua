slot1 = class("ReserveMultiChessTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.UpdateServerData(slot0, slot1)
	uv0.super.UpdateServerData(slot0, slot1)

	if slot0.cont_dic[slot1.data.cont_id] then
		slot4 = slot0:GetContDataTemplateById(slot3)

		slot4:UpdatePosData(slot2.chess_data_info_1)
		slot4:UpdateAiChip(slot2.chess_data_info_2)
	end
end

return slot1
