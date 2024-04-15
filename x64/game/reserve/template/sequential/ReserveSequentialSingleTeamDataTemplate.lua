slot1 = class("ReserveSequentialSingleTeamDataTemplate", import("game.reserve.ReserveSingleTeamDataTemplate"))

function slot1.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot0.affixList = {}
end

function slot1.SetAffix(slot0, slot1, slot2)
	slot0.affixList[slot1] = slot2 or 0
end

function slot1.SetAffixList(slot0, slot1)
	slot0.affixList = clone(slot1)
end

function slot1.GetAffixList(slot0)
	return clone(slot0.affixList)
end

return slot1
