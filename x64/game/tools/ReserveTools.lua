return {
	reserveTemplateClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveBaseTemplate",
		[ReserveConst.RESERVE_TYPE.PROPOSAL] = "ReserveProposalTemplate",
		[ReserveConst.RESERVE_TYPE.ABYSS] = "ReserveAbyssTemplate",
		[ReserveConst.RESERVE_TYPE.BOSS_CHALLENGE] = "ReserveBossChallengeTemplate",
		[ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE] = "ReserveSoloChallengeTemplate",
		[ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE] = "ReserveSequentialBattleTemplate",
		[ReserveConst.RESERVE_TYPE.ATTRIBUTE_ARENA] = "ReserveAttributeArenaTemplate",
		[ReserveConst.RESERVE_TYPE.GUILD_BOSS] = "ReserveGuildBossTemplate",
		[ReserveConst.RESERVE_TYPE.CORE_VERIFICATION] = "ReserveCoreVerificationTemplate",
		[ReserveConst.RESERVE_TYPE.GUILD_ACTIVITY] = "ReserveGuildActivityTemplate"
	},
	contDataClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveContDataTemplate",
		[ReserveConst.RESERVE_TYPE.PROPOSAL] = "ReserveProposalContDataTemplate",
		[ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE] = "ReserveSoloChallengeContDataTemplate",
		[ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE] = "ReserveSequentialContDataTemplate",
		[ReserveConst.RESERVE_TYPE.MULTI_CHESS] = "ReserveMultiChessContDataTemplate"
	},
	singleTeamDataClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveSingleTeamDataTemplate",
		[ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE] = "ReserveSoloChallengeSingleTeamDataTemplate",
		[ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE] = "ReserveSequentialSingleTeamDataTemplate",
		[ReserveConst.RESERVE_TYPE.MULTI_CHESS] = "ReserveMultiChessSingleTeamDataTemplate"
	},
	heroPosDataClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveHeroPosTemplate",
		[ReserveConst.RESERVE_TYPE.GUILD_BOSS] = "ReserveGuildBossHeroPosTemplate"
	},
	mimirDataClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveMimirDataTemplate"
	},
	GetReserveType = function (slot0, slot1)
		slot2 = ReserveConst.RESERVE_TYPE.NOT_NEED_RESERVE

		if slot0 and slot1 and slot1 ~= 0 and BattleStageTools.GetStageCfg(slot0, slot1).team_type and slot3.team_type[1] then
			slot2 = slot3.team_type[1]
		end

		return slot2
	end,
	GetContID = function (slot0, slot1)
		slot2 = ReserveConst.DETAULT_CONT_ID

		if slot0 and slot1 and slot1 ~= 0 and BattleStageTools.GetStageCfg(slot0, slot1).team_type and slot3.team_type[2] then
			slot2 = slot3.team_type[2]
		end

		return slot2
	end,
	NeedDefaultTeam = function (slot0, slot1)
		if not slot0 or not slot1 or slot1 == 0 then
			return false
		end

		if BattleStageTools.GetStageCfg(slot0, slot1).need_default_team then
			return slot2.need_default_team == ReserveConst.NEED_DEFAULT_TEAM
		end

		return false
	end,
	NeedCacheTeam = function (slot0, slot1)
		slot2 = nil

		if slot0 and slot1 and slot1 ~= 0 and BattleStageTools.GetStageCfg(slot0, slot1).team_type and slot3.team_type[2] then
			return slot3.team_type[2] ~= ReserveConst.NOT_NEED_CACHE_CONT_ID
		end

		return false
	end,
	GetReserveParams = function (slot0, slot1, slot2)
		return ReserveParams.New(ReserveTools.GetReserveType(slot0, slot1), ReserveTools.GetContID(slot0, slot1), nil, {
			stageType = slot0,
			stageID = slot1,
			activityID = slot2 or 0
		})
	end,
	GetReserveTemplateByReserveType = function (slot0, slot1)
		slot2 = nil

		return (slot1 or ReserveData:GetTeamTemplate(slot0)) and ReserveData:GetServerTeamTemplate(slot0)
	end,
	GetReserveTemplate = function (slot0, slot1)
		return ReserveData:GetTeamTemplate(ReserveTools.GetReserveType(slot0, slot1))
	end,
	SetTeam = function (slot0, slot1, slot2, slot3, slot4, slot5)
		ReserveTools.SetHeroList(slot0, slot1, slot2)
		ReserveTools.SetComboSkillID(slot0, slot3)
		ReserveTools.SetMimirID(slot0, slot4)
		ReserveTools.SetMimirChipList(slot0, slot5)
	end,
	CleanCacheData = function (slot0)
		ReserveTools.GetReserveTemplateByReserveType(slot0):CleanCacheData()
	end,
	GetHeroList = function (slot0)
		slot0 = uv0.CheckReserveParams(slot0)
		slot1 = {
			0,
			0,
			0
		}
		slot2 = {
			false,
			false,
			false
		}
		slot3 = {}
		slot4 = {
			0,
			0,
			0
		}
		slot5 = false
		slot7, slot8, slot9, slot10, slot11 = ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):GetHeroList(slot0)

		return slot7, slot8, slot9, slot10, slot11
	end,
	SetHeroList = function (slot0, slot1, slot2)
		slot0 = uv0.CheckReserveParams(slot0)

		ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):SetHeroList(slot0, slot1, slot2)
	end,
	GetComboSkillID = function (slot0)
		slot0 = uv0.CheckReserveParams(slot0)

		return ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):GetComboSkillID(slot0)
	end,
	SetComboSkillID = function (slot0, slot1)
		slot0 = uv0.CheckReserveParams(slot0)

		ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):SetComboSkillID(slot0, slot1)
	end,
	GetMimirData = function (slot0)
		slot0 = uv0.CheckReserveParams(slot0)
		slot2, slot3 = ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):GetMimirData(slot0)

		return slot2, slot3
	end,
	GetMimirID = function (slot0)
		slot0 = uv0.CheckReserveParams(slot0)

		return ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):GetMimirID(slot0)
	end,
	SetMimirID = function (slot0, slot1)
		slot0 = uv0.CheckReserveParams(slot0)

		ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):SetMimirID(slot0, slot1)
	end,
	GetMimirChipList = function (slot0)
		slot0 = uv0.CheckReserveParams(slot0)

		return ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):GetMimirChipList(slot0)
	end,
	SetMimirChipList = function (slot0, slot1)
		slot0 = uv0.CheckReserveParams(slot0)

		ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):SetMimirChipList(slot0, slot1)
	end,
	InsertMimirChip = function (slot0, slot1)
		slot0 = uv0.CheckReserveParams(slot0)

		ChipTools.InsertChip(ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):GetMimirChipList(slot0), slot1, function (slot0)
			uv0:SetMimirChipList(uv1, slot0)
		end)
	end,
	RemoveMimirChip = function (slot0, slot1)
		slot0 = uv0.CheckReserveParams(slot0)

		ChipTools.RemoveChip(ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):GetMimirChipList(slot0), slot1, function (slot0)
			uv0:SetMimirChipList(uv1, slot0)
		end)
	end,
	ResetMimirChipList = function (slot0)
		slot0 = uv0.CheckReserveParams(slot0)

		ReserveTools.GetReserveTemplateByReserveType(slot0.reserveType):ResetMimirChipList(slot0)
	end,
	ResetContData = function (slot0, slot1)
		ReserveTools.GetReserveTemplateByReserveType(slot0):GetContDataTemplateById(slot1):Reset()
	end,
	SwapTeam = function (slot0, slot1, slot2, slot3)
		ReserveTools.GetReserveTemplateByReserveType(slot0):GetContDataTemplateById(slot1):SwapTeam(slot2, slot3)
	end,
	GetReserveTemplateClass = function (slot0)
		return _G[uv0.reserveTemplateClassDic[slot0] or uv0.reserveTemplateClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
	end,
	GetContDataClass = function (slot0)
		return _G[uv0.contDataClassDic[slot0] or uv0.contDataClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
	end,
	GetSingleTeamDataClass = function (slot0)
		return _G[uv0.singleTeamDataClassDic[slot0] or uv0.singleTeamDataClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
	end,
	GetHeroPosDataClass = function (slot0)
		return _G[uv0.heroPosDataClassDic[slot0] or uv0.heroPosDataClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
	end,
	GetMimirDataClass = function (slot0)
		return _G[uv0.mimirDataClassDic[slot0] or uv0.mimirDataClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
	end,
	CheckReserveParams = function (slot0)
		if not slot0 then
			slot0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.DEFAULT)

			Debug.LogError("编队参数为空，使用默认编队参数")
		end

		if not slot0.reserveType then
			slot0.reserveType = ReserveConst.RESERVE_TYPE.DEFAULT

			Debug.LogError("编队类型为空，使用默认编队类型")
		end

		return slot0
	end
}
