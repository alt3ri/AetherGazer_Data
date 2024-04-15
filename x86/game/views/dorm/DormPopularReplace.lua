local var_0_0 = class("DormPopularReplace", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HouseUI/HousetwoeventUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.item1 = PopularEventItem.New(arg_4_0.commonitemGo_1)
	arg_4_0.item2 = PopularEventItem.New(arg_4_0.commonitemGo_2)
	arg_4_0.item3 = PopularEventItem.New(arg_4_0.commonitemGo_3)
	arg_4_0.item4 = PopularEventItem.New(arg_4_0.commonitemGo_4)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.surebtnBtn_, nil, function()
		local var_6_0 = DormData:GetCurPopularEvent().id

		if var_6_0 ~= 0 then
			ShowMessageBox({
				content = string.format(GetTips("DORM_POPULAR_EVENT_OPEN"), ItemTools.getItemName(var_6_0), ItemTools.getItemName(var_6_0)),
				OkCallback = function()
					DormAction.SolveOverPopularEvent(arg_5_0.popPopularItem_, arg_5_0.itemList_[arg_5_0.selectItem_].id, 2)
				end
			})
		else
			DormAction.SolveOverPopularEvent(arg_5_0.popPopularItem_, arg_5_0.itemList_[arg_5_0.selectItem_].id, 2)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.clearbtnBtn_, nil, function()
		DormAction.SolveOverPopularEvent(arg_5_0.popPopularItem_, arg_5_0.itemList_[arg_5_0.selectItem_].id, 1)
	end)
end

function var_0_0.OnSolveOverPopularEvent(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.itemList_[arg_9_0.selectItem_].id

	if var_9_0 ~= arg_9_0.popPopularItem_ then
		if arg_9_2.oper == 1 then
			DormData:DeletePopularEvents(var_9_0)
			DormData:AddPopularEvent(arg_9_0.popPopularItem_)
		elseif arg_9_2.oper == 2 then
			DormData:DeletePopularEvents(var_9_0)
			DormData:SetCurPopularEvent({
				id = var_9_0,
				start = manager.time:GetServerTime()
			})
			DormData:AddPopularEvent(arg_9_0.popPopularItem_)
		end
	elseif arg_9_2.oper == 2 then
		DormData:SetCurPopularEvent({
			id = var_9_0,
			start = manager.time:GetServerTime()
		})
	end

	arg_9_0:Back()
end

function var_0_0.RefreshPopularCountdown(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end

	local var_10_0 = DormData:GetCurPopularEvent().start
	local var_10_1 = manager.time:GetHourInType(GameSetting.dorm_special_event_continue.value[1], 2)
	local var_10_2 = var_10_0 + var_10_1 - manager.time:GetServerTime()

	arg_10_0.countdownText_.text = TimeMgr:DescCDTime(var_10_2)
	arg_10_0.timer_ = Timer.New(function()
		local var_11_0 = var_10_0 + var_10_1 - manager.time:GetServerTime()

		arg_10_0.countdownText_.text = TimeMgr:DescCDTime(var_11_0)

		if var_11_0 <= 0 then
			arg_10_0.timer_:Stop()

			arg_10_0.timer_ = nil
		end
	end, 0.5, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.popPopularItem_ = arg_12_0.params_.popularID
	arg_12_0.selectItem_ = 1

	arg_12_0:RefreshItemS()
	arg_12_0:RefreshContent()

	if DormData:GetCurPopularEvent().id ~= 0 then
		SetActive(arg_12_0.eventGo_, true)
		arg_12_0:RefreshPopularCountdown()
	else
		SetActive(arg_12_0.eventGo_, false)
	end
end

function var_0_0.RefreshItemS(arg_13_0)
	arg_13_0.itemList_ = {}
	arg_13_0.itemList_[1] = {
		num = 1,
		id = arg_13_0.popPopularItem_
	}

	local var_13_0 = DormData:GetPopularEvents()
	local var_13_1 = 2

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1 >= 2 then
			for iter_13_2 = 1, iter_13_1 do
				arg_13_0.itemList_[var_13_1] = {
					num = 1,
					id = iter_13_0
				}
				var_13_1 = var_13_1 + 1
			end
		else
			arg_13_0.itemList_[var_13_1] = {
				num = 1,
				id = iter_13_0
			}
			var_13_1 = var_13_1 + 1
		end
	end

	for iter_13_3, iter_13_4 in ipairs(arg_13_0.itemList_) do
		local var_13_2 = arg_13_0["item" .. iter_13_3]

		var_13_2:RefreshData({
			id = iter_13_4.id,
			number = iter_13_4.num
		})
		var_13_2:ShowSelect(arg_13_0.selectItem_ == iter_13_3)
		var_13_2:RegistCallBack(function(arg_14_0)
			arg_13_0.selectItem_ = iter_13_3

			arg_13_0:RefreshItemS()
			arg_13_0:RefreshContent()
		end)
	end
end

function var_0_0.RefreshContent(arg_15_0)
	local var_15_0 = arg_15_0.itemList_[arg_15_0.selectItem_].id

	arg_15_0.descText_.text = ItemTools.getItemDesc(var_15_0)
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.item1:Dispose()
	arg_17_0.item2:Dispose()
	arg_17_0.item3:Dispose()
	arg_17_0.item4:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
