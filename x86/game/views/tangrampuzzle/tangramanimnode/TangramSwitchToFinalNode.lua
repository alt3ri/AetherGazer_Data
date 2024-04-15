slot1 = class("TangramSwitchToFinalNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	ShowTips("ACTIVITY_PUZZLE_FINISH")
	slot0.manager_:SwitchToFinal()
	slot0.root_:SetNodeRunComplete()
end

return slot1
