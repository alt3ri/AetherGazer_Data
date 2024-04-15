slot1 = class("TangramAutoPutNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.Ctor(slot0)
	slot0.nodeDic_ = {}
	slot0.nodeSize_ = 0
end

function slot1.Dispose(slot0)
	slot0.root_ = nil
	slot0.nodeDic_ = nil
end

function slot1.Add(slot0, slot1)
	slot0.nodeSize_ = slot0.nodeSize_ + 1
	slot0.nodeDic_[slot1] = true
end

function slot1.RunFunc(slot0)
	slot0.runningNodeCount_ = slot0.nodeSize_

	for slot4, slot5 in pairs(slot0.nodeDic_) do
		slot4:RunFunc()
	end
end

function slot1.SetNodeRunComplete(slot0)
	slot0.runningNodeCount_ = slot0.runningNodeCount_ - 1

	if slot0.runningNodeCount_ == 0 then
		slot0.root_:SetNodeRunComplete()
	end
end

return slot1
