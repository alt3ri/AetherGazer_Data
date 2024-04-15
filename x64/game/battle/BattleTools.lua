return {
	GetBattleStatisticsData = function ()
		slot0 = LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()
		slot1 = {
			{
				damage = int64.zero,
				hurt = int64.zero,
				cure = int64.zero
			},
			{
				damage = int64.zero,
				hurt = int64.zero,
				cure = int64.zero
			},
			{
				damage = int64.zero,
				hurt = int64.zero,
				cure = int64.zero
			}
		}

		for slot5 = 0, slot0.hurtInfos.Count - 1 do
			if slot0.hurtInfos[slot5].agentOrder ~= 0 and slot6.damageValue < int64.zero then
				slot1[slot6.agentOrder].hurt = slot1[slot6.agentOrder].hurt + -1 * slot6.damageValue
			end

			if slot6.casterOrder ~= 0 then
				if slot6.damageValue < int64.zero then
					slot1[slot6.casterOrder].damage = slot1[slot6.casterOrder].damage + -1 * slot6.damageValue
				else
					slot1[slot6.casterOrder].cure = slot1[slot6.casterOrder].cure + slot6.damageValue
				end
			end
		end

		slot2 = {
			damage = int64.zero,
			hurt = int64.zero,
			cure = int64.zero
		}
		slot3 = {
			damage = int64.zero,
			hurt = int64.zero,
			cure = int64.zero
		}

		for slot7 = 1, 3 do
			slot2.damage = slot2.damage + slot1[slot7].damage
			slot2.hurt = slot2.hurt + slot1[slot7].hurt
			slot2.cure = slot2.cure + slot1[slot7].cure

			if slot3.damage < slot1[slot7].damage then
				slot3.damage = slot1[slot7].damage
			end

			if slot3.hurt < slot1[slot7].hurt then
				slot3.hurt = slot1[slot7].hurt
			end

			if slot3.cure < slot1[slot7].cure then
				slot3.cure = slot1[slot7].cure
			end
		end

		return slot1, slot2, slot3
	end,
	FixBattleAttributeListAndWeaponModule = function (slot0, slot1, slot2, slot3)
		for slot10, slot11 in pairs(HeroTools.GetModuleEffectByHeroAndLevel(SkinCfg[slot2].hero, slot3)) do
			table.insert(slot0, LuaExchangeHelper.GetBattleModuleBuffEnum() + slot10 - 1)
			table.insert(slot1, slot11)
		end

		return slot0, slot1
	end,
	GetAffixPlayerTargetByPos = function (slot0)
		if slot0 == 1 then
			return BattleConst.ENEMY_TYPE.PLAYER_1
		elseif slot0 == 2 then
			return BattleConst.ENEMY_TYPE.PLAYER_2
		elseif slot0 == 3 then
			return BattleConst.ENEMY_TYPE.PLAYER_3
		else
			error("GetAffixPlayerTargetByPos error pos")
		end
	end,
	GetMaxRaceData = function (slot0)
		slot1 = {}
		slot2 = 0
		slot3 = false

		for slot7, slot8 in ipairs(slot0) do
			if slot8 ~= 0 then
				slot1[slot9] = (slot1[HeroCfg[slot8].race] or 0) + 1

				if slot1[slot9] == 2 then
					slot2 = slot9
				elseif slot1[slot9] == 3 then
					slot3 = true
				end
			end
		end

		return slot2, slot1[slot2] or 1, slot3
	end
}
