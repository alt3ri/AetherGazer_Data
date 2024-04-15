slot0 = class("EquipExchangeItem", ShopItemBase)

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.bgController = slot0.controller_:GetController("bg")
	slot0.starController = slot0.controller_:GetController("star")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0.callback(uv0.data, uv0.index)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data = slot1
	slot0.suitData = slot1[1]
	slot0.shopCfg = getShopCfg(slot0.suitData.id)
	slot0.equipCfg = EquipCfg[slot0.shopCfg.give_id]
	slot0.index = slot2
	slot0.callback = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.priceText_.text, slot2, slot3 = ShopTools.GetPrice(slot0.suitData.id)

	if slot0.shopCfg.cost_id == 0 then
		slot4 = slot0.shopCfg.cheap_cost_id
	end

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot4)
	slot5 = EquipSuitCfg[slot0.equipCfg.suit]
	slot0.nameText_.text = GetI18NText(slot5.name)
	slot0.icon_.sprite = getSpriteViaConfig("EquipIcon_s", slot5.icon)

	slot0.starController:SetSelectedState(slot0.equipCfg.starlevel)
	slot0.bgController:SetSelectedState(slot0.equipCfg.starlevel)
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
