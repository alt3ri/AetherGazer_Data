local var_0_0 = {
	GetTotalAddAttribute = function(arg_1_0)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
			if iter_1_1.astrolabe_id ~= 0 then
				local var_1_1 = HeroAstrolabeCfg[iter_1_1.astrolabe_id]

				for iter_1_2, iter_1_3 in ipairs(var_1_1.ability) do
					if var_1_0[iter_1_3[1]] == nil then
						var_1_0[iter_1_3[1]] = iter_1_3[2]
					else
						var_1_0[iter_1_3[1]] = var_1_0[iter_1_3[1]] + iter_1_3[2]
					end
				end
			end
		end

		return var_1_0
	end,
	GetTotalEffect = function(arg_2_0)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs(arg_2_0) do
			table.insert(var_2_0, iter_2_1)
		end

		return var_2_0
	end,
	GetAcitveEffect = function(arg_3_0, arg_3_1)
		if arg_3_1 == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		end

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			if iter_3_1 ~= 0 then
				local var_3_1 = HeroAstrolabeCfg[iter_3_1].hero_astrolabe_suit_id

				if var_3_0[var_3_1] == nil then
					var_3_0[var_3_1] = {
						num = 1,
						id = var_3_1
					}
				else
					var_3_0[var_3_1].num = var_3_0[var_3_1].num + 1
				end
			end
		end

		local var_3_2 = {}

		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			table.insert(var_3_2, iter_3_3)
		end

		return var_3_2
	end
}

function var_0_0.GetLastIsUnlock(arg_4_0, arg_4_1)
	local var_4_0 = HeroAstrolabeCfg[arg_4_0].pre_astrolabe_id
	local var_4_1 = HeroData:GetHeroData(arg_4_1)

	if var_4_0 == 0 then
		return true
	end

	if HeroAstrolabeCfg[var_4_0] then
		return var_0_0.GetIsUnlock(var_4_1.unlocked_astrolabe, var_4_0)
	end

	return false
end

function var_0_0.GetLastIsEquiped(arg_5_0, arg_5_1)
	local var_5_0 = HeroAstrolabeCfg[arg_5_0].pre_astrolabe_id
	local var_5_1 = HeroData:GetHeroData(arg_5_1)

	if var_5_0 == 0 then
		return true
	end

	if HeroAstrolabeCfg[var_5_0] then
		return var_0_0.GetIsEquiped(var_5_1.using_astrolabe, var_5_0)
	end

	return false
end

function var_0_0.GetNextIsEquiped(arg_6_0, arg_6_1)
	local var_6_0 = HeroAstrolabeCfg[arg_6_0]
	local var_6_1 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[arg_6_0] or {}

	if var_6_0.pos == 3 then
		return false
	end

	local var_6_2 = HeroData:GetHeroData(arg_6_1)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if not HeroAstrolabeCfg[iter_6_1] then
			return false
		else
			local var_6_3 = HeroData:GetHeroData(arg_6_1)

			return var_0_0.GetIsEquiped(var_6_3.using_astrolabe, iter_6_1)
		end
	end

	return false
end

function var_0_0.GetNextSPNodeIsEquiped(arg_7_0, arg_7_1)
	local var_7_0 = HeroAstrolabeCfg[arg_7_0]
	local var_7_1 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[arg_7_0] or {}

	if var_7_0.pos == 3 then
		return false
	end

	local var_7_2 = HeroData:GetHeroData(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_3 = HeroAstrolabeCfg[iter_7_1]

		if not var_7_3 then
			return false
		elseif var_7_3.pos == 1 then
			local var_7_4 = HeroData:GetHeroData(arg_7_1)

			return var_0_0.GetIsEquiped(var_7_4.using_astrolabe, iter_7_1)
		end
	end

	return false
end

function var_0_0.GetIsUnlock(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0 or {}) do
		if iter_8_1 == arg_8_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetIsEquiped(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0) do
		if iter_9_1 == arg_9_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetIsHaveCanUnlock(arg_10_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) then
		return false
	end

	local var_10_0 = HeroData:GetHeroData(arg_10_0)

	for iter_10_0, iter_10_1 in ipairs(HeroCfg[var_10_0.id].astrolabe) do
		for iter_10_2, iter_10_3 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_10_1]) do
			local var_10_1 = var_0_0.GetIsUnlock(var_10_0.unlocked_astrolabe, iter_10_3)

			if HeroTools.IsSpHero(arg_10_0) then
				local var_10_2 = var_0_0.GetSpAstrolabeNodeCanEquiped(iter_10_3, arg_10_0)

				if var_10_2 then
					return var_10_2
				end
			elseif not var_10_1 and var_0_0.GetIsCanUnlock(iter_10_3, arg_10_0) then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetIsCanUnlock(arg_11_0, arg_11_1)
	local var_11_0 = HeroData:GetHeroData(arg_11_1)

	if not HeroTools.IsSpHero(arg_11_1) and var_0_0.GetIsUnlock(var_11_0.unlocked_astrolabe, arg_11_0) then
		return false
	end

	local var_11_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_11_2 = HeroAstrolabeCfg[arg_11_0]

	if var_11_1 < var_11_2.unlock[1][2] then
		return false
	end

	if not var_0_0.GetLastIsUnlock(arg_11_0, arg_11_1) then
		return false
	end

	return IsConditionAchieved(var_11_2.unlock_condition, {
		heroId = arg_11_1
	})
