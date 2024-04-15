slot1 = class("TangramAutoPutNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	slot0.manager_:RefreshPuzzleList()
	SetActive(slot0.manager_.autoPutPanelGo_, true)
	slot0.manager_:PlayAnim(slot0.manager_.autoPutAnim_, "regionContentPanel", function ()
		SetActive(uv0.manager_.autoPutPanelGo_, false)
		uv0.root_:SetNodeRunComplete()
	end)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete1", "")
end

return slot1
