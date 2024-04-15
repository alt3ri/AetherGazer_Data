slot1 = class("TangramRotateRegionNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	slot1 = slot0.blackboard_.rotateRegionID_

	if slot0.blackboard_.rotateTimes_ == 0 then
		slot0.root_:SetNodeRunComplete()

		return
	end

	slot3 = slot0.manager_.regionItemList_[slot1]

	slot3:SetTransParent(slot0.manager_.editPanelTrans_)
	slot3:Rotate(TangramPuzzleTools.GetRegionRotateAngle(slot0.manager_.activityID_, slot1) * slot2, function ()
		uv0:RecoverTrans()

		for slot4, slot5 in ipairs(TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(uv1.manager_.activityID_)[uv2]) do
			uv1.manager_:UpdatePuzzleData(slot5)
		end

		uv1.root_:SetNodeRunComplete()
	end)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_rotate", "")
end

return slot1
