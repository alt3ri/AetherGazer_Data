slot1 = class("RecallSystemShopItem", import("game.views.shop.base.ShopItemBase"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItemView.New(slot0.itemGo_, true)
	slot0.commonData = clone(ItemTemplateData)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		uv0:ClickFunction()
	end)
	slot0:AddBtnListener(slot0.bgBuyBtn_, nil, function ()
		uv0:ClickFunction()
	end)
end

function slot1.UpdateView(slot0)
	CommonTools.SetCommonData(slot0.commonItem_, {
		id = slot0.itemCfg.id,
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	}, slot0.commonData)

	slot0.itemNameTxt_.text = string.format("%s x%d", ItemTools.getItemName(slot0.itemCfg.id), slot0.shopCfg.give)

	slot0:SetPriceText()
	slot0:SetCostIcon()

	if slot0.shopCfg.limit_num == -1 or slot0.shopCfg.limit_num == nil then
		SetActive(slot0.buyLimitGo_, false)
		SetActive(slot0.buyLimitTxt_.gameObject, false)
		SetActive(slot0.maskGo_, false)
	elseif slot0.shopCfg.limit_num - slot0.data.buyTime > 0 then
		SetActive(slot0.buyLimitTxt_.gameObject, true)
		SetActive(slot0.buyLimitGo_, true)
		SetActive(slot0.maskGo_, false)

		slot0.buyLimitTxt_.text = string.format("<color=#0d89bf>%d</color>/%d", slot1, slot0.shopCfg.limit_num)
	else
		SetActive(slot0.buyLimitTxt_.gameObject, false)
		SetActive(slot0.buyLimitGo_, false)
		SetActive(slot0.maskGo_, true)
	end
end

function slot1.Dispose(slot0)
	slot0.commonItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot1
