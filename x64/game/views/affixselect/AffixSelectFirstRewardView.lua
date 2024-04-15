local var_0_0 = class("AffixSelectFirstRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillFirstRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, AffixSelectFirstRewardItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.idList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(AFFIX_SELECT_FIRST_BONUS_UPDATE, function()
		arg_9_0:UpdateList()
	end)
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.OnBehind(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.activityId = arg_14_0.params_.affixActivityId

	arg_14_0:AddEventListeners()
	arg_14_0:UpdateList()
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateList(arg_16_0)
	arg_16_0.idList_ = deepClone(ActivityCfg[arg_16_0.activityId].sub_activity_list)

	table.sort(arg_16_0.idList_, function(arg_17_0, arg_17_1)
		local var_17_0 = ActivityAffixSelectData:GetSubActivityData(arg_17_0) or {
			clearState = 1
		}
		local var_17_1 = ActivityAffixSelectData:GetSubActivityData(arg_17_1) or {
			clearState = 1
		}

		if var_17_0.clearState ~= var_17_1.clearState then
			return var_17_0.clearState % 3 > var_17_1.clearState % 3
		end

		return arg_17_0 < arg_17_1
	end)
	arg_16_0.uiList_:StartScroll(#arg_16_0.idList_)
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.uiList_ then
		arg_19_0.uiList_:Dispose()

		arg_19_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
