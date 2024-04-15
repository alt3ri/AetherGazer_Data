local var_0_0 = {}

manager.net:Bind(65201, function(arg_1_0)
	DormLinkGameData:InitLevelInfo(arg_1_0)
end)

function var_0_0.ClearanceLevel(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0, var_2_1 = DormLinkGameTools:ChecklevelUnLock(arg_2_1)

	if var_2_0 then
		local var_2_2 = DormLinkGameData:GetLastPoint()
		local var_2_3 = arg_2_2.gameTime
		local var_2_4 = {}

		if arg_2_2.useItemList then
			for iter_2_0, iter_2_1 in pairs(arg_2_2.useItemList) do
				local var_2_5 = {
					id = iter_2_0,
					num = iter_2_1
				}

				table.insert(var_2_4, var_2_5)
			end
		end

		manager.net:SendWithLoadingNew(65210, {
			id = arg_2_1,
			point = var_2_2,
			remain_time = var_2_3,
			item_list = var_2_4
		}, 65211, var_0_0.ClearanceLevelCallBack)
	else
		if var_2_1 == DormLinkGameConst.LevelLockType.stop then
			ShowTips("TIME_OVER")
		end

		DormLinkGameData:FailedClear()
	end
end

function var_0_0.ClearanceLevelCallBack(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		DormLinkGameData:SuccessClear(arg_3_1)
	else
		print("结算失败")
	end
end

function var_0_0.GetLevelAward(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(65212, {
		reward_id = arg_4_1
	}, 65213, var_0_0.GetLevelAwardCallBack)
end

function var_0_0.GetLevelAwardCallBack(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		if ActivityLinkGameRewardCfg[arg_5_1.reward_id] then
			DormLinkGameData:SetRewardInfo(arg_5_1.reward_id, true)

			local var_5_0 = arg_5_0.reward_list
			local var_5_1 = mergeReward2(var_5_0)
			local var_5_2 = {}

			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				if ItemCfg[iter_5_1.id].use == 2 then
					table.insert(var_5_2, {
						item_info = {
							id = iter_5_1.id,
							num = iter_5_1.num
						},
						use_list = {}
					})
				end
			end

			getReward2(var_5_1, nil, function()
				CommonAction.TryToUseItem(var_5_2)
			end, true)
			manager.notify:Invoke(DORM_LINK_REFRESH_LEVEL_AWARD, arg_5_1.reward_id)
		end
	else
		print("领取关卡奖励失败")
	end
end

return var_0_0
