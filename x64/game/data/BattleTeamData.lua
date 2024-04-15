require("game.data.BattleTeamDataTemplate")

local var_0_0 = singletonClass("BattleTeamData")

function var_0_0.Init(arg_1_0)
	arg_1_0.battleTeam_ = {}
	arg_1_0.stageTeam_ = {}
	arg_1_0.stageTeamTrial_ = {}
	arg_1_0.trialActivityData_ = {}
	arg_1_0.teamRawData_ = {}
	arg_1_0.reservesTeamList_ = {}
	arg_1_0.reservesTempTeamList_ = {}
end

var_0_0.NO_OWNER = "0"
var_0_0.EMPTY_ENTRY = {
	hero_id = 0,
	owner_id = var_0_0.NO_OWNER
}

function var_0_0.IsValidOwner(arg_2_0)
	if arg_2_0 == nil then
		return false
	end

	return tostring(arg_2_0) ~= var_0_0.NO_OWNER
end

function var_0_0.InitTeam(arg_3_0, arg_3_1)
	arg_3_0.teamRawData_ = arg_3_0:CreateTeamRawData(arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = iter_3_1.stage_type
		local var_3_1 = iter_3_1.activity_id or 0
		local var_3_2 = GetHeroTeamActivityID(var_3_0, var_3_1)

		arg_3_0.battleTeam_[var_3_0] = arg_3_0.battleTeam_[var_3_0] or {}
		arg_3_0.battleTeam_[var_3_0][var_3_2] = {}

		local var_3_3 = {}

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.cont_teams or {}) do
			local var_3_4 = {
				teams = {},
				cont_id = iter_3_3.cont_id
			}
			local var_3_5 = cleanProtoTable(iter_3_3.teams)

			for iter_3_4, iter_3_5 in ipairs(iter_3_3.teams or {}) do
				local var_3_6 = {
					id = iter_3_5.id,
					result = iter_3_5.result
				}
				local var_3_7 = {}
				local var_3_8 = {}
				local var_3_9 = {}

				for iter_3_6, iter_3_7 in ipairs(iter_3_5.hero_list or {}) do
					if iter_3_7.hero_type == 1 or iter_3_7.hero_id == 0 then
						var_3_7[iter_3_6] = iter_3_7.hero_id
						var_3_8[iter_3_6] = 0
						var_3_9[iter_3_6] = clone(var_0_0.EMPTY_ENTRY)
					elseif iter_3_7.hero_type == 2 then
						var_3_7[iter_3_6] = HeroStandardSystemCfg[iter_3_7.hero_id].hero_id
						var_3_8[iter_3_6] = iter_3_7.hero_id
						var_3_9[iter_3_6] = clone(var_0_0.EMPTY_ENTRY)
					else
						var_3_7[iter_3_6] = 0
						var_3_8[iter_3_6] = 0
						var_3_9[iter_3_6] = {
							hero_id = iter_3_7.hero_id,
							owner_id = iter_3_7.owner_id
						}
					end
				end

				for iter_3_8 = 1, 3 do
					var_3_7[iter_3_8] = var_3_7[iter_3_8] or 0
					var_3_8[iter_3_8] = var_3_8[iter_3_8] or 0
					var_3_9[iter_3_8] = var_3_9[iter_3_8] or clone(var_0_0.EMPTY_ENTRY)
				end

				var_3_6.singleTeam = var_3_7
				var_3_6.heroTrialList = var_3_8
				var_3_6.heroAssistList = var_3_9
				var_3_6.combo = iter_3_5.cooperate_unique_skill_id
				var_3_6.mimir = {
					id = iter_3_5.mimir_info.mimir_id,
					chip = cleanProtoTable(iter_3_5.mimir_info.chip_list or {})
				}

				table.insert(var_3_4.teams, var_3_6)
			end

			table.insert(var_3_3, var_3_4)
		end

		local var_3_10 = {
			chess_data_info_1 = {},
			chess_data_info_2 = {}
		}

		for iter_3_9, iter_3_10 in ipairs(iter_3_1.data.chess_data_info_1) do
			local var_3_11 = {
				cont_id = iter_3_10.cont_id,
				chess_pos = cleanProtoTable(iter_3_10.chess_pos)
			}

			table.insert(var_3_10.chess_data_info_1, var_3_11)
		end

		for iter_3_11, iter_3_12 in ipairs(iter_3_1.data.chess_data_info_2) do
			local var_3_12 = {
				cont_id = iter_3_12.cont_id,
				team_id = iter_3_12.team_id,
				chess_ai_chip_list = cleanProtoTable(iter_3_12.chess_ai_chip_list)
			}

			table.insert(var_3_10.chess_data_info_2, var_3_12)
		end

		arg_3_0.battleTeam_[var_3_0][var_3_2].cont_teams = var_3_3
		arg_3_0.battleTeam_[var_3_0][var_3_2].data = var_3_10
	end
end

