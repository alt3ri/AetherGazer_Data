local var_0_0 = singletonClass("CoreVerificationData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = 0
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_9 = {}
	var_0_2 = {}
	var_0_6 = {}
	var_0_7 = {}
	var_0_8 = {}
	var_0_3 = 1
	var_0_4 = 2

	for iter_1_0, iter_1_1 in pairs(CoreVerificationInfoCfg.get_id_list_by_cycle) do
		var_0_1[iter_1_0] = {}
		var_0_1[iter_1_0][1] = {}
		var_0_1[iter_1_0][2] = {}

		for iter_1_2, iter_1_3 in ipairs(iter_1_1) do
			local var_1_0 = CoreVerificationInfoCfg[iter_1_3]

			var_0_1[iter_1_0][var_1_0.boss_type][var_1_0.difficult] = iter_1_3
		end
	end

	var_0_2[1] = {}
	var_0_2[2] = {}
	var_0_2[3] = {}
	var_0_2[4] = {}

	for iter_1_4, iter_1_5 in pairs(CoreVerificationRewardCfg.all) do
		local var_1_1 = CoreVerificationRewardCfg[iter_1_5]

		if var_1_1.reward_type == 1 or var_1_1.reward_type == 2 then
			if not var_0_2[var_1_1.reward_type][var_1_1.cycle] then
				var_0_2[var_1_1.reward_type][var_1_1.cycle] = {}
			end

			table.insert(var_0_2[var_1_1.reward_type][var_1_1.cycle], iter_1_5)
		else
			table.insert(var_0_2[var_1_1.reward_type], iter_1_5)
		end
	end

	arg_1_0:SetUpdateCycleCallBack()
end

function var_0_0.UpdateCycleInfo(arg_2_0, arg_2_1)
	var_0_3 = arg_2_1.now_cycle
	var_0_4 = arg_2_1.next_cycle
	var_0_5 = arg_2_1.refresh_timestamp

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.stage_info) do
		var_0_6[iter_2_1.id] = {}
		var_0_6[iter_2_1.id].passState = iter_2_1.sign == 1
		var_0_6[iter_2_1.id].passTime = iter_2_1.sign == 1 and iter_2_1.min_time / 1000 or 3600
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.reward_list) do
		var_0_8[iter_2_3] = true
	end

	var_0_7[1] = {}
	var_0_7[2] = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.lock_list) do
		for iter_2_6, iter_2_7 in ipairs(iter_2_5.hero_list) do
			table.insert(var_0_7[iter_2_5.boss_type], iter_2_7)
		end
	end

	var_0_9 = {
		0,
		0
	}

	local var_2_0 = var_0_1[var_0_3][1]
	local var_2_1 = var_0_1[var_0_3][2]

	for iter_2_8, iter_2_9 in ipairs(var_2_0) do
		if var_0_6[iter_2_9] and var_0_6[iter_2_9].passState then
			var_0_9[1] = iter_2_8
		end
	end

	for iter_2_10, iter_2_11 in ipairs(var_2_1) do
		if var_0_6[iter_2_11] and var_0_6[iter_2_11].passState then
			var_0_9[2] = iter_2_10
		end
	end
end

function var_0_0.BattleStageData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = CoreVerificationInfoCfg[arg_3_1]
	local var_3_1 = var_3_0.boss_type
	local var_3_2 = var_3_0.difficult

	if var_3_2 > var_0_9[var_3_1] then
		var_0_9[var_3_1] = var_3_2
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if not table.keyof(var_0_7[var_3_1], iter_3_1) then
			table.insert(var_0_7[var_3_1], iter_3_1)
		end
	end

	if var_0_6[var_3_0.id] then
		var_0_6[var_3_0.id].passState = true

		if arg_3_3 < var_0_6[var_3_0.id].passTime then
			var_0_6[var_3_0.id].passTime = arg_3_3
		end
	else
		var_0_6[var_3_0.id] = {}
		var_0_6[var_3_0.id].passState = true
		var_0_6[var_3_0.id].passTime = arg_3_3
	end

	CoreVerificationAction.UpdateRewardRedPoints()
end

function var_0_0.UpdateRewardData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.reward_list) do
		var_0_8[iter_4_1] = true
	end
end

function var_0_0.GetBossUICfgByBossType(arg_5_0, arg_5_1)
	local var_5_0 = var_0_1[var_0_3][arg_5_1][1]
	local var_5_1 = CoreVerificationInfoCfg[var_5_0].stage_id

	return BossChallengeUICfg[var_5_1] or BossChallengeUICfg[3090009]
end

function var_0_0.GetRecommendByBossType(arg_6_0, arg_6_1)
	local var_6_0 = var_0_1[var_0_3][arg_6_1][1]

	return CoreVerificationInfoCfg[var_6_0].recommend
end

function var_0_0.GetLockHeroByBossType(arg_7_0, arg_7_1)
	return var_0_7[arg_7_1]
end

