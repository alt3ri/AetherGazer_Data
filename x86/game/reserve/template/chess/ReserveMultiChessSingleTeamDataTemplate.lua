slot1 = class("ReserveMultiChessSingleTeamDataTemplate", import("game.reserve.ReserveSingleTeamDataTemplate"))

function slot1.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot0.aiChipList = {}
end

function slot1.UpdateAiChip(slot0, slot1)
	slot0.aiChipList = cleanProtoTable(slot1)
end

function slot1.GetAiChip(slot0)
	return slot0.aiChipList
end

function slot1.SetAiChip(slot0, slot1)
	slot0.aiChipList = clone(slot1)
end

return slot1
