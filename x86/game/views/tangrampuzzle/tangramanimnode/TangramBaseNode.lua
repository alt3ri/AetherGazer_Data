slot0 = class("TangramBaseNode")

function slot0.Ctor(slot0)
end

function slot0.Init(slot0, slot1, slot2, slot3)
	slot0.root_ = slot1
	slot0.blackboard_ = slot2
	slot0.manager_ = slot3
end

function slot0.RunFunc(slot0)
	slot0.root_:SetNodeRunComplete()
end

function slot0.Dispose(slot0)
	slot0.root_ = nil
	slot0.blackboard_ = nil
	slot0.manager_ = nil
end

return slot0
