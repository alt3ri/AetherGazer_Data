local var_0_0 = class("SuitSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/EquipSelectPopUI"
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

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.suitListGo_, SuitSelectItem)
	arg_4_0.stateController_ = arg_4_0.controller:GetController("state")
end

function var_0_0.UpdateData(arg_5_0)
	arg_5_0.suitList_ = {}

	local var_5_0 = HideInfoData:GetEquipSuitHideList()
	local var_5_1 = {}
	local var_5_2 = arg_5_0.select_
	local var_5_3 = table.length(EquipSuitCfg.get_id_list_by_equip_type)

	if arg_5_0.select_ == 0 then
		var_5_2 = var_5_3
	elseif arg_5_0.select_ == var_5_3 then
		var_5_2 = 0
	end

	if var_5_2 < var_5_3 then
		var_5_1 = EquipSuitCfg.get_id_list_by_equip_type[var_5_2]
	else
		var_5_1 = EquipSuitCfg.get_id_list_by_suit
	end

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_4 = iter_5_1

		if type(iter_5_1) == "table" then
			var_5_4 = iter_5_1[1]
		end

		if EquipSuitCfg[var_5_4].stage_up_list == 1 and not var_5_0[var_5_4] then
			table.insert(arg_5_0.suitList_, var_5_4)
		end
	end
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.suitList_[arg_6_1]

	if var_6_0 == arg_6_0.selectSuitId_ then
		arg_6_2:ShowSelect(true)
	else
		arg_6_2:ShowSelect(false)
	end

	if var_6_0 == arg_6_0.params_.currentSuitId then
		arg_6_2:ShowCurrentUp(true)
	else
		arg_6_2:ShowCurrentUp(false)
	end

	arg_6_2:RefreshData(arg_6_0, {
		id = var_6_0
	})
	arg_6_2:RegistCallBack(function(arg_7_0)
		arg_6_0:SelectSuitItem(arg_7_0)
	end)
end

function var_0_0.SelectSuitItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.scrollHelper_:GetItemList()
	local var_8_1 = table.indexof(arg_8_0.suitList_, arg_8_1.id)
	local var_8_2 = table.indexof(arg_8_0.suitList_, arg_8_0.selectSuitId_)

	if var_8_0[var_8_2] then
		var_8_0[var_8_2]:ShowSelect(false)
	end

	arg_8_0.selectSuitId_ = arg_8_1.id

	if arg_8_0.params_.hideBtn then
		arg_8_0.stateController_:SetSelectedState("hide")
	else
		arg_8_0.stateController_:SetSelectedState(arg_8_0.choosedId_ ~= arg_8_0.selectSuitId_ and "confirm" or "select")
	end

	var_8_0[var_8_1]:ShowSelect(true)
	arg_8_0:RefreshSelectSuitInfo()
end

function var_0_0.RefreshSelectSuitInfo(arg_9_0)
	local var_9_0 = EquipSuitCfg[arg_9_0.selectSuitId_]

	if not var_9_0 then
		SetActive(arg_9_0.infoGo_, false)

		return
	end

	SetActive(arg_9_0.infoGo_, true)

	arg_9_0.name_.text = GetI18NText(var_9_0.name)
	arg_9_0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), var_9_0.need)
	arg_9_0.desc_.text = GetI18NText(EquipTools.GetEffectDesc(var_9_0.suit_effect[1]))
	arg_9_0.scrollView_.verticalNormalizedPosition = 1
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.btnBgMask_, nil, function()
		JumpTools.Back()
	end)
	arg_10_0:AddBtnListenerScale(arg_10_0.btnConfirm_, nil, function()
		if arg_10_0.selectSuitId_ == nil then
			return
		end

		BattleEquipAction.ChangeUpSuit(arg_10_0.selectSuitId_)
		SDKTools.SendMessageToSDK("equip_target_changed", {
			equip_id_old = arg_10_0.params_.currentSuitId,
			equip_id_new = arg_10_0.selectSuitId_
		})
	end)
	arg_10_0:AddToggleListener(arg_10_0.dropDown_, function(arg_13_0)
		arg_10_0.select_ = arg_13_0

		arg_10_0:RefreshUI()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.selectSuitId_ = arg_14_0.params_.suitId
	arg_14_0.choosedId_ = arg_14_0.params_.suitId
	arg_14_0.select_ = 0
	arg_14_0.dropDown_.value = 0

	arg_14_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:UpdateData()

	local var_15_0 = false

	if arg_15_0.selectSuitId_ then
		var_15_0 = table.indexof(arg_15_0.suitList_, arg_15_0.selectSuitId_)

		if not var_15_0 then
			var_15_0 = 1
			arg_15_0.selectSuitId_ = arg_15_0.suitList_[1]
		end
	else
		var_15_0 = 1
		arg_15_0.selectSuitId_ = arg_15_0.suitList_[1]
	end

	if arg_15_0.params_.hideBtn then
		arg_15_0.stateController_:SetSelectedState("hide")
	else
		arg_15_0.stateController_:SetSelectedState(arg_15_0.choosedId_ ~= arg_15_0.selectSuitId_ and "confirm" or "select")
	end

	local var_15_1 = 5
	local var_15_2 = var_15_0 - var_15_1 < 1 and 1 or var_15_0 - var_15_1

	arg_15_0.scrollHelper_:StartScroll(#arg_15_0.suitList_, var_15_2)
	arg_15_0:RefreshSelectSuitInfo()
end

function var_0_0.OnChangeUpSuit(arg_16_0, arg_16_1, arg_16_2)
	if isSuccess(arg_16_1.result) then
		JumpTools.Back()
	end
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0.selectSuitId_ = nil
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
