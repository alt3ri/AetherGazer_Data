function slot1()
	return {
		atk_style_id = math.random(5),
		skill_id = math.random() < 0.2 and IdolTraineeSkillCfg.all[math.random(#IdolTraineeSkillCfg.all)] or 0,
		index_list = {}
	}
end

function slot2()
	manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound")
end

return {
	Enter = function (slot0, slot1)
		manager.ui:SetMainCamera("dance")
		manager.audio:StopAll()
		DanceGame.GetInstance():Init(BackHomeCricketBattleData:GetSingleBattleData(), slot1)
		JumpTools.OpenPageByJump("backHomeCricketBattleView", {
			stage = slot1
		})
	end,
	Exit = function (slot0)
		DanceGame.GetInstance():Reset(true)
	end
}
