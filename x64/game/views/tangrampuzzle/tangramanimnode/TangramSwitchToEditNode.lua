slot1 = class("TangramSwitchToEditNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	slot0.manager_:EnterEdit(slot0.blackboard_.newEditIndex_)
	slot0.root_:SetNodeRunComplete()
end

return slot1
