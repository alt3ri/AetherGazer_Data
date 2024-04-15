local var_0_0 = class("BattleSettlemenMultiResultModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_0:InstView(arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.InstView(arg_2_0, arg_2_1)
	local var_2_0 = "Widget/System/BattleResult/Common/Module/BattleMultipleResultContent"

	return (Object.Instantiate(Asset.Load(var_2_0), arg_2_1))
end

function var_0_0.BuildContext(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()

	arg_4_0.scrollHelper = LuaList.New(handler(arg_4_0, arg_4_0.RenderItem), arg_4_0.rewardsListObj_, BattleSettlementMultiResultItem)
	arg_4_0.scrollRect = arg_4_0.rewardsListObj_:GetComponent(typeof(ScrollRectEx))
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.RenderView(arg_7_0, arg_7_1)
	arg_7_0.stageData = arg_7_1.stageData
	arg_7_0.rewardList = arg_7_1.rewardList
	arg_7_0.multiple = arg_7_1.rewardTimes

	arg_7_0.scrollHelper:StartScroll(arg_7_0.multiple or 0)
end

function var_0_0.RenderItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.rewardList[arg_8_1]

	arg_8_2:TryInitScroll(arg_8_0.scrollRect)
	arg_8_2:RenderView(arg_8_1, clone(var_8_0))
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.scrollHelper:Dispose()

	arg_9_0.scrollRect = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
