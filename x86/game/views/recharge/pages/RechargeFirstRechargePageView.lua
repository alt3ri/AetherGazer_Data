slot1 = class("RechargeFirstRechargeWelfarePageView", import("game.views.recharge.pages.RechargePageBase"))

function slot1.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2[1]

	slot0:BindCfgUI()

	slot0.contentViewList_ = {}
	slot0.contentClasss_ = {
		ActivityNoobFirstRechargeView_1,
		ActivityNoobFirstRechargeView_2
	}
end

function slot1.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.contentViewList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot1.SwitchPage(slot0, slot1)
	slot2 = ShopConst.SIX_EIGHT[slot1]

	if slot0.curView_ then
		slot0.curView_:SetActive(false)
	end

	if not slot0.contentViewList_[slot2] then
		slot0.contentViewList_[slot2] = slot0.contentClasss_[slot2].New(slot0.contentTrans_, slot0.index_)
	end

	slot0.curView_ = slot0.contentViewList_[slot2]

	slot0.curView_:SetData(slot2)
	slot0.curView_:SetActive(true)
end

return slot1
