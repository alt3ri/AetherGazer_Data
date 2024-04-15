local var_0_0 = class("CustomBox", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.ListGo_, CustomItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(arg_4_0.customList_[arg_4_1], arg_4_0.customList_[arg_4_1] == arg_4_0.selectID_)
	arg_4_2:RegisterClickListener(arg_4_0.clickFunc_)
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.customIndex_ = arg_7_1
	arg_7_0.customList_ = arg_7_2
	arg_7_0.selectID_ = arg_7_3

	arg_7_0.scrollHelper_:StartScroll(#arg_7_0.customList_)

	arg_7_0.customText_.text = GetI18NText(AffixTypeCfg[arg_7_0.customIndex_].name)
end

function var_0_0.RegisterClickListener(arg_8_0, arg_8_1)
	arg_8_0.clickFunc_ = arg_8_1
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
