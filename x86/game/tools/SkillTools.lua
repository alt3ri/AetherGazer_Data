local var_0_0 = {}
local var_0_1 = import("game.const.HeroConst")

function var_0_0.GetAstrolabeDescByServant(arg_1_0, arg_1_1)
	local var_1_0 = AstrolabeEffectCfg[arg_1_0]

	if not var_1_0 then
		print("id" .. arg_1_0 .. "没有配置")
	end

	if var_1_0 and var_1_0.desc and type(var_1_0.desc) == "table" then
		if not var_1_0.desc[1] then
			print("id" .. arg_1_0 .. "等级溢出" .. 1)

			return ""
		end

		local var_1_1 = var_1_0.desc[1]

		if arg_1_1 ~= 0 and var_1_0.equip_orange_desc and type(var_1_0.equip_orange_desc) == "table" then
			for iter_1_0, iter_1_1 in ipairs(var_1_0.equip_orange_desc) do
				if iter_1_1[1] == arg_1_1 then
					var_1_1 = iter_1_1[2]
				end
			end
		end

		return GetCfgDescription(var_1_1, 1)
	end

	return ""
end

function var_0_0.GetHeroIDBySkillID(arg_2_0)
	local var_2_0

	while arg_2_0 > 9999 do
		arg_2_0 = arg_2_0 / 10
	end

	return (math.modf(arg_2_0))
end

function var_0_0.GetIsDodgeSkill(arg_3_0)
	return arg_3_0 % 1000 == 305
end

function var_0_0.GetIsPassiveSkill(arg_4_0)
	return arg_4_0 % 1000 == 999
end

function var_0_0.GetIsMelee(arg_5_0)
	return arg_5_0 % 1000 < 200
end

function var_0_0.GetMainHeroId(arg_6_0)
	return math.floor(arg_6_0 / 1000)
end

function var_0_0.GetSkillIdIndex(arg_7_0)
	local var_7_0 = var_0_0.GetMainHeroId(arg_7_0)
	local var_7_1 = HeroCfg[var_7_0]

	return table.indexof(var_7_1.skills, arg_7_0)
end

function var_0_0.GetIsCanUp(arg_8_0, arg_8_1)
	if var_0_0.GetIsPassiveSkill(arg_8_0) or arg_8_1 == var_0_1.MAX_SKILL_LEVEL or var_0_0.GetIsDodgeSkill(arg_8_0) then
		return false
	end

	local var_8_0 = var_0_0.GetMainHeroId(arg_8_0)
	local var_8_1 = HeroCfg[var_8_0]
	local var_8_2 = HeroData:GetHeroData(var_8_0)
	local var_8_3 = table.indexof(var_8_1.skills, arg_8_0)

	if SkillCfg[arg_8_1]["skill_limit" .. var_8_3] > var_8_2.break_level then
		return false
	end

	local var_8_4 = SkillCfg[arg_8_1]["skill_cost" .. var_8_3][1]

	return ItemTools.getItemNum(var_8_4[1]) > var_8_4[2]
end

