slot1 = class("TangramRegionReceiveNode", import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode"))

function slot1.RunFunc(slot0)
	if slot0.blackboard_.isOnlyRegionRewardPop_ == true then
		slot0:RunCompleteFunc()

		return
	end

	slot5 = "minigame_activity_2_1_puzzle_reward"

	manager.audio:PlayEffect("minigame_activity_2_1", slot5, "")

	for slot5 = 1, #slot0.blackboard_.receivedRegionList_ do
		if slot5 == #slot1 then
			slot0.manager_.regionItemList_[slot1[slot5]]:PlayRewardAnim(function ()
				uv0:RunCompleteFunc()
			end)
		else
			slot0.manager_.regionItemList_[slot1[slot5]]:PlayRewardAnim()
		end
	end
end

function slot1.RunCompleteFunc(slot0)
	showRewardUI(slot0.blackboard_.rewardList_, nil, function ()
		uv0.root_:SetNodeRunComplete()
	end)
end

return slot1
