slot1 = import("game.const.HeroConst")
slot2 = import("game.tools.BattleInstance")

return {
	SortShowHero = function (slot0, slot1, slot2)
		slot3 = {
			[slot8] = slot8 + (slot9.level or slot9.hero_level) * 10000 + (slot9.star or slot9.hero_star) * 10000000,
			[slot8] = slot11 + 100000000 * (4 - slot11)
		}
		slot4 = {}

		for slot8, slot9 in pairs(slot0) do
			if type(slot9) == "table" then
				slot10 = HeroCfg[slot8]

				if table.keyof(slot1, slot8) then
					-- Nothing
				end

				if slot1[slot2] == slot8 then
					slot3[slot8] = slot3[slot8] + 1000000000
				end

				if slot9.hero_unlock == 1 or slot9.unlock == 1 then
					table.insert(slot4, slot8)
				end
			end
		end

		table.sort(slot4, function (slot0, slot1)
			return uv0[slot1] < uv0[slot0]
		end)

		return slot4
	end,
	PackUserData = function (slot0)
		if PlayerData:GetPlayerInfo() == nil then
			return "{}"
		end

		return string.format("{\"dataType\" : \"%s\",\"money\" : \"%d\",\"createTime\" : \"%d\",\"roleId\" : \"%s\",\"roleName\" : \"%s\",\"level\" : \"%s\",\"serverId\" : \"%s\",\"chapter\" : \"%s\"}", slot0, ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND), slot1.register_timestamp, tostring(slot1.userID), tostring(slot1.nick), tostring(slot1.userLevel), tostring(_G.TMP_SERVER_ID), tostring(uv0.GetCurrentBattleId()))
	end
}
