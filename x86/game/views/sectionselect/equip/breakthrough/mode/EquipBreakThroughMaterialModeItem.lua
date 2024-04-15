local var_0_0 = class("EquipBreakThroughtMaterialModeItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "chooseItem")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.chooseHandler_ = handler(arg_1_0, arg_1_0.ChooseMode)

	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, arg_1_0.chooseHandler_)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, arg_2_0.chooseHandler_)

	arg_2_0.chooseHandler_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		local var_4_0 = EquipBreakThroughMaterialData:GetOpenModeList()
		local var_4_1 = arg_3_0.index_

		if table.keyof(var_4_0, var_4_1) == nil then
			local var_4_2 = EquipBreakThroughMaterialDifficultyCfg[var_4_1].unlock_condition[2]
			local var_4_3 = EquipBreakThroughMaterialDifficultyCfg[var_4_2]

			ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_MODE_UNLOCK"), GetI18NText(var_4_3.name)))

			return
		end

		manager.notify:Invoke(CHALLENGE_CHOOSE_MODE, arg_3_0.index_)
	end)
end

function var_0_0.ChooseMode(arg_5_0, arg_5_1)
	if arg_5_0.index_ == arg_5_1 then
		arg_5_0.selectController_:SetSelectedState("on")
	else
		arg_5_0.selectController_:SetSelectedState("off")
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1

	local var_6_0 = arg_6_1
	local var_6_1 = EquipBreakThroughMaterialDifficultyCfg[var_6_0]

	SetSpriteWithoutAtlasAsync(arg_6_0.bgImage_, SpritePathCfg.ChapterPaint.path .. var_6_1.bg)

	if table.keyof(EquipBreakThroughMaterialData:GetOpenModeList(), var_6_0) then
		arg_6_0.lockController_:SetSelectedState("off")
	else
		arg_6_0.lockController_:SetSelectedState("on")
	end

	arg_6_0.difficultyImage_.sprite = getSprite("Atlas/Switch", string.format("bg_n%s", arg_6_1))

	arg_6_0:ChooseMode(arg_6_2)
end

return var_0_0
