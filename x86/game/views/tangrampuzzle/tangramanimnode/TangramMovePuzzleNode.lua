slot1 = class("TangramMovePuzzleNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	slot0.updatingPuzzleCount_ = 0
	slot1 = slot0.blackboard_.moveOriginPuzzleIndex_
	slot2 = slot0.blackboard_.moveTargetPuzzleIndex_

	slot0:UpdatePuzzle(slot1, slot0.manager_.puzzleItemList_[slot2].transform_.position)
	slot0:UpdatePuzzle(slot2, slot0.manager_.puzzleItemList_[slot1].transform_.position)
end

function slot1.UpdatePuzzle(slot0, slot1, slot2)
	slot0.updatingPuzzleCount_ = slot0.updatingPuzzleCount_ + 1
	slot3 = slot0.manager_.puzzleItemList_[slot1]

	slot3:SetTransParent(slot0.manager_.editPanelTrans_)
	slot3:UpdatePosition(slot2, function ()
		uv0.manager_:UpdatePuzzleData(uv1)

		uv0.updatingPuzzleCount_ = uv0.updatingPuzzleCount_ - 1

		if uv0.updatingPuzzleCount_ == 0 then
			uv0.root_:SetNodeRunComplete()
		end
	end)
end

return slot1
