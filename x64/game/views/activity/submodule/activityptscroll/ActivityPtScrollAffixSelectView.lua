local var_0_0 = class("ActivityPtScrollAffixSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/SuitSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.tgl_ = {}
	arg_5_0.tglCon_ = {}
	arg_5_0.todayCon_ = {}

	for iter_5_0 = 1, 7 do
		local var_5_0 = Object.Instantiate(arg_5_0.tempBtn_.gameObject, arg_5_0.contentGo_.transform)

		var_5_0.transform:Find("text").gameObject:GetComponent("Text").text = GetTips("ACTIVITY_ROULETTE_WEEK_" .. iter_5_0)
		var_5_0.name = "tgl_" .. iter_5_0

		SetActive(var_5_0, true)

		arg_5_0.tgl_[iter_5_0] = var_5_0.transform:GetComponent("Toggle")
		arg_5_0.tglCon_[iter_5_0] = ControllerUtil.GetController(arg_5_0.tgl_[iter_5_0].transform, "toggle")
		arg_5_0.todayCon_[iter_5_0] = ControllerUtil.GetController(arg_5_0.tgl_[iter_5_0].transform, "isToday")
	end

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.itempanelGo_, SuitSelectItem)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.curSuitList_[arg_6_1]

	arg_6_2:ShowSelect(var_6_0 == arg_6_0.selectSuitId_)
	arg_6_2:ShowCurrentUp(var_6_0 == arg_6_0.upID_ and arg_6_0.selectDay_ == arg_6_0.nowDay_)
	arg_6_2:RefreshData(arg_6_0, {
		id = var_6_0
	})
	arg_6_2:RegistCallBack(function(arg_7_0)
		arg_6_0:SetSelect(arg_7_0)
	end)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgMaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_8_0:AddBtnListenerScale(arg_8_0.upBtn_, nil, function()
		ActivityPtScrollAction.SetSelectSuit(arg_8_0.activityID_, arg_8_0.selectSuitId_)
	end)
	arg_8_0:AddBtnListener(arg_8_0.selectBtn_, nil, function()
		if arg_8_0.buttonUp_ and arg_8_0.buttonUp_ > 0 then
			arg_8_0:HidePop()
			FuncTimerManager.inst:RemoveFuncTimer(arg_8_0.clickTimer_)

			arg_8_0.clickTimer_ = nil

			return
		end

		SetActive(arg_8_0.contentGo_, true)
		arg_8_0:AddClickTimer()
	end)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tgl_) do
		arg_8_0:AddToggleListener(iter_8_1, function(arg_12_0)
			if arg_12_0 then
				arg_8_0:RefreshDay(iter_8_0)
			end
		end)
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.scrollList_ = {}
	arg_13_0.activityID_ = arg_13_0.params_.mainActivityID

	local var_13_0 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_13_0.activityID_]

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if ActivityPtRouletteStageCfg[iter_13_1].mode == 2 then
			arg_13_0.scrollList_ = ActivityPtRouletteStageCfg[iter_13_1].roulette_id

			break
		end
	end

	arg_13_0.isSelect_, arg_13_0.upID_ = ActivityPtScrollData:GetUpSelect(arg_13_0.activityID_)

	local var_13_1 = ActivityPtScrollData:GetPoolID(arg_13_0.activityID_)

	arg_13_0.nowDay_ = ActivityPtRouletteRandomCfg[var_13_1].time

	arg_13_0:RefreshDay(arg_13_0.nowDay_)
	arg_13_0:ResetSort()

	local var_13_2 = manager.time:GetServerTime()

	saveData("activityPtScroll", "last_check_up", var_13_2)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_13_0.activityID_, 0)
end

function var_0_0.RefreshDay(arg_14_0, arg_14_1)
	arg_14_0.selectDay_ = arg_14_1
	arg_14_0.selectText_.text = GetTips("ACTIVITY_ROULETTE_WEEK_" .. arg_14_0.selectDay_)

	arg_14_0:RefreshList()
	arg_14_0:RefreshInfo()
end

function var_0_0.ResetSort(arg_15_0)
	arg_15_0.tgl_[arg_15_0.selectDay_].isOn = true

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.tglCon_) do
		iter_15_1:SetSelectedState(iter_15_0 == arg_15_0.selectDay_ and "on" or "off")
		arg_15_0.todayCon_[iter_15_0]:SetSelectedState(iter_15_0 == arg_15_0.selectDay_ and "true" or "false")
	end
end

function var_0_0.RefreshList(arg_16_0)
	arg_16_0.curSuitList_ = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.scrollList_) do
		local var_16_0 = ActivityPtRouletteRandomCfg[iter_16_1]

		if var_16_0.time == arg_16_0.selectDay_ then
			arg_16_0.curSuitList_ = var_16_0.equip_suit_list

			break
		end
	end

	arg_16_0.selectSuitId_ = arg_16_0.selectDay_ == arg_16_0.nowDay_ and arg_16_0.upID_ or arg_16_0.curSuitList_[1]

	arg_16_0.scrollHelper_:StartScroll(#arg_16_0.curSuitList_)
end

function var_0_0.RefreshInfo(arg_17_0)
	local var_17_0 = EquipSuitCfg[arg_17_0.selectSuitId_]

	if not var_17_0 then
		SetActive(arg_17_0.infoGo_, false)

		return
	end

	SetActive(arg_17_0.infoGo_, true)

	arg_17_0.nameText_.text = var_17_0.name
	arg_17_0.numText_.text = var_17_0.need
	arg_17_0.contentText_.text = EquipTools.GetEffectDesc(var_17_0.suit_effect[1])

	SetActive(arg_17_0.upBtn_.gameObject, arg_17_0.selectSuitId_ ~= arg_17_0.upID_ and arg_17_0.selectDay_ == arg_17_0.nowDay_)
	SetActive(arg_17_0.tipGo_, arg_17_0.selectDay_ ~= arg_17_0.nowDay_)
end

function var_0_0.SetSelect(arg_18_0, arg_18_1)
	arg_18_0.selectSuitId_ = arg_18_1.id

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.scrollHelper_:GetItemList()) do
		iter_18_1:ShowSelect(iter_18_1.info_.id == arg_18_0.selectSuitId_)
	end

	arg_18_0:RefreshInfo()
end

function var_0_0.AddClickTimer(arg_19_0)
	arg_19_0:StopTimer()

	arg_19_0.buttonUp_ = 0
	arg_19_0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			arg_19_0.buttonUp_ = arg_19_0.buttonUp_ + 1

			if arg_19_0.buttonUp_ >= 2 then
				arg_19_0:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(arg_19_0.clickTimer_)

				arg_19_0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_21_0.clickTimer_)

		arg_21_0.clickTimer_ = nil
	end
end

function var_0_0.HidePop(arg_22_0)
	arg_22_0.buttonUp_ = 0

	SetActive(arg_22_0.contentGo_, false)
end

function var_0_0.OnSetSelectSuit(arg_23_0)
	arg_23_0.isSelect_, arg_23_0.upID_ = ActivityPtScrollData:GetUpSelect(arg_23_0.activityID_)

	arg_23_0:RefreshDay(arg_23_0.nowDay_)
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0.selectSuitId_ = nil
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
