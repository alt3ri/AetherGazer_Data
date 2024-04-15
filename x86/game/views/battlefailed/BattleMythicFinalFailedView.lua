local var_0_0 = class("BattleMythicFinalFailedView", BattleFailedView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/BattleMythicFailed"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	SetActive(arg_2_0.tipsGo_, false)

	arg_2_0.stageData = arg_2_0.params_.stageData
end

function var_0_0.OnEnter(arg_3_0)
	BattleInstance.hideBattlePanel()
	arg_3_0:RecordThreeStar()

	arg_3_0.startTime = Time.realtimeSinceStartup
	arg_3_0.isEnd = false

	arg_3_0:RemoveTimer()

	arg_3_0.battleTimeText_.text = arg_3_0:GetBattleTime()

	arg_3_0.animator_:Play("battleFailed")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_backBtn, nil, function()
		if arg_4_0.isEnd then
			return
		end

		if Time.realtimeSinceStartup - arg_4_0.startTime < 2 then
			return
		end

		arg_4_0:Quit()
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_againBtn, nil, function()
		if arg_4_0.isEnd then
			return
		end

		if arg_4_0.stageData then
			arg_4_0:OnceMoreBattle()
		else
			arg_4_0:Quit()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnBattleCount_, nil, function()
		if arg_4_0.isEnd then
			return
		end

		arg_4_0:RemoveTimer()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = arg_4_0.stageData,
			battleTime = arg_4_0:GetBattleTime()
		})
	end)
end

function var_0_0.Quit(arg_8_0)
	BattleInstance.QuitBattle(arg_8_0.params_.stageData)
end

function var_0_0.OnceMoreBattle(arg_9_0)
	arg_9_0.isEnd = true

	arg_9_0:RemoveTimer()

	arg_9_0.timer_ = Timer.New(function()
		BattleInstance.OnceMoreBattle(arg_9_0.stageData)
	end, 1, 1)

	arg_9_0.timer_:Start()
	arg_9_0.animator_:Play("battleFailed_out")
end

return var_0_0
