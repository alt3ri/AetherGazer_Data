return {
	bossTeamCacheFlagDic = {},
	SetLayerBossTeamCacheFlag = function (slot0, slot1, slot2)
		uv0.bossTeamCacheFlagDic[slot0] = uv0.bossTeamCacheFlagDic[slot0] or {}
		uv0.bossTeamCacheFlagDic[slot0][slot1] = slot2
	end,
	GetLayerBossTeamCacheFlag = function (slot0, slot1)
		uv0.bossTeamCacheFlagDic[slot0] = uv0.bossTeamCacheFlagDic[slot0] or {}

		return uv0.bossTeamCacheFlagDic[slot0][slot1]
	end,
	GetTeamIndex = function (slot0, slot1)
		slot2 = nil

		if AbyssData:GetAbyssCfg(slot0).stage_list[slot1][1] == 3 then
			if uv0.GetLayerBossTeamCacheFlag(slot0, slot1) then
				slot2 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetContDataTemplateById(slot4[2]):GetTeamCount()
			else
				slot2 = slot9 + 1

				uv0.SetLayerBossTeamCacheFlag(slot0, slot1, true)
			end
		else
			slot2 = ReserveConst.DEFAULT_TEAM_INDEX
		end

		return slot2
	end,
	GetLayerLockHeroList = function (slot0)
		return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetLayerLockHeroList(slot0)
	end,
	GetGlobalBanHeroList = function ()
		return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetGloalBanHeroList()
	end,
	GetStageLockHeroList = function (slot0, slot1)
		return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetStageLockHeroList(slot0, slot1)
	end,
	GetStageBanHeroList = function (slot0, slot1)
		return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetStageBanHeroList(slot0, slot1)
	end
}
