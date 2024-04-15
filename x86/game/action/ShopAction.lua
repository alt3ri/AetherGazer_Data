manager.net:Bind(20005, function (slot0)
	ShopData.SingleShopUpdate(slot0.changed_shop_info)
	uv0.UpdateRedPoints()
	uv0.UpdateNewShopRedPoints()
end)
manager.net:Bind(20009, function (slot0)
	ShopData.AllShopUpdate(slot0.shop_item_list)
	uv0.UpdateRedPoints()
	uv0.UpdateNewShopRedPoints()
end)
manager.net:Bind(20003, function (slot0)
	UpdateShopCfg(slot0.shop_item_cfg_list)
	uv0.UpdateRedPoints()
end)
manager.net:Bind(20007, function (slot0)
	for slot4, slot5 in ipairs(slot0.shop_item_cfg_list) do
		UpdateShopCfg(slot5)
	end

	uv0.UpdateRedPoints()
end)
Timer.New(function ()
	uv0.UpdateRedPoints()
end, 1, -1):Start()

return {
	LateInitLua = function ()
		JumpTools.SetSystemOpenCheck(ViewConst.SYSTEM_ID.RECHARGE_SKIN, function (slot0)
			slot2 = slot0.skinID

			if getShopCfg(slot0.goodID) and not ShopTools.IsGoodCanDisplay(slot3.shop_id, slot3.goods_id) then
				return false, GetTips("GOODS_HAS_BEEN_REMOVED")
			end

			if (ShopTools.HaveSkin(slot2) or HeroTools.CanChangeSkin(slot2)) and slot3.dlc and ShopTools.CheckDlcPurchased(slot3.dlc) then
				return false, GetTips("SOLD_OUT")
			end

			return true, ""
		end)
		JumpTools.SetSystemOpenCheck(ViewConst.SYSTEM_ID.RECHARGE_FUKUBUKURO, function (slot0)
			slot2 = slot0.shopID

			if getShopCfg(slot0.goodID) and not ShopTools.IsGoodCanDisplay(slot3.shop_id, slot3.goods_id) then
				return false, GetTips("GOODS_HAS_BEEN_REMOVED")
			end

			if ShopData.GetShop(slot2)[slot1] ~= nil and slot3.limit_num ~= nil and slot3.limit_num ~= -1 and slot3.limit_num - (slot4.buy_times or 0) <= 0 then
				return false, GetTips("SOLD_OUT")
			end

			return true, ""
		end)
	end,
	UpdateRedPoints = function ()
		if manager.time == nil or manager.time:GetServerTime() == manager.time:RealtimeSinceStartup() then
			return
		end

		for slot3, slot4 in ipairs(RechargeRecommendCfg.all) do
			slot7 = false

			if not RechargeRecommendCfg[slot4].time[1] or #slot6[1] < 3 or #slot6[2] < 3 then
				slot7 = true
			end

			if not slot5.time[2] or #slot8[1] < 3 or #slot8[2] < 3 then
				slot7 = true
			end

			if slot5.new_recommend == 0 or not (slot7 or TimeMgr.GetInstance():GetServerTime() < TimeMgr.GetInstance():parseTimeFromConfig(slot5.time[2]) and TimeMgr.GetInstance():parseTimeFromConfig(slot5.time[1]) <= slot11 and true or false) or getData("recharge_recommend", tostring(slot4)) ~= nil then
				manager.redPoint:setTip(RedPointConst.RECHARGE_RECOMMEND .. slot4, 0)
			else
				manager.redPoint:setTip(slot9, 1)
			end
		end
	end,
	UpdateNewShopRedPoints = function ()
		slot0 = ShopData.GetRedPointData()

		manager.redPoint:setTip(RedPointConst.NEW_SHOP_RECHARGE, 0, RedPointStyle.SHOW_NEW_TAG)

		slot4 = 0
		slot5 = RedPointStyle.SHOW_NEW_TAG

		manager.redPoint:setTip(RedPointConst.NEW_SHOP_SHOP, slot4, slot5)

		for slot4, slot5 in pairs(ShopListCfg.all) do
			if ShopListCfg[slot5].system == "2" then
				manager.redPoint:setTip(RedPointConst.NEW_SHOP_RECHARGE .. slot6.display_group, 0, RedPointStyle.SHOW_NEW_TAG)
			elseif slot6.system == "1" then
				manager.redPoint:setTip(RedPointConst.NEW_SHOP_SHOP .. slot6.display_group, 0, RedPointStyle.SHOW_NEW_TAG)
			end
		end

		for slot4, slot5 in pairs(slot0) do
			slot6 = ShopListCfg[slot4]

			if ShopTools.IsPC() and ShopConst.PC_LOCK_SHOP[slot4] then
				slot0[slot4] = false
			end

			if slot5 and slot6.system == "2" and slot6.display_group <= 5 then
				manager.redPoint:setTip(RedPointConst.NEW_SHOP_RECHARGE, 1, RedPointStyle.SHOW_NEW_TAG)
				manager.redPoint:setTip(RedPointConst.NEW_SHOP_RECHARGE .. slot6.display_group, 1, RedPointStyle.SHOW_NEW_TAG)
			elseif slot5 and slot6.system == "1" and slot6.display_group <= 5 then
				manager.redPoint:setTip(RedPointConst.NEW_SHOP_SHOP, 1, RedPointStyle.SHOW_NEW_TAG)
				manager.redPoint:setTip(RedPointConst.NEW_SHOP_SHOP .. slot6.display_group, 1, RedPointStyle.SHOW_NEW_TAG)
			end
		end
	end,
	ReadRedPoint = function (slot0)
		slot1 = RedPointConst.RECHARGE_RECOMMEND .. slot0

		saveData("recharge_recommend", tostring(slot0), true)
		uv0.UpdateRedPoints()
	end,
	BuyItem = function (slot0, slot1, slot2)
		if slot2 == nil then
			slot2 = 0
		end

		slot3 = {}
		slot4 = nil

		for slot8, slot9 in ipairs(slot0) do
			if not ShopTools.IsShopOpen(getShopCfg(slot9.goodID).shop_id) then
				ShowTips("TIME_OVER")

				return
			end

			slot11 = 0

			if slot1 then
				slot11 = slot1
			else
				slot11 = slot10.cost
				slot12, slot13, slot14 = ShopTools.IsOnDiscountArea(slot9.goodID)

				if slot12 and slot14 then
					slot11 = slot10.cheap_cost
				end
			end

			slot12 = slot11 * slot9.buyNum
			slot13 = ItemCfg[slot10.cost_id].type
			slot14 = {}

			if slot10.cost_type == 2 then
				slot16 = math.min(slot12, ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND))

				table.insert(slot14, {
					id = CurrencyConst.CURRENCY_TYPE_DIAMOND,
					num = slot16
				})

				if slot12 - slot16 > 0 then
					table.insert(slot14, {
						id = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
						num = slot17
					})
				end

				if slot17 > 0 and CurrencyData:GetRechargeDiamond() < slot17 then
					ShopTools.DiamondEnoughMessageBox()

					return
				end
			else
				table.insert(slot14, {
					id = slot10.cost_id,
					num = slot12
				})

				if slot13 == ItemConst.ITEM_TYPE.CURRENCY then
					if ItemTools.getItemNum(slot10.cost_id) < slot12 then
						if slot15 == CurrencyConst.CURRENCY_TYPE_GOLD then
							slot17 = false

							for slot22, slot23 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
								if ItemTools.getItemNum(slot23) > 0 then
									slot17 = true

									break
								end
							end

							if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or slot17 then
								JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)

								return
							end
						elseif slot15 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
							if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
								ShopTools.DefaultOpenPopUp(slot12 - slot16)
							else
								ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
							end

							return
						elseif slot15 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
							ShopTools.DiamondEnoughMessageBox()

							return
						end

						ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[slot15].name)))

						return
					end
				elseif slot13 == ItemConst.ITEM_TYPE.MATERIAL then
					if ItemTools.getItemNum(slot10.cost_id) < slot12 then
						ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[slot15].name)))

						return
					end
				else
					print("其他大类未做处理")
				end
			end

			if ItemTools.IsItemExpiredByItemId(slot10.cost_id) then
				ShowTips("ERROR_ITEM_TIME_INVALID")

				return
			end

			if slot9.buyNum > 0 then
				table.insert(slot3, {
					buy_id = slot9.goodID,
					buy_num = slot9.buyNum,
					cost_items = slot14
				})
			else
				print("shopID", slot4, "goodID", slot9.goodID)
			end
		end

		slot5 = {
			buy_goods_list = slot3,
			shop_id = slot4,
			buy_source = slot2
		}

		if #slot3 == 0 then
			ShowTips("ERROR_BAD_ARG")

			return
		end

		SendMessageManagerToSDK("purchase_complete_GP_ONCE")
		manager.net:SendWithLoadingNew(20012, slot5, 20013, uv0.ShopItemUpdate)
	end,
	ShopItemUpdate = function (slot0, slot1)
		slot2 = {}

		if slot0.result == 0 then
			if uv0.CheckIsDlcAndSkin(slot1.buy_goods_list) then
				manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK, slot0.result, slot1.buy_goods_list[1].buy_id, slot1.shop_id, slot1.buy_goods_list[1].buy_num)
				manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK, slot0.result, slot1.buy_goods_list[2].buy_id, slot1.shop_id, slot1.buy_goods_list[2].buy_num)

				slot3 = uv0.GetSkinGiveBackList(slot1.buy_goods_list)

				JumpTools.OpenPageByJump("/skinDlcShow", {
					goodId = slot1.buy_goods_list[1].buy_id,
					dlcId = slot1.buy_goods_list[2].buy_id,
					callBack = function ()
						getReward(uv0, {
							ItemConst.ITEM_TYPE.HERO_SKIN
						})
					end
				})
				ShopData.ShopItemUpdate(slot1.buy_goods_list[1].buy_id, slot1.shop_id, slot1.buy_goods_list[1].buy_num)
				ShopData.ShopItemUpdate(slot1.buy_goods_list[2].buy_id, slot1.shop_id, slot1.buy_goods_list[2].buy_num)

				return
			end

			for slot6, slot7 in ipairs(slot1.buy_goods_list) do
				ShopData.ShopItemUpdate(slot7.buy_id, slot1.shop_id, slot7.buy_num)

				slot10 = slot8.give or 1
				slot11, slot12 = nil

				if ((not slot8.description or RechargeShopDescriptionCfg[slot8.description]) and ItemCfg[getShopCfg(slot7.buy_id).give_id or slot8.description]).sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
					slot13 = {}

					for slot18, slot19 in ipairs(slot12.param) do
						table.insert(slot13, {
							slot19[1],
							slot19[2] * slot7.buy_num * slot10
						})
					end

					slot2 = slot13
				elseif slot12.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_SEVEN_PACKS then
					slot13 = {}

					for slot18, slot19 in ipairs(slot12.param[1]) do
						table.insert(slot13, {
							slot19[1],
							slot19[2] * slot7.buy_num * slot10
						})
					end

					slot2 = slot13
				elseif slot12.type == 5 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == slot12.sub_type then
					slot2 = {
						{
							slot9,
							slot10 * slot7.buy_num
						}
					}
				elseif slot12.type == 8 and slot8.description then
					slot2 = {}
					slot2 = {
						{
							slot12.param[1],
							1
						}
					}
				elseif slot12.type == ItemConst.ITEM_TYPE.SCENE then
					slot2 = {
						{
							slot12.id,
							[2.0] = 1
						}
					}
				end

				if slot8.give_back_list and next(slot8.give_back_list) ~= nil then
					slot13 = {}

					for slot17, slot18 in ipairs(slot8.give_back_list) do
						table.insert(slot13, {
							slot18.id,
							slot18.num
						})
					end

					table.insertto(slot2, slot13)
				end

				slot2 = mergeReward(formatRewardCfgList(slot2))

				manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK, slot0.result, slot7.buy_id, slot1.shop_id, slot7.buy_num)

				if slot12.type == ItemConst.ITEM_TYPE.SCENE then
					JumpTools.OpenPageByJump("/skinDlcShow", {
						goodId = slot7.buy_id,
						callBack = function ()
							getReward(uv0)
						end
					})
				elseif slot2 and #slot2 > 0 then
					getReward(slot2, {
						ItemConst.ITEM_TYPE.HERO_SKIN
					}, function ()
						uv0:AfterShopItemUpdate(uv1)
					end)
				else
					ShowTips("TRANSACTION_SUCCESS")
				end
			end
		elseif slot0.result == 899 then
			ShowMessageBox({
				content = GetTips("EQUIP_NUM_MAX"),
				OkCallback = function ()
					JumpTools.GoToSystem("/bag", {
						type = "equip"
					}, ViewConst.SYSTEM_ID.BAG)
				end
			})
		elseif slot0.result == 406 then
			ShowTips("ITEM_INVALID")
		elseif TipsCfg[slot0.result] ~= nil then
			ShowTips(TipsCfg[slot0.result].desc)
		else
			ShowTips(GetTips(tostring(slot0.result)))
		end

		manager.notify:Invoke(SHOP_BUY_SUCCESS, slot1.buy_goods_list[1].buy_id, slot1.shop_id)
	end,
	CheckIsDlcAndSkin = function (slot0)
		if #slot0 ~= 2 then
			return false
		end

		slot2 = getShopCfg(slot0[2].buy_id)
		slot3, slot4 = nil

		return ((not getShopCfg(slot0[1].buy_id).description or RechargeShopDescriptionCfg[slot1.description]) and ItemCfg[slot1.give_id]).type == 8 and ((not slot2.description or RechargeShopDescriptionCfg[slot2.description]) and ItemCfg[slot2.give_id]).type == 21
	end,
	GetSkinGiveBackList = function (slot0)
		slot1 = {}
		slot3 = getShopCfg(slot0[2].buy_id)
		slot4, slot5 = nil
		slot1 = {
			{
				((not getShopCfg(slot0[1].buy_id).description or RechargeShopDescriptionCfg[slot2.description]) and ItemCfg[slot2.give_id]).param[1],
				1
			},
			{
				((not slot3.description or RechargeShopDescriptionCfg[slot3.description]) and ItemCfg[slot3.give_id]).id,
				1
			}
		}

		if slot2.give_back_list and next(slot2.give_back_list) ~= nil then
			slot7 = {}

			for slot11, slot12 in ipairs(slot2.give_back_list) do
				table.insert(slot7, {
					slot12.id,
					slot12.num
				})
			end

			table.insertto(slot1, slot7)
		end

		if slot3.give_back_list and next(slot3.give_back_list) ~= nil then
			slot7 = {}

			for slot11, slot12 in ipairs(slot3.give_back_list) do
				table.insert(slot7, {
					slot12.id,
					slot12.num
				})
			end

			table.insertto(slot1, slot7)
		end

		return mergeReward(formatRewardCfgList(slot1))
	end,
	AfterShopItemUpdate = function (slot0, slot1)
		if slot1.type == 5 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == slot1.sub_type then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("LUCKILYBAG_JUMP"),
				OkCallback = function ()
					JumpTools.GoToSystem("/bag", nil, ViewConst.SYSTEM_ID.BAG)
				end
			})
		end
	end,
	RefreshSingleShop = function (slot0, slot1)
		uv0.diamondRequire_ = slot1

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < slot1 then
			ShopTools.DefaultOpenPopUp(1)

			return
		end

		manager.net:SendWithLoadingNew(20014, {
			shop_id = slot0
		}, 20015, uv0.OnRefreshSingleShop)
	end,
	OnRefreshSingleShop = function (slot0, slot1)
		if slot0.result == 0 then
			uv0.diamondRequire_ = nil
		end

		manager.notify:CallUpdateFunc(ON_SHOP_REFRESH_ONE_SHOP, slot0)
	end,
	RefreshAllShop = function ()
		manager.net:SendWithLoadingNew(20016, {}, 20017, uv0.OnRefreshAllShop)
	end,
	OnRefreshAllShop = function (slot0, slot1)
		manager.notify:Invoke(SHOP_REFRESH_ALL_SHOP, slot0)
	end,
	ResolveFragment = function ()
		manager.net:SendWithLoadingNew(14032, {}, 14033, uv0.OnResolveFragment)
	end,
	OnResolveFragment = function (slot0, slot1)
		manager.notify:CallUpdateFunc(ON_RESOLVE_FRAGMENT, slot0)
	end,
	RemoveShopRedPoint = function (slot0)
		manager.net:SendWithLoadingNew(20020, {
			shop_id = slot0
		}, 20021, uv0.OnRemoveShopRedPoint)
	end,
	OnRemoveShopRedPoint = function (slot0, slot1)
		if slot0.result == 0 then
			ShopData.UpdateRedPoint(slot1.shop_id)
			uv0.UpdateNewShopRedPoints()
		end
	end
}
