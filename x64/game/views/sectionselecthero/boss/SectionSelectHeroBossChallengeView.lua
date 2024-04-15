local var_0_0 = class("SectionSelectHeroBossChallengeView", SectionSelectHeroBaseView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.bossIndex_ = arg_1_0.params_.bossIndex
	arg_1_0.stageType_ = arg_1_0.params_.sectionType
	arg_1_0.challengeUpdateHandler_ = handler(arg_1_0, arg_1_0.UpdateBossChallenge)

	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_1_0.challengeUpdateHandler_)
	var_0_0.super.OnEnter(arg_1_0)
end

function var_0_0.OnTop(arg_2_0)
	var_0_0.super.OnTop(arg_2_0)

	if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
		arg_2_0:UpdateBossChallenge()
	end
end

function var_0_0.OnExit(arg_3_0)
	var_0_0.super.OnExit(arg_3_0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_3_0.challengeUpdateHandler_)

	arg_3_0.challengeUpdateHandler_ = nil
end

function var_0_0.GoHeroInfoUI(arg_4_0, arg_4_1)
	arg_4_0:Go("/heroTeamInfoBoss", {
		isEnter = true,
		selectHeroPos = arg_4_1,
		stageID = arg_4_0.stageID_,
		stageType = arg_4_0.stageType_,
		bossIndex = arg_4_0.bossIndex_,
		reserveParams = arg_4_0.reserveParams_
	})
end

function var_0_0.StartBattle(arg_5_0)
	if manager.time:GetServerTime() >= BattleBossChallengeData:GetNextRefreshTime() - 300 then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("NEARLY_OVER"),
			OkCallback = function()
				return
			end,
			MaskCallback = function()
				return
			end
		})

		return
	end

	local var_5_0 = BattleStageFactory.Produce(arg_5_0.stageType_, arg_5_0.stageID_, arg_5_0.bossIndex_, arg_5_0.reserveParams_)

	var_5_0:SetMultiple(arg_5_0.multiple_)
	BattleController.GetInstance():LaunchBattle(var_5_0)
end

function var_0_0.UpdateBossChallenge(arg_8_0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

return var_0_0
