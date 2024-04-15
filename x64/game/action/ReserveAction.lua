manager.net:Bind(63005, function (slot0)
	ReserveData:InitData(slot0)
end)
manager.net:Bind(63999, function (slot0)
	if slot0.default_teams_info.team_type == ReserveConst.RESERVE_TYPE.DEFAULT then
		ReserveData:UpdateSingleServerTeamTemplate(slot1, slot0.default_teams_info)
	end
end)

return {
	SaveContData = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(63000, {
			team_type = slot0,
			cont_team = ReserveTools.GetReserveTemplateByReserveType(slot0):GetContDataTemplateById(slot1):ConvertToSendData()
		}, 63001, function (slot0)
			if isSuccess(slot0.result) then
				uv0:SetIsDirty(false)

				if uv1 then
					uv1(slot0)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResetContData = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(63002, {
			team_type = slot0,
			cont_id = slot1
		}, 63003, function (slot0, slot1)
			if isSuccess(slot0.result) then
				ReserveTools.ResetContData(uv0, uv1)

				if uv2 then
					uv2(slot0, slot1)
				end

				manager.notify:Invoke(RESERVE_RESET_CONT_DATA, uv0, uv1)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SaveReserveProposal = function (slot0, slot1, slot2)
		slot3 = ReserveConst.RESERVE_TYPE.PROPOSAL
		slot5 = ReserveTools.GetReserveTemplateByReserveType(slot3):GetContDataTemplateById(slot0)

		manager.net:SendWithLoadingNew(63010, {
			team_type = slot3,
			cont_team = slot5:ConverAllTeamToSendData(),
			data = {
				cont_id = slot0,
				name = slot5:GetName()
			}
		}, 63011, function (slot0)
			if isSuccess(slot0.result) then
				uv0:SetIsDirty(false)
				uv0:SetIsTemp(false)
				ReserveTools.GetReserveTemplateByReserveType(uv1, true):GetContDataTemplateById(uv2):UpdateServerData(uv0)

				if uv3 then
					uv3()
				end
			else
				ShowTips(slot0.result)

				if uv4 then
					uv4()
				end
			end
		end)
	end,
	RenameReserveProposal = function (slot0, slot1, slot2)
		slot5 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(slot0)
		slot6 = slot5:GetName()

		slot5:SetName(slot1)
		uv0.SaveReserveProposal(slot0, slot2, function ()
			uv0:SetName(uv1)
		end)
	end,
	SaveSoloChallengeContData = function (slot0, slot1, slot2)
		slot7 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(ActivitySoloChallengeCfg[slot0].stage_id[slot1][1])
		slot8 = {}
		slot9 = {}

		for slot13, slot14 in ipairs(ActivitySoloChallengeCfg[slot0].stage_id[slot1][2]) do
			if table.nums(SoloChallengeData:GetCompletedStageList(slot0)[slot1]) < slot13 then
				slot8[#slot8 + 1] = slot7:GetSingleTeamData(slot13):ConvertToSendData()
				slot9[#slot9 + 1] = {
					cont_id = slot7:GetContID(),
					team_index = slot13,
					artifact = slot7:GetAffixList(slot13)
				}
			end
		end

		manager.net:SendWithLoadingNew(63008, {
			team_type = ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE,
			cont_team = {
				cont_id = slot7:GetContID(),
				teams = slot8
			},
			data = slot9
		}, 63009, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SaveMultiChessContData = function (slot0, slot1, slot2, slot3, slot4)
		slot6 = GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, slot3)
		slot9 = {
			cont_id = slot6,
			teams = {}
		}

		for slot13 = 1, slot2 do
			slot9.teams[slot13] = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.MULTI_CHESS):GetContDataTemplateById(slot6):GetSingleTeamData(slot13):ConvertToSendData()
		end

		manager.net:SendWithLoadingNew(63006, {
			team_type = ReserveConst.RESERVE_TYPE.MULTI_CHESS,
			cont_team = slot9,
			data = {
				chess_data_info_1 = {
					{
						cont_id = slot6,
						x = slot0,
						z = slot1
					}
				},
				chess_data_info_2 = {}
			}
		}, 63007, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
