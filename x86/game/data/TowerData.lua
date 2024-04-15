local var_0_0 = singletonClass("TowerData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitTowerData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = iter_2_1.area
		local var_2_1 = iter_2_1.stage

		var_0_1[var_2_0] = var_2_1
	end
end

function var_0_0.UpdateOverTower(arg_3_0, arg_3_1, arg_3_2)
	if not var_0_1[arg_3_1] then
		var_0_1[arg_3_1] = arg_3_2
	else
		var_0_1[arg_3_1] = Mathf.Max(var_0_1[arg_3_1], arg_3_2)
	end
end

function var_0_0.GetCurId(arg_4_0, arg_4_1)
	local var_4_0 = ChapterCfg[arg_4_1].section_id_list
	local var_4_1 = var_0_1[arg_4_1]

	return var_4_0[(var_4_1 and table.indexof(var_4_0, var_4_1) or 0) + 1]
end

function var_0_0.GetOverId(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1] or 0
end

function var_0_0.GetTowerList(arg_6_0, arg_6_1)
	return ChapterCfg[arg_6_1].section_id_list
end

function var_0_0.GetTowerMaxId(arg_7_0)
	local var_7_0 = 0

	if var_0_1 then
		for iter_7_0, iter_7_1 in pairs(var_0_1) do
			var_7_0 = var_7_0 < iter_7_1 and iter_7_1 or var_7_0
		end
	end

	return var_7_0
end

function var_0_0.CheckIsOverStage(arg_8_0, arg_8_1, arg_8_2)
	if var_0_1[arg_8_1] and arg_8_2 <= var_0_1[arg_8_1] then
		return true
	end

	return false
end

function var_0_0.ReverseTable(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0 = 1, #arg_9_1 do
		var_9_0[iter_9_0] = arg_9_1[#arg_9_1 + 1 - iter_9_0]
	end

	return var_9_0
end

function var_0_0.GetAllTowerList(arg_10_0)
	return BattleTowerStageCfg.all
end

function var_0_0.CacheTowerStageViewScrollPos(arg_11_0, arg_11_1)
	arg_11_0.towerStageViewScrollPos_ = arg_11_1
end

function var_0_0.GetTowerStageViewScrollPos(arg_12_0)
	return arg_12_0.towerStageViewScrollPos_
end

return var_0_0
