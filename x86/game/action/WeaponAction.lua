manager.notify:RegistListener(MATERIAL_INIT, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(HERO_DATA_INIT, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(MATERIAL_MODIFY, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(PLAYER_MODIFIED, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)
manager.notify:RegistListener(WEAPON_DATA_MODIFY, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)

return {
	WeaponStr = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(46016, {
			hero_id = slot0,
			material_list = slot1,
			servant_list = slot2
		}, 46017, function (slot0, slot1)
			WeaponAction.OnWeaponStr(slot0, slot1, uv0)
		end)
	end,
	OnWeaponStr = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			WeaponAction.OnWeaponStrResponse(slot0, slot1, slot2)
			manager.notify:Invoke(WEAPON_STR, slot0, slot1)
			manager.notify:Invoke(WEAPON_DATA_MODIFY, slot1.hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	OnWeaponStrResponse = function (slot0, slot1, slot2)
		slot4 = HeroData:GetHeroList()[slot1.hero_id].weapon_info
		slot5, slot6, slot7 = WeaponTools.AddWeaponExp(slot4.exp, slot4.breakthrough, slot2)

		HeroAction.WeaponStr(slot1.hero_id, slot6, slot4.exp + slot2 - slot7)
	end,
	WeaponBreak = function (slot0)
		manager.net:SendWithLoadingNew(46018, {
			hero_id = slot0
		}, 46019, function (slot0, slot1)
			WeaponAction.OnWeaponBreak(slot0, slot1)
		end)
	end,
	OnWeaponBreak = function (slot0, slot1)
		if isSuccess(slot0.result) then
			WeaponAction.OnWeaponBreakResponse(slot0, slot1)
			manager.notify:Invoke(WEAPON_BREAK, slot0, slot1)
			manager.notify:Invoke(WEAPON_DATA_MODIFY, slot1.hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	OnWeaponBreakResponse = function (slot0, slot1)
		slot2 = slot1.hero_id

		HeroAction.WeaponBreak(slot2, HeroData:GetHeroList()[slot2].weapon_info.breakthrough + 1)
	end,
	CheckLvUp = function (slot0)
		slot1 = {}
		slot2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		slot3 = deepClone(HeroData:GetHeroList()[slot0].weapon_info)

		if GameSetting.weapon_exp_limit.value[slot3.breakthrough + 1] <= slot3.level then
			return false
		end

		for slot8, slot9 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
			slot10 = ItemTools.getItemNum(slot9)

			if ItemCfg[slot9].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and slot10 > 0 then
				table.insert(slot1, {
					index = 0,
					select = 0,
					type = ItemConst.ITEM_TYPE.MATERIAL,
					id = slot9,
					number = slot10
				})
			end
		end

		table.sort(slot1, function (slot0, slot1)
			return ItemCfg[slot0.id].rare < ItemCfg[slot1.id].rare
		end)

		slot6 = GameLevelSetting[slot3.level + 1].weapon_lv_exp_sum - slot3.exp

		for slot10 = #slot1, 1, -1 do
			slot12 = ItemCfg[slot1[slot10].id].param[1]
			slot13 = 0

			while slot6 > 0 and slot13 < slot11.number do
				slot6 = slot6 - slot12
				slot13 = slot13 + 1
			end

			if slot6 < 0 and slot10 > 1 then
				slot13 = slot13 - 1
				slot6 = slot6 + slot12
			end
		end

		if slot6 > 0 then
			return false
		end

		slot7 = nil

		if slot2 < (slot3.level + 1 == slot4 and slot5 * GameSetting.weapon_strengthen_gold_cost.value[1] or (slot5 - slot6) * GameSetting.weapon_strengthen_gold_cost.value[1]) then
			return false
		end

		return true
	end,
	CheckBreak = function (slot0, slot1)
		slot2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		slot3 = deepClone(HeroData:GetHeroList()[slot0].weapon_info)
		slot4 = GameSetting.weapon_user_limit.value[slot3.breakthrough + 1]
		slot5 = PlayerData:GetPlayerInfo().userLevel

		if slot3.level < GameSetting.weapon_exp_limit.value[slot3.breakthrough + 1] or slot6 == HeroConst.WEAPON_LV_MAX then
			if slot1 then
				ShowTips("ERROR_HERO_WEAPON_LEVEL_LIMIT")
			end

			return false
		end

		if slot5 < slot4 then
			if slot1 then
				ShowTips("ERROR_USER_LEVEL_LIMIT")
			end

			return false
		end

		slot7, slot8 = WeaponTools.BreakMaterial(slot3.breakthrough)

		for slot12, slot13 in pairs(slot8) do
			if ItemTools.getItemNum(slot13[1]) < slot13[2] then
				if slot1 then
					ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
				end

				return false
			end
		end

		if slot2 < slot7 then
			if slot1 then
				checkGold(slot7)
			end

			return false
		end

		return true
	end,
	UpdateWeaponBreakRedPoint = function ()
		if not HeroData:GetHeroList() then
			return
		end

		for slot4, slot5 in pairs(slot0) do
			if uv0.CheckBreak(slot4, false) or uv0.CheckLvUp(slot4) then
				manager.redPoint:setTip(RedPointConst.HERO_WEAPON_BREAK_ID .. slot4, 1)
			else
				manager.redPoint:setTip(slot6, 0)
			end
		end
	end
}
