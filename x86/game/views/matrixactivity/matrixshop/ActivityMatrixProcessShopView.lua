local var_0_0 = class("ActivityMatrixProcessShopView", MatrixProcessShopView)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.matrixShopList_ = LuaList.New(handler(arg_1_0, arg_1_0.indexItem), arg_1_0.m_list, ActivityMatrixProcessShopItem)
	arg_1_0.emptyController = ControllerUtil.GetController(arg_1_0.transform_, "empty")
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_sellerBtn, nil, function()
		arg_2_0:RandomDialog(1)
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_refreshBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					arg_2_0:GetSwitchItemIcon(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN),
					arg_2_0.refreshCost
				},
				(GetTips("MATRIX_SHOP_REFRESH"))
			},
			OkCallback = function()
				ActivityMatrixAction.QueryRefreshShopItem(arg_2_0.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.indexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetMatrixActivityId(arg_7_0.matrix_activity_id)
	var_0_0.super.indexItem(arg_7_0, arg_7_1, arg_7_2)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_8_0.matrix_activity_id)
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MATRIX_SURE_GET_OUT_SHOP"),
			OkCallback = function()
				if ActivityMatrixData:GetGameState(arg_8_0.matrix_activity_id) == MatrixConst.STATE_TYPE.STARTED then
					ActivityMatrixAction.QueryNextProgress(arg_8_0.matrix_activity_id)
				end

				JumpTools.OpenPageByJump("/matrixBlank/activityMatrixOrigin", {
					matrix_activity_id = arg_8_0.matrix_activity_id
				})
			end
		})
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.matrix_activity_id = arg_11_0.params_.matrix_activity_id

	var_0_0.super.OnEnter(arg_11_0)
end

function var_0_0.GetGameState(arg_12_0)
	return ActivityMatrixData:GetGameState(arg_12_0.matrix_activity_id)
end

function var_0_0.GetMatrixPhaseData(arg_13_0)
	return ActivityMatrixData:GetMatrixPhaseData(arg_13_0.matrix_activity_id)
end

function var_0_0.GetShoRefreshTimes(arg_14_0)
	return ActivityMatrixData:GetShoRefreshTimes(arg_14_0.matrix_activity_id)
end

function var_0_0.GetShopFressRefreshTimes(arg_15_0)
	return ActivityMatrixData:GetShopFressRefreshTimes(arg_15_0.matrix_activity_id)
end

function var_0_0.GetSwitchItemIcon(arg_16_0, arg_16_1)
	if arg_16_1 == 26 then
		return ActivityMatrixTools.GetCoinItem(arg_16_0.matrix_activity_id)
	end

	return arg_16_1
end

return var_0_0
