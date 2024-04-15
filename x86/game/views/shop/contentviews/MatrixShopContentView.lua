slot1 = class("MatrixShopContentView", import("game.views.shop.contentViews.ShopExchangeContentView"))

function slot1.GetExchangeGoodList(slot0)
	return ShopTools.FilterShopDataList(slot0.shopId_, true)
end

return slot1
