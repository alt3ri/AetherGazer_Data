NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")
slot0 = class("BattleBossResultView", NewBattleSettlementView)

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	if BattleBossChallengeData:GetNextRefreshTime() <= manager.time:GetServerTime() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_REFRESH_DATA"),
			OkCallback = function ()
				uv0:CloseFunc()
			end,
			MaskCallback = function ()
				uv0:CloseFunc()
			end
		})
	end
end

return slot0