function var_0_0.CreateTeamRawData(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		var_4_0[iter_4_1.stage_type] = {}

		local var_4_1 = {}

		if iter_4_1.cont_teams[1] and iter_4_1.cont_teams[1].teams[1] then
			var_4_1 = iter_4_1.cont_teams[1].teams[1].hero_list or {}
		end

		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			table.insert(var_4_0[iter_4_1.stage_type], {
				hero_id = iter_4_3.hero_id,
				owner_id = iter_4_3.owner_id,
				hero_type = iter_4_3.hero_type
			})
		end
	end

	return var_4_0
end

function var_0_0.InitReservesTeam(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.formation_list or {}

	for iter_5_0 = 1, 10 do
		arg_5_0.reservesTeamList_[iter_5_0] = {
			comboSkill = 0,
			name = "",
			index = iter_5_0,
			hero_list = {
				0,
				0,
				0
			},
			chipInfo = {
				id = 0,
				list = {}
			}
		}
	end

	for iter_5_1, iter_5_2 in ipairs(var_5_0 or {}) do
		local var_5_1 = iter_5_2.id
		local var_5_2 = {
			0,
			0,
			0
		}

		for iter_5_3, iter_5_4 in ipairs(iter_5_2.hero_list or {}) do
			var_5_2[iter_5_3] = iter_5_4
		end

		local var_5_3 = {}
		local var_5_4 = iter_5_2.mimir_info[1] or {}

		for iter_5_5, iter_5_6 in ipairs(var_5_4.chip_list or {}) do
			table.insert(var_5_3, iter_5_6)
		end

		arg_5_0.reservesTeamList_[var_5_1] = {
			index = var_5_1,
			name = iter_5_2.name,
			hero_list = var_5_2,
			comboSkill = iter_5_2.cooperate_unique_skill_id or 0,
			chipInfo = {
				id = var_5_4.mimir_id or 0,
				list = var_5_3 or {}
			}
		}
	end
end

function var_0_0.SetStageTeam(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.stageTeam_[arg_6_1] = arg_6_2
	arg_6_0.stageTeamTrial_[arg_6_1] = arg_6_3
end

function var_0_0.GetStageTeam(arg_7_0, arg_7_1)
	return clone(arg_7_0.stageTeam_[arg_7_1]), clone(arg_7_0.stageTeamTrial_[arg_7_1])
end

function var_0_0.SetSingleTeam(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8)
	local var_8_0 = GetHeroTeamActivityID(arg_8_1, arg_8_2)
	local var_8_1 = arg_8_5 or BattleTeamData:GetComboInfo(arg_8_1, arg_8_2, arg_8_7, arg_8_8)
	local var_8_2 = {}

	if not arg_8_6 then
		var_8_2.id, var_8_2.chip = BattleTeamData:GetMimirInfo(arg_8_1, arg_8_2, arg_8_7, arg_8_8)
	else
		var_8_2.id = arg_8_6.id or 0
		var_8_2.chip = arg_8_6.chip or {}
	end

	arg_8_0:CreatBaseTeamInfo(arg_8_1, var_8_0, arg_8_7, arg_8_8)

	local var_8_3 = {}

	if not arg_8_7 or arg_8_7 == 0 then
		if not arg_8_8 or arg_8_8 == 0 then
			var_8_3 = arg_8_0.battleTeam_[arg_8_1][var_8_0].cont_teams[1].teams[1]
		else
			for iter_8_0, iter_8_1 in ipairs(arg_8_0.battleTeam_[arg_8_1][var_8_0].cont_teams[1].teams) do
				if iter_8_1.id == arg_8_8 then
					var_8_3 = iter_8_1

					break
				end
			end
		end
	else
		for iter_8_2, iter_8_3 in ipairs(arg_8_0.battleTeam_[arg_8_1][var_8_0].cont_teams) do
			if iter_8_3.cont_id == arg_8_7 then
				if not arg_8_8 or arg_8_8 == 0 then
					var_8_3 = iter_8_3.teams[1]

					break
				end

				for iter_8_4, iter_8_5 in ipairs(iter_8_3.teams) do
					if iter_8_5.id == arg_8_8 then
						var_8_3 = iter_8_5

						break
					end
				end

				break
			end
		end
	end

	var_8_3.singleTeam = deepClone(arg_8_3)
	var_8_3.heroTrialList = deepClone(arg_8_4)
	var_8_3.combo = var_8_1
	var_8_3.mimir = var_8_2
end

function var_0_0.CreatBaseTeamInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = GetHeroTeamActivityID(arg_9_1, arg_9_2)

	arg_9_0.battleTeam_[arg_9_1] = arg_9_0.battleTeam_[arg_9_1] or {}
	arg_9_0.battleTeam_[arg_9_1][var_9_0] = arg_9_0.battleTeam_[arg_9_1][var_9_0] or {}
	arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams = arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams or {}

	if arg_9_0.battleTeam_[arg_9_1][var_9_0] and not arg_9_3 and not arg_9_4 and #arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams > 0 then
		return
	end

	local var_9_1

	if arg_9_3 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams) do
			if iter_9_1.cont_id == arg_9_3 then
				var_9_1 = iter_9_1
			end
		end
	else
		var_9_1 = arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams[1]
	end

	var_9_1 = var_9_1 or {
		teams = {},
		cont_id = arg_9_3
	}

	local var_9_2

	if arg_9_4 then
		for iter_9_2, iter_9_3 in ipairs(var_9_1.teams) do
			if iter_9_3.id == arg_9_4 then
				return
			end
		end
	else
		var_9_2 = var_9_1.teams[1]
	end

	var_9_2 = var_9_2 or {
		combo = 0,
		id = arg_9_4,
		singleTeam = {
			0,
			0,
			0
		},
		heroTrialList = {
			0,
			0,
			0
		},
		heroAssistList = {
			clone(var_0_0.EMPTY_ENTRY),
			clone(var_0_0.EMPTY_ENTRY),
			clone(var_0_0.EMPTY_ENTRY)
		},
		mimir = {
			id = 0,
			chip = {}
		}
	}

	table.insert(var_9_1.teams, var_9_2)
	table.insert(arg_9_0.battleTeam_[arg_9_1][var_9_0].cont_teams, var_9_1)

	local var_9_3 = {
		chess_data_info_1 = {},
		chess_data_info_2 = {}
	}

	arg_9_0.battleTeam_[arg_9_1][var_9_0].data = arg_9_0.battleTeam_[arg_9_1][var_9_0].data or var_9_3
end

function var_0_0.GetSingleTeam(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = GetHeroTeamActivityID(arg_10_1, arg_10_2)

	arg_10_0:CreatBaseTeamInfo(arg_10_1, var_10_0, arg_10_3, arg_10_4)

	if not arg_10_3 or arg_10_3 == 0 then
		if not arg_10_4 or arg_10_4 == 0 then
			return clone(arg_10_0.battleTeam_[arg_10_1][var_10_0].cont_teams[1].teams[1].singleTeam or {
				0,
				0,
				0
			}), clone(arg_10_0.battleTeam_[arg_10_1][var_10_0].cont_teams[1].teams[1].heroTrialList or {
				0,
				0,
				0
			})
		else
			for iter_10_0, iter_10_1 in ipairs(arg_10_0.battleTeam_[arg_10_1][var_10_0].cont_teams[1].teams) do
				if iter_10_1.id == arg_10_4 then
					return clone(iter_10_1.singleTeam or {
						0,
						0,
						0
					}), clone(iter_10_1.heroTrialList or {
						0,
						0,
						0
					})
				end
			end
		end
	else
		for iter_10_2, iter_10_3 in ipairs(arg_10_0.battleTeam_[arg_10_1][var_10_0].cont_teams) do
			if iter_10_3.cont_id == arg_10_3 then
				if not arg_10_4 or arg_10_4 == 0 then
					return clone(iter_10_3.teams[1].singleTeam or {
						0,
						0,
						0
					}), clone(iter_10_3.teams[1].heroTrialList or {
						0,
						0,
						0
					})
				else
					for iter_10_4, iter_10_5 in ipairs(iter_10_3.teams) do
						if iter_10_5.id == arg_10_4 then
							return clone(iter_10_5.singleTeam or {
								0,
								0,
								0
							}), clone(iter_10_5.heroTrialList or {
								0,
								0,
								0
							})
						end
					end
				end
			end
		end
	end

	return {
		0,
		0,
		0
	}, {
		0,
		0,
		0
	}
end

function var_0_0.GetMultiTeam(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = GetHeroTeamActivityID(arg_11_1, arg_11_2)

	arg_11_0:CreatBaseTeamInfo(arg_11_1, var_11_0)

	return arg_11_0.battleTeam_[arg_11_1][var_11_0]
end

function var_0_0.GetMimirInfo(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = GetHeroTeamActivityID(arg_12_1, arg_12_2)

	arg_12_0:CreatBaseTeamInfo(arg_12_1, var_12_0, arg_12_3, arg_12_4)

	if not arg_12_3 or arg_12_3 == 0 then
		if not arg_12_4 or arg_12_4 == 0 then
			return clone(arg_12_0.battleTeam_[arg_12_1][var_12_0].cont_teams[1].teams[1].mimir.id or 0), clone(arg_12_0.battleTeam_[arg_12_1][var_12_0].cont_teams[1].teams[1].mimir.chip or {})
		else
			for iter_12_0, iter_12_1 in ipairs(arg_12_0.battleTeam_[arg_12_1][var_12_0].cont_teams[1].teams) do
				if iter_12_1.id == arg_12_4 then
					return clone(iter_12_1.mimir.id or 0), clone(iter_12_1.mimir.chip or {})
				end
			end
		end
	else
		for iter_12_2, iter_12_3 in ipairs(arg_12_0.battleTeam_[arg_12_1][var_12_0].cont_teams) do
			if iter_12_3.cont_id == arg_12_3 then
				if not arg_12_4 or arg_12_4 == 0 then
					return clone(iter_12_3.teams[1].mimir.id or 0), clone(iter_12_3.teams[1].mimir.chip or {})
				else
					for iter_12_4, iter_12_5 in ipairs(iter_12_3.teams) do
						if iter_12_5.id == arg_12_4 then
							return clone(iter_12_5.mimir.id or 0), clone(iter_12_5.mimir.chip or {})
						end
					end
				end
			end
		end
	end

	return 0, {}
end

function var_0_0.GetMimirIDInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = GetHeroTeamActivityID(arg_13_1, arg_13_2)

	arg_13_0:CreatBaseTeamInfo(arg_13_1, var_13_0, arg_13_3, arg_13_4)

	if not arg_13_3 or arg_13_3 == 0 then
		if not arg_13_4 or arg_13_4 == 0 then
			return clone(arg_13_0.battleTeam_[arg_13_1][var_13_0].cont_teams[1].teams[1].mimir.id or 0)
		else
			for iter_13_0, iter_13_1 in ipairs(arg_13_0.battleTeam_[arg_13_1][var_13_0].cont_teams[1].teams) do
				if iter_13_1.id == arg_13_4 then
					return clone(iter_13_1.mimir.id or 0)
				end
			end
		end
	else
		for iter_13_2, iter_13_3 in ipairs(arg_13_0.battleTeam_[arg_13_1][var_13_0].cont_teams) do
			if iter_13_3.cont_id == arg_13_3 then
				if not arg_13_4 or arg_13_4 == 0 then
					return clone(iter_13_3.teams[1].mimir.id or 0)
				else
					for iter_13_4, iter_13_5 in ipairs(iter_13_3.teams) do
						if iter_13_5.id == arg_13_4 then
							return clone(iter_13_5.mimir.id or 0)
						end
					end
				end
			end
		end
	end

	return 0
end

function var_0_0.GetMimirChipInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = GetHeroTeamActivityID(arg_14_1, arg_14_2)

	arg_14_0:CreatBaseTeamInfo(arg_14_1, var_14_0, arg_14_3, arg_14_4)

	if not arg_14_3 or arg_14_3 == 0 then
		if not arg_14_4 or arg_14_4 == 0 then
			return clone(arg_14_0.battleTeam_[arg_14_1][var_14_0].cont_teams[1].teams[1].mimir.chip or {})
		else
			for iter_14_0, iter_14_1 in ipairs(arg_14_0.battleTeam_[arg_14_1][var_14_0].cont_teams[1].teams) do
				if iter_14_1.id == arg_14_4 then
					return clone(iter_14_1.mimir.chip or {})
				end
			end
		end
	else
		for iter_14_2, iter_14_3 in ipairs(arg_14_0.battleTeam_[arg_14_1][var_14_0].cont_teams) do
			if iter_14_3.cont_id == arg_14_3 then
				if not arg_14_4 or arg_14_4 == 0 then
					return clone(iter_14_3.teams[1].mimir.chip or {})
				else
					for iter_14_4, iter_14_5 in ipairs(iter_14_3.teams) do
						if iter_14_5.id == arg_14_4 then
							return clone(iter_14_5.mimir.chip or {})
						end
					end
				end
			end
		end
	end

	return {}
end

function var_0_0.SetMimirIDInfo(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = GetHeroTeamActivityID(arg_15_1, arg_15_2)

	arg_15_0:CreatBaseTeamInfo(arg_15_1, var_15_0, arg_15_4, arg_15_5)

	local var_15_1

	if not arg_15_4 or arg_15_4 == 0 then
		if not arg_15_5 or arg_15_5 == 0 then
			var_15_1 = arg_15_0.battleTeam_[arg_15_1][var_15_0].cont_teams[1].teams[1].mimir
		else
			for iter_15_0, iter_15_1 in ipairs(arg_15_0.battleTeam_[arg_15_1][var_15_0].cont_teams[1].teams) do
				if iter_15_1.id == arg_15_5 then
					var_15_1 = iter_15_1.mimir

					break
				end
			end
		end
	else
		for iter_15_2, iter_15_3 in ipairs(arg_15_0.battleTeam_[arg_15_1][var_15_0].cont_teams) do
			if iter_15_3.cont_id == arg_15_4 then
				if not arg_15_5 or arg_15_5 == 0 then
					var_15_1 = iter_15_3.teams[1].mimir

					break
				end

				for iter_15_4, iter_15_5 in ipairs(iter_15_3.teams) do
					if iter_15_5.id == arg_15_5 then
						var_15_1 = iter_15_5.mimir

						break
					end
				end

				break
			end
		end
	end

	if var_15_1 then
		var_15_1.id = arg_15_3 or 0

		if not var_15_1 or arg_15_3 == 0 then
			var_15_1.chip = arg_15_0:GetMimirChipInfo(arg_15_1, arg_15_2, arg_15_4, arg_15_5)
		end
	end
end

function var_0_0.SetMimirChipInfo(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = GetHeroTeamActivityID(arg_16_1, arg_16_2)

	arg_16_0:CreatBaseTeamInfo(arg_16_1, var_16_0, arg_16_4, arg_16_5)

	if not arg_16_4 or arg_16_4 == 0 then
		if not arg_16_5 or arg_16_5 == 0 then
			arg_16_0.battleTeam_[arg_16_1][var_16_0].cont_teams[1].teams[1].mimir.chip = clone(arg_16_3 or {})
		else
			for iter_16_0, iter_16_1 in ipairs(arg_16_0.battleTeam_[arg_16_1][var_16_0].cont_teams[1].teams) do
				if iter_16_1.id == arg_16_5 then
					iter_16_1.mimir.chip = clone(arg_16_3 or {})

					break
				end
			end
		end
	else
		for iter_16_2, iter_16_3 in ipairs(arg_16_0.battleTeam_[arg_16_1][var_16_0].cont_teams) do
			if iter_16_3.cont_id == arg_16_4 then
				if not arg_16_5 or arg_16_5 == 0 then
					iter_16_3.teams[1].mimir.chip = clone(arg_16_3 or {})

					break
				end

				for iter_16_4, iter_16_5 in ipairs(iter_16_3.teams) do
					if iter_16_5.id == arg_16_5 then
						iter_16_5.mimir.chip = clone(arg_16_3 or {})

						break
					end
				end

				break
			end
		end
	end
end

function var_0_0.InsertMimirChipInfo(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = GetHeroTeamActivityID(arg_17_1, arg_17_2)
	local var_17_1 = {}

	arg_17_0:CreatBaseTeamInfo(arg_17_1, var_17_0, arg_17_4, arg_17_5)

	if not arg_17_4 or arg_17_4 == 0 then
		if not arg_17_5 or arg_17_5 == 0 then
			var_17_1 = arg_17_0.battleTeam_[arg_17_1][var_17_0].cont_teams[1].teams[1].mimir.chip
		else
			for iter_17_0, iter_17_1 in ipairs(arg_17_0.battleTeam_[arg_17_1][var_17_0].cont_teams[1].teams) do
				if iter_17_1.id == arg_17_5 then
					var_17_1 = iter_17_1.mimir.chip

					break
				end
			end
		end
	else
		for iter_17_2, iter_17_3 in ipairs(arg_17_0.battleTeam_[arg_17_1][var_17_0].cont_teams) do
			if iter_17_3.cont_id == arg_17_4 then
				if not arg_17_5 or arg_17_5 == 0 then
					var_17_1 = iter_17_3.teams[1].mimir.chip

					break
				end

				for iter_17_4, iter_17_5 in ipairs(iter_17_3.teams) do
					if iter_17_5.id == arg_17_5 then
						var_17_1 = iter_17_5.mimir.chip

						break
					end
				end

				break
			end
		end
	end

	ChipTools.InsertChip(var_17_1, arg_17_3)
end

function var_0_0.RemoveMimirChipInfo(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = GetHeroTeamActivityID(arg_18_1, arg_18_2)
	local var_18_1 = {}

	arg_18_0:CreatBaseTeamInfo(arg_18_1, var_18_0, arg_18_4, arg_18_5)

	if not arg_18_4 or arg_18_4 == 0 then
		if not arg_18_5 or arg_18_5 == 0 then
			var_18_1 = arg_18_0.battleTeam_[arg_18_1][var_18_0].cont_teams[1].teams[1].mimir.chip
		else
			for iter_18_0, iter_18_1 in ipairs(arg_18_0.battleTeam_[arg_18_1][var_18_0].cont_teams[1].teams) do
				if iter_18_1.id == arg_18_5 then
					var_18_1 = iter_18_1.mimir.chip

					break
				end
			end
		end
	else
		for iter_18_2, iter_18_3 in ipairs(arg_18_0.battleTeam_[arg_18_1][var_18_0].cont_teams) do
			if iter_18_3.cont_id == arg_18_4 then
				if not arg_18_5 or arg_18_5 == 0 then
					var_18_1 = iter_18_3.teams[1].mimir.chip

					break
				end

				for iter_18_4, iter_18_5 in ipairs(iter_18_3.teams) do
					if iter_18_5.id == arg_18_5 then
						var_18_1 = iter_18_5.mimir.chip

						break
					end
				end

				break
			end
		end
	end

	ChipTools.RemoveChip(var_18_1, arg_18_3)
end

function var_0_0.GetComboInfo(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = GetHeroTeamActivityID(arg_19_1, arg_19_2)

	arg_19_0:CreatBaseTeamInfo(arg_19_1, var_19_0, arg_19_3, arg_19_4)

	if not arg_19_3 or arg_19_3 == 0 then
		if not arg_19_4 or arg_19_4 == 0 then
			return clone(arg_19_0.battleTeam_[arg_19_1][var_19_0].cont_teams[1].teams[1].combo or 0)
		else
			for iter_19_0, iter_19_1 in ipairs(arg_19_0.battleTeam_[arg_19_1][var_19_0].cont_teams[1].teams) do
				if iter_19_1.id == arg_19_4 then
					return clone(iter_19_1.combo or 0)
				end
			end
		end
	else
		for iter_19_2, iter_19_3 in ipairs(arg_19_0.battleTeam_[arg_19_1][var_19_0].cont_teams) do
			if iter_19_3.cont_id == arg_19_3 then
				if not arg_19_4 or arg_19_4 == 0 then
					return clone(iter_19_3.teams[1].combo or 0)
				else
					for iter_19_4, iter_19_5 in ipairs(iter_19_3.teams) do
						if iter_19_5.id == arg_19_4 then
							return clone(iter_19_5.combo or 0)
						end
					end
				end
			end
		end
	end

	return 0
end

function var_0_0.SetComboInfo(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = GetHeroTeamActivityID(arg_20_1, arg_20_2)

	arg_20_0:CreatBaseTeamInfo(arg_20_1, var_20_0, arg_20_4, arg_20_5)

	if not arg_20_4 or arg_20_4 == 0 then
		if not arg_20_5 or arg_20_5 == 0 then
			arg_20_0.battleTeam_[arg_20_1][var_20_0].cont_teams[1].teams[1].combo = arg_20_3
		else
			for iter_20_0, iter_20_1 in ipairs(arg_20_0.battleTeam_[arg_20_1][var_20_0].cont_teams[1].teams) do
				if iter_20_1.id == arg_20_5 then
					iter_20_1.combo = arg_20_3

					break
				end
			end
		end
	else
		for iter_20_2, iter_20_3 in ipairs(arg_20_0.battleTeam_[arg_20_1][var_20_0].cont_teams) do
			if iter_20_3.cont_id == arg_20_4 then
				if not arg_20_5 or arg_20_5 == 0 then
					iter_20_3.teams[1].combo = arg_20_3

					break
				end

				for iter_20_4, iter_20_5 in ipairs(iter_20_3.teams) do
					if iter_20_5.id == arg_20_5 then
						iter_20_5.combo = arg_20_3

						break
					end
				end

				break
			end
		end
	end
end

function var_0_0.ReSetMythicTeamData(arg_21_0)
	local var_21_0 = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
	local var_21_1 = GetHeroTeamActivityID(var_21_0)

	arg_21_0.battleTeam_[var_21_0][var_21_1].cont_teams[1].teams = {}
end

function var_0_0.ResetTeamData(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.battleTeam_[arg_22_2] and arg_22_0.battleTeam_[arg_22_2][arg_22_1] then
		arg_22_0.battleTeam_[arg_22_2][arg_22_1].cont_teams = {}
	end
end

function var_0_0.SetMultiTeamData(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6, arg_23_7, arg_23_8)
	local var_23_0 = GetHeroTeamActivityID(arg_23_1, arg_23_2)

	arg_23_0:SetSingleTeam(arg_23_1, var_23_0, arg_23_3, arg_23_4, arg_23_5, arg_23_6, arg_23_7, arg_23_8)

	for iter_23_0 = 1, 3 do
		if iter_23_0 ~= arg_23_8 then
			local var_23_1 = {}
			local var_23_2 = {}
			local var_23_3, var_23_4 = arg_23_0:GetSingleTeam(arg_23_1, var_23_0, arg_23_7, iter_23_0)

			for iter_23_1, iter_23_2 in ipairs(var_23_3) do
				local var_23_5 = false

				if iter_23_2 ~= 0 and table.indexof(arg_23_3, iter_23_2) then
					var_23_5 = true

					local var_23_6 = arg_23_0:GetComboInfo(arg_23_1, var_23_0, arg_23_7, iter_23_0)

					if ComboSkillCfg[var_23_6] then
						for iter_23_3, iter_23_4 in pairs(ComboSkillCfg[var_23_6].cooperate_role_ids) do
							if iter_23_2 == iter_23_4 then
								arg_23_0:SetComboInfo(arg_23_1, var_23_0, 0, arg_23_7, iter_23_0)

								break
							end
						end
					end
				end

				if not var_23_5 then
					table.insert(var_23_1, iter_23_2)
					table.insert(var_23_2, var_23_4[iter_23_1] or 0)
				end
			end

			for iter_23_5 = #var_23_1 + 1, 3 do
				var_23_1[iter_23_5] = 0
			end

			arg_23_0:SetSingleTeam(arg_23_1, var_23_0, var_23_1, var_23_2, nil, nil, arg_23_7, iter_23_0)
		end
	end
end

function var_0_0.SwapTeam(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	local var_24_0 = arg_24_0:GetMultiTeam(arg_24_1, arg_24_2)
	local var_24_1 = {}

	if not arg_24_3 or arg_24_3 == 0 then
		var_24_1 = var_24_0.cont_teams[1]
	else
		for iter_24_0, iter_24_1 in ipairs(var_24_0.cont_teams) do
			if iter_24_1.cont_id == arg_24_3 then
				var_24_1 = iter_24_1

				break
			end
		end
	end

	for iter_24_2, iter_24_3 in ipairs(var_24_1.teams) do
		if iter_24_3.id == arg_24_4 then
			iter_24_3.id = arg_24_5
		elseif iter_24_3.id == arg_24_5 then
			iter_24_3.id = arg_24_4
		end
	end
end

function var_0_0.SetGuildSingleTeam(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6, arg_25_7)
	local var_25_0 = GetHeroTeamActivityID(arg_25_1, arg_25_2)
	local var_25_1 = arg_25_4 or BattleTeamData:GetComboInfo(arg_25_1, arg_25_2, arg_25_6, arg_25_7)
	local var_25_2 = {}

	if not arg_25_5 then
		var_25_2.id, var_25_2.chip = BattleTeamData:GetMimirInfo(arg_25_1, arg_25_2, arg_25_6, arg_25_7)
	else
		var_25_2.id = arg_25_5.id or 0
		var_25_2.chip = arg_25_5.chip or {}
	end

	arg_25_0:CreatBaseTeamInfo(arg_25_1, var_25_0, arg_25_6, arg_25_7)

	local var_25_3 = {}

	if not arg_25_6 or arg_25_6 == 0 then
		if not arg_25_7 or arg_25_7 == 0 then
			var_25_3 = arg_25_0.battleTeam_[arg_25_1][var_25_0].cont_teams[1].teams[1]
		else
			for iter_25_0, iter_25_1 in ipairs(arg_25_0.battleTeam_[arg_25_1][var_25_0].cont_teams[1].teams) do
				if iter_25_1.id == arg_25_7 then
					var_25_3 = iter_25_1

					break
				end
			end
		end
	else
		for iter_25_2, iter_25_3 in ipairs(arg_25_0.battleTeam_[arg_25_1][var_25_0].cont_teams) do
			if iter_25_3.cont_id == arg_25_6 then
				if not arg_25_7 or arg_25_7 == 0 then
					var_25_3 = iter_25_3.teams[1]

					break
				end

				for iter_25_4, iter_25_5 in ipairs(iter_25_3.teams) do
					if iter_25_5.id == arg_25_7 then
						var_25_3 = iter_25_5

						break
					end
				end

				break
			end
		end
	end

	local var_25_4 = {}
	local var_25_5 = {}
	local var_25_6 = {}

	for iter_25_6, iter_25_7 in ipairs(arg_25_3 or {}) do
		if iter_25_7.hero_type == 1 or iter_25_7.hero_id == 0 then
			var_25_4[iter_25_6] = iter_25_7.hero_id
			var_25_5[iter_25_6] = 0
			var_25_6[iter_25_6] = clone(var_0_0.EMPTY_ENTRY)
		elseif iter_25_7.hero_type == 2 then
			var_25_4[iter_25_6] = HeroStandardSystemCfg[iter_25_7.hero_id].hero_id
			var_25_5[iter_25_6] = iter_25_7.hero_id
			var_25_6[iter_25_6] = clone(var_0_0.EMPTY_ENTRY)
		else
			var_25_4[iter_25_6] = 0
			var_25_5[iter_25_6] = 0
			var_25_6[iter_25_6] = {
				hero_id = iter_25_7.hero_id,
				owner_id = iter_25_7.owner_id
			}
		end
	end

	for iter_25_8 = 1, 3 do
		var_25_4[iter_25_8] = var_25_4[iter_25_8] or 0
		var_25_5[iter_25_8] = var_25_5[iter_25_8] or 0
		var_25_6[iter_25_8] = var_25_6[iter_25_8] or clone(var_0_0.EMPTY_ENTRY)
	end

	var_25_3.singleTeam = deepClone(var_25_4)
	var_25_3.heroTrialList = deepClone(var_25_5)
	var_25_3.heroAssistList = deepClone(var_25_6)
	var_25_3.combo = var_25_1
	var_25_3.mimir = var_25_2
end

function var_0_0.GetGuildSingleTeam(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = GetHeroTeamActivityID(arg_26_1, arg_26_2)

	arg_26_0:CreatBaseTeamInfo(arg_26_1, var_26_0, arg_26_3, arg_26_4)

	local var_26_1 = {
		clone(var_0_0.EMPTY_ENTRY),
		clone(var_0_0.EMPTY_ENTRY),
		clone(var_0_0.EMPTY_ENTRY)
	}

	if not arg_26_3 or arg_26_3 == 0 then
		if not arg_26_4 or arg_26_4 == 0 then
			return clone(arg_26_0.battleTeam_[arg_26_1][var_26_0].cont_teams[1].teams[1].singleTeam or {
				0,
				0,
				0
			}), clone(arg_26_0.battleTeam_[arg_26_1][var_26_0].cont_teams[1].teams[1].heroTrialList or {
				0,
				0,
				0
			}), clone(arg_26_0.battleTeam_[arg_26_1][var_26_0].cont_teams[1].teams[1].heroAssistList or var_26_1)
		else
			for iter_26_0, iter_26_1 in ipairs(arg_26_0.battleTeam_[arg_26_1][var_26_0].cont_teams[1].teams) do
				if iter_26_1.id == arg_26_4 then
					return clone(iter_26_1.singleTeam or {
						0,
						0,
						0
					}), clone(iter_26_1.heroTrialList or {
						0,
						0,
						0
					}), clone(iter_26_1.heroAssistList or var_26_1)
				end
			end
		end
	else
		for iter_26_2, iter_26_3 in ipairs(arg_26_0.battleTeam_[arg_26_1][var_26_0].cont_teams) do
			if iter_26_3.cont_id == arg_26_3 then
				if not arg_26_4 or arg_26_4 == 0 then
					return clone(iter_26_3.teams[1].singleTeam or {
						0,
						0,
						0
					}), clone(iter_26_3.teams[1].heroTrialList or {
						0,
						0,
						0
					}), clone(iter_26_3.teams[1].heroAssistList or var_26_1)
				else
					for iter_26_4, iter_26_5 in ipairs(iter_26_3.teams) do
						if iter_26_5.id == arg_26_4 then
							return clone(iter_26_5.singleTeam or {
								0,
								0,
								0
							}), clone(iter_26_5.heroTrialList or {
								0,
								0,
								0
							}), clone(iter_26_5.heroAssistList or var_26_1)
						end
					end
				end
			end
		end
	end

	return {
		0,
		0,
		0
	}, {
		0,
		0,
		0
	}, var_26_1
end

function var_0_0.UpdateHeroTrial(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1.hero_trial_list) do
		arg_27_0.trialActivityData_[iter_27_1.activity_id] = {}

		for iter_27_2, iter_27_3 in ipairs(iter_27_1.template_hero_list) do
			table.insert(arg_27_0.trialActivityData_[iter_27_1.activity_id], iter_27_3)
		end
	end
end

function var_0_0.GetHeroTrial(arg_28_0, arg_28_1)
	if ActivityTools.GetActivityType(arg_28_1) == ActivityTemplateConst.SURVIVE_SOLO_LEVEL then
		return ActivitySoloSlayerCfg[arg_28_1].hero_standard_system_id_list
	end

	return arg_28_0.trialActivityData_[arg_28_1]
end

function var_0_0.SetHeroTrial(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.trialActivityData_[arg_29_1] = arg_29_2
end

function var_0_0.SetTeamRawData(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.teamRawData_[arg_30_1] = arg_30_2
end

function var_0_0.GetTeamRawDataByType(arg_31_0, arg_31_1)
	if not arg_31_0.teamRawData_ then
		return nil
	end

	return arg_31_0.teamRawData_[arg_31_1]
end

function var_0_0.GetTeamRawData(arg_32_0)
	return arg_32_0.teamRawData_
end

function var_0_0.GetReservesTeamList(arg_33_0)
	return arg_33_0.reservesTeamList_
end

function var_0_0.GetReservesTeam(arg_34_0, arg_34_1)
	if arg_34_0.reservesTeamList_[arg_34_1] then
		return deepClone(arg_34_0.reservesTeamList_[arg_34_1].hero_list)
	end

	return {
		0,
		0,
		0
	}
end

function var_0_0.SetReservesTeam(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		local var_35_0 = iter_35_1.id

		arg_35_0.reservesTeamList_[var_35_0].name = iter_35_1.name
		arg_35_0.reservesTeamList_[var_35_0].hero_list = deepClone(iter_35_1.hero_list)
		arg_35_0.reservesTeamList_[var_35_0].comboSkill = iter_35_1.cooperate_unique_skill_id
		arg_35_0.reservesTeamList_[var_35_0].chipInfo = {
			id = iter_35_1.mimir_info[1].mimir_id,
			list = deepClone(iter_35_1.mimir_info[1].chip_list)
		}
		arg_35_0.reservesTempTeamList_[var_35_0].name = iter_35_1.name
		arg_35_0.reservesTempTeamList_[var_35_0].hero_list = deepClone(iter_35_1.hero_list)
		arg_35_0.reservesTempTeamList_[var_35_0].comboSkill = iter_35_1.cooperate_unique_skill_id
		arg_35_0.reservesTempTeamList_[var_35_0].chipInfo = {
			id = iter_35_1.mimir_info[1].mimir_id,
			list = deepClone(iter_35_1.mimir_info[1].chip_list)
		}
	end
end

function var_0_0.InitTempList(arg_36_0)
	arg_36_0.reservesTempTeamList_ = {}
	arg_36_0.reservesTempTeamList_ = deepClone(arg_36_0.reservesTeamList_)

	return arg_36_0.reservesTempTeamList_
end

function var_0_0.SetCurTeam(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = 0

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.reservesTempTeamList_) do
		if iter_37_1.hero_list[1] == 0 then
			iter_37_1.name = ""
			iter_37_1.hero_list = deepClone(arg_37_1)
			iter_37_1.comboSkill = arg_37_2
			iter_37_1.chipInfo = {
				id = arg_37_3.enabledID,
				list = deepClone(arg_37_3.chipList)
			}
			var_37_0 = iter_37_0

			return var_37_0
		end
	end

	return var_37_0
end

function var_0_0.GetReservesTempTeamList(arg_38_0)
	return arg_38_0.reservesTempTeamList_
end

function var_0_0.SetReservesTempTeamList(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = arg_39_0.reservesTempTeamList_[arg_39_1].hero_list

	if arg_39_3 == 0 then
		if arg_39_2 ~= 2 then
			var_39_0[arg_39_2] = 0
		else
			var_39_0[2] = var_39_0[3]
			var_39_0[3] = 0
		end
	else
		if table.indexof(var_39_0, arg_39_3) then
			var_39_0[table.indexof(var_39_0, arg_39_3)] = var_39_0[arg_39_2]
			var_39_0[arg_39_2] = arg_39_3
		else
			var_39_0[arg_39_2] = arg_39_3
		end

		if var_39_0[2] == 0 then
			var_39_0[2] = var_39_0[3]
			var_39_0[3] = 0
		end
	end

	local var_39_1 = arg_39_0.reservesTempTeamList_[arg_39_1].comboSkill

	if var_39_1 ~= 0 then
		local var_39_2 = ComboSkillCfg[var_39_1]

		for iter_39_0, iter_39_1 in ipairs(var_39_2.cooperate_role_ids) do
			if not table.indexof(var_39_0, iter_39_1) then
				arg_39_0.reservesTempTeamList_[arg_39_1].comboSkill = 0

				break
			end
		end
	end
end

function var_0_0.SetReservesTempTeamChip(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0.reservesTempTeamList_[arg_40_1].chipInfo.id = arg_40_2
end

function var_0_0.SetReservesTempTeamChipList(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.reservesTempTeamList_[arg_41_1].chipInfo.list
	local var_41_1 = false
	local var_41_2 = 0
	local var_41_3 = ChipCfg[arg_41_2].spec_char
	local var_41_4 = ChipCfg.get_id_list_by_spec_char[var_41_3]

	for iter_41_0, iter_41_1 in ipairs(var_41_0) do
		if ChipCfg[iter_41_1].spec_char ~= 0 and table.keyof(var_41_4, iter_41_1) and iter_41_1 ~= arg_41_2 then
			var_41_1 = true
			var_41_2 = iter_41_1

			break
		end
	end

	if not table.indexof(var_41_0, arg_41_2) and not var_41_1 and #var_41_0 >= GameSetting.ai_secondary_chip_equip_num.value[1] then
		ShowTips("CHIP_CNT_MORE_THEN_MAX")

		return
	end

	if var_41_1 then
		local var_41_5 = table.indexof(var_41_0, var_41_2)

		if var_41_5 then
			table.remove(var_41_0, var_41_5)
		end
	end

	table.insert(var_41_0, arg_41_2)
	ShowTips("CHIP_USE_SUCCESS")
	manager.notify:Invoke(ENABLED_CHIP)
end

function var_0_0.ResetReservesTempTeamChipList(arg_42_0, arg_42_1)
	arg_42_0.reservesTempTeamList_[arg_42_1].chipInfo.list = {}

	ShowTips("CHIP_UNLOAD_SUCCESS")
	manager.notify:Invoke(ENABLED_CHIP)
end

function var_0_0.UnloadReservesTempTeamChipList(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.reservesTempTeamList_[arg_43_1].chipInfo.list
	local var_43_1 = table.indexof(var_43_0, arg_43_2)

	if var_43_1 then
		table.remove(var_43_0, var_43_1)
	end

	ShowTips("CHIP_UNLOAD_SUCCESS")
	manager.notify:Invoke(ENABLED_CHIP)
end

function var_0_0.ReservesTempTeamEnabledSchemeID(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0.reservesTempTeamList_[arg_44_1].chipInfo.list = deepClone(arg_44_2 or {})

	manager.notify:Invoke(ENABLED_SCHEME)
end

function var_0_0.ChangeComboSkillID(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0.reservesTempTeamList_[arg_45_1].comboSkill = arg_45_2

	manager.notify:Invoke(COMBO_SKILL_SELECT, arg_45_2)
end

function var_0_0.DelectReservesTeam(arg_46_0, arg_46_1)
	arg_46_0.reservesTeamList_[arg_46_1] = {
		comboSkill = 0,
		name = "",
		index = arg_46_1,
		hero_list = {
			0,
			0,
			0
		},
		chipInfo = {
			id = 0,
			list = {}
		}
	}
	arg_46_0.reservesTempTeamList_[arg_46_1] = {
		comboSkill = 0,
		name = "",
		index = arg_46_1,
		hero_list = {
			0,
			0,
			0
		},
		chipInfo = {
			id = 0,
			list = {}
		}
	}
end

function var_0_0.IsInList(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_2.hero_list

	for iter_47_0 = 1, 10 do
		local var_47_1 = arg_47_0.reservesTeamList_[iter_47_0]
		local var_47_2 = arg_47_0.reservesTeamList_[iter_47_0].hero_list

		if var_47_0[1] == var_47_2[1] and var_47_0[2] == var_47_2[2] and var_47_0[3] == var_47_2[3] and arg_47_2.comboSkill == var_47_1.comboSkill and arg_47_2.chipInfo.id == var_47_1.chipInfo.id and #arg_47_2.chipInfo.list == #var_47_1.chipInfo.list then
			for iter_47_1, iter_47_2 in ipairs(arg_47_2.chipInfo.list) do
				if not table.indexof(var_47_1.chipInfo.list, iter_47_2) then
					return false
				end
			end

			return true
		end
	end

	return false
end

return var_0_0
