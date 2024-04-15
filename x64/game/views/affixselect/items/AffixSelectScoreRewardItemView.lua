local var_0_0 = class("AffisSelectScoreRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateBtnController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "stateBtn")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.m_list, CommonItem)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshData({
		id = arg_4_0.cfg_.reward_item_list[arg_4_1][1],
		number = arg_4_0.cfg_.reward_item_list[arg_4_1][2]
	})
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id
		})
	end)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_receiveBtn, nil, function()
		ActivityAction.ReceivePointReward({
			arg_6_0.rewardId_
		})
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.index_ = arg_9_1
	arg_9_0.rewardId_ = arg_9_2
	arg_9_0.cfg_ = ActivityPointRewardCfg[arg_9_2]
	arg_9_0.activityId = arg_9_3

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.m_pointLab.text = arg_10_0.cfg_.need

	arg_10_0.uiList_:StartScroll(#arg_10_0.cfg_.reward_item_list)

	local var_10_0 = ActivityAffixSelectData:GetRewardStatus(arg_10_0.activityId, arg_10_0.rewardId_)

	if var_10_0 == 0 then
		arg_10_0.stateBtnController_:SetSelectedState("rewarded")
	elseif var_10_0 == 1 then
		arg_10_0.stateBtnController_:SetSelectedState("unfinished")
	else
		arg_10_0.stateBtnController_:SetSelectedState("complete")
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.data_ = nil

	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
