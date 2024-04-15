return {
	InitConst = function (slot0)
		uv0.stageInfoDic = uv0.stageInfoDic or {}
		uv0.difficultyIDToIndex = uv0.difficultyIDToIndex or {}

		for slot6, slot7 in ipairs(ActivitySoloChallengeCfg[slot0].stage_id) do
			slot8 = slot7[1]

			for slot13, slot14 in ipairs(slot7[2]) do
				uv0.stageInfoDic[slot14] = {
					stageID = slot14,
					stageIndex = slot13,
					difficultIndex = slot6,
					difficultID = slot8
				}
			end

			uv0.difficultyIDToIndex[slot8] = slot6
		end
	end,
	GetStageInfo = function (slot0)
		return uv0.stageInfoDic[slot0] or {}
	end,
	GetDifficultyIndex = function (slot0)
		return uv0.difficultyIDToIndex[slot0]
	end,
	EquipAffix = function (slot0, slot1, slot2, slot3)
		slot4 = SoloChallengeTools.GetStageInfo(slot1)

		ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(slot4.difficultID):SetAffix(slot4.stageIndex, slot2, slot3)
		ReserveAction.SaveSoloChallengeContData(slot0, slot4.difficultIndex, function ()
			SoloChallengeData:EquipAffix(uv0, uv1, uv2, uv3)
			manager.notify:CallUpdateFunc(SOLO_CHALLENGE_AFFIX_REFRESH, uv3)
		end)
	end,
	DischargeAffix = function (slot0, slot1)
		slot2 = SoloChallengeData:GetAffixState(slot0, slot1)
		slot5 = SoloChallengeTools.GetStageInfo(slot2.stageID)

		ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(slot5.difficultID):SetAffix(slot5.stageIndex, slot2.pos, 0)
		ReserveAction.SaveSoloChallengeContData(slot0, slot5.difficultIndex, function ()
			SoloChallengeData:DischargeAffix(uv0, uv1)
			manager.notify:CallUpdateFunc(SOLO_CHALLENGE_AFFIX_REFRESH, uv1)
		end)
	end
}
