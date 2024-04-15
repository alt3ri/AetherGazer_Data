slot1 = class("XH3rdWaterSettlementView", import("game.views.battleResult.BattleResultBaseView"))

function slot1.GoToBattleStatistics(slot0)
	slot0.toStat_ = true

	JumpTools.OpenPageByJump("xH3rdWaterBattleStatistics", {
		stageData = slot0.stageData,
		battleTime = slot0:GetBattleTime()
	})
end

return slot1
