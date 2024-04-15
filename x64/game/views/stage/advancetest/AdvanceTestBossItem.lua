local var_0_0 = class("AdvanceTestBossItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.difficultyController_ = ControllerUtil.GetController(arg_1_0.transform_, "difficulty")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if arg_3_0.clickFunc_ then
			arg_3_0.clickFunc_()
		end
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	local var_5_0 = AdvanceTestData:GetCurCfgByIndex(arg_5_1)
	local var_5_1 = var_5_0.stage_target
	local var_5_2 = MonsterCfg[var_5_1]

	arg_5_0.nameText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_2"), GetMonsterName({
		var_5_1
	}))
	arg_5_0.descText_.text = var_5_2.desc
	arg_5_0.riskText_.text = arg_5_0:GetTipsByCfg(var_5_0)
	arg_5_0.bossImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_5_1)

	local var_5_3 = arg_5_0:SetLimitTextTop(var_5_0)
	local var_5_4 = string.format(GetTips("TEST_CHALLENGE_TIPS_1"), arg_5_0:GetStrByCharacterStar(var_5_0.character), var_5_0.weapon)

	if var_5_3 ~= "" then
		arg_5_0.limitText_.text = var_5_3 .. "\n" .. var_5_4
	else
		arg_5_0.limitText_.text = var_5_4
	end

	arg_5_0.difficultyController_:SetSelectedState(arg_5_1)
end

function var_0_0.SetLimitTextTop(arg_6_0, arg_6_1)
	local var_6_0 = ""
	local var_6_1 = arg_6_1.limit_hero
	local var_6_2 = #var_6_1

	for iter_6_0 = 1, var_6_2 do
		local var_6_3 = var_6_1[iter_6_0]
		local var_6_4 = var_6_3[1]
		local var_6_5 = var_6_3[2]
		local var_6_6 = ""

		for iter_6_1, iter_6_2 in pairs(var_6_5) do
			var_6_6 = var_6_6 .. HeroCfg[iter_6_2].name .. "·" .. HeroCfg[iter_6_2].suffix .. " "
		end

		local var_6_7 = string.gsub(var_6_6, "^[%s]*(.-)[%s]*$", "%1")

		if var_6_4 == 1 then
			var_6_0 = var_6_0 .. string.format(GetTips("TEST_CHALLENGE_MAIN_HERO_LIMIT"), var_6_7)
		elseif var_6_4 == 2 then
			var_6_0 = var_6_0 .. string.format(GetTips("TEST_CHALLENGE_OTHER_HERO_LIMIT_1"), var_6_7)
		elseif var_6_4 == 3 then
			var_6_0 = var_6_0 .. string.format(GetTips("TEST_CHALLENGE_HERO_LIST_LIMIT_1"), var_6_7)
		elseif var_6_4 == 4 then
			var_6_0 = ""
		elseif var_6_4 == 5 then
			var_6_0 = var_6_0 .. string.format(GetTips("TEST_CHALLENGE_BAN_HERO"), var_6_7)
		elseif var_6_4 == 6 then
			var_6_0 = var_6_0 .. string.format(GetTips("TEST_CHALLENGE_OTHER_HERO_LIMIT_2"), var_6_7)
		elseif var_6_4 == 7 then
			var_6_0 = var_6_0 .. string.format(GetTips("TEST_CHALLENGE_HERO_LIST_LIMIT_2"), var_6_7)
		end

		if iter_6_0 ~= var_6_2 then
			var_6_0 = var_6_0 .. "\n"
		end
	end

	return var_6_0
end

function var_0_0.GetTipsByCfg(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_1.stage_type == 1 then
		var_7_0 = GetTips("TEST_CHALLENGE_TIPS_3")
	elseif arg_7_1.stage_type == 2 then
		var_7_0 = GetTips("TEST_CHALLENGE_TIPS_4")
	elseif arg_7_1.stage_type == 3 then
		var_7_0 = GetTips("TEST_CHALLENGE_TIPS_5")
	end

	return var_7_0
end

function var_0_0.GetStrByCharacterStar(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_1 == 400 then
		var_8_0 = "SS"
	elseif arg_8_1 == 500 then
		var_8_0 = "SSS"
	elseif arg_8_1 == 600 then
		var_8_0 = "Ω"
	end

	return var_8_0
end

function var_0_0.RegistClickFunc(arg_9_0, arg_9_1)
	arg_9_0.clickFunc_ = arg_9_1
end

return var_0_0
