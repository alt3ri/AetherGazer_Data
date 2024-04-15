local var_0_0 = class("PolyhedronRankSquadsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronRankpopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, PolyhedronRankSquadsItem)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroList_ = arg_7_0.params_.list

	arg_7_0:Refresh()
end

function var_0_0.Refresh(arg_8_0)
	arg_8_0.list_:StartScroll(#arg_8_0.heroList_)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.heroList_[arg_9_1], arg_9_1 == 1)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.list_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
