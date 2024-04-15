slot0 = class("PosterGirlBaseState")

function slot0.Ctor(slot0, slot1)
	slot0.actor = slot1
	slot0.state_key = nil
end

function slot0.Enter(slot0)
end

function slot0.Exit(slot0, slot1)
end

function slot0.SetStateKey(slot0, slot1)
	slot0.state_key = slot1
end

function slot0.GetStateKey(slot0)
	return slot0.state_key
end

return slot0
