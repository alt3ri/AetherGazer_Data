local var_0_0 = class("LuaTree")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.treeGo_ = arg_1_1

	arg_1_0:InitUI()
	arg_1_0:AddListeners()

	if not arg_1_0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(arg_1_0)
	end

	arg_1_0.ctored_ = true
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.tree_ = arg_2_0.treeGo_:GetComponent("UITree")
end

function var_0_0.AddListeners(arg_3_0)
	if arg_3_0.tree_ ~= nil then
		arg_3_0.tree_:SetItemRenderer(handler(arg_3_0, arg_3_0.ItemRenderer))
		arg_3_0.tree_:SetGroupRenderer(handler(arg_3_0, arg_3_0.GroupRenderer))
		arg_3_0.tree_:SetGroupSelectHandler(handler(arg_3_0, arg_3_0.OnGroupSelect))
		arg_3_0.tree_:SetItemSelectHandler(handler(arg_3_0, arg_3_0.OnItemSelect))
	end
end

function var_0_0.RemoveListeners(arg_4_0)
	if arg_4_0.tree_ ~= nil then
		arg_4_0.tree_:SetItemRenderer(nil)
		arg_4_0.tree_:SetGroupRenderer(nil)
		arg_4_0.tree_:SetGroupSelectHandler(nil)
		arg_4_0.tree_:SetItemSelectHandler(nil)
	end
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	if arg_5_0.tree_ ~= nil then
		arg_5_0.tree_:SetData(arg_5_1)
	end
end

function var_0_0.SetRenderer(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.groupRenderer_ = arg_6_1
	arg_6_0.itemRenderer_ = arg_6_2
end

function var_0_0.OverrideRenderer(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:SetRenderer(arg_7_1 or arg_7_0.groupRenderer_, arg_7_2 or arg_7_0.itemRenderer_)
end

function var_0_0.SetSelectedHandler(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.itemSelectedHandler_ = arg_8_2
	arg_8_0.groupSelectHandler_ = arg_8_1
end

function var_0_0.OnItemSelect(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_0.itemSelectedHandler_ ~= nil then
		arg_9_0.itemSelectedHandler_(arg_9_1 + 1, arg_9_2, arg_9_3, arg_9_4)
	end
end

function var_0_0.OnGroupSelect(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0.groupSelectHandler_ ~= nil then
		arg_10_0.groupSelectHandler_(arg_10_1 + 1, arg_10_2, arg_10_3, arg_10_4)
	end
end

function var_0_0.ItemRenderer(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.itemRenderer_ then
		arg_11_0.itemRenderer_(arg_11_1, arg_11_2)
	end
end

function var_0_0.GroupRenderer(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.groupRenderer_ then
		arg_12_0.groupRenderer_(arg_12_1, arg_12_2)
	end
end

function var_0_0.SelectGroup(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 - 1

	arg_13_0.tree_:SelectGroup(var_13_0, false)

	local var_13_1 = arg_13_0.tree_.data.groupDatas[var_13_0]

	if arg_13_0.groupSelectHandler_ then
		arg_13_0.groupSelectHandler_(arg_13_1, var_13_1.id, var_13_1.text, var_13_1.extraData)
	end
end

function var_0_0.GetGroupGameObjectById(arg_14_0, arg_14_1)
	return arg_14_0.tree_:GetGroupGameObjectById(arg_14_1)
end

function var_0_0.SelectItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1 - 1
	local var_15_1 = arg_15_2 - 1

	arg_15_0.tree_:SelectItem(var_15_0, var_15_1)

	local var_15_2 = arg_15_0.tree_.data.groupDatas[var_15_0]

	if arg_15_0.groupSelectHandler_ then
		arg_15_0.groupSelectHandler_(arg_15_1, var_15_2.id, var_15_2.text, var_15_2.extraData)
	end

	if var_15_1 < var_15_2.itemDatas.Count then
		local var_15_3 = var_15_2.itemDatas[var_15_1]

		if arg_15_0.itemSelectedHandler_ then
			arg_15_0.itemSelectedHandler_(arg_15_2, var_15_3.id, var_15_3.text, var_15_3.extraData)
		end
	end
end

function var_0_0.GetItemGameObjectById(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_0.tree_:GetItemGameObjectById(arg_16_1, arg_16_2)
end

function var_0_0.GetGroupRedPointContainerById(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.tree_:GetGroupGameObjectById(arg_17_1)

	if var_17_0 ~= nil then
		return var_17_0:GetComponent("UITreeGroup").noticeContainer
	end

	return nil
end

function var_0_0.GetItemRedPointContainerById(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.tree_:GetItemGameObjectById(arg_18_1, arg_18_2)

	if var_18_0 ~= nil then
		return var_18_0:GetComponent("UITreeItem").noticeContainer
	end

	return nil
end

function var_0_0.Refresh(arg_19_0)
	arg_19_0.tree_:Refresh()
end

function var_0_0.GetData(arg_20_0)
	return arg_20_0.tree_.data
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:RemoveListeners()

	if arg_21_0.tree_ ~= nil then
		arg_21_0.tree_ = nil
	end

	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_21_0)
end

return var_0_0
