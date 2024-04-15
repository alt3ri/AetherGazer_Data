slot1 = class("BossChallengeSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.bossIndex = slot1.bossIndex
	slot0.updateHandler = handler(slot0, slot0.UpdateBossChallenge)
end

function slot1.UpdateBossChallenge(slot0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function slot1.OnSectionSelectEnter(slot0)
	if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
		slot0:UpdateBossChallenge()
	end

	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.updateHandler)
end

function slot1.OnSectionSelectExit(slot0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.updateHandler)
end

function slot1.CustomCheckBeforeBattle(slot0)
	if manager.time:GetServerTime() >= BattleBossChallengeData:GetNextRefreshTime() - 300 then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("NEARLY_OVER"),
			OkCallback = function ()
				return false
			end,
			MaskCallback = function ()
				return false
			end
		})
	end

	return true
end

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/heroTeamInfoBoss"
end

function slot1.GetCustomeTeamInfoParams(slot0, slot1)
	return {
		bossIndex = slot0.bossIndex
	}
end

function slot1.GetStageData(slot0)
	return BattleStageFactory.Produce(slot0.stageType, slot0.stageID, slot0.bossIndex)
end

return slot1
