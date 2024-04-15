local var_0_0 = {}

manager.net:Bind(16015, function(arg_1_0)
	DrawData:InitPool(arg_1_0)
end)

function var_0_0.GoToDraw(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {
		id = arg_2_2,
		num = arg_2_3
	}

	manager.net:SendWithLoadingNew(16010, {
		type = arg_2_1,
		pool = arg_2_0,
		cost = var_2_0
	}, 16011, var_0_0.OnGoToDraw)
end

function var_0_0.OnGoToDraw(arg_3_0, arg_3_1)
	if arg_3_0.result == 0 then
		local var_3_0 = 0

		if DrawConst.DRAW_TYPE.ONE == arg_3_1.type then
			local var_3_1 = 1

			SendMessageManagerToSDK("roll_complete_1")
		elseif DrawConst.DRAW_TYPE.TEN == arg_3_1.type then
			local var_3_2 = 10

			SendMessageManagerToSDK("roll_complete_10")
		end

		DrawData:UpdatePool(arg_3_1.pool, arg_3_0.ssr_draw_times, arg_3_0.first_ssr_draw_flag, arg_3_0.newbie_choose_draw_flag)
		AchievementAction.SendMessageForDrawAction(arg_3_0, arg_3_1)
	end

	DrawData:SetDrawRecord(arg_3_1.pool, nil)
	manager.notify:CallUpdateFunc(GO_TO_DRAW, arg_3_0, arg_3_1)
end

function var_0_0.RequestRecord(arg_4_0)
	manager.net:SendWithLoadingNew(16012, {
		id = arg_4_0
	}, 16013, var_0_0.OnRequestRecord)
end

function var_0_0.OnRequestRecord(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		DrawData:SetDrawRecord(arg_5_1.id, arg_5_0)
		manager.notify:CallUpdateFunc(REQUEST_RECORD, arg_5_0, arg_5_1)
	end
end

function var_0_0.SetPollUpID(arg_6_0, arg_6_1)
	arg_6_1 = DrawData:ConvertUpId(arg_6_0, arg_6_1, 0)

	manager.net:SendWithLoadingNew(16016, {
		id = arg_6_0,
		up = arg_6_1
	}, 16017, var_0_0.OnSetPollUpID)
end

function var_0_0.OnSetPollUpID(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		arg_7_1.up = DrawData:ConvertUpId(arg_7_1.id, arg_7_1.up, 1)

		DrawData:SetPollUpID(arg_7_1.id, arg_7_1.up)
		manager.notify:CallUpdateFunc(SET_POLL_UP_ID, arg_7_0, arg_7_1)
	else
		ShowTips(arg_7_0.result)
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end
end

function var_0_0.SetPollUpIDIgnoreFail(arg_8_0, arg_8_1)
	manager.net:SendWithLoadingNew(16016, {
		id = arg_8_0,
		up = arg_8_1
	}, 16017, var_0_0.JumpToPool)
end

function var_0_0.JumpToPool(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		arg_9_1.up = DrawData:ConvertUpId(arg_9_1.id, arg_9_1.up, 1)

		DrawData:SetPollUpID(arg_9_1.id, arg_9_1.up)
		manager.notify:CallUpdateFunc(SET_POLL_UP_ID, arg_9_0, arg_9_1)
		JumpTools.GoToSystem("/draw", {
			poolId = arg_9_1.id
		}, ViewConst.SYSTEM_ID.DRAW)
	end
end

function var_0_0.GetPoolData(arg_10_0)
	local var_10_0 = DrawData:GetPollUpID(arg_10_0)

	if DrawData:GetPoolData(arg_10_0) and not var_10_0 then
		JumpTools.OpenPageByJump("drawInfoPopView", {
			poolId = arg_10_0
		})

		return
	end

	manager.net:SendWithLoadingNew(16018, {
		id = arg_10_0
	}, 16019, var_0_0.OnGetPoolData)
end

function var_0_0.OnGetPoolData(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		DrawData:SetPoolData(arg_11_1.id, arg_11_0.pool_details)
		JumpTools.OpenPageByJump("drawInfoPopView", {
			poolId = arg_11_1.id
		})
	else
		ShowTips(arg_11_0.result)
	end
end

function var_0_0.HidePoolNewTag(arg_12_0, arg_12_1)
	if DrawData:GetPoolIsNew(arg_12_0) == 1 then
		manager.net:SendWithLoadingNew(16020, {
			pool_id = arg_12_0
		}, 16021, var_0_0.OnHidePoolNewTag)

		var_0_0.redPointCallback_ = arg_12_1
	end
end

function var_0_0.OnHidePoolNewTag(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		local var_13_0 = arg_13_1.pool_id

		DrawData:SetPoolIsNew(var_13_0, 0)
		var_0_0.redPointCallback_(false, var_13_0)
	end
end

return var_0_0
