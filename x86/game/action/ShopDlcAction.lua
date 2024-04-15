slot1 = {}
slot2 = {}

return {
	DlcConfirmBuyItem = function (slot0, slot1)
		uv0 = {}
		uv1 = {}
		slot2 = ShopTools.GetCostCfg(slot0)
		slot4 = ""

		for slot8, slot9 in ipairs(slot1) do
			slot10 = getShopCfg(slot9)
			slot11, slot12, slot13 = ShopTools.GetPrice(slot9, slot10.shop_id)
			slot3 = 0 + slot11
			slot14 = RechargeShopDescriptionCfg[slot10.description]
			slot4 = (slot8 ~= 1 or GetI18NText(slot14.name)) and GetI18NText(slot14.name) .. "," .. GetI18NText(slot14.name)
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("CONFIRM_BUY"), GetI18NText(slot2.name), slot3, slot4, 1),
			OkCallback = function ()
				for slot3, slot4 in ipairs(uv0) do
					if ShopData.IsGoodOutOfDate(slot4, getShopCfg(slot4).shop_id) then
						ShowTips("GOODS_HAS_BEEN_REMOVED")

						return
					end
				end

				uv1 = clone(uv0)
				uv2 = {}
				slot0 = table.remove(uv1, 1)

				uv3.BuyItem(slot0, 1, nil, getShopCfg(slot0).shop_id)
			end,
			CancelCallback = function ()
			end
		})
	end,
	BuyItem = function (slot0, slot1, slot2, slot3)
		slot5 = ShopListCfg[slot3].type ~= 3

		if not ShopTools.IsShopOpen(getShopCfg(slot0, slot3).shop_id) then
			ShowTips("TIME_OVER")

			return
		end

		slot7 = 0

		if slot2 then
			slot7 = slot2
		else
			slot7 = slot4.cost
			slot8, slot9, slot10 = ShopTools.IsOnDiscountArea(slot0, slot6)

			if slot8 and slot10 then
				slot7 = slot4.cheap_cost
			end
		end

		slot9 = ItemCfg[slot4.cost_id].type
		slot10 = {}

		table.insert(slot10, {
			id = slot4.cost_id,
			num = slot7 * slot1
		})
		SendMessageManagerToSDK("purchase_complete_GP_ONCE")

		return manager.net:SendWithLoadingNew(20012, {
			buy_id = slot0,
			shop_id = slot4.shop_id,
			buy_num = slot1,
			cost_items = slot10,
			buy_source = 0
		}, 20013, uv0.ShopItemUpdate)
	end,
	ShopItemUpdate = function (slot0, slot1)
		slot2 = nil

		if slot0.result == 0 then
			ShopData.ShopItemUpdate(slot1.buy_id, slot1.shop_id, slot1.buy_num)

			slot5 = ShopTools.GetPrice(slot1.buy_id, slot1.shop_id) * slot1.buy_num
			slot7 = slot3.give or 1
			slot8, slot9 = nil

			if ((not slot3.description or RechargeShopDescriptionCfg[slot3.description]) and ItemCfg[getShopCfg(slot1.buy_id, slot1.shop_id).give_id or slot3.description]).sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
				slot10 = {}

				for slot15, slot16 in ipairs(slot9.param) do
					table.insert(slot10, {
						slot16[1],
						slot16[2] * slot1.buy_num * slot7
					})
				end

				slot2 = slot10
			elseif slot9.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_SEVEN_PACKS then
				slot10 = {}

				for slot15, slot16 in ipairs(slot9.param[1]) do
					table.insert(slot10, {
						slot16[1],
						slot16[2] * slot1.buy_num * slot7
					})
				end

				slot2 = slot10
			elseif slot9.type == 8 and slot3.description then
				slot2 = {}
				slot2 = {
					{
						slot9.param[1],
						1
					}
				}
			else
				slot2 = {
					{
						slot6,
						slot7 * slot1.buy_num
					}
				}
			end

			if slot3.give_back_list and next(slot3.give_back_list) ~= nil then
				slot10 = {}

				for slot14, slot15 in ipairs(slot3.give_back_list) do
					table.insert(slot10, {
						slot15.id,
						slot15.num
					})
				end

				table.insertto(slot2, slot10)
			end

			manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK, slot0.result, slot1.buy_id, slot1.shop_id, slot1.buy_num)
			table.insertto(uv0, slot2)

			if #uv1 == 0 then
				if slot2 and #slot2 > 0 then
					uv0 = formatRewardCfgList(uv0)
					uv0 = mergeReward(uv0)

					getReward(uv0, {
						ItemConst.ITEM_TYPE.HERO_SKIN
					})
				else
					ShowTips("TRANSACTION_SUCCESS")
				end
			else
				slot10 = table.remove(uv1, 1)

				uv2.BuyItem(slot10, 1, nil, getShopCfg(slot10).shop_id)
			end
		elseif TipsCfg[slot0.result] ~= nil then
			ShowTips(TipsCfg[slot0.result].desc)
		else
			ShowTips(GetTips(tostring(slot0.result)))
		end

		manager.notify:Invoke(SHOP_BUY_SUCCESS, slot1.buy_id, slot1.shop_id)
	end
}
