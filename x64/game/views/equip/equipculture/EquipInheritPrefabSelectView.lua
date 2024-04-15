local var_0_0 = class("EquipInheritPrefabSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/EquipSelectPopUI"
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

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.suitListGo_, SuitSelectItem)
	arg_5_0.stateController_ = arg_5_0.controller:GetController("state")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnBgMask_, nil, function()
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.btnConfirm_, nil, function()
		if arg_6_0.selectSuitId_ == nil then
			JumpTools.Back()

			return
		end

		if arg_6_0.selectHandler_ ~= nil then
			arg_6_0.selectHandler_(arg_6_0.selectSuitId_)
		end

		JumpTools.Back()
	end)
	arg_6_0:AddToggleListener(arg_6_0.dropDown_, function(arg_9_0)
		arg_6_0.select_ = arg_9_0

		arg_6_0:RefreshUI()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.selectSuitId_ = arg_10_0.params_.suitId
	arg_10_0.choosedId_ = arg_10_0.params_.suitId
	arg_10_0.selectHandler_ = arg_10_0.params_.selectSuitHandler
	arg_10_0.equipTypeCfg_ = EquipSuitCfg.get_id_list_by_equip_type
	arg_10_0.select_ = arg_10_0.select_ or 0

	arg_10_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:UpdateData()

	local var_11_0 = table.indexof(arg_11_0.suitList_, arg_11_0.selectSuitId_)

	if not var_11_0 then
		var_11_0 = 1
		arg_11_0.selectSuitId_ = arg_11_0.suitList_[1]
	end

	arg_11_0.stateController_:SetSelectedState(arg_11_0.choosedId_ ~= arg_11_0.selectSuitId_ and "confirm" or "select")

	local var_11_1 = 6
	local var_11_2 = var_11_0 - var_11_1 < 1 and 1 or var_11_0 - var_11_1

	arg_11_0.scrollHelper_:StartScroll(#arg_11_0.suitList_, var_11_2)
	arg_11_0:RefreshSelectSuitInfo()
end

function var_0_0.UpdateData(arg_12_0)
	arg_12_0.suitList_ = {}

	local var_12_0 = HideInfoData:GetEquipSuitHideList()
	local var_12_1 = arg_12_0.select_ ~= 0 and arg_12_0.equipTypeCfg_[arg_12_0.select_ - 1] or EquipSuitCfg.all
	local var_12_2 = EquipData:GetEquipData(arg_12_0.params_.equipID)
	local var_12_3 = EquipCfg[var_12_2.prefab_id].suit

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		if not var_12_0[iter_12_1] and iter_12_1 ~= var_12_3 and EquipSuitCfg[iter_12_1].inherit_cost_type ~= 0 then
			table.insert(arg_12_0.suitList_, iter_12_1)
		end
	end
end

function var_0_0.RefreshSelectSuitInfo(arg_13_0)
	local var_13_0 = EquipSuitCfg[arg_13_0.selectSuitId_]

	if not var_13_0 then
		SetActive(arg_13_0.infoGo_, false)

		return
	end

	arg_13_0.name_.text = GetI18NText(var_13_0.name)
	arg_13_0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), var_13_0.need)
	arg_13_0.desc_.text = GetI18NText(EquipTools.GetEffectDesc(var_13_0.suit_effect[1]))

	SetActive(arg_13_0.infoGo_, true)
end

function var_0_0.indexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.suitList_[arg_14_1]

	arg_14_2:ShowSelect(var_14_0 == arg_14_0.selectSuitId_)
	arg_14_2:ShowCurrentUp(var_14_0 == arg_14_0.params_.currentSuitId)
	arg_14_2:RefreshData(arg_14_0, {
		id = var_14_0
	})
	arg_14_2:RegistCallBack(function(arg_15_0)
		arg_14_0:SelectSuitItem(arg_15_0)
	end)
end

function var_0_0.SelectSuitItem(arg_16_0, arg_16_1)
	local var_16_0 = table.indexof(arg_16_0.suitList_, arg_16_1.id)
	local var_16_1 = table.indexof(arg_16_0.suitList_, arg_16_0.selectSuitId_)
	local var_16_2 = arg_16_0.scrollHelper_:GetItemByIndex(var_16_0)
	local var_16_3 = arg_16_0.scrollHelper_:GetItemByIndex(var_16_1)

	if var_16_3 then
		var_16_3:ShowSelect(false)
	end

	var_16_2:ShowSelect(true)

	arg_16_0.selectSuitId_ = arg_16_1.id

	arg_16_0.stateController_:SetSelectedState(arg_16_0.choosedId_ ~= arg_16_0.selectSuitId_ and "confirm" or "select")
	arg_16_0:RefreshSelectSuitInfo()
end

function var_0_0.OnChangeUpSuit(arg_17_0, arg_17_1, arg_17_2)
	if isSuccess(arg_17_1.result) then
		JumpTools.Back()
	end
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0.selectSuitId_ = nil
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
