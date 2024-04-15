slot1 = class("MythicSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.partition = slot1.partition
	slot0.difficulty = slot1.difficulty
end

function slot1.CustomCheckBeforeBattle(slot0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function ()
				JumpTools.OpenPageByJump("/mythic", nil)
			end
		})

		return false
	end

	return true
end

function slot1.GetStageData(slot0)
	slot2 = slot0.difficulty

	return BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC, slot0.stageID, slot0.partition)
end

return slot1