function var_0_0.GetIsCanUpNew(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0

	if SkillTools.GetIsDodgeSkill(var_9_0) then
		return false
	end

	local var_9_1 = var_0_0.GetMainHeroId(var_9_0)
	local var_9_2 = HeroData:GetHeroData(var_9_1)
	local var_9_3 = arg_9_1
	local var_9_4 = SkillTools.GetSkillIdIndex(var_9_0)
	local var_9_5

	if not arg_9_2 then
		if SkillCfg[var_9_3]["skill_limit" .. var_9_4] > var_9_2.break_level or var_9_3 >= var_0_1.MAX_SKILL_LEVEL then
			return false
		end

		var_9_5 = SkillCfg[var_9_3]["skill_cost" .. var_9_4]
	else
		if var_9_3 < var_0_1.MAX_SKILL_LEVEL then
			return false
		end

		local var_9_6 = HeroTools.GetSkillAttrLv(var_9_2.id, var_9_4)

		if var_9_6 == var_0_1.MAX_SKILL_ATTR_LEVEL then
			return false
		end

		local var_9_7 = var_0_0.GetSkillAttrCfg(var_9_2.id, var_9_4, var_9_6 + 1)

		var_9_5 = var_9_7 and var_9_7.cost or nil

		if var_9_5 == nil or var_9_5 and #var_9_5 == 0 then
			return false
		end
	end

	local var_9_8 = true

	for iter_9_0 = 1, 2 do
		if var_9_5 and var_9_5[iter_9_0] then
			local var_9_9 = var_9_5[iter_9_0][1]

			if var_9_5[iter_9_0][2] > ItemTools.getItemNum(var_9_9) then
				var_9_8 = false

				break
			end
		end
	end

	return var_9_8
end

function var_0_0.GetSkillUpCostNum(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = SkillTools.GetSkillIdIndex(arg_10_0)
	local var_10_1 = {}

	for iter_10_0 = 1, arg_10_2 do
		local var_10_2 = SkillCfg[arg_10_1 + iter_10_0 - 1]["skill_cost" .. var_10_0][1]

		var_10_1[var_10_2[1]] = (var_10_1[var_10_2[1]] or 0) + var_10_2[2]
	end

	return var_10_1
end

function var_0_0.GetRealSkillIdByWeaponServantId(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = HeroCfg[arg_11_0]
	local var_11_1 = arg_11_2

	for iter_11_0, iter_11_1 in pairs(var_11_0.equip_orange_skill) do
		if iter_11_1[1] == arg_11_2 and arg_11_1 == iter_11_1[2] then
			var_11_1 = iter_11_1[3]
		end
	end

	return var_11_1
end

function var_0_0.GetAttr(arg_12_0)
	local var_12_0 = PublicAttrCfg[arg_12_0[1]].name
	local var_12_1

	if PublicAttrCfg[arg_12_0[1]].percent == 1 then
		var_12_1 = string.format("%.2f%%", arg_12_0[2] / 10)
	else
		var_12_1 = string.format("%d", arg_12_0[2])
	end

	local var_12_2 = getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[arg_12_0[1]].icon)

	return var_12_0, var_12_1, var_12_2
end

function var_0_0.GetSkillModuleDes(arg_13_0)
	local var_13_0 = getSkillIDOrServantID(arg_13_0)
	local var_13_1 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
	local var_13_2 = var_0_0.GetHeroIDBySkillID(var_13_0)
	local var_13_3

	for iter_13_0, iter_13_1 in pairs(HeroCfg[var_13_2].skills) do
		if iter_13_1 == var_13_0 then
			var_13_3 = HeroCfg[var_13_2].skill_subhead[iter_13_0]

			break
		end
	end

	local var_13_4 = HeroSkillCfg[var_13_0].name
	local var_13_5 = HeroSkillCfg[var_13_0].desc[1]
	local var_13_6 = HeroSkillCfg[var_13_0].strengthen_desc[2]

	return string.format(var_13_1, var_13_3, var_13_4, var_0_0.GetSkillRate(var_13_5), var_0_0.GetSkillRate(var_13_6))
end

function var_0_0.GetServantSkillModuleDes(arg_14_0)
	local var_14_0 = getSkillIDOrServantID(arg_14_0)
	local var_14_1 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
	local var_14_2 = var_0_0.GetHeroIDBySkillID(var_14_0)
	local var_14_3 = HeroCfg[var_14_2].equip_orange_skill[1][1]
	local var_14_4

	for iter_14_0, iter_14_1 in pairs(HeroCfg[var_14_2].skills) do
		if iter_14_1 == var_14_3 then
			var_14_4 = HeroCfg[var_14_2].skill_subhead[iter_14_0]

			break
		end
	end

	local var_14_5 = HeroSkillCfg[var_14_0].name
	local var_14_6 = HeroSkillCfg[var_14_0].desc[1]
	local var_14_7 = HeroSkillCfg[var_14_0].strengthen_desc[2]

	return string.format(var_14_1, var_14_4, var_14_5, var_0_0.GetSkillRate(var_14_6), var_0_0.GetSkillRate(var_14_7))
end

function var_0_0.GetSkillRate(arg_15_0)
	local var_15_0 = DescriptionCfg[arg_15_0]

	if not var_15_0 then
		return ""
	end

	local var_15_1

	if var_15_0.type == 1 then
		local var_15_2 = var_15_0.param

		if #var_15_2 >= 1 then
			for iter_15_0, iter_15_1 in ipairs(var_15_2) do
				local var_15_3 = iter_15_1[1]
				local var_15_4 = iter_15_1[3]
				local var_15_5 = iter_15_1[4]
				local var_15_6 = var_15_3

				if var_15_6 % 1 == 0 then
					var_15_6 = string.format("%.0f", var_15_6) .. var_15_5
				else
					var_15_6 = string.format("%.1f", var_15_6) .. var_15_5
				end

				if var_15_4 then
					if var_15_1 == nil then
						var_15_1 = var_15_6
					else
						var_15_1 = var_15_1 .. "/" .. var_15_6
					end
				end
			end
		end
	end

	return var_15_1 or ""
end

function var_0_0.CanUseComboSkill(arg_16_0, arg_16_1)
	if arg_16_0 == 0 then
		return true
	end

	local var_16_0 = ComboSkillCfg[arg_16_0]

	for iter_16_0, iter_16_1 in ipairs(var_16_0.cooperate_role_ids) do
		if not table.keyof(arg_16_1, iter_16_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetSkillAttrCfg(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0

	if arg_17_2 < 10 then
		var_17_0 = string.format("%s0%s", arg_17_0, arg_17_2)
	else
		var_17_0 = string.format("%s%s", arg_17_0, arg_17_2)
	end

	local var_17_1 = HeroSkillElementCfg[tonumber(var_17_0)]

	if var_17_1 then
		return {
			cost = var_17_1["skill_element_cost" .. arg_17_1],
			attr = var_17_1["skill_element_attr" .. arg_17_1]
		}
	end

	return nil
end

function var_0_0.GetSkillAttrCost(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = {}

	for iter_18_0 = 1, arg_18_3 do
		local var_18_1 = var_0_0.GetSkillAttrCfg(arg_18_0, arg_18_1, arg_18_2 + iter_18_0 - 1)

		if var_18_1 then
			local var_18_2 = var_18_1.cost

			var_18_0[var_18_2[1]] = (var_18_0[var_18_2[1]] or 0) + var_18_2[2]
		end
	end

	return var_18_0
end

return var_0_0
