manager.notify:RegistListener(NEW_DAY, function ()
	uv0.UpdateChallengeRedPoints()
end)
manager.net:Bind(55001, function (slot0)
	AbyssData:InitFromServer(slot0)
	uv0.UpdateRedPoints()
	manager.notify:CallUpdateFunc(ABYSS_TIME_OUT_UPDATE)
end)
manager.net:Bind(55009, function (slot0)
	AbyssData:UpdateResetTime(slot0)
	uv0.UpdateRedPoints()
end)
manager.net:Bind(55023, function (slot0)
	manager.notify:CallUpdateFunc(ABYSS_REFRESH)
end)
manager.net:Bind(55011, function (slot0)
	AbyssData:UpdateBossInfo(slot0)
	uv0.UpdateRedPoints()
end)
manager.net:Bind(55017, function (slot0)
	AbyssData:UpdateLayerUnlock(slot0)
	uv0.UpdateRedPoints()
end)

slot1, slot2 = nil

return {
	UpdateRedPoints = function ()
		uv0.UpdateRewardRedPoints()
		uv0.UpdateChallengeRedPoints()
	end,
	UpdateRewardRedPoints = function ()
		slot0 = AbyssData:GetCanGetLayers()

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_ABYSS) and true or false then
			manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 0)
		elseif #slot0 > 0 then
			manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 1)
		else
			manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 0)
		end
	end,
	UpdateChallengeRedPoints = function ()
		slot0 = false

		for slot4, slot5 in ipairs(AbyssData:GetCurrentIdList()) do
			slot6 = AbyssCfg[slot5]

			for slot11, slot12 in ipairs(slot6.stage_list) do
				if AbyssData:GetStageData(slot6.level, slot11) and slot13.is_completed then
					slot0 = true

					break
				end
			end

			if slot0 then
				break
			end
		end

		slot1 = AbyssData:HaveGetBonusNum()
		slot2 = getData("abyss", "click_time") or 0
		slot3 = _G.gameTimer:GetNextDayFreshTime()

		if ChapterClientCfg[502] then
			if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_ABYSS) and true or false then
				manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 0)
			elseif slot0 or slot1 > 0 or slot3 > 0 and slot3 <= slot2 then
				manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 0)
			else
				manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 1)
			end
		end
	end,
	ClickChallengeRedPoint = function ()
		saveData("abyss", "click_time", _G.gameTimer:GetNextDayFreshTime())
		uv0.UpdateChallengeRedPoints()
	end,
	ResetLayer = function (slot0)
		manager.net:SendWithLoadingNew(55002, {
			layer = slot0
		}, 55003, uv0.OnResetLayerCallback)
	end,
	OnResetLayerCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot6, slot7 in ipairs(AbyssData:GetAbyssCfg(slot1.layer).stage_list) do
				if slot7[1] == 3 then
					AbyssTools.SetLayerBossTeamCacheFlag(slot1.layer, slot6, false)
				end

				ReserveTools.ResetContData(ReserveConst.RESERVE_TYPE.ABYSS, slot7[2])
			end

			AbyssData:OnResetLayer(slot1.layer)
			uv0.UpdateRedPoints()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	ResetStage = function (slot0, slot1, slot2)
		uv0 = slot0
		uv1 = slot1

		manager.net:SendWithLoadingNew(55004, {
			stage_id = slot2
		}, 55005, uv2.OnResetStageCallback)
	end,
	OnResetStageCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if AbyssData:GetAbyssCfg(uv0).stage_list[uv1][1] == 3 then
				AbyssTools.SetLayerBossTeamCacheFlag(uv0, uv1, false)
			end

			ReserveTools.ResetContData(ReserveConst.RESERVE_TYPE.ABYSS, slot1.stage_id)
			AbyssData:OnResetStage(uv0, uv1, slot1.stage_id)

			uv0 = nil
			uv1 = nil

			uv2.UpdateRedPoints()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetLayerBonus = function (slot0)
		manager.net:SendWithLoadingNew(55006, {
			layer_list = slot0
		}, 55007, uv0.OnGetLayerBonusCallback)
	end,
	OnGetLayerBonusCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			for slot6, slot7 in ipairs(slot1.layer_list) do
				table.insertto(slot2, AbyssData:GetAbyssCfg(slot7).reward_list)
			end

			getReward(mergeReward(formatRewardCfgList(slot2)))
			AbyssData:OnLayerBonusGet(slot1.layer_list)
			uv0.UpdateRedPoints()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SaveProgress = function (slot0, slot1)
		manager.net:SendWithLoadingNew(55012, {
			stage_id = slot0,
			is_save = slot1
		}, 55013, uv0.OnSaveProgressCallback)
	end,
	OnSaveProgressCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			uv0.UpdateRedPoints()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	ReadBackFlag = function ()
		manager.net:SendWithLoadingNew(55020, {}, 55021, uv0.OnReadBackFlagCallback)
	end,
	OnReadBackFlagCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AbyssData:OnReadBackFlag()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	ClearTeamCache = function (slot0)
		AbyssData:ClearTeamCache(slot0)
	end
}
