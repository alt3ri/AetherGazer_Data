local var_0_0 = class("GotoActivityWaterStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoActivityWaterStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoActivityWaterStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/xH3rdWaterSettlementView", {
				result = arg_2_1,
				rewardList = var_2_0,
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end
	else
		function BattleCallLuaCallBack()
			local var_4_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_4_0, manager.story.LOSE, function()
				gameContext:Go("/xH3rdWaterBattleFailed", {
					stageData = arg_2_2,
					starMissionData = arg_2_3,
					battleResult = arg_2_4
				})
				manager.story:RemovePlayer()
				EndBattleLogic(arg_2_1)
			end)
		end
	end
end

return var_0_0
