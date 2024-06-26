slot0 = class("SectionSelectHeroBossChallengeView", SectionSelectHeroBaseView)

function slot0.OnEnter(slot0)
	slot0.bossIndex_ = slot0.params_.bossIndex
	slot0.stageType_ = slot0.params_.sectionType
	slot0.challengeUpdateHandler_ = handler(slot0, slot0.UpdateBossChallenge)

	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)
	uv0.super.OnEnter(slot0)
end

function slot0.OnTop(slot0)
	uv0.super.OnTop(slot0)

	if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
		slot0:UpdateBossChallenge()
	end
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)

	slot0.challengeUpdateHandler_ = nil
end

function slot0.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/heroTeamInfoBoss", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		stageType = slot0.stageType_,
		bossIndex = slot0.bossIndex_,
		reserveParams = slot0.reserveParams_
	})
end

function slot0.StartBattle(slot0)
	if manager.time:GetServerTime() >= BattleBossChallengeData:GetNextRefreshTime() - 300 then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("NEARLY_OVER"),
			OkCallback = function ()
			end,
			MaskCallback = function ()
			end
		})

		return
	end

	slot1 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, slot0.bossIndex_, slot0.reserveParams_)

	slot1:SetMultiple(slot0.multiple_)
	BattleController.GetInstance():LaunchBattle(slot1)
end

function slot0.UpdateBossChallenge(slot0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

return slot0
