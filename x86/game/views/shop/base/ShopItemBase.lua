slot0 = class("ShopItemBase", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, , "OnClick")
	slot0:AddBtnListener(slot0.tipsBtn_, nil, function ()
		if ItemCfg[uv0.itemCfg.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = uv0.itemCfg.id
			})
		else
			ShowPopItem(POP_SOURCE_ITEM, {
				uv0.itemCfg.id
			})
		end
	end)
end

function slot0.SetPriceText(slot0, slot1)
	if slot1 == nil then
		slot1 = slot0.goodID
	end

	slot0.priceText_.text, slot3, slot4 = ShopTools.GetPrice(slot0.goodID)
end

function slot0.UpdatePrice(slot0, slot1)
	slot2 = getShopCfg(slot1)
	slot4, slot0.oldPriceLabel_.text, slot6 = ShopTools.GetPrice(slot1)

	if ShopListCfg[slot0.shopID].system == "1" and slot0.oldPriceLabel_ then
		SetActive(slot0.oldPriceLabel_.gameObject, true)
	elseif slot0.oldPriceLabel_ then
		SetActive(slot0.oldPriceLabel_.gameObject, false)
	end

	slot0.moneyTxt_.text = ShopTools.GetMoneySymbol(slot1)

	if slot4 <= 0 then
		slot0.costTypeController_:SetSelectedState("free")
	else
		if ShopTools.IsRMB(slot1) then
			slot0.priceText_.text = slot4
		else
			slot0:SetCostIcon()
			slot0:SetPriceText(slot1)
		end

		if slot0.isDiscountController_ then
			slot0.isDiscountController_:SetSelectedState(slot0:IsOnDiscountArea(slot1) and "true" or "false")
		end

		slot0.costTypeController_:SetSelectedState(ShopTools.IsRMB(slot1) and "money" or "currency")
	end

	if slot2.tag == ShopConst.TAGS.NEW then
		slot0.tipController_:SetSelectedState(slot0:IsOnDiscountArea(slot1) and "discount" or "none")
	end

	if ShopTools.IsRMB(slot1) and ShopTools.IsPC() then
		slot0.priceText_.text = GetTips("PC_SHOP_TIPS3")
		slot0.moneyTxt_.text = ""
	end
end

function slot0.IsOnDiscountArea(slot0, slot1)
	return ShopTools.IsOnDiscountArea(slot1)
end

function slot0.SetCostIcon(slot0)
	if slot0.shopCfg.cost_id == 0 then
		slot1 = slot0.shopCfg.cheap_cost_id
	end

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot1)
end

function slot0.SetCommonItem(slot0)
	CommonTools.SetCommonData(slot0.commonItem_, {
		id = slot0.itemCfg.id
	}, slot0.commonData)
end

function slot0.SetData(slot0, slot1)
	slot0.data = slot1
	slot0.shopCfg = getShopCfg(slot1.id)
	slot0.goodID = slot1.id
	slot0.dlcID = slot0.shopCfg.dlc or nil
	slot0.haveDlc = slot0.dlcID ~= nil and slot0.dlcID ~= 0
	slot0.isExchange = slot0.shopCfg.shop_refresh == 2
	slot0.shopID = slot0.shopCfg.shop_id
	slot2 = nil

	if slot0.shopCfg.description then
		slot0.isDesc = true
		slot0.itemCfg = RechargeShopDescriptionCfg[slot0.shopCfg.description]
		slot2 = slot0.itemCfg.param[1]
	else
		slot0.isDesc = false
		slot0.itemCfg = ItemCfg[slot0.shopCfg.give_id]
	end

	if slot2 and SkinCfg[slot2] then
		slot0.skinCfg = SkinCfg[slot2]
		slot0.skinID = slot2
		slot0.heroCfg = HeroCfg[slot0.skinCfg.hero]
	end

	if slot0.haveDlc then
		slot0.shopDlcCfg = getShopCfg(slot0.dlcID)
		slot0.itemDlcCfg = RechargeShopDescriptionCfg[slot0.shopDlcCfg.description]

		if slot0.itemDlcCfg == nil then
			slot0.itemDlcCfg = ItemCfg[getShopCfg(slot0.dlcID).give_id]
		end

		slot0.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == slot0.shopDlcCfg.shop_id
	end

	slot0.buyTime = ShopData.GetShop(slot0.shopID)[slot0.goodID] ~= nil and ShopData.GetShop(slot0.shopID)[slot0.goodID].buy_times or 0
	slot0.restNum = slot0.shopCfg.limit_num - slot0.buyTime

	slot0:UpdateView()
	slot0:UpdateTimerView()
end

function slot0.UpdateView(slot0)
end

function slot0.UpdateTimerView(slot0)
end

function slot0.GetItemInfo(slot0)
	return slot0.data
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callBack = slot1
end

function slot0.ClickFunction(slot0)
	if ItemCfg[slot0.shopCfg.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		if ShopTools.HaveSkin(slot0.shopCfg.give_id) then
			return
		end
	elseif slot0.shopCfg.limit_num then
		if slot0.shopCfg.limit_num ~= -1 and slot0.shopCfg.limit_num <= slot0.data.buyTime then
			return
		end

		slot2, slot3 = ShopTools.JudgeIsLvLimit(slot0.shopCfg.level_limit)

		if slot2 then
			return
		end
	end

	JumpTools.OpenPopUp("shopBuy", {
		goodInfo = slot0.data
	})
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