end

function var_0_0.GetAstrolabeModuleDes(arg_12_0, arg_12_1)
	local var_12_0 = getAstrolabeID(arg_12_0, arg_12_1)
	local var_12_1 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_3")
	local var_12_2

	for iter_12_0, iter_12_1 in pairs(AstrolabeEffectCfg[var_12_0].equip_orange_desc) do
		if iter_12_1[1] == arg_12_1 and iter_12_1[3] == arg_12_0 then
			var_12_2 = iter_12_1[2]
		end
	end

	local var_12_3 = GetCfgDescription(var_12_2, 1)

	return string.format(var_12_1, HeroAstrolabeCfg[var_12_0].suit_name, HeroAstrolabeCfg[var_12_0].name, var_12_3)
end

function var_0_0.GetAstrolabePrafabName(arg_13_0)
	local var_13_0 = 1
	local var_13_1 = HeroCfg[arg_13_0]

	if var_13_1 then
		var_13_0 = var_13_1.race
	end

	if not HeroTools.IsSpHero(arg_13_0) then
		return string.format("TX_GodHood_0%s", var_13_0)
	else
		return string.format("TX_GodHood_SP_0%s", var_13_0)
	end
end

function var_0_0.GetHeroAstrolabeS(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(HeroCfg[arg_14_0.id].astrolabe) do
		local var_14_1 = {
			suitId = iter_14_1,
			astrolabe = {}
		}

		for iter_14_2, iter_14_3 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_14_1]) do
			local var_14_2 = false
			local var_14_3 = false

			if HeroTools.IsSpHero(arg_14_0.id) then
				var_14_2 = AstrolabeTools.GetIsUnlock(iter_14_3, arg_14_0.id)
			else
				var_14_2 = AstrolabeTools.GetIsUnlock(arg_14_0.unlocked_astrolabe, iter_14_3)
				var_14_3 = AstrolabeTools.GetIsCanUnlock(iter_14_3, arg_14_0.id) and arg_14_0.unlock == 1
			end

			local var_14_4 = {
				id = iter_14_3,
				heroId = arg_14_0.id,
				isUnlock = var_14_2,
				isEquiped = AstrolabeTools.GetIsEquiped(arg_14_0.using_astrolabe, iter_14_3),
				isCanLock = var_14_3,
				posX = iter_14_0,
				posY = iter_14_2
			}

			if arg_14_1 == AstrolabeConst.VIEW_TYPE.ISPREVIEW then
				var_14_4.isUnlock = true
				var_14_4.isEquiped = true
				var_14_4.isCanLock = false
			elseif arg_14_1 == AstrolabeConst.VIEW_TYPE.ISPOLYHEDRON then
				var_14_4.isUnlock = true
				var_14_4.isCanLock = false
			end

			table.insert(var_14_1.astrolabe, var_14_4)
		end

		table.insert(var_14_0, var_14_1)
	end

	return var_14_0
end

function var_0_0.GetAstrolabeItemPos(arg_15_0, arg_15_1)
	local var_15_0 = HeroCfg[arg_15_1] and HeroCfg[arg_15_1].astrolabe or {}
	local var_15_1 = HeroAstrolabeCfg[arg_15_0] and HeroAstrolabeCfg[arg_15_0].hero_astrolabe_suit_id
	local var_15_2 = 1

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_1 == var_15_1 then
			var_15_2 = iter_15_0
		end
	end

	return var_15_2
end

function var_0_0.GetSpAstrolabeNodeCanEquiped(arg_16_0, arg_16_1)
	local var_16_0 = var_0_0.GetLastIsEquiped(arg_16_0, arg_16_1)
	local var_16_1 = HeroData:GetHeroData(arg_16_1)
	local var_16_2 = AstrolabeTools.GetIsEquiped(var_16_1 and var_16_1.using_astrolabe or {}, arg_16_0)
	local var_16_3 = AstrolabeTools.GetIsUnlock(var_16_1 and var_16_1.unlocked_astrolabe, arg_16_0)

	return var_16_0 and var_16_3 and not var_16_2
end

function var_0_0.GetSpAstrolabeNodeBySurpass(arg_17_0, arg_17_1)
	local var_17_0 = 0

	if HeroTools.IsSpHero(arg_17_0) then
		local var_17_1 = HeroCfg[arg_17_0]
		local var_17_2 = HeroCfg[arg_17_0].astrolabe or {}

		for iter_17_0, iter_17_1 in ipairs(var_17_2) do
			local var_17_3 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_17_1] or {}

			for iter_17_2, iter_17_3 in ipairs(var_17_3) do
				local var_17_4 = HeroAstrolabeCfg[iter_17_3]

				if var_17_4 then
					local var_17_5 = ConditionCfg[var_17_4.unlock_condition]

					if var_17_5.type == 1024 and arg_17_1 == (var_17_5.params and var_17_5.params[1] or 0) then
						return iter_17_3
					end
				end
			end
		end
	end

	return 0
end

return var_0_0
