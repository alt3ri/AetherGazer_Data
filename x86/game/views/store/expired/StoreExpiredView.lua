slot0 = class("StoreExpiredView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Bag/BagExpiredUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveBonusController_ = slot0.controllerEx_:GetController("haveBonus")
	slot0.expiredItemList_ = LuaList.New(handler(slot0, slot0.indexExpiredItem), slot0.expiredListGo_, CommonItemView)
	slot0.expiredItemList2_ = LuaList.New(handler(slot0, slot0.indexExpiredItem), slot0.expiredListGo2_, CommonItemView)
	slot0.getItemList_ = LuaList.New(handler(slot0, slot0.indexGetItem), slot0.getListGo_, CommonItemView)
end

function slot0.indexGetItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot3.id = slot0.getItemDataList_[slot1].id
	slot3.number = slot0.getItemDataList_[slot1].num

	slot2:SetData(slot3)
end

function slot0.indexExpiredItem(slot0, slot1, slot2)
	slot3 = slot0.expiredList_[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3.id
	slot4.number = slot3.num

	slot2:SetData(slot4)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn2_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.expiredList_ = slot0.params_.expiredList
	slot1 = {}
	slot0.getItemDataList_ = {}

	for slot5, slot6 in ipairs(slot0.expiredList_) do
		if ItemTimeLimitExchangeCfg[slot6.id] then
			if not slot1[slot9.exchange_item[1]] then
				slot1[slot9.exchange_item[1]] = slot9.exchange_item[2] * slot6.num
			else
				slot1[slot9.exchange_item[1]] = slot1[slot9.exchange_item[1]] + slot9.exchange_item[2] * slot8
			end
		end
	end

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0.getItemDataList_, {
			id = slot5,
			num = slot6
		})
	end

	if #slot0.getItemDataList_ > 0 then
		slot0.haveBonusController_:SetSelectedState("true")
		slot0.expiredItemList_:StartScroll(#slot0.expiredList_)
		slot0.getItemList_:StartScroll(#slot0.getItemDataList_)
	else
		slot0.expiredItemList2_:StartScroll(#slot0.expiredList_)
		slot0.haveBonusController_:SetSelectedState("false")
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.expiredItemList_:Dispose()

	slot0.expiredItemList_ = nil

	slot0.expiredItemList2_:Dispose()

	slot0.expiredItemList2_ = nil

	slot0.getItemList_:Dispose()

	slot0.getItemList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
