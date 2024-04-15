slot1 = class("MythicFinalSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.CustomCheckBeforeBattle(slot0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function ()
				JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
			end
		})

		return false
	end

	return true
end

return slot1
