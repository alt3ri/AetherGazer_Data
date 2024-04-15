local var_0_0 = class("GuildBossSelectHeroView", SectionSelectHeroBaseView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.heroInfoList_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0["assistantController" .. iter_1_0] = ControllerUtil.GetController(arg_1_0["heroRect_" .. iter_1_0], "assistant")
	end
end

function var_0_0.GoHeroInfoUI(arg_2_0, arg_2_1)
	arg_2_0:Go("/guildBossTeamInfo", {
		isEnter = true,
		selectHeroPos = arg_2_1,
		stageID = arg_2_0.stageID_,
		activityID = arg_2_0.params_.activityID,
		stageType = arg_2_0.stageType_,
		heroList = arg_2_0.heroInfoList_,
		reserveParams = arg_2_0.reserveParams_
	})
end

function var_0_0.GetSelectHero(arg_3_0)
	local var_3_0 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	arg_3_0.cacheHeroTeam_, arg_3_0.lockStateList_, arg_3_0.lockList_, arg_3_0.heroTrialList_, _ = var_3_0:GetHeroList(arg_3_0.reserveParams_)
	arg_3_0.heroInfoList_ = var_3_0:GetCurHeroInfoList()

	arg_3_0:RefreshAssistantHero()
end

function var_0_0.SaveTeamInfo(arg_4_0)
	arg_4_0:GuildBossChangeHeroTeam(arg_4_0.heroInfoList_)
end

function var_0_0.OnHeroChange(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == nil then
		arg_5_2 = 0
	end

	if arg_5_2 == 0 then
		for iter_5_0 = arg_5_1, 2 do
			arg_5_0.heroInfoList_[iter_5_0] = arg_5_0.heroInfoList_[iter_5_0 + 1]
		end

		arg_5_0.heroInfoList_[3] = nil
	else
		local var_5_0 = arg_5_0.heroInfoList_[1]

		if var_5_0 ~= nil and var_5_0.type == 1 and var_5_0.heroId == arg_5_2 and arg_5_0.heroInfoList_[arg_5_1] == nil then
			return
		end

		if arg_5_2 ~= nil and arg_5_2 > 0 then
			arg_5_0.heroInfoList_[arg_5_1] = {
				type = 1,
				heroId = arg_5_2
			}
		else
			arg_5_0.heroInfoList_[arg_5_1] = nil
		end
	end

	arg_5_0:GuildBossChangeHeroTeam(arg_5_0.heroInfoList_)
end

function var_0_0.OnAssistantHeroChange(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == nil then
		for iter_6_0 = arg_6_1, 2 do
			arg_6_0.heroInfoList_[iter_6_0] = arg_6_0.heroInfoList_[iter_6_0 + 1]
		end

		arg_6_0.heroInfoList_[3] = nil
	else
		local var_6_0 = arg_6_0.heroInfoList_[1]

		if var_6_0 ~= nil and var_6_0.type == 2 and var_6_0.info.assist_hero_id == arg_6_2.assist_hero_id and var_6_0.info.member_id == arg_6_2.member_id and arg_6_0.heroInfoList_[arg_6_1] == nil then
			return
		end

		if arg_6_2 ~= nil then
			arg_6_0.heroInfoList_[arg_6_1] = {
				type = 2,
				info = arg_6_2
			}
		else
			arg_6_0.heroInfoList_[arg_6_1] = nil
		end
	end

	arg_6_0:GuildBossChangeHeroTeam(arg_6_0.heroInfoList_)
end

function var_0_0.GetHeroPower(arg_7_0, arg_7_1)
	if arg_7_0.heroInfoList_[arg_7_1] and arg_7_0.heroInfoList_[arg_7_1].type == 2 then
		return arg_7_0.heroInfoList_[arg_7_1].info.fight_capacity
	end

	return getHeroPower(arg_7_0.heroInfoList_[arg_7_1].heroId, false)
end

function var_0_0.GetSkinCfg(arg_8_0, arg_8_1)
	if arg_8_0.heroInfoList_[arg_8_1] and arg_8_0.heroInfoList_[arg_8_1].type == 2 then
		local var_8_0 = arg_8_0.heroInfoList_[arg_8_1].info.assist_hero_skin

		if var_8_0 == 0 then
			var_8_0 = arg_8_0.heroInfoList_[arg_8_1].info.assist_hero_id
		end

		return SkinCfg[var_8_0]
	end

	return arg_8_0:GetHeroCfg(arg_8_0.heroInfoList_[arg_8_1].heroId)
end

function var_0_0.ChangeHeroTeam(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		for iter_9_2, iter_9_3 in ipairs(arg_9_0.heroInfoList_) do
			if iter_9_3.type == 2 and iter_9_3.info.assist_hero_id == iter_9_1 then
				var_9_0[iter_9_1] = iter_9_3
			elseif iter_9_3.type == 1 and iter_9_3.heroId == iter_9_1 then
				var_9_0[iter_9_1] = iter_9_3
			end
		end
	end

	local var_9_1 = {}

	for iter_9_4, iter_9_5 in pairs(arg_9_1) do
		var_9_1[iter_9_4] = var_9_0[iter_9_5]
	end

	arg_9_0.heroInfoList_ = var_9_1

	arg_9_0:GuildBossChangeHeroTeam(arg_9_0.heroInfoList_)
	arg_9_0:RefreshAddBtn()
end

function var_0_0.RefreshAssistantHero(arg_10_0)
	for iter_10_0 = 1, 3 do
		arg_10_0["assistantController" .. iter_10_0]:SetSelectedState("false")
	end

	if arg_10_0.heroInfoList_ then
		for iter_10_1, iter_10_2 in ipairs(arg_10_0.heroInfoList_) do
			if iter_10_2.type == 2 then
				arg_10_0["assistantController" .. iter_10_1]:SetSelectedState("true")
			else
				arg_10_0["assistantController" .. iter_10_1]:SetSelectedState("false")
			end
		end
	end
end

function var_0_0.GuildBossChangeHeroTeam(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {
		0,
		0,
		0
	}
	local var_11_2 = {}
	local var_11_3 = {}
	local var_11_4 = 1

	for iter_11_0 = 1, 3 do
		if arg_11_1[iter_11_0] then
			local var_11_5 = arg_11_1[iter_11_0]

			if var_11_5.type == 1 then
				var_11_0[var_11_4] = var_11_5.heroId
			elseif var_11_5.type == 2 then
				var_11_0[var_11_4] = var_11_5.info.assist_hero_id
				var_11_2[var_11_4] = var_11_5.info.member_id
			end

			var_11_4 = var_11_4 + 1
		end
	end

	local var_11_6 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	var_11_6:SetHeroList(arg_11_0.reserveParams_, var_11_0, var_11_1)
	var_11_6:SetOwnerID(var_11_2)
end

function var_0_0.CheckComboSkillExist(arg_12_0, arg_12_1)
	return true
end

function var_0_0.StartBattle(arg_13_0)
	local var_13_0 = BattleStageFactory.Produce(arg_13_0.stageType_, arg_13_0.stageID_, 1, arg_13_0.reserveParams_)
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.heroInfoList_) do
		if iter_13_1.type == 2 then
			table.insert(var_13_1, iter_13_1.info.assist_hero_id)
			table.insert(var_13_2, iter_13_1.info.member_id)
			table.insert(var_13_3, iter_13_1.info.assist_hero_id)
			table.insert(var_13_4, iter_13_1.info.member_id)
		else
			table.insert(var_13_1, iter_13_1.heroId)
			table.insert(var_13_2, "0")
		end
	end

	local var_13_5 = 0

	var_13_0:SetGuildBossTeam(var_13_1, var_13_2)
	var_13_0:SetMultiple(arg_13_0.multiple_)
	var_13_0:SetDest(arg_13_0.params_.dest)
	var_13_0:InitChipData()

	if #var_13_3 > 0 then
		for iter_13_2, iter_13_3 in ipairs(var_13_3) do
			ForeignInfoAction:TryToCheckForeignHeroInfo(var_13_4[iter_13_2], iter_13_3, 2, function()
				var_13_5 = var_13_5 + 1

				if var_13_5 >= #var_13_3 then
					local var_14_0 = {}

					for iter_14_0, iter_14_1 in ipairs(var_13_3) do
						local var_14_1 = ForeignInfoData:GetHeroInfo(iter_14_1)
						local var_14_2 = {}

						if var_14_1.using_hero_chip then
							for iter_14_2, iter_14_3 in ipairs(var_14_1.using_hero_chip) do
								if iter_14_3 > 0 then
									table.insert(var_14_2, iter_14_3)
								end
							end
						end

						var_14_0[iter_14_1] = var_14_2
					end

					var_13_0:SetChipDic(var_14_0)
					BattleController.GetInstance():LaunchBattle(var_13_0)
				end
			end)
		end
	else
		BattleController.GetInstance():LaunchBattle(var_13_0)
	end
end

function var_0_0.GotoReservesUI(arg_15_0)
	if arg_15_0.heroInfoList_ then
		local var_15_0 = arg_15_0.cacheHeroTeam_

		for iter_15_0, iter_15_1 in ipairs(arg_15_0.heroInfoList_) do
			if iter_15_1.type == 2 then
				var_15_0 = {}

				break
			end
		end

		JumpTools.OpenPageByJump("/reservesUI", {
			isInit = true,
			stage_type = arg_15_0.stageType_,
			activityID = arg_15_0.params_.activityID,
			hero_list = var_15_0,
			hero_trial_list = arg_15_0.heroTrialList_,
			lockList = arg_15_0.lockList_,
			comboSkill = arg_15_0.comboSkillView_:GetCurComboSkill(),
			chipInfo = {
				enabledID = arg_15_0.chipView_:GetCurEnabledID(),
				chipList = arg_15_0.chipView_:GetCurChipList()
			},
			reserveParams = arg_15_0.reserveParams_
		})
	end
end

function var_0_0.GetHeroId(arg_16_0, arg_16_1)
	if arg_16_0.heroInfoList_[arg_16_1] == nil then
		return 0
	end

	if arg_16_0.heroInfoList_[arg_16_1].type == 1 then
		return arg_16_0.heroInfoList_[arg_16_1].heroId
	end

	return arg_16_0.heroInfoList_[arg_16_1].assist_hero_id
end

return var_0_0
