slot1 = class("TangramSwitchToPlayNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	slot0.manager_:SwitchToPlay()
	slot0.root_:SetNodeRunComplete()
end

return slot1
