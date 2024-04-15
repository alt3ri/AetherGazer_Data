slot0 = class("SkinBuyCheckDLCItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.discountController = ControllerUtil.GetController(slot0.transform_, "discount")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.itemController = ControllerUtil.GetController(slot0.transform_, "icon")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		uv0.clickFunc(uv0.index)
	end)
	slot0:AddBtnListener(slot0.m_addBtn, nil, function ()
		if uv0.index == 1 then
			return
		end

		if ShopConst.SHOP_ID.DLC_SHOP ~= getShopCfg(uv0.id).shop_id then
			return
		end

		uv0.selectClickFunc(uv0.id)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.id = slot2
	slot5 = slot3.give or 1
	slot6, slot7 = nil
	slot7 = (not slot3.description or RechargeShopDescriptionCfg[slot3.description]) and ItemCfg[getShopCfg(slot2).give_id or slot3.description]
	slot0.isDlc = slot7.type ~= ItemConst.ITEM_TYPE.HERO_SKIN

	if slot7.type == ItemConst.ITEM_TYPE.HERO_SKIN then
		slot0.itemController:SetSelectedIndex(1)

		slot0.m_skinIcon.sprite = ItemTools.getItemSprite(slot7.id)
	else
		slot0.itemController:SetSelectedIndex(0)

		slot0.m_icon.sprite = ItemTools.getItemSprite(slot7.id)
	end

	slot0.m_currency.sprite = ItemTools.getItemLittleSprite(slot3.cost_id)

	slot0:UpdateTimer()
end

function slot0.UpdateTimer(slot0)
	slot1 = slot0.id
	slot2 = getShopCfg(slot1)
	slot0.m_num.text, slot0.m_oldPriceLabel.text, slot5 = ShopTools.GetPrice(slot1, slot2.shop_id)
	slot6, slot7, slot8 = ShopTools.IsOnDiscountArea(slot1, slot2.shop_id)

	if slot6 and slot8 then
		if slot7 then
			slot0.discountController:SetSelectedState("time_limit_discount")

			if slot0.isDlc then
				slot0.discountLastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(slot2.cheap_close_time)))
			else
				slot0.discountLastTimeLabel_.text = ""
			end
		else
			slot0.discountController:SetSelectedState("discount")
		end
	else
		slot0.discountController:SetSelectedState("null")
	end
end

function slot0.GetIndex(slot0)
	return slot0.index
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.SetState(slot0, slot1)
	if slot1 == 2 then
		slot0.m_btn.interactable = false
	else
		slot0.m_btn.interactable = true
	end

	slot0.stateController:SetSelectedIndex(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.RegistSelectCallBack(slot0, slot1)
	slot0.selectClickFunc = slot1
end

return slot0
