manager.net:Bind(45201, function (slot0)
	BattleBossChallengeData:InitData(slot0)
end)
manager.net:Bind(45001, function (slot0)
	BattleBossChallengeNormalData:InitData(slot0)
	manager.notify:Invoke(BOSS_CHALLENGE_UPDATE)
end)
manager.net:Bind(45003, function (slot0)
	BattleBossChallengeNormalData:SetUsedCnt(slot0.use_times)
	manager.notify:Invoke(BOSS_CHALLENGE_UPDATE_CHALLENGE_CNT)
end)
manager.net:Bind(45101, function (slot0)
	BattleBossChallengeAdvanceData:InitData(slot0)
end)

return {
	RequireBossChallengeData = function (slot0, slot1)
		manager.net:SendWithLoadingNew(45202, {
			select = slot0
		}, 45203, function (slot0)
			if isSuccess(slot0.result) then
				uv0()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResetHardMode = function (slot0)
		manager.net:SendWithLoadingNew(45204, {}, 45205, function (slot0)
			BattleBossChallengeAdvanceData:Init()
			BattleBossChallengeData:Reset()
			uv0(slot0)
		end)
	end,
	ResetNormalModeBoss = function (slot0, slot1)
		manager.net:SendWithLoadingNew(45006, {
			group_id = BattleBossChallengeNormalData:GetBossList()[slot0]
		}, 45007, function (slot0)
			BattleBossChallengeNormalData:ResetBoss(uv0)
			uv1(slot0)
		end)
	end,
	ResetHardModeBoss = function (slot0, slot1)
		manager.net:SendWithLoadingNew(45106, {
			boss_id = BattleBossChallengeAdvanceData:GetBossList()[slot0].id
		}, 45107, function (slot0)
			BattleBossChallengeAdvanceData:ResetBoss(uv0)
			uv1(slot0)
		end)
	end,
	ChangeBossHeroTeam = function (slot0, slot1)
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NORMAL then
			BattleBossChallengeNormalData:SetCacheHeroTeam(slot0, slot1)
			manager.net:SendWithLoadingNew(45110, {
				group_id = BattleBossChallengeNormalData:GetBossList()[slot0],
				heroes_cfg = slot1
			}, 45111, function (slot0)
			end)
		else
			BattleBossChallengeAdvanceData:SetCacheHeroTeam(slot0, slot1)
			manager.net:SendWithLoadingNew(45108, {
				id = BattleBossChallengeAdvanceData:GetBossList()[slot0].id,
				heroes_cfg = slot1
			}, 45109, function (slot0)
			end)
		end
	end,
	RequireBossExchange = function (slot0, slot1)
		manager.net:SendWithLoadingNew(45004, {
			star = slot0
		}, 45005, function (slot0)
			uv0(slot0)
		end)
	end,
	ClientModifyThreeStar = function (slot0, slot1)
		BattleBossChallengeNormalData:ClientModifyThreeStar(slot0, slot1)
	end,
	RequireBossPointExchange = function (slot0, slot1)
		manager.net:SendWithLoadingNew(45102, {
			point = slot0
		}, 45103, function (slot0)
			uv0(slot0)
		end)
	end,
	RequireAllBossPointExchange = function (slot0)
		manager.net:SendWithLoadingNew(45112, {}, 45113, function (slot0)
			uv0(slot0)
		end)
	end,
	ModifySelectAffix = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(45104, {
			id = slot0,
			affix_index_list = slot3,
			time_index_list = slot2,
			diffculty_index = slot1
		}, 45105, function (slot0)
			uv0(slot0)
		end)
	end,
	BossChallengeBackEntrace = function ()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_REFRESH_DATA"),
			OkCallback = function ()
				if #BattleBossChallengeData:GetOpenModeList() >= 2 then
					gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
					gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
					gameContext:Go("/bossMode")
				else
					gameContext:Go("/bossSwitch")
				end
			end,
			MaskCallback = function ()
				if #BattleBossChallengeData:GetOpenModeList() >= 2 then
					gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
					gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
					gameContext:Go("/bossMode")
				else
					gameContext:Go("/bossSwitch")
				end
			end
		})
	end,
	EnterBossChallenge = function ()
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			if #BattleBossChallengeData:GetOpenModeList() >= 2 then
				JumpTools.GoToSystem("/bossMode", {}, ViewConst.SYSTEM_ID.BOSS_CHALLENGE)
			else
				JumpTools.GoToSystem("/bossSwitch", {}, ViewConst.SYSTEM_ID.BOSS_CHALLENGE)
			end
		elseif slot0 == BossConst.MODE_NORMAL then
			JumpTools.GoToSystem("/bossSwitch", {}, ViewConst.SYSTEM_ID.BOSS_CHALLENGE)
		else
			JumpTools.GoToSystem("/bossAdvanceSwitch", {}, ViewConst.SYSTEM_ID.BOSS_CHALLENGE)
		end
	end
}
