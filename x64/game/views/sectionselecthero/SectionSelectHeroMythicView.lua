slot0 = class("SectionSelectHeroMythicView", SectionSelectHeroBaseView)

function slot0.StartBattle(slot0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function ()
				JumpTools.OpenPageByJump("/mythic", nil)
			end
		})

		return
	end

	slot2 = slot0.params_.difficulty

	BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC, slot0.stageID_, slot0.params_.partition, slot0.reserveParams_))
end

return slot0
