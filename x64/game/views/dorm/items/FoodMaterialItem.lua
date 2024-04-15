slot0 = class("FoodMaterialItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.colorController = ControllerUtil.GetController(slot0.transform_, "numcolor1")
	slot0.shopController = ControllerUtil.GetController(slot0.transform_, "shopBtn")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		if uv0.goodID then
			JumpTools.GoToSystem("/activityShop", {
				hideHomeBtn = 1,
				shopId = ShopConst.SHOP_ID.CANTEEN_SHOP,
				showShops = {
					ShopConst.SHOP_ID.CANTEEN_SHOP
				},
				goodId = uv0.goodID
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1[1]
	slot0.num = slot1[2]
	slot0.textText_.text = ItemTools.getItemName(slot0.id)

	slot0.colorController:SetSelectedState("1")

	slot0.iconImg_.sprite = ItemTools.getItemSprite(slot0.id)

	if slot2 then
		slot6 = 0

		for slot10, slot11 in ipairs(BackHomeCanteenFoodCfg[slot2].ingredient_list) do
			if slot11[1] == slot0.id then
				slot6 = slot11[2]
			end
		end

		slot0.num = slot6 * slot3
	end

	slot0.costNumText_.text = NumberTools.RetractNumberForWindBar(slot0.num)

	if slot4 == DormEnum.FoodSellType.SignFood then
		slot0.hadNumText_.text = ""
	else
		slot5 = CanteenFoodData:GetCateenIngredientNum(slot0.id)
		slot0.hadNumText_.text = NumberTools.RetractNumberForWindBar(slot5)

		if slot5 < slot0.num then
			slot0.colorController:SetSelectedState("2")
		end

		slot0.costNumText_.text = "/" .. NumberTools.RetractNumberForWindBar(slot0.num)
	end

	slot6 = false

	for slot10, slot11 in ipairs(getGoodListByGiveID(slot0.id)) do
		if ShopTools.IsGoodCanBuy(ShopConst.SHOP_ID.CANTEEN_SHOP, slot11) then
			slot6 = true
			slot0.goodID = slot11

			break
		end
	end

	if slot6 then
		slot0.shopController:SetSelectedState("true")
	else
		slot0.shopController:SetSelectedState("false")
	end
end

function slot0.RegistCallBack(slot0, slot1)
	if slot1 then
		slot0.btnCallBack = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
