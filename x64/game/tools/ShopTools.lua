slot1 = import("game.const.ShopConst")

return {
	GetShopRedPointKey = function (slot0)
		return "SHOP_" .. tostring(slot0)
	end,
	CollectShopInGroup = function (slot0)
		for slot5, slot6 in ipairs(slot0) do
			-- Nothing
		end

		slot2 = {}

		if next({
			[slot6] = true
		}) then
			for slot6, slot7 in ipairs(ShopListCfg.all) do
				if slot1[ShopListCfg[slot7].display_group] then
					table.insert(slot2, slot7)
				end
			end
		end

		return slot2
	end,
	FilterShopDataList = function (slot0, slot1)
		slot2 = {}

		for slot7, slot8 in pairs(ShopData.GetShop(slot0).shopItemIDs) do
			if uv0.IsGoodCanDisplay(slot0, slot8, slot1 or false) then
				table.insert(slot2, {
					id = slot8,
					shopId = slot0,
					buyTime = ShopData.GetShop(slot0)[slot8] ~= nil and slot9.buy_times or 0,
					next_refresh_timestamp = slot9 ~= nil and slot9.next_refresh_timestamp or 0
				})
			end
		end

		table.sort(slot2, function (slot0, slot1)
			return getShopCfg(slot1.id).shop_sort < getShopCfg(slot0.id).shop_sort
		end)

		return slot2
	end,
	CommonSort = function (slot0)
		table.sort(slot0, function (slot0, slot1)
			slot2 = getShopCfg(slot0.id)
			slot3 = getShopCfg(slot1.id)

			if uv0.GetGoodStatus(slot0.id) ~= uv0.GetGoodStatus(slot1.id) then
				return slot4 < slot5
			end

			if slot2.shop_sort ~= slot3.shop_sort then
				return slot3.shop_sort < slot2.shop_sort
			end

			return slot3.goods_id < slot2.goods_id
		end)

		return slot0
	end,
	GetGoodStatus = function (slot0)
		slot1 = false
		slot4 = ShopData.GetShop(getShopCfg(slot0).shop_id)[slot0]

		if ShopData.IsGoodOutOfDate(slot0) then
			return 3
		end

		if slot4 ~= nil and slot2.limit_num ~= nil and slot2.limit_num ~= -1 and slot2.limit_num - (slot4.buy_times or 0) <= 0 then
			slot1 = true
		end

		if slot1 then
			return 3
		end

		if ShopData.IsGoodUnlock(slot0) == 0 then
			return 1
		end

		return 0
	end,
	CheckLevelEnough = function (slot0)
		if #getShopCfg(slot0).level_limit > 0 then
			if slot1.level_limit[1][1] ~= nil then
				if slot1.level_limit[1][1] == 1 and PlayerData:GetPlayerInfo().userLevel < slot1.level_limit[1][2] then
					return false
				end
			elseif slot1.level_limit[1].type and slot1.level_limit[1].type == 1 and PlayerData:GetPlayerInfo().userLevel < slot1.level_limit[1].num then
				return false
			end
		end

		return true
	end,
	IsGoodCanDisplay = function (slot0, slot1, slot2)
		slot3 = getShopCfg(slot1)
		slot4 = true
		slot5 = true
		slot6 = true
		slot7 = true

		if #uv0.GetNextGoods(slot1) > 0 and uv0.CheckSoldOut(slot1) then
			slot5 = false
		end

		if slot3.pre_goods_id ~= nil and #slot3.pre_goods_id > 0 then
			for slot12, slot13 in ipairs(slot3.pre_goods_id) do
				slot14 = getShopCfg(slot13)

				if ShopData.GetShop(slot0)[slot13] ~= nil and slot14.limit_num ~= nil and slot14.limit_num ~= -1 and slot14.limit_num - (slot15.buy_times or 0) > 0 then
					slot4 = false

					break
				end
			end

			if #uv0.GetNextGoods(slot1) == 0 and slot8 and not slot2 then
				slot6 = false
			end
		end

		slot10 = false

		if slot3.taken_down == 0 and slot4 and slot5 and slot6 and uv0.CheckInSoldTime(slot1) and ((not uv0.GetIsTakenDown(slot3) or false) and (slot3.limit_display == 1 or ShopData.IsGoodUnlock(slot3.goods_id, slot0) == 1)) and not (HideInfoData:GetSkinHideList()[slot1] or false) then
			if ShopTools.GetPrice(slot3.goods_id) == 0 then
				ShopData.IsGoodUnlock(slot3.goods_id)
			end

			return true
		end

		return false
	end,
	CheckInSoldTime = function (slot0)
		slot2 = TimeMgr.GetInstance():GetServerTime()
		slot3 = true
		slot4 = true

		return (#getShopCfg(slot0).open_time < 2 and true or TimeMgr.GetInstance():parseTimeFromConfig(slot1.open_time) <= slot2) and (#slot1.close_time < 2 and true or slot2 < TimeMgr.GetInstance():parseTimeFromConfig(slot1.close_time))
	end,
	GetIsTakenDown = function (slot0)
		if slot0.taken_down == 0 then
			if ItemCfg[slot0.give_id] and slot1.type == ItemConst.ITEM_TYPE.HERO_PIECE and HeroTools.GetIsHide(slot1.hero_id) then
				return true
			end

			if slot1 and slot1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT and ServantTools.GetIsHide(slot1.id) then
				return true
			end

			if slot1 and slot1.type == ItemConst.ITEM_TYPE.EQUIP and EquipTools.GetIsHide(slot1.id) then
				return true
			end
		else
			return true
		end

		return false
	end,
	CheckSoldOut = function (slot0)
		if ShopData.GetShop(getShopCfg(slot0).shop_id)[slot0] ~= nil and slot1.limit_num ~= nil and slot1.limit_num ~= -1 and slot1.limit_num - (slot2.buy_times or 0) <= 0 then
			return true
		end

		return false
	end,
	IsGoodCanBuyInShop = function (slot0, slot1, slot2)
		slot3 = getShopCfg(slot1)
		slot4 = true
		slot5 = true
		slot6 = true
		slot7 = true

		if #uv0.GetNextGoods(slot1) > 0 and uv0.CheckSoldOut(slot1) then
			slot5 = false
		end

		if slot3.pre_goods_id ~= nil and #slot3.pre_goods_id > 0 then
			for slot12, slot13 in ipairs(slot3.pre_goods_id) do
				slot14 = getShopCfg(slot13)

				if ShopData.GetShop(slot0)[slot13] ~= nil and slot14.limit_num ~= nil and slot14.limit_num ~= -1 and slot14.limit_num - (slot15.buy_times or 0) > 0 then
					slot4 = false

					break
				end
			end

			if #uv0.GetNextGoods(slot1) == 0 and slot8 and not slot2 then
				slot6 = false
			end
		end

		if slot3.taken_down == 0 and slot4 and slot5 and slot6 and uv0.CheckInSoldTime(slot1) and (slot3.limit_display == 1 or ShopData.IsGoodUnlock(slot3.goods_id, slot0) == 1) then
			if ShopTools.GetPrice(slot3.goods_id) == 0 then
				ShopData.IsGoodUnlock(slot3.goods_id)
			end

			return true
		end

		return false
	end,
	IsGoodCanBuy = function (slot0, slot1, slot2)
		return ShopData.GetShop(slot0)[slot1] and uv0.IsGoodCanBuyInShop(slot0, slot1, slot2)
	end,
	GetNextGoods = function (slot0)
		return ShopData.GetNextGoods(slot0)
	end,
	JudgeIsLvLimit = function (slot0)
		for slot5, slot6 in ipairs(slot0) do
			if uv0.SHOP_LIMIT.PLAYER_LV == slot6[1] and PlayerData:GetPlayerInfo().userLevel < slot6[2] then
				return true, slot6
			end
		end

		return false
	end,
	HaveSkin = function (slot0)
		slot3 = {}

		for slot7, slot8 in ipairs(HeroData:GetHeroData(SkinCfg[slot0].hero).unlocked_skin) do
			if slot8.skin_id == slot0 and slot8.time == 0 then
				return true
			end
		end

		return false
	end,
	GetCostLevel = function (slot0)
		slot1 = getShopCfg(slot0)

		if uv0.GetCostCfg(slot0).type == ItemConst.ITEM_TYPE.CURRENCY then
			if slot1.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or slot1.cost_id == CurrencyConst.GetPlatformDiamondId() then
				return uv1.COST_LEVEL.FREE_DIAMOND
			else
				return uv1.COST_LEVEL.RECHARGE_DIAMOND
			end
		else
			return uv1.COST_LEVEL.MATERIAL
		end
	end,
	DiamondEnoughMessageBox = function ()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH"),
			OkCallback = function ()
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_pay_flower_check = 0
				})
				JumpTools.GoToSystem("/rechargeMain", {
					childShopIndex = 2,
					page = 3
				}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
			end,
			CancelCallback = function ()
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_pay_flower_check = 1
				})
			end
		})
	end,
	DefaultOpenPopUp = function (slot0)
		JumpTools.OpenPopUp("rechargeDiamondExchange", {
			getBaseNum = 1,
			useBaseNum = 1,
			useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
			getId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
			defaultNum = slot0
		}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
	end,
	CostEnoughJump = function (slot0)
		if slot0 == uv0.COST_LEVEL.FREE_DIAMOND then
			uv1.DiamondEnoughMessageBox()
		elseif slot0 == uv0.COST_LEVEL.RECHARGE_DIAMOND then
			uv1.DefaultOpenPopUp(0)
		elseif slot0 == uv0.COST_LEVEL.MATERIAL then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
		end
	end,
	ConfirmBuyItem = function (slot0, slot1, slot2, slot3, slot4)
		slot8 = uv0.GetCostCount(slot0)
		slot9, slot10, slot11 = uv0.GetPrice(slot0)
		slot12 = uv0.GetCostLevel(slot0)

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("CONFIRM_BUY"), GetI18NText(uv0.GetCostCfg(slot0).name), slot9 * slot1, GetI18NText((getShopCfg(slot0).give_id and ItemCfg[slot5.give_id] or RechargeShopDescriptionCfg[slot5.description]).name), slot1),
			OkCallback = function ()
				if uv0 < uv1 * uv2 then
					uv3.CostEnoughJump(uv4)
				else
					if ShopData.IsGoodOutOfDate(uv5) then
						ShowTips("GOODS_HAS_BEEN_REMOVED")

						return
					end

					if uv6 then
						uv6(uv5)
					end

					ShopAction.BuyItem({
						{
							goodID = uv5,
							buyNum = uv2
						}
					}, uv1, uv7)
				end
			end,
			CancelCallback = slot3
		})
	end,
	ConfirmBuySkin = function (slot0, slot1, slot2, slot3, slot4)
		slot6 = nil
		slot7 = ""
		slot8 = uv0.GetCostCount(slot0[1])
		slot9 = uv0.GetCostLevel(slot0[1])

		for slot14, slot15 in ipairs(slot0) do
			slot17 = getShopCfg(slot15).give_id and ItemCfg[slot16.give_id] or RechargeShopDescriptionCfg[slot16.description]
			slot19, slot20, slot21 = uv0.GetPrice(slot15)
			slot5 = 0 + slot19 * slot1[slot14]
			slot6 = uv0.GetCostCfg(slot15)
			slot7 = (slot14 ~= 1 or GetI18NText(slot17.name)) and GetI18NText(slot17.name) .. "+" .. GetI18NText(slot17.name)

			table.insert({}, {
				goodID = slot15,
				buyNum = slot1[slot14]
			})
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("CONFIRM_BUY"), GetI18NText(slot6.name), slot5, slot7, slot1[1]),
			OkCallback = function ()
				if uv0 < uv1 then
					uv2.CostEnoughJump(uv3)
				else
					for slot3, slot4 in ipairs(uv4) do
						if ShopData.IsGoodOutOfDate(slot4) then
							ShowTips("GOODS_HAS_BEEN_REMOVED")

							return
						end
					end

					ShopAction.BuyItem(uv5, nil, uv6)
				end
			end,
			CancelCallback = slot3
		})
	end,
	GetCostCount = function (slot0)
		if getShopCfg(slot0).cost_id == 0 then
			slot2 = slot1.cheap_cost_id
		end

		return ItemTools.getItemNum(slot2)
	end,
	GetCostCfg = function (slot0)
		return ItemCfg[getShopCfg(slot0).cost_id]
	end,
	GetCostId = function (slot0)
		slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0)
		slot4 = nil

		return (not slot1 or not slot3 or getShopCfg(slot0).cheap_cost_id) and getShopCfg(slot0).cost_id
	end,
	IsOnDiscountArea = function (slot0)
		slot1 = getShopCfg(slot0)

		if uv0.GetDiscount(slot0) ~= 100 then
			if #slot1.cheap_close_time > 0 then
				if TimeMgr.GetInstance():parseTimeFromConfig(slot1.cheap_open_time) <= TimeMgr.GetInstance():GetServerTime() and slot2 <= TimeMgr.GetInstance():parseTimeFromConfig(slot1.cheap_close_time) then
					return true, true, true
				else
					return true, true, false
				end
			else
				return true, false, true
			end
		else
			return false, false, false
		end
	end,
	GetPrice = function (slot0)
		slot3, slot4, slot5 = uv0.IsOnDiscountArea(slot0)
		slot6 = uv0.GetDiscountPrice(slot0) == uv0.GetOriPrice(slot0) and 1 or slot1 / slot2

		if SettingData:GetCurrentLanguage() == "fr" or slot7 == "de" then
			slot1 = string.gsub(tostring(slot1), "%.", ",")
		end

		if slot3 and slot5 then
			return slot1, slot2, slot6
		else
			return slot2, slot2, 1
		end
	end,
	IsRMB = function (slot0)
		return getShopCfg(slot0).cost_type == 1
	end,
	IsSkin = function (slot0)
		return getShopCfg(slot0).cost_type == 3
	end,
	GetDiscountLabel = function (slot0)
		slot1 = uv0.GetDiscount(slot0)

		if SDKTools.GetIsThisServer({
			"jp"
		}) then
			return GetTips("LABEL_DISCOUNT_EXTRA")
		elseif SDKTools.GetIsThisServer({
			"kr",
			"en"
		}) then
			return string.format("%d%%%s", 100 - slot1, GetTips("LABEL_DISCOUNT"))
		end

		return string.format("%.1f%s", slot1 / 10, GetTips("LABEL_DISCOUNT"))
	end,
	GetDiscount = function (slot0)
		slot2 = nil

		return (not getShopCfg(slot0) or not slot1.is_limit_time_discount or slot1.is_limit_time_discount ~= 1 or (not uv0.IsRMB(slot0) or math.ceil(100 * PaymentCfg[slot1.cheap_cost_id].cost / PaymentCfg[slot1.cost_id].cost)) and math.ceil(100 * slot1.cheap_cost / slot1.cost)) and (not slot1 or not slot1.discount or slot1.discount == 0 or slot1.discount) and 100
	end,
	GetOriPrice = function (slot0)
		if getShopCfg(slot0) and slot1.is_limit_time_discount and slot1.is_limit_time_discount == 1 or uv0.GetDiscount(slot0) == 100 then
			if uv0.IsRMB(slot0) then
				return PaymentCfg[slot1.cost_id].cost / 100
			else
				return slot1.cost
			end
		else
			slot3 = nil

			return math.ceil((uv0.IsRMB(slot0) and PaymentCfg[slot1.cheap_cost_id].cost / 100 or slot1.cheap_cost) / (slot2 / 100))
		end
	end,
	GetMoneySymbol = function (slot0)
		slot1 = getShopCfg(slot0)

		if uv0.IsRMB(slot0) and PaymentCfg[slot1.cost_id] then
			return PaymentCfg[slot1.cost_id].currency_symbol
		end

		return ""
	end,
	GetDiscountPrice = function (slot0)
		if uv0.GetDiscount(slot0) ~= 100 then
			if uv0.IsRMB(slot0) then
				return PaymentCfg[getShopCfg(slot0).cheap_cost_id].cost / 100
			else
				return slot1.cheap_cost
			end
		else
			return uv0.GetOriPrice(slot0)
		end
	end,
	IsShopOpen = function (slot0)
		if ShopListCfg[slot0].activity_id == 0 then
			return true, 0
		elseif ActivityData:GetActivityIsOpen(slot1.activity_id) then
			return true, 1
		elseif ActivityData:GetActivityData(slot1.activity_id) and manager.time:GetServerTime() < slot2.startTime then
			return false, 3
		else
			return false, 2
		end
	end,
	GetGoodsIDListByItemID = function (slot0, slot1)
		slot2 = {}

		if #getShopIDListByShopID(slot0) > 0 then
			for slot7, slot8 in ipairs(getShopIDListByShopID(slot0)) do
				if getShopCfg(slot8).give_id == slot1 then
					table.insert(slot2, slot8)
				end
			end
		end

		return slot2
	end,
	IsGoodCanExchange = function (slot0, slot1)
		for slot5, slot6 in ipairs(slot1) do
			if uv0.IsGoodCanDisplay(slot0, slot6) then
				return true
			end
		end

		return false
	end,
	CheckShopIsUnLock = function (slot0)
		if slot0 and ShopListCfg[slot0].open_condition and slot1 > 0 and ShopListCfg[slot0].display_group == 18 then
			return IsConditionAchieved(slot1)
		end

		return true
	end,
	GetShopIsUnLockDesc = function (slot0)
		if ShopListCfg[slot0].open_condition and slot1 > 0 and ShopListCfg[slot0].display_group == 18 then
			slot2, slot3, slot4 = IsConditionAchieved(slot1)

			return GuildActivityTools.GetGuildSpConditionDesc(slot1) .. GetTips("DORM_CANTEEN_LEVEL_UNLOCK") .. string.format(GetTips("ACTIVITY_CLUB_SP_SHOP_UNLOCK_PROGRESS"), tostring(slot3), tostring(slot4))
		end
	end,
	CheckDlcPurchased = function (slot0)
		if not getShopCfg(slot0) then
			return true
		end

		slot3 = slot1.give or 1
		slot4, slot5 = nil

		if (not slot1.description or RechargeShopDescriptionCfg[slot1.description]) and ItemCfg[slot1.give_id or slot1.description] and slot5.type == ItemConst.ITEM_TYPE.SCENE and (SceneConst.HOME_SCENE_TYPE.LOCK == HomeSceneSettingData:GetUsedState(slot5.id) or SceneConst.HOME_SCENE_TYPE.TRIAL == HomeSceneSettingData:GetUsedState(slot5.id)) then
			return false
		end

		return true
	end,
	GetFragmentList = function ()
		slot0 = {}

		for slot5 = 1, #HeroTools.GetCanExchangeHero() do
			slot9 = GameSetting.fragment_break_num.value[ItemCfg[slot1[slot5].id].rare - 2]
			slot0[slot9[1]] = (slot0[slot9[1]] or 0) + slot6.number * slot9[2]
		end

		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			if slot7 > 0 then
				table.insert(slot2, {
					id = slot6,
					num = slot7
				})
			end
		end

		return slot2
	end,
	CheckGiftSkinOwn = function (slot0)
		if RechargeShopDescriptionCfg[getShopCfg(slot0).description].sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
			for slot6, slot7 in ipairs(slot2.param) do
				if slot7[1] then
					if ItemTools.getItemNum(slot7[1]) == 1 and ItemCfg[slot7[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
						return true
					end
				end
			end
		end

		return false
	end,
	SplitDataByShopID = function (slot0, slot1)
		slot2 = ShopListCfg[slot1]
		slot4 = {}

		for slot8, slot9 in ipairs(slot0) do
			if ItemCfg[getShopCfg(slot9.id).give_id].type == ItemConst.ITEM_TYPE.HERO_PIECE then
				table.insert(({
					{},
					{},
					{},
					{}
				})[4], slot9)
			elseif slot11.type == ItemConst.ITEM_TYPE.EQUIP then
				table.insert(slot3[3], slot9)
			elseif slot11.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				table.insert(slot3[2], slot9)
			else
				table.insert(slot3[1], slot9)
			end
		end

		slot5 = {
			false,
			false,
			false,
			false,
			[slot10] = true
		}

		for slot9, slot10 in ipairs(slot2.shop_label) do
			-- Nothing
		end

		for slot9, slot10 in ipairs(slot3) do
			if slot5[slot9] == false then
				for slot14, slot15 in ipairs(slot3[slot9]) do
					table.insert(slot3[1], slot10)
				end

				slot3[slot9] = {}
			end
		end

		for slot9, slot10 in ipairs(slot3) do
			if #slot10 > 0 then
				uv0.CommonSort(slot10)
			end
		end

		slot6 = {}

		for slot10, slot11 in ipairs(slot3[3]) do
			if slot6[EquipCfg[getShopCfg(slot11.id).give_id].suit] == nil then
				slot6[slot13.suit] = {}
			end

			if slot6[slot13.suit][slot13.starlevel] == nil then
				slot6[slot13.suit][slot13.starlevel] = {}
			end

			table.insert(slot6[slot13.suit][slot13.starlevel], slot11)
		end

		for slot11, slot12 in pairs(slot6) do
			table.insert({}, slot11)
		end

		slot8 = {}

		for slot12, slot13 in ipairs(EquipSuitCfg.all) do
			if slot6[slot13] then
				for slot17, slot18 in pairs(slot6[slot13]) do
					table.insert(slot8, slot18)
				end
			end
		end

		if #slot8 == 0 or #slot8[1] == 6 then
			slot3[3] = slot8
		end

		slot9 = {}

		for slot13, slot14 in ipairs(slot3) do
			if #slot14 ~= 0 then
				table.insert(slot4, slot13)
			end
		end

		for slot13, slot14 in ipairs(slot2.shop_label) do
			table.insert(slot9, slot3[slot14])
		end

		return slot9, slot4, slot7
	end,
	IsPC = function ()
		return GameToSDK.IsPCPlatform()
	end,
	CheckDlcCanBuy = function (slot0)
		if slot0 == nil or slot0 == 0 then
			return false
		end

		if not getShopCfg(slot0) then
			return false
		end

		return uv0.SHOP_ID.DLC_SHOP == slot1.shop_id
	end,
	JumpToSkinShop = function (slot0, slot1, slot2, slot3)
		slot4 = 0
		slot5 = nil

		if not slot1 then
			slot4 = uv0.GetGoodsIdBySkinId(slot0)
		else
			slot4, slot5 = uv0.GetGoodsIdByDlcId(slot3)
		end

		if slot4 == 0 then
			ShowTips(GetTips("ERROR_SHOP_GOODS_OPEN_TIME"))

			return
		end

		if not getShopCfg(slot4) then
			ShowTips(GetTips("ERROR_SHOP_GOODS_OPEN_TIME"))

			return
		end

		slot7 = false

		if ShopTools.CheckShopIsUnLock(slot6.shop_id) and ShopTools.IsGoodCanDisplay(slot6.shop_id, slot6.goods_id) then
			slot7 = true
		end

		if slot7 then
			slot8 = ShopListCfg[slot6.shop_id]

			JumpTools.GoToSystem("/rechargeMain", {
				page = slot8.display_group,
				shopListId = slot8.id
			}, slot8.system)

			if slot5 == uv1.SHOP_ID.PASSPORT_SHOP then
				JumpTools.OpenPageByJump("shop", {
					goodID = slot6.goods_id,
					heroID = SkinCfg[slot0].hero,
					skinID = slot0,
					shopID = slot6.shop_id
				})
			else
				JumpTools.OpenPageByJump("/heroSkinPreview", {
					isShop = true,
					heroID = slot9.hero,
					skinID = slot9.id,
					goodId = slot6.goods_id,
					shopID = slot6.shop_id,
					isDlc = slot1
				})
			end
		else
			ShowTips(GetTips("ERROR_SHOP_GOODS_OPEN_TIME"))
		end
	end,
	GetGoodsIdBySkinId = function (slot0)
		for slot5, slot6 in pairs(uv0.FilterShopDataList(uv1.SHOP_ID.SKIN_SHOP)) do
			if getShopCfg(slot6.id).description == slot0 then
				return slot6.id
			end
		end
	end,
	GetGoodsIdByDlcId = function (slot0)
		for slot5, slot6 in pairs(uv0.FilterShopDataList(uv1.SHOP_ID.SKIN_SHOP)) do
			if getShopCfg(slot6.id).description == slot0 then
				return slot6.id, uv1.SHOP_ID.SKIN_SHOP
			end
		end

		for slot6, slot7 in pairs(uv0.FilterShopDataList(uv1.SHOP_ID.PASSPORT_SHOP)) do
			if getShopCfg(slot7.id).give_id == slot0 then
				return slot7.id, uv1.SHOP_ID.PASSPORT_SHOP
			end
		end
	end
}
