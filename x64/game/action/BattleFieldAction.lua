manager.net:Bind(11071, function(arg_1_0)
	BattleTeamData:UpdateHeroTrial(arg_1_0)
end)
manager.net:Bind(54007, function(arg_2_0)
	local var_2_0 = arg_2_0.battle_start.result

	if isSuccess(var_2_0) then
		if WaitStartBattle then
			print("已经存在战斗")

			return
		end

		local var_2_1 = arg_2_0.battle_start.battle_id
		local var_2_2 = arg_2_0.battle_start.battle_server_ip
		local var_2_3 = arg_2_0.battle_start.battle_server_port

		WaitStartBattle = true

		print("战斗开始", var_2_1, var_2_2, var_2_3)
		BattleFieldData:SetServerBattleParams(var_2_1, var_2_2, var_2_3)
		BattleController.GetInstance():StartBattle()
	else
		if var_2_0 == TipsCfg.get_id_list_by_define.ERROR_NO_TEMPLATE then
			JumpTools.Back()
			ShowTips("STAGE_REFRESH_DATA")
		else
			ShowTips(var_2_0)
		end

		WaitStartBattle = false
	end
end)
manager.net:Bind(54107, function(arg_3_0)
	local var_3_0 = arg_3_0.battle_start.result

	if isSuccess(var_3_0) then
		local var_3_1 = arg_3_0.battle_start.battle_id
		local var_3_2 = arg_3_0.battle_start.battle_server_ip
		local var_3_3 = arg_3_0.battle_start.battle_server_port

		print("联机战斗开始", var_3_1, var_3_2, var_3_3)
		manager.notify:Invoke(START_COOPERATION_BATTLE)

		local var_3_4 = CooperationData:GetRoomData()
		local var_3_5 = BattleStageFactory.ProduceCooperation(var_3_4.type, var_3_4.dest, var_3_4.activity_id)

		BattleController.GetInstance():SetBattleStageData(var_3_5)
		var_3_5:UpdateRoleDatas()
		BattleFieldData:SetServerBattleParams(var_3_1, var_3_2, var_3_3)
		BattleController.GetInstance():StartBattle(true)
	elseif var_3_0 == TipsCfg.get_id_list_by_define.ERROR_NO_TEMPLATE then
		JumpTools.Back()
		ShowTips("STAGE_REFRESH_DATA")
	else
		ShowTips(var_3_0)
	end
end)
manager.net:Bind(54003, function(arg_4_0)
	local var_4_0 = BattleTeamPlayerTemplate.New(arg_4_0.player_info)

	BattleController.GetInstance():UpdateHeroTeam(var_4_0)
end)
manager.net:Bind(21101, function(arg_5_0)
	BattleTeamData:InitReservesTeam(arg_5_0)
end)

local var_0_0 = {
	PushMythicTeamsToServer = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
		local var_6_0 = arg_6_1 or 0
		local var_6_1 = arg_6_0 or 0
		local var_6_2 = arg_6_3 or 0
		local var_6_3 = {}

		if not arg_6_4 then
			var_6_3.mimir_id = 0
			var_6_3.chip_list = {}
		else
			var_6_3.mimir_id = arg_6_4.id or 0
			var_6_3.chip_list = arg_6_4.chip or {}
		end

		local var_6_4 = {
			cont_id = arg_6_5,
			teams = {
				{
					id = arg_6_6,
					hero_list = arg_6_2,
					cooperate_unique_skill_id = var_6_2 or 0,
					mimir_info = var_6_3
				}
			}
		}
		local var_6_5 = {
			stage_type = var_6_0,
			activity_id = var_6_1,
			cont_teams = var_6_4,
			data = {
				chess_data_info_1 = {},
				chess_data_info_2 = {}
			}
		}
	end
}

function var_0_0.SetMimirIDInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	BattleTeamData:SetMimirIDInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	var_0_0.PushTeamsByParams(arg_7_0, arg_7_1, arg_7_3, arg_7_4)
end

