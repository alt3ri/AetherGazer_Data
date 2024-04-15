slot1 = class("TangramMovePuzzleImmediatelyNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	slot0.manager_:UpdatePuzzleData(slot0.blackboard_.moveOriginPuzzleIndex_)
	slot0.manager_:UpdatePuzzleData(slot0.blackboard_.moveTargetPuzzleIndex_)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_button", "")
	slot0.root_:SetNodeRunComplete()
end

return slot1
