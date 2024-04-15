slot1 = class("TangramRegionTypeAllRightNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	for slot5 = 1, #slot0.blackboard_.allRightRegionTypeList_ do
		slot0.manager_.regionContentItemList_[slot1[slot5]]:PlayCompletedAnim(function ()
			uv0:RefreshStatus()

			if uv1 == #uv2 then
				manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete2", "")
				uv3.root_:SetNodeRunComplete()
			end
		end)
	end
end

return slot1
