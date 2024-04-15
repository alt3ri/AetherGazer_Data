local var_0_0 = class("SectionSelectHeroChip", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListener()
end

function var_0_0.AddListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.isCustom_ then
			ShowTips("CANNOT_CHANGE_CHIP")
		else
			ChipAction:UpdateChipRed()
			arg_2_0:Go("/battleChipManager", {
				stageType = arg_2_0.stageType_,
				stageID = arg_2_0.stageID_,
				activityID = arg_2_0.activityID_,
				reserveParams = arg_2_0.reserveParams_
			})
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.stageType_ = arg_4_1
	arg_4_0.stageID_ = arg_4_2
	arg_4_0.activityID_ = arg_4_3
	arg_4_0.reserveParams_ = arg_4_4
	arg_4_0.isCustom_ = false

	local var_4_0 = BattleStageTools.GetStageCfg(arg_4_1, arg_4_2)

	if var_4_0 and type(var_4_0.chip_list) == "table" then
		arg_4_0.enabledID_ = var_4_0.chip_list[1]
		arg_4_0.chipList_ = {}

		for iter_4_0 = 2, 3 do
			arg_4_0.chipList_[iter_4_0 - 1] = var_4_0.chip_list[iter_4_0]
		end

		arg_4_0:RefreshUI()

		arg_4_0.isCustom_ = true

		return
	end

	arg_4_0.enabledID_ = arg_4_0:GetChipManagerID()
	arg_4_0.chipList_ = arg_4_0:GetChipList()

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = arg_5_0.enabledID_ or 0
	local var_5_1 = var_5_0 == 0

	SetActive(arg_5_0.chipManagerGo_, not var_5_1)

	if var_5_1 then
		for iter_5_0 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
			SetActive(arg_5_0[string.format("chipIconGo%s_", iter_5_0)], false)
		end
	else
		if ChipCfg[var_5_0] == nil then
			print(string.format("ChipCfg[%s] is nil", var_5_0))
		end

		arg_5_0.chipManagerImg_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[var_5_0].picture_id)

		local var_5_2 = arg_5_0.chipList_
		local var_5_3 = GameSetting.ai_secondary_chip_equip_num.value[1]

		if var_5_3 < #arg_5_0.chipList_ then
			for iter_5_1 = #arg_5_0.chipList_, var_5_3 + 1, -1 do
				arg_5_0.chipList_[iter_5_1] = nil
			end
		end

		for iter_5_2, iter_5_3 in ipairs(var_5_2) do
			if iter_5_3 == nil or iter_5_3 == 0 then
				break
			end

			SetActive(arg_5_0[string.format("chipIconGo%s_", iter_5_2)], true)

			if ChipCfg[iter_5_3] == nil then
				print(string.format("ChipCfg[%s] is nil", iter_5_3))
			end

			arg_5_0[string.format("chipIcon%s_", iter_5_2)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[iter_5_3].picture_id)
		end

		for iter_5_4 = #var_5_2 + 1, var_5_3 do
			SetActive(arg_5_0[string.format("chipIconGo%s_", iter_5_4)], false)
		end
	end
end

function var_0_0.GetChipManagerID(arg_6_0)
	return ReserveTools.GetMimirID(arg_6_0.reserveParams_)
end

function var_0_0.GetChipList(arg_7_0)
	return ReserveTools.GetMimirChipList(arg_7_0.reserveParams_)
end

function var_0_0.GetCurMimirID(arg_8_0)
	return arg_8_0.enabledID_ or 0
end

function var_0_0.GetCurChipList(arg_9_0)
	return arg_9_0.chipList_ or {}
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
