return {
	GetHeroAstrolabeS = function(arg_1_0, arg_1_1)
		if HeroTools.IsSpHero(arg_1_1) then
			return arg_1_0:GetSpHeroAstrolabeS(arg_1_1)
		end

		local var_1_0 = arg_1_0:GetHeroData(arg_1_1)
		local var_1_1 = {}

		for iter_1_0, iter_1_1 in ipairs(HeroCfg[var_1_0.id].astrolabe) do
			local var_1_2 = {
				suitId = iter_1_1,
				astrolabe = {}
			}

			for iter_1_2, iter_1_3 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_1_1]) do
				local var_1_3 = false
				local var_1_4 = false

				if HeroTools.IsSpHero(var_1_0.id) then
					var_1_3 = AstrolabeTools.GetIsUnlock(var_1_0.unlocked_astrolabe, iter_1_3)

					local var_1_5 = false
				else
					var_1_3 = AstrolabeTools.GetIsUnlock(var_1_0.unlocked_astrolabe, iter_1_3)

					local var_1_6

					var_1_6 = AstrolabeTools.GetIsCanUnlock(iter_1_3, var_1_0.id) and var_1_0.unlock == 1
				end

				local var_1_7 = {
					id = iter_1_3,
					heroId = var_1_0.id,
					isUnlock = var_1_3,
					isEquiped = AstrolabeTools.GetIsEquiped(var_1_0.using_astrolabe, iter_1_3),
					isCanLock = AstrolabeTools.GetIsCanUnlock(iter_1_3, var_1_0.id) and var_1_0.unlock == 1,
					posX = iter_1_0,
					posY = iter_1_2
				}

				if arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
					var_1_7.isUnlock = true
					var_1_7.isEquiped = false
					var_1_7.isCanLock = false
				elseif arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
					var_1_7.isCanLock = false
				end

				table.insert(var_1_2.astrolabe, var_1_7)
			end

			table.insert(var_1_1, var_1_2)
		end

		return var_1_1
	end,
	GetSpHeroAstrolabeS = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_0:GetHeroData(arg_2_1)
		local var_2_1 = {}
		local var_2_2 = HeroCfg[var_2_0.id].astrolabe[1]
		local var_2_3 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_2_2] or {}
		local var_2_4 = {}

		for iter_2_0, iter_2_1 in ipairs(var_2_3) do
			if HeroAstrolabeCfg[iter_2_1].pos == 1 then
				table.insert(var_2_4, iter_2_1)
			end
		end

		for iter_2_2, iter_2_3 in ipairs(var_2_4) do
			local var_2_5 = {
				suitId = var_2_2,
				astrolabe = {}
			}
			local var_2_6 = {}
			local var_2_7 = 1

			table.insert(var_2_6, iter_2_3)

			for iter_2_4, iter_2_5 in ipairs(var_2_3) do
				if iter_2_3 == HeroAstrolabeCfg[iter_2_5].pre_astrolabe_id then
					table.insert(var_2_6, iter_2_5)

					var_2_7 = var_2_7 + 1
				end
			end

			for iter_2_6, iter_2_7 in ipairs(var_2_6) do
				local var_2_8 = HeroAstrolabeCfg[iter_2_7]
				local var_2_9 = false
				local var_2_10 = false

				if HeroTools.IsSpHero(var_2_0.id) then
					var_2_9 = AstrolabeTools.GetIsUnlock(var_2_0.unlocked_astrolabe, iter_2_7)

					local var_2_11 = false
				end

				local var_2_12 = {
					id = iter_2_7,
					heroId = var_2_0.id,
					isUnlock = var_2_9,
					isEquiped = AstrolabeTools.GetIsEquiped(var_2_0.using_astrolabe, iter_2_7),
					isCanLock = AstrolabeTools.GetIsCanUnlock(iter_2_7, var_2_0.id) and var_2_0.unlock == 1,
					posX = iter_2_2,
					posY = iter_2_6
				}

				if arg_2_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
					var_2_12.isUnlock = true
					var_2_12.isEquiped = false
					var_2_12.isCanLock = false
				elseif arg_2_0.viewDataType == HeroConst.HERO_DATA_TYPE.ISPOLYHEDRON then
					var_2_12.isUnlock = true
					var_2_12.isCanLock = true
				end

				table.insert(var_2_5.astrolabe, var_2_12)
			end

			table.insert(var_2_1, var_2_5)
		end

		return var_2_1
	end,
	GetAcitveEffect = function(arg_3_0, arg_3_1)
		if arg_3_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		end

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
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
	end,
	GetUsingAstrolabe = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0:GetHeroData(arg_4_1)

		if arg_4_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		else
			return var_4_0.using_astrolabe
		end
	end,
	GetAstrolabeDesc = function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = AstrolabeEffectCfg[arg_5_1]

		if not var_5_0 then
			print("id:" .. arg_5_1 .. "没有配置")
		end

		if var_5_0 and var_5_0.desc and type(var_5_0.desc) == "table" then
			local var_5_1 = var_5_0.desc[1]
			local var_5_2 = arg_5_0:GetServantId(arg_5_2)
			local var_5_3 = arg_5_0:GetModuleEffectList(arg_5_2)
			local var_5_4 = false

			if var_5_0.equip_orange_desc and type(var_5_0.equip_orange_desc) == "table" then
				for iter_5_0, iter_5_1 in ipairs(var_5_0.equip_orange_desc) do
					if iter_5_1[1] > 0 and iter_5_1[3] > 0 and iter_5_1[1] == var_5_2 and table.indexof(var_5_3, iter_5_1[3]) then
						var_5_1 = iter_5_1[2]
						var_5_4 = true
					end
				end

				if not var_5_4 then
					for iter_5_2, iter_5_3 in ipairs(var_5_0.equip_orange_desc) do
						if iter_5_3[1] > 0 and iter_5_3[3] == 0 and iter_5_3[1] == var_5_2 then
							var_5_1 = iter_5_3[2]
							var_5_4 = true
						end
					end

					if not var_5_4 then
						for iter_5_4, iter_5_5 in ipairs(var_5_0.equip_orange_desc) do
							if iter_5_5[1] == 0 and iter_5_5[3] > 0 and table.indexof(var_5_3, iter_5_5[3]) then
								var_5_1 = iter_5_5[2]

								local var_5_5 = true
							end
						end
					end
				end
			end

			return GetCfgDescription(var_5_1, 1)
		end

		return ""
	end,
	GetServantId = function(arg_6_0, arg_6_1)
		local var_6_0 = 0
		local var_6_1 = arg_6_0:GetHeroServantInfo(arg_6_1)

		if var_6_1 then
			var_6_0 = var_6_1.id
		end

		return var_6_0
	end,
	GetModuleEffectList = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:GetHeroData(arg_7_1)
		local var_7_1 = {}

		return (HeroTools:GetModulePowersByHeroIDAndLevel(var_7_0.id, var_7_0.moduleLevel))
	end,
	GetAstrolabeAction = function(arg_8_0, arg_8_1)
		local var_8_0 = AstrolabeAction

		if arg_8_0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			var_8_0 = PolyhedronAction
		end

		return var_8_0
	end,
	AstrolabeUnlock = function(arg_9_0, arg_9_1, arg_9_2)
		AstrolabeAction.AstrolabeUnlock(arg_9_1, arg_9_2)
	end,
	AstrolabeEquip = function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_0:GetAstrolabeAction().AstrolabeEquip(arg_10_1, arg_10_2)
	end,
	AstrolabeUnload = function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_0:GetAstrolabeAction().AstrolabeUnload(arg_11_1, arg_11_2)
	end,
	AstrolabeEquipAll = function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_0:GetAstrolabeAction().AstrolabeEquipAll(arg_12_1, arg_12_2)
	end,
	AstrolabeUnlock = function(arg_13_0, arg_13_1, arg_13_2)
		AstrolabeAction.AstrolabeUnlock(arg_13_1, arg_13_2)
	end,
	AstrolabeUnloadAll = function(arg_14_0, arg_14_1)
		arg_14_0:GetAstrolabeAction().AstrolabeUnloadAll(arg_14_1)
	end,
	GetNextIsEquiped = function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = HeroAstrolabeCfg[arg_15_1]
		local var_15_1 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[arg_15_1] or {}

		if var_15_0.pos == 3 then
			return false
		end

		local var_15_2 = arg_15_0:GetHeroData(arg_15_2)

		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if not HeroAstrolabeCfg[iter_15_1] then
				return false
			else
				return AstrolabeTools.GetIsEquiped(var_15_2.using_astrolabe, iter_15_1)
			end
		end

		return false
	end,
	GetLastIsEquiped = function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = HeroAstrolabeCfg[arg_16_1].pre_astrolabe_id
		local var_16_1 = arg_16_0:GetHeroData(arg_16_2)

		if var_16_0 == 0 then
			return true
		end

		if HeroAstrolabeCfg[var_16_0] then
			return AstrolabeTools.GetIsEquiped(var_16_1.using_astrolabe, var_16_0)
		end

		return false
	end
}
