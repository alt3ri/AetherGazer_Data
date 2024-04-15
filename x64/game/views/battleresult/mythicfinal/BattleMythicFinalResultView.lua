local var_0_0 = import("game.views.battleResult.BattleResultBaseView")
local var_0_1 = class("BattleMythicFinalResultView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/BattleResult/MythicBattleSettlementUI"
end

function var_0_1.RefreshUI(arg_2_0)
	arg_2_0:SetLevelTitle()
	arg_2_0:RefreshMyExpS()
	arg_2_0:RefreshHeroS()
	arg_2_0:RefreshMythicFinalUI()
	arg_2_0:RefreshBattleTime()
end

function var_0_1.OnEnter(arg_3_0)
	arg_3_0.tweens_ = {}
	arg_3_0.stageData = arg_3_0.params_.stageData
	arg_3_0.stageId = arg_3_0.stageData:GetStageId()
	arg_3_0.stageType = arg_3_0.stageData:GetType()
	arg_3_0.heroExp_ = {}

	BattleInstance.hideBattlePanel()
	arg_3_0:CaculateReward()
	arg_3_0:RefreshUI()

	if arg_3_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				BattleInstance.TryNextBattle(arg_3_0.stageData)
			end
		})
	end

	if arg_3_0.stageData:GetDest() >= #MythicData:GetCurLevelIdList() then
		if not MythicData:GetIsNew() then
			RankAction.QueryOwnCommonRank(RankConst.RANK_ID.MATRIX)
			MythicAction.UpdateMythicFinalRedPoint()
		end

		SetActive(arg_3_0.gogiveup_, false)
		SetActive(arg_3_0.pointgo_, true)

		arg_3_0.pointtext_.text = MythicData:GetCurPoint()
	else
		SetActive(arg_3_0.gogiveup_, true)
		SetActive(arg_3_0.pointgo_, false)
	end
end

function var_0_1.RefreshMythicFinalUI(arg_5_0)
	local var_5_0
	local var_5_1 = arg_5_0.stageData:GetDest() == 0 and 1 or arg_5_0.stageData:GetDest()

	arg_5_0.teamindextext_.text = string.format(var_5_1 .. "/" .. #MythicData:GetCurLevelIdList())

	local var_5_2 = "TEAM_" .. var_5_1

	arg_5_0.teamtext_.text = GetTips(var_5_2)
end

function var_0_1.SetLevelTitle(arg_6_0)
	arg_6_0.lvText_.text = string.format(GetTips("MYTHIC_FINAL_LEVEL"), MythicData:GetCurHotLevelId())

	arg_6_0:RefreshTitleImmediate()
end

function var_0_1.RefreshBattleTime(arg_7_0)
	if BattleStageTools.GetStageCfg(arg_7_0.stageType, arg_7_0.stageId).tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	arg_7_0.battleTimeText_.text = arg_7_0:GetBattleTime()
	arg_7_0.teamTimeText_.text = arg_7_0:GetBattleTime()

	local var_7_0 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)

	arg_7_0.remainTimeText_.text = manager.time:DescCdTime2(MythicData:GetBattlingTime())
end

function var_0_1.AddListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btnClose_, nil, function()
		BattleInstance.TryNextBattle(arg_8_0.stageData)
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonMask_, nil, function()
		arg_8_0:EndAnimator()
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnOnceMore_, nil, function()
		ShowMessageBox({
			content = GetTips("MYTHIC_FINAL_LEVEL_RETRY"),
			OkCallback = function()
				BattleInstance.OnceMoreBattle(arg_8_0.stageData)
			end
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnBattleCount_, nil, function()
		arg_8_0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = arg_8_0.stageData,
			battleTime = arg_8_0:GetBattleTime()
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.btngiveup_, nil, function()
		BattleInstance.QuitBattle(arg_8_0.stageData)
	end)
end

return var_0_1
