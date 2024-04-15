manager.net:Bind(13009, function (slot0)
	EquipData:EquipInit(slot0.equip_list)
end)

slot1 = nil

return {
	ModifyEquipList = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			if slot5.num > 0 then
				EquipData:AddEquip(slot5)
				IllustratedAction.ModifyEquipInfo(EquipCfg[slot5.prefab_id].suit, EquipCfg[slot5.prefab_id].pos)
			else
				EquipData:RemoveEquip(slot5)
			end
		end

		EquipData:ResetEquipSort()

		if #slot0 > 0 then
			manager.notify:Invoke(EQUIP_LIST_UPDATE)
		end
	end,
	EquipDecompose = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			table.insert(slot1, slot6.equip_id)
		end

		manager.net:SendWithLoadingNew(13024, {
			equip_id_list = slot1
		}, 13025, uv0.OnEquipDecompose)
	end,
	OnEquipDecompose = function (slot0, slot1)
		manager.notify:CallUpdateFunc(EQUIP_DECOMPOSE_CALLBACK, slot0, slot1)
	end,
	ApplyLockEquip = function (slot0, slot1)
		if slot1 == EquipData:GetEquipData(slot0).is_lock then
			return
		end

		manager.net:SendWithLoadingNew(13016, {
			equip_id = slot0,
			is_lock = slot1 and 1 or 0
		}, 13017, uv0.OnApplyLockEquipCallBack)
	end,
	OnApplyLockEquipCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.is_lock == 1

			EquipData:ApplyLockEquipSuccess(slot1.equip_id, slot2)
			manager.notify:CallUpdateFunc(EQUIP_LOCK, slot2)
			manager.notify:Invoke(EQUIP_LOCK, {
				equipID = slot1.equip_id,
				lock = slot2
			})
		else
			ShowTips(slot0.result)
		end
	end,
	ApplyStrengthEquip = function (slot0, slot1, slot2, slot3, slot4)
		if not checkGold(slot3) then
			return
		end

		for slot9, slot10 in pairs(slot1) do
			table.insert({}, slot10.equip_id)
		end

		slot6 = {}

		for slot10, slot11 in pairs(slot2) do
			table.insert(slot6, {
				id = slot10,
				num = slot11
			})
		end

		return manager.net:SendWithLoading(13014, {
			equip_id = slot0,
			equip_list = slot5,
			mat_list = slot6
		}, 13015):next(function (slot0)
			if isSuccess(slot0.result) then
				slot1 = EquipData:GetEquipData(uv0)

				EquipData:ApplyEquipStrengthSuccess(tonumber(uv0), uv2, uv3, math.floor(uv1 / GameSetting.equip_strengthen_gold_cost.value[1]))

				slot6 = EquipCfg[slot1.prefab_id]

				manager.notify:Invoke(EQUIP_STRENGTH_SUCCESS, slot1:GetMaxLv() <= slot1:GetLevel(), deepClone(slot1):GetLevel() ~= slot1:GetLevel(), {
					type = "levelup",
					equipId = uv0,
					equip = slot1,
					oldEquip = slot2,
					newEquip = slot1,
					callback = function ()
						getReward2(mergeReward2(uv0.mat_list))
					end
				})
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ApplyUpgradeEquip = function (slot0)
		slot1 = EquipData:GetEquipData(slot0)
		slot2 = slot1:GetUpgradeCost()

		if PlayerData:GetPlayerInfo().userLevel < GameSetting.equip_break_user_level.value[slot1.now_break_level + 1] then
			ShowTips("ERROR_USER_LEVEL_LIMIT")

			return
		end

		if not checkGold(slot2.money) then
			return
		end

		for slot9 = 1, #slot2.item_list do
			if ItemTools.getItemNum(slot2.item_list[slot9][1]) < slot2.item_list[slot9][2] then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

				return
			end
		end

		return manager.net:SendWithLoading(13022, {
			equip_id = slot0
		}, 13023):next(function (slot0)
			if isSuccess(slot0.result) then
				slot1 = EquipData:GetEquipData(uv0)

				EquipData:ApplyUpgradeEquipSuccess(tonumber(uv0))
				manager.notify:Invoke(EQUIP_UPGRADE_SUCCESS, {
					pageIndex = 2,
					type = "upgrade",
					equipId = uv0,
					oldEquip = deepClone(slot1),
					newEquip = slot1
				})
			else
				ShowTips(slot0.result)
			end
		end, function (slot0)
			print(slot0)
		end)
	end,
	EquipQuickDressOn = function (slot0, slot1)
		return manager.net:SendWithLoadingNew(13026, {
			hero_id = slot0,
			use_equip_list = slot1
		}, 13027, uv0.OnEquipQuickDressOn)
	end,
	OnEquipQuickDressOn = function (slot0, slot1)
		slot2 = true

		for slot6, slot7 in ipairs(slot0.result) do
			if not isSuccess(slot7.result) then
				slot2 = false
			end
		end

		if not slot2 then
			ShowTips(GetTips("EQUIP_DRESS_FAIL"))
		else
			manager.notify:CallUpdateFunc(EQUIP_QUICK_DRESS_ON, slot0, slot1)
		end
	end,
	QueryEquipEnchant = function (slot0, slot1, slot2, slot3)
		slot4 = slot2.id
		slot6 = slot2.number

		if not checkGold(slot2.money) then
			return
		end

		if ItemTools.getItemNum(slot4) < slot6 then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot4,
				slot6
			})

			return
		end

		if not (ItemCfg[slot4] and ItemCfg[slot4].param and ItemCfg[slot4].param[1]) and slot8 ~= "" then
			return
		end

		manager.net:SendWithLoading(13028, {
			equip_id = slot0,
			enchant_slot_id = slot1,
			pool_id = slot8,
			lock_type = slot3
		}, 13029):next(function (slot0)
			if isSuccess(slot0.result) then
				EquipData:AddPreEnchant(uv0, uv1, slot0.enchant_preview)
				manager.notify:CallUpdateFunc(EQUIP_ENCHANT)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryEquipEnchantConfirm = function (slot0, slot1, slot2, slot3)
		return manager.net:SendWithLoading(13030, {
			equip_id = slot0,
			enchant_slot_id = slot1,
			confirm = slot2,
			preview_index = slot3
		}, 13031):next(function (slot0)
			if isSuccess(slot0.result) then
				EquipData:ConfirmEnchant(uv0, uv1, uv2, uv3)
				manager.notify:CallUpdateFunc(EQUIP_ENCHANT_CONFIRM, uv2)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryEquipGiveUpAllEnchant = function (slot0, slot1)
		return manager.net:SendWithLoading(13044, {
			equip_id = slot0,
			enchant_slot_id = slot1
		}, 13045):next(function (slot0)
			if isSuccess(slot0.result) then
				EquipData:GiveUpAllEnchant(uv0, uv1)
				manager.notify:CallUpdateFunc(EQUIP_ENCHANT_GIVE_UP)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryEquipRace = function (slot0, slot1, slot2)
		slot3 = EquipData:GetRaceMaterial(slot1)
		slot4 = slot3.id
		slot6 = slot3.number

		if not checkGold(slot3.money) then
			return
		end

		if ItemTools.getItemNum(slot4) < slot6 then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot4,
				slot6
			})

			return
		end

		slot8, slot9 = nil
		slot10 = {
			equip_id = slot0
		}

		if slot1 == 1 then
			slot8 = 13032
			slot9 = 13033
		else
			slot8 = 13046
			slot9 = 13047
			slot10.hero_id = slot2
		end

		manager.net:SendWithLoading(slot8, slot10, slot9):next(function (slot0)
			if isSuccess(slot0.result) then
				if uv0 == 2 then
					EquipData:SetPreRace(uv1, uv2)
					EquipData:ConfirmRace(uv1, true)

					if not EquipData:GetEquipData(uv1).is_lock then
						EquipAction.ApplyLockEquip(uv1, true)
					end

					ShowTips("EQUIP_HERO_SUCCESS")
					JumpTools.OpenPageByJump("equipCulturePopView", {
						type = "reset",
						heroId = uv2,
						callback = function ()
							manager.notify:CallUpdateFunc(EQUIP_RACE)
						end
					})
				else
					EquipData:SetPreRace(uv1, slot0.race_preview)
					JumpTools.OpenPageByJump("/equipRaceConfirmView", {
						equipId = uv1,
						heroId = uv2
					})
					manager.notify:CallUpdateFunc(EQUIP_RACE)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryEquipRaceConfirm = function (slot0, slot1)
		manager.net:SendWithLoading(13034, {
			equip_id = slot0,
			confirm = slot1
		}, 13035):next(function (slot0)
			if isSuccess(slot0.result) then
				EquipData:ConfirmRace(uv0, uv1)
				manager.notify:CallUpdateFunc(EQUIP_RACE_CONFIRM)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	EquipBagFull = function (slot0)
		EquipData:EquipBagFull(slot0)
	end,
	InheritEquip = function (slot0, slot1)
		uv0 = slot1

		manager.net:SendWithLoadingNew(13052, {
			inherit_equip_prefab_id = slot1,
			new_equip_id = slot0
		}, 13053, uv1.OnInheritEquip)
	end,
	OnInheritEquip = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ShowTips("EQUIP_INHERIT_SUCCESS")
			manager.notify:CallUpdateFunc(EQUIP_INHERIT_SUCCESS, slot1.new_equip_id)
		else
			ShowTips(slot0.result)
		end
	end
}
