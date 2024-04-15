manager.net:Bind(11071, function (slot0)
	BattleTeamData:UpdateHeroTrial(slot0)
end)
manager.net:Bind(54007, function (slot0)
	if isSuccess(slot0.battle_start.result) then
		if WaitStartBattle then
			print("已经存在战斗")

			return
		end

		slot2 = slot0.battle_start.battle_id
		slot3 = slot0.battle_start.battle_server_ip
		slot4 = slot0.battle_start.battle_server_port
		WaitStartBattle = true

		print("战斗开始", slot2, slot3, slot4)
		BattleFieldData:SetServerBattleParams(slot2, slot3, slot4)
		BattleController.GetInstance():StartBattle()
	else
		if slot1 == TipsCfg.get_id_list_by_define.ERROR_NO_TEMPLATE then
			JumpTools.Back()
			ShowTips("STAGE_REFRESH_DATA")
		else
			ShowTips(slot1)
		end

		WaitStartBattle = false
	end
end)
manager.net:Bind(54107, function (slot0)
	if isSuccess(slot0.battle_start.result) then
		slot2 = slot0.battle_start.battle_id
		slot3 = slot0.battle_start.battle_server_ip
		slot4 = slot0.battle_start.battle_server_port

		print("联机战斗开始", slot2, slot3, slot4)
		manager.notify:Invoke(START_COOPERATION_BATTLE)

		slot5 = CooperationData:GetRoomData()
		slot6 = BattleStageFactory.ProduceCooperation(slot5.type, slot5.dest, slot5.activity_id)

		BattleController.GetInstance():SetBattleStageData(slot6)
		slot6:UpdateRoleDatas()
		BattleFieldData:SetServerBattleParams(slot2, slot3, slot4)
		BattleController.GetInstance():StartBattle(true)
	elseif slot1 == TipsCfg.get_id_list_by_define.ERROR_NO_TEMPLATE then
		JumpTools.Back()
		ShowTips("STAGE_REFRESH_DATA")
	else
		ShowTips(slot1)
	end
end)
manager.net:Bind(54003, function (slot0)
	BattleController.GetInstance():UpdateHeroTeam(BattleTeamPlayerTemplate.New(slot0.player_info))
end)
manager.net:Bind(21101, function (slot0)
	BattleTeamData:InitReservesTeam(slot0)
end)

