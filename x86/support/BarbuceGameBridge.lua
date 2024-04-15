slot1 = {}
slot2 = {}
slot3 = nil

return {
	Enter = function (slot0)
		manager.ui:SetMainCamera("barbecue")
		JumpTools.OpenPageByJump("/spHeroChallengeBarbuceView", {
			gameManager = slot0.game
		})
	end,
	Exit = function (slot0)
		DormRhythmGameData:Dispose()
	end
}
