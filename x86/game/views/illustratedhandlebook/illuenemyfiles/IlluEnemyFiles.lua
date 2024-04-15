local var_0_0 = class("IlluEnemyFiles", ReduxView)
local var_0_1 = {
	7,
	8,
	6
}
local var_0_2 = true

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluEnemyUI"
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

	arg_4_0.scroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, IlluEnemyFilesItem)
	arg_4_0.btn1Controller = ControllerUtil.GetController(arg_4_0.btn1trs_, "name")
	arg_4_0.btn2Controller = ControllerUtil.GetController(arg_4_0.btn2trs_, "name")
	arg_4_0.btn3Controller = ControllerUtil.GetController(arg_4_0.btn3trs_, "name")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_1, nil, function()
		arg_5_0:RefreshUI(1)

		arg_5_0.params_.index = 1
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_2, nil, function()
		arg_5_0:RefreshUI(2)

		arg_5_0.params_.index = 2
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_3, nil, function()
		arg_5_0:RefreshUI(3)

		arg_5_0.params_.index = 3
	end)
end

function var_0_0.UpdateDate(arg_9_0, arg_9_1)
	arg_9_0.itemList_ = {}

	if MonsterCfg.get_id_list_by_race[var_0_1[arg_9_1]] then
		for iter_9_0, iter_9_1 in pairs(MonsterCfg.get_id_list_by_race[var_0_1[arg_9_1]]) do
			if CollectMonsterCfg[iter_9_1].hide == 0 then
				table.insert(arg_9_0.itemList_, {
					id = iter_9_1,
					name = GetMonsterName({
						iter_9_1
					})
				})
			elseif CollectMonsterCfg[iter_9_1].hide == 2 then
				-- block empty
			elseif IllustratedData:GetEnemyInfo()[iter_9_1] then
				table.insert(arg_9_0.itemList_, {
					id = iter_9_1,
					name = GetMonsterName({
						iter_9_1
					})
				})
			end
		end
	end
end

function var_0_0.RefreshNum(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1 = not MonsterCfg.get_id_list_by_race[var_0_1[arg_10_1]] and 0 or #MonsterCfg.get_id_list_by_race[var_0_1[arg_10_1]]
	local var_10_2 = IllustratedData:GetEnemyInfo()
	local var_10_3 = 0
	local var_10_4 = 0

	if MonsterCfg.get_id_list_by_race[var_0_1[arg_10_1]] then
		for iter_10_0, iter_10_1 in pairs(MonsterCfg.get_id_list_by_race[var_0_1[arg_10_1]]) do
			if var_10_2[iter_10_1] then
				var_10_3 = var_10_3 + 1
			end

			if not var_10_2[iter_10_1] and CollectMonsterCfg[iter_10_1].hide == 1 then
				var_10_4 = var_10_4 + 1
			end
		end
	end

	arg_10_0.collectnumText_.text = var_10_3 .. "/" .. var_10_1 - var_10_4
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.selectType_

	arg_11_2:RefreshUI(arg_11_0.itemList_[arg_11_1])
end

function var_0_0.RefreshUI(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:UpdateDate(arg_12_1)

	if arg_12_2 then
		if arg_12_0.params_.scrollPos_ then
			arg_12_0.scroll_:StartScrollByPosition(#arg_12_0.itemList_, arg_12_0.params_.scrollPos_)
		else
			arg_12_0.scroll_:StartScroll(#arg_12_0.itemList_)
		end
	else
		arg_12_0.scroll_:StartScroll(#arg_12_0.itemList_)
	end

	arg_12_0:RefreshNum(arg_12_1)
	arg_12_0.btn1Controller:SetSelectedIndex(arg_12_1 == 1 and 0 or 1)
	arg_12_0.btn2Controller:SetSelectedIndex(arg_12_1 == 2 and 0 or 1)
	arg_12_0.btn3Controller:SetSelectedIndex(arg_12_1 == 3 and 0 or 1)
end

function var_0_0.OnEnter(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_13_0.params_.index = arg_13_0.params_.index or 1

	arg_13_0:RefreshUI(arg_13_0.params_.index, true)
	manager.redPoint:bindUIandKey(arg_13_0.btn1trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[1]])
	manager.redPoint:bindUIandKey(arg_13_0.btn2trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[2]])
	manager.redPoint:bindUIandKey(arg_13_0.btn3trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[3]])
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_14_0.btn1trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[1]])
	manager.redPoint:unbindUIandKey(arg_14_0.btn2trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[2]])
	manager.redPoint:unbindUIandKey(arg_14_0.btn3trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[3]])

	arg_14_0.params_.scrollPos_ = arg_14_0.scroll_:GetScrolledPosition()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.scroll_:Dispose()

	arg_15_0.scroll_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
