return {
	GetConditionStatus = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			if slot7[1] == 1 then
				table.insert(slot2, uv0.GetRaceConditionStatus(slot0, slot7[2]))
			elseif slot7[1] == 2 then
				table.insert(slot2, uv0.GetMechanismConditionStatus(slot0, slot7[2]))
			elseif slot7[1] == 3 then
				table.insert(slot2, uv0.GetAttackAttributeConditionStatus(slot0, slot7[2]))
			end
		end

		return slot2
	end,
	GetRaceConditionStatus = function (slot0, slot1)
		for slot6, slot7 in pairs(slot0) do
			if HeroCfg[slot7].race == slot1 then
				slot2 = 0 + 1
			end
		end

		return slot2
	end,
	GetMechanismConditionStatus = function (slot0, slot1)
		for slot6, slot7 in pairs(slot0) do
			if table.keyof(HeroCfg[slot7].mechanism_type, slot1) then
				slot2 = 0 + 1
			end
		end

		return slot2
	end,
	GetAttackAttributeConditionStatus = function (slot0, slot1)
		for slot6, slot7 in pairs(slot0) do
			if table.keyof(HeroCfg[slot7].ATK_attribute, slot1) then
				slot2 = 0 + 1
			end
		end

		return slot2
	end,
	CheckHeroTeam = function (slot0, slot1)
		ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE):CheckHeroTeam(slot0, slot1)
	end,
	SaveEnabledBuff = function (slot0, slot1)
		ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE):SaveEnabledBuff(slot0, slot1)
	end,
	GetEnabledBuff = function (slot0, slot1)
		return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE):GetContDataTemplateById(slot0):GetAffixList(slot1)
	end
}
