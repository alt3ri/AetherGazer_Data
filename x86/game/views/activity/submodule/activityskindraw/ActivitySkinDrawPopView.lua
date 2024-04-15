slot0 = class("ActivitySkinDrawPopView", ReduxView)

function slot0.UIName(slot0)
	return ActivitySkinDrawTools.GetPopUIName(slot0.params_.mainActivity)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.discountCon_ = ControllerUtil.GetController(slot0.transform_, "discount")
end

function slot0.AddUIListeners(slot0)
	slot0:AddToggleListener(slot0.tgl1_, function (slot0)
		uv0.choose_ = 1
	end)
	slot0:AddToggleListener(slot0.tgl2_, function (slot0)
		uv0.choose_ = 2
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		ShopAction.BuyItem({
			{
				goodID = uv0.goods_[uv0.choose_],
				buyNum = uv0.cnt_
			}
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.choose_ = 2
	slot0.tgl2_.isOn = true

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.activityID_ = slot0.params_.poolActivityID
	slot0.poolID_ = slot0.params_.poolID
	slot0.goods_ = slot0.params_.goods
	slot0.cnt_ = slot0.params_.cnt

	slot0:RefreshGoods()
	slot0:RefreshDiscount()
end

function slot0.RefreshGoods(slot0)
	slot0.text1_.text = slot0:GetGoodsDesc(1)
	slot0.text2_.text = slot0:GetGoodsDesc(2)
end

function slot0.GetGoodsDesc(slot0, slot1)
	slot3 = getShopCfg(slot0.goods_[slot1])
	slot4 = slot3.cost_id
	slot5 = slot3.give_id
	slot6 = slot3.cost

	if slot3.discount ~= 0 then
		slot6 = slot3.cheap_cost
	end

	return string.format(GetTips("GENGCHEN_SWIMWEAR_TICKET_TIPS"), slot6 * slot0.cnt_, ItemTools.getItemName(slot4), ItemTools.getItemName(slot5), slot0.cnt_)
end

function slot0.RefreshDiscount(slot0)
	if getShopCfg(slot0.goods_[2]).discount ~= 0 then
		slot0.discount_.text = string.format("%.1f%s", slot2.discount / 10, GetTips("LABEL_DISCOUNT"))

		slot0.discountCon_:SetSelectedState("true")
	else
		slot0.discountCon_:SetSelectedState("false")
	end
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3)
	slot0:Back()

	if slot2 == slot0.goods_[slot0.choose_] then
		ActivitySkinDrawAction.StartDraw(slot0.activityID_, slot0.poolID_, slot0.cnt_)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