function var_0_0.SetMimirChipInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	BattleTeamData:SetMimirChipInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	var_0_0.PushTeamsByParams(arg_8_0, arg_8_1, arg_8_3, arg_8_4)
end

function var_0_0.InsertMimirChipInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	BattleTeamData:InsertMimirChipInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_0.PushTeamsByParams(arg_9_0, arg_9_1, arg_9_3, arg_9_4)
end

function var_0_0.RemoveMimirChipInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	BattleTeamData:RemoveMimirChipInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	var_0_0.PushTeamsByParams(arg_10_0, arg_10_1, arg_10_3, arg_10_4)
end

function var_0_0.SetComboInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON == arg_11_0 then
		manager.net:Send(66038, {
			cooperate_unique_skill_id = arg_11_2
		}, 66039):next(function(arg_12_0)
			return
		end)

		arg_11_1 = PolyhedronData:GetActivityID()
	end

	BattleTeamData:SetComboInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	var_0_0.PushTeamsByParams(arg_11_0, arg_11_1, arg_11_3, arg_11_4)
end

function var_0_0.PushTeamsByParams(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0 == BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE or arg_13_0 == BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE then
		local var_13_0 = GetHeroTeamActivityID(arg_13_0, arg_13_1)
		local var_13_1, var_13_2, var_13_3 = BattleTeamData:GetGuildSingleTeam(arg_13_0, var_13_0, arg_13_2, arg_13_3)
		local var_13_4, var_13_5 = BattleTeamData:GetMimirInfo(arg_13_0, var_13_0, arg_13_2, arg_13_3)
		local var_13_6 = BattleTeamData:GetComboInfo(arg_13_0, var_13_0, arg_13_2, arg_13_3)
		local var_13_7 = {}
		local var_13_8 = true

		for iter_13_0 = 1, 3 do
			if var_13_3[iter_13_0] and var_13_3[iter_13_0].hero_id ~= 0 then
				var_13_7[iter_13_0] = {
					hero_type = 3,
					owner_id = var_13_3[iter_13_0].owner_id,
					hero_id = var_13_3[iter_13_0].hero_id or BattleTeamData.NO_OWNER
				}
			elseif var_13_2[iter_13_0] ~= 0 then
				var_13_7[iter_13_0] = {
					hero_type = 2,
					owner_id = BattleTeamData.NO_OWNER,
					hero_id = var_13_2[iter_13_0] or 0
				}
			else
				var_13_7[iter_13_0] = {
					hero_type = 1,
					owner_id = BattleTeamData.NO_OWNER,
					hero_id = var_13_1[iter_13_0] or 0
				}
			end

			if var_13_7[iter_13_0].hero_id ~= 0 then
				var_13_8 = false
			end
		end

		if var_13_8 then
			return
		end

		var_0_0.PushTeamsToServer(arg_13_0, var_13_7, var_13_0, var_13_6, {
			id = var_13_4,
			chip = var_13_5
		}, arg_13_2, arg_13_3)
	else
		local var_13_9, var_13_10 = BattleTeamData:GetSingleTeam(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		local var_13_11, var_13_12 = BattleTeamData:GetMimirInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		local var_13_13 = BattleTeamData:GetComboInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)

		var_0_0.PushTeams(arg_13_1, arg_13_0, var_13_9, var_13_10, var_13_13, {
			id = var_13_11,
			chip = var_13_12
		}, arg_13_2, arg_13_3)
	end
end

function var_0_0.PushTeams(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = arg_14_4 or 0
	local var_14_3 = arg_14_5 or {
		id = 0,
		chip = {}
	}
	local var_14_4 = true

	for iter_14_0 = 1, 3 do
		if arg_14_3[iter_14_0] ~= 0 then
			var_14_0[iter_14_0] = {
				hero_type = 2,
				owner_id = BattleTeamData.NO_OWNER,
				hero_id = arg_14_3[iter_14_0] or 0
			}
		else
			var_14_0[iter_14_0] = {
				hero_type = 1,
				owner_id = BattleTeamData.NO_OWNER,
				hero_id = arg_14_2[iter_14_0] or 0
			}
		end

		if var_14_0[iter_14_0].hero_id ~= 0 then
			var_14_4 = false
		end
	end

	if var_14_4 then
		return
	end

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_14_1 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == arg_14_1 then
		var_0_0.PushBossTeamsToServer(arg_14_0, arg_14_1, var_14_0, var_14_2, var_14_3, arg_14_6, arg_14_7)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == arg_14_1 then
		var_0_0.PushMythicTeamsToServer(arg_14_0, arg_14_1, var_14_0, var_14_2, var_14_3, arg_14_6, arg_14_7)
	elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == arg_14_1 then
		MythicAction.SaveAllTeam()
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == arg_14_1 then
		var_0_0.SetMultiTeam(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
	else
		var_0_0.PushTeamsToServer(arg_14_1, var_14_0, arg_14_0, var_14_2, var_14_3, arg_14_6, arg_14_7)
	end
end

function var_0_0.PushBossTeamsToServer(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	local var_15_0 = arg_15_1 or 0
	local var_15_1 = GetHeroTeamActivityID(var_15_0, arg_15_0)
	local var_15_2 = arg_15_3 or 0
	local var_15_3 = {}

	if not arg_15_4 then
		var_15_3.mimir_id = 0
		var_15_3.chip_list = {}
	else
		var_15_3.mimir_id = arg_15_4.id or 0
		var_15_3.chip_list = arg_15_4.chip or {}
	end

	local var_15_4 = {
		cont_id = arg_15_5,
		teams = {
			{
				hero_list = arg_15_2,
				cooperate_unique_skill_id = var_15_2 or 0,
				mimir_info = var_15_3
			}
		}
	}
	local var_15_5 = {
		activity_id = 0,
		stage_type = var_15_0,
		cont_teams = var_15_4,
		data = {
			chess_data_info_1 = {},
			chess_data_info_2 = {}
		}
	}
end

function var_0_0.SetSingleTeam(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
	var_0_0.PushTeams(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
	BattleTeamData:SetSingleTeam(arg_16_1, arg_16_0, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
end

function var_0_0.SetMultiTeam(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6, arg_17_7)
	BattleTeamData:SetMultiTeamData(arg_17_1, arg_17_0, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6, arg_17_7)
	var_0_0.PushMultiTeamToServer(arg_17_1, arg_17_0, arg_17_6)
end

function var_0_0.ClearMultiTeam(arg_18_0, arg_18_1, arg_18_2)
	BattleTeamData:ResetTeamData(arg_18_0, arg_18_1, arg_18_2)
end

function var_0_0.PushMultiTeamToServer(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = {}

	for iter_19_0 = 1, 3 do
		local var_19_1, var_19_2 = BattleTeamData:GetSingleTeam(arg_19_0, arg_19_1, arg_19_2, iter_19_0)
		local var_19_3 = {
			id = iter_19_0,
			hero_list = {}
		}

		for iter_19_1 = 1, 3 do
			if var_19_1[iter_19_1] ~= 0 and var_19_2[iter_19_1] ~= 0 then
				var_19_3.hero_list[iter_19_1] = {
					hero_type = 2,
					owner_id = BattleTeamData.NO_OWNER,
					hero_id = var_19_2[iter_19_1] or 0
				}
			else
				var_19_3.hero_list[iter_19_1] = {
					hero_type = 1,
					owner_id = BattleTeamData.NO_OWNER,
					hero_id = var_19_1[iter_19_1] or 0
				}
			end
		end

		local var_19_4, var_19_5 = BattleTeamData:GetMimirInfo(arg_19_0, arg_19_1, arg_19_2, iter_19_0)

		var_19_3.mimir_info = {
			mimir_id = var_19_4,
			chip_list = var_19_5
		}
		var_19_3.cooperate_unique_skill_id = BattleTeamData:GetComboInfo(arg_19_0, arg_19_1, arg_19_2, iter_19_0)

		table.insert(var_19_0, var_19_3)
	end

	local var_19_6 = {
		stage_type = arg_19_0,
		activity_id = arg_19_1,
		cont_teams = {
			cont_id = arg_19_2,
			teams = var_19_0
		},
		data = {
			chess_data_info_1 = {},
			chess_data_info_2 = {}
		}
	}
end

function var_0_0.PushGuildTeamsToServer(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	var_0_0.PushTeamsToServer(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	BattleTeamData:SetGuildSingleTeam(arg_20_0, arg_20_2, arg_20_1, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
end

function var_0_0.OnPushTeamsToServer(arg_21_0, arg_21_1)
	if isSuccess(arg_21_0.result) then
		-- block empty
	end
end

function var_0_0.PushTeamsToServer(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	local var_22_0 = arg_22_0 or 0
	local var_22_1 = GetHeroTeamActivityID(var_22_0, arg_22_2)
	local var_22_2 = arg_22_3 or 0
	local var_22_3 = {}

	if not arg_22_4 then
		var_22_3.mimir_id = 0
		var_22_3.chip_list = {}
	else
		var_22_3.mimir_id = arg_22_4.id or 0
		var_22_3.chip_list = arg_22_4.chip or {}
	end

	local var_22_4 = {
		cont_id = arg_22_5,
		teams = {
			{
				id = arg_22_6,
				hero_list = arg_22_1,
				cooperate_unique_skill_id = var_22_2 or 0,
				mimir_info = var_22_3
			}
		}
	}
	local var_22_5 = {
		stage_type = var_22_0,
		activity_id = var_22_1,
		teams_info_list = var_22_4,
		data = {
			chess_data_info_1 = {},
			chess_data_info_2 = {}
		}
	}

	manager.net:Push(63006, var_22_5)
end

function var_0_0.ChangeSelectChapterID(arg_23_0)
	local var_23_0 = getChapterClientCfgByChapterID(arg_23_0)
	local var_23_1 = getChapterToggle(var_23_0.id)

	BattleFieldData:SetCacheChapterClient(var_23_1, var_23_0.id)
	BattleFieldData:SetCacheChapter(var_23_0.id, arg_23_0)

	if var_23_1 == BattleConst.TOGGLE.PLOT or var_23_1 == BattleConst.TOGGLE.SUB_PLOT then
		manager.notify:Invoke(CHANGE_PLOT_SELECT_CHAPTER)
	end
end

function var_0_0.ChangePlotHardLevel(arg_24_0)
	BattleFieldData:ChangePlotHardLevel(arg_24_0)
	manager.notify:Invoke(CHANGE_PLOT_HARD_LEVEL)
end

function var_0_0.SaveReservesTeam(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0 = {
		formation_info_list = {
			{
				id = arg_25_0,
				name = arg_25_1,
				hero_list = arg_25_2,
				cooperate_unique_skill_id = arg_25_3,
				mimir_info = {
					{
						mimir_id = arg_25_4.id,
						chip_list = arg_25_4.list
					}
				}
			}
		}
	}

	manager.net:SendWithLoadingNew(21110, var_25_0, 21111, function(arg_26_0)
		if isSuccess(arg_26_0.result) then
			BattleTeamData:SetReservesTeam(var_25_0.formation_info_list)
			manager.notify:CallUpdateFunc(RESERVES_SAVE_TEAM)
			ShowTips(arg_25_5)
		else
			ShowTips(arg_26_0.result)
		end
	end)
end

function var_0_0.DelectReservesTeam(arg_27_0)
	local var_27_0 = {
		id = arg_27_0
	}

	manager.net:SendWithLoadingNew(21112, var_27_0, 21113, var_0_0.OnDelectReservesTeam)
end

function var_0_0.OnDelectReservesTeam(arg_28_0, arg_28_1)
	if isSuccess(arg_28_0.result) then
		BattleTeamData:DelectReservesTeam(arg_28_1.id)
		manager.notify:CallUpdateFunc(RESERVES_DELECT_TEAM)
	else
		ShowTips(arg_28_0.result)
	end
end

return var_0_0
