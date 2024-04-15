local var_0_0 = singletonClass("ChipData")

function var_0_0.Init(arg_1_0)
	arg_1_0.enabledChipManagerID_ = 0
	arg_1_0.unlockChipManagerIDList_ = {}
	arg_1_0.chipManagerList_ = {}

	for iter_1_0, iter_1_1 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_MANAGER]) do
		arg_1_0.chipManagerList_[iter_1_1] = {}
	end

	arg_1_0.unlockChipIDList_ = {}
	arg_1_0.chipList_ = {}

	for iter_1_2, iter_1_3 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]) do
		arg_1_0.chipList_[iter_1_3] = {}
	end

	arg_1_0.schemeList_ = {}
	arg_1_0.unlockHeroChip_ = {}
	arg_1_0.enabledheroChipList_ = {}

	for iter_1_4, iter_1_5 in pairs(ChipCfg.get_id_list_by_spec_char) do
		arg_1_0.enabledheroChipList_[iter_1_4] = {
			0,
			0,
			0,
			0
		}
	end

	arg_1_0.heroChipList_ = {}

	for iter_1_6, iter_1_7 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_HERO_CHIP]) do
		if arg_1_0.heroChipList_[ChipCfg[iter_1_7].spec_char] then
			table.insert(arg_1_0.heroChipList_[ChipCfg[iter_1_7].spec_char], iter_1_7)
		else
			arg_1_0.heroChipList_[ChipCfg[iter_1_7].spec_char] = {}

			table.insert(arg_1_0.heroChipList_[ChipCfg[iter_1_7].spec_char], iter_1_7)
		end
	end

	arg_1_0.curEnabledChipManagerID_ = nil
	arg_1_0.curChipManagerList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	if arg_2_1.chip == nil then
		print("后端发送的芯片数据是空的")
	end

	arg_2_0.enabledChipManagerID_ = arg_2_1.chip or 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.unlock_kernel_chip) do
		table.insert(arg_2_0.unlockChipManagerIDList_, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.unlock_secondary_chip) do
		table.insert(arg_2_0.unlockChipIDList_, iter_2_3)
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.unlock_hero_chip) do
		table.insert(arg_2_0.unlockHeroChip_, iter_2_5)
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.proposals) do
		local var_2_0 = {}

		for iter_2_8, iter_2_9 in ipairs(iter_2_7.secondary) do
			table.insert(var_2_0, iter_2_9)
		end

		local var_2_1 = {
			id = iter_2_7.id,
			name = iter_2_7.name,
			chipList = var_2_0
		}

		arg_2_0.schemeList_[iter_2_7.id] = var_2_1
	end

	for iter_2_10, iter_2_11 in ipairs(arg_2_1.hero_chip_state) do
		for iter_2_12, iter_2_13 in ipairs(iter_2_11.secondary) do
			if iter_2_13 > 0 then
				local var_2_2 = ChipCfg[iter_2_13].role_type_id

				arg_2_0.enabledheroChipList_[iter_2_11.hero_id][var_2_2] = iter_2_13
			end
		end
	end
end

