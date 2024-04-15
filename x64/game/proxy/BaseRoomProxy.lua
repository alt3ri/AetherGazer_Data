TeamInfo = class("TeamInfo")

function TeamInfo.Ctor(arg_1_0)
	arg_1_0.HeroList = {
		0,
		0,
		0
	}
	arg_1_0.TrialHeroList = {
		0,
		0,
		0
	}
	arg_1_0.LockStateList = {
		false,
		false,
		false
	}
	arg_1_0.LockHeroList = {}
	arg_1_0.ComboSkillId = 0
	arg_1_0.MimirInfo = {
		ChipMgrId = 0,
		Chip = {}
	}
	arg_1_0.ContId = 0
	arg_1_0.TeamId = 0
	arg_1_0.IsInvalid = false
end

local var_0_0 = class("BaseRoomProxy")

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.stageId_ = arg_2_1
	arg_2_0.stageType_ = arg_2_2
	arg_2_0.activityId_ = arg_2_3
	arg_2_0.data_ = arg_2_4
end

function var_0_0.GetTemplate(arg_3_0, arg_3_1)
	if arg_3_0.template_ == nil then
		arg_3_0.template_ = arg_3_0:CreateTemplate(arg_3_1)
	end

	return arg_3_0.template_
end

function var_0_0.GetHeroTeam(arg_4_0)
	local var_4_0, var_4_1, var_4_2, var_4_3 = GetLocalHeroTeam(arg_4_0.stageType_, arg_4_0.stageId_, arg_4_0.activityId_)
	local var_4_4 = TeamInfo.New()

	var_4_4.HeroList = var_4_0
	var_4_4.LockStateList = var_4_1
	var_4_4.LockHeroList = var_4_2
	var_4_4.TrialHeroList = var_4_3

	return var_4_4
end

function var_0_0.SetHeroTeam(arg_5_0, arg_5_1)
	SetHeroTeam(arg_5_0.stageType_, arg_5_0.stageId_, arg_5_0.activityId_, arg_5_1.HeroList, arg_5_1.TrialHeroList, arg_5_1.ComboSkillId, arg_5_1.MimirInfo, arg_5_1.ContId, arg_5_1.TeamId)
end

function var_0_0.CreateBattleCallback(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if isSuccess(arg_6_1) then
		return arg_6_0:CreateBattleSuccessCallback(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	else
		return arg_6_0:CreateBattleFailedCallback(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	end
end

function var_0_0.CreateBattleSuccessCallback(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return function()
		local var_8_0 = arg_7_2:GetStageId()
		local var_8_1, var_8_2 = GetResultReward()

		manager.story:CheckBattleStory(var_8_0, manager.story.WIN, function()
			JumpTools.OpenPageByJump("/newSettlement", {
				result = arg_7_1,
				rewardList = var_8_1,
				stageData = arg_7_2,
				starMissionData = arg_7_3,
				battleResult = arg_7_4
			})
			manager.story:RemovePlayer()
			EndBattleLogic(arg_7_1)
		end)
	end
end

function var_0_0.CreateBattleFailedCallback(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	return function()
		local var_11_0 = arg_10_2:GetStageId()

		manager.story:CheckBattleStory(var_11_0, manager.story.LOSE, function()
			JumpTools.OpenPageByJump("/battlefailed", {
				stageData = arg_10_2,
				starMissionData = arg_10_3,
				battleResult = arg_10_4,
				isHalfWay_ = arg_10_0.tempData.isHalfWay_
			})
			manager.story:RemovePlayer()
			EndBattleLogic(arg_10_1)
		end)
	end
end

function var_0_0.CreateTemplate(arg_13_0, arg_13_1)
	return nil
end

function var_0_0.OnBattleStart(arg_14_0)
	return
end

function var_0_0.OnBattleResult(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	return
end

function var_0_0.OnBattleQuit(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	return
end

function var_0_0.Dispose(arg_17_0)
	return
end

return var_0_0
