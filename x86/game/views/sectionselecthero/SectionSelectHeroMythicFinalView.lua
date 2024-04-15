local var_0_0 = class("SectionSelectHeroMythicFinalView", SectionSelectHeroBaseView)

function var_0_0.StartBattle(arg_1_0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function()
				JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
			end
		})

		return
	end

	arg_1_0.super.StartBattle(arg_1_0)
end

return var_0_0
