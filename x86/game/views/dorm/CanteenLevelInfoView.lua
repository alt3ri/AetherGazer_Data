local var_0_0 = class("CanteenLevelInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamCanteenDetailsPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.awardListScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexAwardItem), arg_4_0.awarduilistUilist_, CommonItem)
	arg_4_0.activiteID_ = ActivityConst.SPRING_CANTEEN
	arg_4_0.stopTime_ = ActivityData:GetActivityData(arg_4_0.activiteID_).stopTime
	arg_4_0.emptyController_ = ControllerUtil.GetController(arg_4_0.awarduilistGo_.transform, "empty")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.indexAwardItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:RefreshData({
		id = arg_7_0.awardList[arg_7_1][1],
		number = arg_7_0.awardList[arg_7_1][2]
	})
	arg_7_2:RegistCallBack(function(arg_8_0)
		ShowPopItem(POP_ITEM, {
			arg_8_0.id
		})
	end)
end

function var_0_0.UpdataView(arg_9_0)
	local var_9_0 = CanteenData:GetInfoCanteenLevel()

	arg_9_0.nowleveltextText_.text = var_9_0

	if var_9_0 == BackHomeFestivalCanteenLevel.all[#BackHomeFestivalCanteenLevel.all] then
		arg_9_0.expprogressbarSlr_.value = 0
		arg_9_0.exptextText_.text = string.format("<size=28><color=#767878>%s</color></size>", GetTips("TEXT_LEVEL_MAX"))
		arg_9_0.awardList = {}

		arg_9_0.awardListScroll_:StartScroll(#arg_9_0.awardList)
		arg_9_0.emptyController_:SetSelectedState("false")
	else
		arg_9_0.awardList = BackHomeFestivalCanteenLevel[var_9_0 + 1].gift

		local var_9_1 = CanteenData:CalculateCurLevelNum()
		local var_9_2 = BackHomeFestivalCanteenLevel[var_9_0].need

		arg_9_0.exptextText_.text = string.format("%d<size=28><color=#767878>/%d</color></size>", var_9_1, var_9_2)
		arg_9_0.expprogressbarSlr_.value = var_9_1 / var_9_2

		arg_9_0.awardListScroll_:StartScroll(#arg_9_0.awardList)
	end

	arg_9_0.popnumText_.text = CanteenData:GetPopularityNum()
	arg_9_0.poptextText_.text = GetTips("CANTEEN_HOT_DESC")

	if var_9_0 == BackHomeFestivalCanteenLevel.all[#BackHomeFestivalCanteenLevel.all] then
		arg_9_0.leveluptitleGo_:SetActive(false)
	else
		arg_9_0.leveluptitleText_.text = string.format(GetTips("CANTEEN_LEVEL_PREVIEW"), var_9_0 + 1)
	end

	arg_9_0.lasttimeText_.text = manager.time:GetLostTimeStr(arg_9_0.stopTime_)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:UpdataView()
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.awardListScroll_ then
		arg_11_0.awardListScroll_:Dispose()

		arg_11_0.awardListScroll_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
