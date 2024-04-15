slot1 = class("ReserveProposalContDataTemplate", import("game.reserve.ReserveContDataTemplate"))

function slot1.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot0.isTemp = false
	slot0.name = ""
end

function slot1.SetName(slot0, slot1)
	slot0.name = slot1
end

function slot1.GetName(slot0)
	return slot0.name
end

function slot1.GetIsTemp(slot0)
	return slot0.isTemp
end

function slot1.SetIsTemp(slot0, slot1)
	slot0.isTemp = slot1
end

function slot1.Reset(slot0)
	uv0.super.Reset(slot0)

	slot0.isTemp = false
	slot0.name = ""
end

return slot1