function var_0_0.GetDiffListByBossType(arg_8_0, arg_8_1)
	return var_0_1[var_0_3][arg_8_1]
end

function var_0_0.GetLockHeroByInfoID(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = CoreVerificationInfoCfg[arg_9_1].boss_type

	if arg_9_2 then
		return var_0_7[var_9_0]
	elseif var_9_0 == 1 then
		return var_0_7[2]
	elseif var_9_0 == 2 then
		return var_0_7[1]
	end

	return var_0_7[1]
end

function var_0_0.GetMaxPassByBossType(arg_10_0, arg_10_1)
	local var_10_0 = var_0_9[arg_10_1] > 0
	local var_10_1 = var_0_9[arg_10_1] > 0 and var_0_9[arg_10_1] or 1
	local var_10_2 = var_0_1[var_0_3][arg_10_1][var_10_1]
	local var_10_3 = var_10_0 and var_0_6[var_10_2].passTime or 0

	return var_10_0, var_10_1, var_10_3
end

function var_0_0.GetMaxUnlockByBossType(arg_11_0, arg_11_1)
	local var_11_0 = 1
	local var_11_1 = PlayerData:GetPlayerInfo().userLevel

	for iter_11_0, iter_11_1 in ipairs(var_0_1[var_0_3][arg_11_1]) do
		if var_0_6[iter_11_1 - 1] and var_11_1 >= CoreVerificationInfoCfg[iter_11_1].unlock_level then
			var_11_0 = iter_11_0
		end
	end

	return var_11_0
end

function var_0_0.GetStageInfoByTypeAndDiff(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_1[var_0_3][arg_12_1][arg_12_2]

	return var_0_6[var_12_0]
end

function var_0_0.GetInfoCfgByTypeAndDiff(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = var_0_1[var_0_3][arg_13_1][arg_13_2]

	return CoreVerificationInfoCfg[var_13_0]
end

function var_0_0.GetAffixByTypeAndDiff(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = var_0_1[var_0_3][arg_14_1][arg_14_2]

	return CoreVerificationInfoCfg[var_14_0].affix_type
end

function var_0_0.GetRewardListByType(arg_15_0, arg_15_1)
	if arg_15_1 == 1 or arg_15_1 == 2 then
		return var_0_2[arg_15_1][var_0_3]
	else
		return var_0_2[arg_15_1]
	end
end

function var_0_0.CheckFirstReward(arg_16_0)
	local var_16_0 = var_0_2[4]

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if not var_0_8[iter_16_1] then
			return "true"
		end
	end

	return "false"
end

function var_0_0.GetCurCycleInfo(arg_17_0)
	return var_0_1[var_0_3]
end

function var_0_0.GetPreviewInfo(arg_18_0)
	return var_0_1[var_0_4]
end

function var_0_0.GetRefreshTime(arg_19_0)
	return var_0_5
end

function var_0_0.GetTaskProcess(arg_20_0, arg_20_1)
	local var_20_0 = CoreVerificationRewardCfg[arg_20_1].condition
	local var_20_1 = ConditionCfg[var_20_0]
	local var_20_2 = 0

	if var_20_1.type == 11300 then
		local var_20_3 = var_20_1.params[1]

		var_20_2 = var_20_1.params[2] <= var_0_9[var_20_3] and 1 or 0
	elseif var_20_1.type == 11302 then
		local var_20_4 = var_20_1.params[1]

		var_20_2 = var_20_4 <= var_0_9[1] and var_20_4 <= var_0_9[2] and 1 or 0
	elseif var_20_1.type == 11301 then
		local var_20_5 = var_20_1.params[1]
		local var_20_6 = var_0_1[var_0_3][1][var_20_5]
		local var_20_7 = var_0_1[var_0_3][2][var_20_5]

		var_20_2 = var_0_6[var_20_6] and var_0_6[var_20_7] and 1 or 0
	elseif var_20_1.type == 11303 then
		local var_20_8 = var_20_1.params[1]
		local var_20_9 = var_20_1.params[2]
		local var_20_10 = var_0_1[var_0_3][var_20_8][var_20_9]

		var_20_2 = var_0_6[var_20_10] and 1 or 0
	end

	return var_20_2, var_20_1.progress_show, var_20_2 == 1, var_0_8[arg_20_1] or false
end

function var_0_0.IsStageProcess(arg_21_0)
	return var_0_9[1] > 0 or var_0_9[2] > 0
end

local var_0_10

function var_0_0.SetUpdateCycleCallBack(arg_22_0)
	function var_0_10()
		ShowTips("STAGE_REFRESH_DATA")
		JumpTools.GoToSystem("/coreVerificationMain", nil, ViewConst.SYSTEM_ID.CORE_VERIFICATION)
	end
end

function var_0_0.InvokeUpdateCycleCallBack(arg_24_0)
	if var_0_10 then
		var_0_10()

		var_0_10 = nil
	end
end

return var_0_0
