slot0 = class("ReserveHeroPosTemplate")

function slot0.Ctor(slot0)
	slot0.x = 0
	slot0.y = 0
end

function slot0.UpdateServerData(slot0, slot1)
	slot0.x = slot1.x
	slot0.y = slot1.y
end

return slot0
