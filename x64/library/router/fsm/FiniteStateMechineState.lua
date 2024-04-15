slot0 = class("FiniteStateMechineState")

function slot0.Ctor(slot0, slot1)
	slot0.state_ = slot1
end

function slot0.OnEnter(slot0)
end

function slot0.OnLeave(slot0)
end

function slot0.GetStateName(slot0)
	return slot0.state_.name
end

function slot0.GetFromName(slot0)
	return slot0.state_.from
end

function slot0.GetToName(slot0)
	return slot0.state_.to
end

return slot0
