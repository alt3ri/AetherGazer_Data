slot1 = class("RechargeWelfarePageView", import("game.views.recharge.pages.RechargePageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.rechargeItemList_ = {}

	for slot5, slot6 in pairs(ActivityNewbieData:GetRechargeTemplate()) do
		slot0.rechargeItemList_[slot5] = ActivityNewbieRechargeItem.New(slot0[string.format("button%s_", slot5)], slot5)
	end

	slot0:Show()
end

function slot1.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rechargeItemList_) do
		slot5:Dispose()
	end

	slot0.rechargeItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.Show(slot0)
	SetActive(slot0.gameObject_, true)

	for slot4, slot5 in pairs(slot0.rechargeItemList_) do
		slot5:RefreshUI()
	end
end

return slot1
