local var_0_0 = class("SectionSelectHeroMythicView", SectionSelectHeroBaseView)

function var_0_0.StartBattle(arg_1_0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function()
				JumpTools.OpenPageByJump("/mythic", nil)
			end
		})

		return
	end

	local var_1_0 = arg_1_0.params_.partition
	local var_1_1 = arg_1_0.params_.difficulty
	local var_1_2 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC, arg_1_0.stageID_, var_1_0, arg_1_0.reserveParams_)

	BattleController.GetInstance():LaunchBattle(var_1_2)
end

return var_0_0
