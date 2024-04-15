local var_0_0 = class("XH3rdWaterSingleRoomProxy", BaseRoomProxy)

function var_0_0.CreateTemplate(arg_1_0, arg_1_1)
	return BattleActivityWaterTemplate.New(arg_1_0.stageId_, arg_1_0.activityId_)
end

function var_0_0.CreateBattleSuccessCallback(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	return function()
		local var_3_0 = arg_2_2:GetStageId()
		local var_3_1, var_3_2 = GetResultReward()

		manager.story:CheckBattleStory(var_3_0, manager.story.WIN, function()
			JumpTools.OpenPageByJump("/newSettlement", {
				result = arg_2_1,
				rewardList = var_3_1,
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
			manager.story:RemovePlayer()
			EndBattleLogic(arg_2_1)
		end)
	end
end

function var_0_0.OnBattleQuit(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	OpenPageUntilLoaded("/cooperationBlank/xH3rdWaterSelectAssistant", {
		activityId = arg_5_1:GetMainActivityId()
	})
end

return var_0_0