function var_0_0.SetEnabledChipManagerID(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		print(debug.traceback("设置芯片数据时为空", 2))
	end

	arg_3_0.enabledChipManagerID_ = arg_3_1 or 0
end

function var_0_0.GetEnabledChipManagerID(arg_4_0)
	return arg_4_0.enabledChipManagerID_
end

function var_0_0.SetEnabledChipID(arg_5_0, arg_5_1, arg_5_2)
	if table.keyof(arg_5_0.chipManagerList_[arg_5_1], arg_5_2) then
		print(string.format("已经装备了芯片：", arg_5_2))

		return
	end

	if GameSetting.ai_secondary_chip_equip_num.value[1] <= #arg_5_0.chipManagerList_[arg_5_1] then
		return
	end

	table.insert(arg_5_0.chipManagerList_[arg_5_1], arg_5_2)
end

function var_0_0.RemoveChipID(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = table.keyof(arg_6_0.chipManagerList_[arg_6_1], arg_6_2)

	if var_6_0 then
		table.remove(arg_6_0.chipManagerList_[arg_6_1], var_6_0)
	end
end

function var_0_0.ResetChipManager(arg_7_0, arg_7_1)
	arg_7_0.chipManagerList_[arg_7_1] = {}
end

function var_0_0.GetChipManagerList(arg_8_0)
	return arg_8_0.chipManagerList_
end

function var_0_0.UnlockChipManager(arg_9_0, arg_9_1)
	table.insert(arg_9_0.unlockChipManagerIDList_, arg_9_1)
end

function var_0_0.GetUnlockChipManagerIDList(arg_10_0)
	return arg_10_0.unlockChipManagerIDList_
end

function var_0_0.GetChipList(arg_11_0)
	return arg_11_0.chipList_
end

function var_0_0.UnlockChip(arg_12_0, arg_12_1)
	table.insert(arg_12_0.unlockChipIDList_, arg_12_1)
end

function var_0_0.GetUnlockChipIDList(arg_13_0)
	return arg_13_0.unlockChipIDList_
end

function var_0_0.GetIsUnlockChip(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.unlockChipIDList_) do
		if iter_14_1 == arg_14_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetSchemeList(arg_15_0)
	return arg_15_0.schemeList_
end

function var_0_0.RenameChipScheme(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.schemeList_[arg_16_1].name = arg_16_2
end

function var_0_0.DeleteChipScheme(arg_17_0, arg_17_1)
	arg_17_0.schemeList_[arg_17_1] = nil
end

function var_0_0.SaveChipScheme(arg_18_0, arg_18_1)
	arg_18_0.schemeList_[arg_18_1.id] = arg_18_1
end

function var_0_0.GetHeroIsHaveChip(arg_19_0, arg_19_1)
	return arg_19_0.heroChipList_[arg_19_1] and true or false
end

function var_0_0.GetHeroChipsByHeroId(arg_20_0, arg_20_1)
	return arg_20_0.heroChipList_[arg_20_1]
end

function var_0_0.GetCurHeroChip(arg_21_0, arg_21_1)
	return arg_21_0.enabledheroChipList_[arg_21_1]
end

function var_0_0.GetUnlockHeroChipIDList(arg_22_0)
	return arg_22_0.unlockHeroChip_
end

function var_0_0.GetIsUnlockHeroChip(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.unlockHeroChip_) do
		if iter_23_1 == arg_23_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetHeroChipIsEnableByChipId(arg_24_0, arg_24_1)
	local var_24_0 = ChipCfg[arg_24_1].spec_char
	local var_24_1 = ChipCfg[arg_24_1].role_type_id
	local var_24_2 = arg_24_0.enabledheroChipList_[var_24_0][var_24_1]

	return var_24_2 == arg_24_1, var_24_2
end

function var_0_0.UnlockHeroChip(arg_25_0, arg_25_1)
	table.insert(arg_25_0.unlockHeroChip_, arg_25_1)
end

function var_0_0.EnableHeroChip(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0.enabledheroChipList_[arg_26_1][arg_26_3] = arg_26_2
end

function var_0_0.GetEnableAllChipList(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_3 or {}

	if arg_27_2 then
		for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
			if arg_27_0.enabledheroChipList_[iter_27_1] then
				for iter_27_2, iter_27_3 in pairs(arg_27_0.enabledheroChipList_[iter_27_1]) do
					if iter_27_3 > 0 then
						table.insert(var_27_0, iter_27_3)
					end
				end
			end
		end
	else
		print("未传入出战英雄列表,专属芯片未传入战斗！！！！！！！！！！！！！！！")
	end

	return var_27_0
end

function var_0_0.GetEnableHeroChipIdByHeroId(arg_28_0, arg_28_1)
	return arg_28_0.enabledheroChipList_[arg_28_1]
end

function var_0_0.GetCurEnabledChipManagerID(arg_29_0)
	return arg_29_0.curEnabledChipManagerID_ and arg_29_0.curEnabledChipManagerID_ or arg_29_0:GetEnabledChipManagerID()
end

function var_0_0.SetCurEnabledChipManagerID(arg_30_0, arg_30_1)
	arg_30_0.curEnabledChipManagerID_ = arg_30_1
end

function var_0_0.GetCurChipManagerList(arg_31_0, arg_31_1)
	return arg_31_0.curChipManagerList_[arg_31_1] and arg_31_0.curChipManagerList_[arg_31_1] or arg_31_0:GetChipManagerList()[arg_31_1]
end

function var_0_0.SetCurChipManagerList(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.curChipManagerList_[arg_32_1] = deepClone(arg_32_2)
end

function var_0_0.InsertCurChipManagerList(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:GetCurChipManagerList(arg_33_1)

	ChipTools.InsertChip(var_33_0, arg_33_2)
end

function var_0_0.RemoveCurChipManagerList(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0:GetCurChipManagerList(arg_34_1)

	ChipTools.RemoveChip(var_34_0, arg_34_2)
end

return var_0_0
