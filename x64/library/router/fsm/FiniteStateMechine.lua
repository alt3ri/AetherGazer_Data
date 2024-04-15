slot0 = class("FiniteStateMechine")

function slot0.Ctor(slot0)
	slot0.states_ = {}
	slot0.curState_ = nil
end

function slot0.AddState(slot0, slot1)
	if slot0.states_[slot1:GetStateName()] then
		return
	end

	slot0.states_[slot1:GetStateName()] = slot1
end

function slot0.SetInitState(slot0, slot1)
	slot0.curState_ = slot0.states_[slot1]
end

function slot0.GetCurState(slot0)
	return slot0.curState_
end

function slot0.CanTransition(slot0, slot1)
	if slot0.curState_:GetStateName() == slot1 then
		return false
	end

	if slot0.curState_:GetToName() == slot0.states_[slot1]:GetFromName() then
		return true
	end

	return false
end

function slot0.Trigger(slot0, slot1)
	if slot0:CanTransition(slot1) then
		slot0.curState_:OnLeave()

		slot0.curState_ = slot0.states_[slot1]

		slot0.curState_:OnEnter()
	else
		print("can not transition " .. slot1)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.states_) do
		slot5:Dispose()
	end

	slot0.states_ = nil
end

return slot0