return {
	PushMythicTeamsToServer = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		slot7 = slot1 or 0
		slot8 = slot0 or 0
		slot9 = slot3 or 0

		if not slot4 then
			-- Nothing
		else
			slot10.mimir_id = slot4.id or 0
			slot10.chip_list = slot4.chip or {}
		end

		slot12 = {
			stage_type = slot7,
			activity_id = slot8,
			cont_teams = {
				cont_id = slot5,
				teams = {
					{
						id = slot6,
						hero_list = slot2,
						cooperate_unique_skill_id = slot9 or 0,
						mimir_info = {
							mimir_id = 0,
							chip_list = {}
						}
					}
				}
			},
			data = {
				chess_data_info_1 = {},
				chess_data_info_2 = {}
			}
		}
	end,
	SetMimirIDInfo = function (slot0, slot1, slot2, slot3, slot4)
		BattleTeamData:SetMimirIDInfo(slot0, slot1, slot2, slot3, slot4)
		uv0.PushTeamsByParams(slot0, slot1, slot3, slot4)
	end,
	SetMimirChipInfo = function (slot0, slot1, slot2, slot3, slot4)
		BattleTeamData:SetMimirChipInfo(slot0, slot1, slot2, slot3, slot4)
		uv0.PushTeamsByParams(slot0, slot1, slot3, slot4)
	end,
	InsertMimirChipInfo = function (slot0, slot1, slot2, slot3, slot4)
		BattleTeamData:InsertMimirChipInfo(slot0, slot1, slot2, slot3, slot4)
		uv0.PushTeamsByParams(slot0, slot1, slot3, slot4)
	end,
	RemoveMimirChipInfo = function (slot0, slot1, slot2, slot3, slot4)
		BattleTeamData:RemoveMimirChipInfo(slot0, slot1, slot2, slot3, slot4)
		uv0.PushTeamsByParams(slot0, slot1, slot3, slot4)
	end,
	SetComboInfo = function (slot0, slot1, slot2, slot3, slot4)
		if BattleConst.STAGE_TYPE_NEW.POLYHEDRON == slot0 then
			manager.net:Send(66038, {
				cooperate_unique_skill_id = slot2
			}, 66039):next(function (slot0)
			end)

			slot1 = PolyhedronData:GetActivityID()
		end

		BattleTeamData:SetComboInfo(slot0, slot1, slot2, slot3, slot4)
		uv0.PushTeamsByParams(slot0, slot1, slot3, slot4)
	end,
	PushTeamsByParams = function (slot0, slot1, slot2, slot3)
		if slot0 == BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE or slot0 == BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE then
			slot4 = GetHeroTeamActivityID(slot0, slot1)
			slot5, slot6, slot7 = BattleTeamData:GetGuildSingleTeam(slot0, slot4, slot2, slot3)
			slot8, slot9 = BattleTeamData:GetMimirInfo(slot0, slot4, slot2, slot3)
			slot10 = BattleTeamData:GetComboInfo(slot0, slot4, slot2, slot3)
			slot12 = true

			for slot16 = 1, 3 do
				if slot7[slot16] and slot7[slot16].hero_id ~= 0 then
					-- Nothing
				elseif slot6[slot16] ~= 0 then
					slot11[slot16] = {
						hero_type = 2,
						owner_id = BattleTeamData.NO_OWNER,
						hero_id = slot6[slot16] or 0
					}
				else
					slot11[slot16] = {
						hero_type = 1,
						owner_id = BattleTeamData.NO_OWNER,
						hero_id = slot5[slot16] or 0
					}
				end

				if ({
					[slot16] = {
						hero_type = 3,
						owner_id = slot7[slot16].owner_id,
						hero_id = slot7[slot16].hero_id or BattleTeamData.NO_OWNER
					}
				})[slot16].hero_id ~= 0 then
					slot12 = false
				end
			end

			if slot12 then
				return
			end

			uv0.PushTeamsToServer(slot0, slot11, slot4, slot10, {
				id = slot8,
				chip = slot9
			}, slot2, slot3)
		else
			slot4, slot5 = BattleTeamData:GetSingleTeam(slot0, slot1, slot2, slot3)
			slot6, slot7 = BattleTeamData:GetMimirInfo(slot0, slot1, slot2, slot3)

			uv0.PushTeams(slot1, slot0, slot4, slot5, BattleTeamData:GetComboInfo(slot0, slot1, slot2, slot3), {
				id = slot6,
				chip = slot7
			}, slot2, slot3)
		end
	end,
	PushTeams = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
		slot9 = {}
		slot10 = slot4 or 0
		slot11 = slot5 or {
			id = 0,
			chip = {}
		}
		slot12 = true

		for slot16 = 1, 3 do
			if slot3[slot16] ~= 0 then
				-- Nothing
			else
				slot8[slot16] = {
					hero_type = 1,
					owner_id = BattleTeamData.NO_OWNER,
					hero_id = slot2[slot16] or 0
				}
			end

			if ({
				[slot16] = {
					hero_type = 2,
					owner_id = BattleTeamData.NO_OWNER,
					hero_id = slot3[slot16] or 0
				}
			})[slot16].hero_id ~= 0 then
				slot12 = false
			end
		end

		if slot12 then
			return
		end

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot1 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == slot1 then
			uv0.PushBossTeamsToServer(slot0, slot1, slot8, slot10, slot11, slot6, slot7)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot1 then
			uv0.PushMythicTeamsToServer(slot0, slot1, slot8, slot10, slot11, slot6, slot7)
		elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot1 then
			MythicAction.SaveAllTeam()
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == slot1 then
			uv0.SetMultiTeam(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
		else
			uv0.PushTeamsToServer(slot1, slot8, slot0, slot10, slot11, slot6, slot7)
		end
	end,
	PushBossTeamsToServer = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		slot8 = GetHeroTeamActivityID(slot1 or 0, slot0)
		slot9 = slot3 or 0

		if not slot4 then
			-- Nothing
		else
			slot10.mimir_id = slot4.id or 0
			slot10.chip_list = slot4.chip or {}
		end

		slot12 = {
			activity_id = 0,
			stage_type = slot7,
			cont_teams = {
				cont_id = slot5,
				teams = {
					{
						hero_list = slot2,
						cooperate_unique_skill_id = slot9 or 0,
						mimir_info = {
							mimir_id = 0,
							chip_list = {}
						}
					}
				}
			},
			data = {
				chess_data_info_1 = {},
				chess_data_info_2 = {}
			}
		}
	end,
	SetSingleTeam = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
		uv0.PushTeams(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
		BattleTeamData:SetSingleTeam(slot1, slot0, slot2, slot3, slot4, slot5, slot6, slot7)
	end,
	SetMultiTeam = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
		BattleTeamData:SetMultiTeamData(slot1, slot0, slot2, slot3, slot4, slot5, slot6, slot7)
		uv0.PushMultiTeamToServer(slot1, slot0, slot6)
	end,
	ClearMultiTeam = function (slot0, slot1, slot2)
		BattleTeamData:ResetTeamData(slot0, slot1, slot2)
	end,
	PushMultiTeamToServer = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7 = 1, 3 do
			slot8, slot9 = BattleTeamData:GetSingleTeam(slot0, slot1, slot2, slot7)
			slot10 = {
				id = slot7,
				hero_list = {}
			}

			for slot14 = 1, 3 do
				if slot8[slot14] ~= 0 and slot9[slot14] ~= 0 then
					slot10.hero_list[slot14] = {
						hero_type = 2,
						owner_id = BattleTeamData.NO_OWNER,
						hero_id = slot9[slot14] or 0
					}
				else
					slot10.hero_list[slot14] = {
						hero_type = 1,
						owner_id = BattleTeamData.NO_OWNER,
						hero_id = slot8[slot14] or 0
					}
				end
			end

			slot11, slot12 = BattleTeamData:GetMimirInfo(slot0, slot1, slot2, slot7)
			slot10.mimir_info = {
				mimir_id = slot11,
				chip_list = slot12
			}
			slot10.cooperate_unique_skill_id = BattleTeamData:GetComboInfo(slot0, slot1, slot2, slot7)

			table.insert(slot3, slot10)
		end

		slot4 = {
			stage_type = slot0,
			activity_id = slot1,
			cont_teams = {
				cont_id = slot2,
				teams = slot3
			},
			data = {
				chess_data_info_1 = {},
				chess_data_info_2 = {}
			}
		}
	end,
	PushGuildTeamsToServer = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		uv0.PushTeamsToServer(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		BattleTeamData:SetGuildSingleTeam(slot0, slot2, slot1, slot3, slot4, slot5, slot6)
	end,
	OnPushTeamsToServer = function (slot0, slot1)
		if isSuccess(slot0.result) then
			-- Nothing
		end
	end,
	PushTeamsToServer = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		slot8 = GetHeroTeamActivityID(slot0 or 0, slot2)
		slot9 = slot3 or 0

		if not slot4 then
			-- Nothing
		else
			slot10.mimir_id = slot4.id or 0
			slot10.chip_list = slot4.chip or {}
		end

		manager.net:Push(63006, {
			stage_type = slot7,
			activity_id = slot8,
			teams_info_list = {
				cont_id = slot5,
				teams = {
					{
						id = slot6,
						hero_list = slot1,
						cooperate_unique_skill_id = slot9 or 0,
						mimir_info = {
							mimir_id = 0,
							chip_list = {}
						}
					}
				}
			},
			data = {
				chess_data_info_1 = {},
				chess_data_info_2 = {}
			}
		})
	end,
	ChangeSelectChapterID = function (slot0)
		slot1 = getChapterClientCfgByChapterID(slot0)
		slot2 = getChapterToggle(slot1.id)

		BattleFieldData:SetCacheChapterClient(slot2, slot1.id)
		BattleFieldData:SetCacheChapter(slot1.id, slot0)

		if slot2 == BattleConst.TOGGLE.PLOT or slot2 == BattleConst.TOGGLE.SUB_PLOT then
			manager.notify:Invoke(CHANGE_PLOT_SELECT_CHAPTER)
		end
	end,
	ChangePlotHardLevel = function (slot0)
		BattleFieldData:ChangePlotHardLevel(slot0)
		manager.notify:Invoke(CHANGE_PLOT_HARD_LEVEL)
	end,
	SaveReservesTeam = function (slot0, slot1, slot2, slot3, slot4, slot5)
		manager.net:SendWithLoadingNew(21110, {
			formation_info_list = {
				{
					id = slot0,
					name = slot1,
					hero_list = slot2,
					cooperate_unique_skill_id = slot3,
					mimir_info = {
						{
							mimir_id = slot4.id,
							chip_list = slot4.list
						}
					}
				}
			}
		}, 21111, function (slot0)
			if isSuccess(slot0.result) then
				BattleTeamData:SetReservesTeam(uv0.formation_info_list)
				manager.notify:CallUpdateFunc(RESERVES_SAVE_TEAM)
				ShowTips(uv1)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	DelectReservesTeam = function (slot0)
		manager.net:SendWithLoadingNew(21112, {
			id = slot0
		}, 21113, uv0.OnDelectReservesTeam)
	end,
	OnDelectReservesTeam = function (slot0, slot1)
		if isSuccess(slot0.result) then
			BattleTeamData:DelectReservesTeam(slot1.id)
			manager.notify:CallUpdateFunc(RESERVES_DELECT_TEAM)
		else
			ShowTips(slot0.result)
		end
	end
}
