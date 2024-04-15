slot0 = class("DrawGiftView", ReduxView)
slot1 = 15

function slot0.UIName(slot0)
	return "Widget/System/Recharge/RechargeDrawGiftUI"
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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, RechargeGiftItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_bgmask, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	if DrawTools.GetActivityCostTicket(slot0.poolId) == 0 or ItemTools.IsItemExpiredByItemId(slot2) then
		manager.windowBar:SwitchBar(table.insertto(DrawTools.GetCostTicketList(slot0.poolId), {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		}))
	else
		if ItemTools.getItemNum(slot2) > 0 then
			table.insert({}, slot2)
		end

		for slot7, slot8 in ipairs(slot1) do
			table.insert(slot3, slot8)
		end

		table.insertto(slot3, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(slot3)

		if ItemTools.getItemNum(slot2) > 0 then
			manager.windowBar:SetBarCanAdd(slot2, false)
			manager.windowBar:SetBarCanClick(slot2, true)
		end
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	slot0.list:Refresh()
end

function slot0.OnEnter(slot0)
	slot0.poolId = slot0.params_.poolId

	slot0:RefreshUI()
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0.list:Refresh()
	end)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		uv0.list:Refresh()
	end)
	slot0:RegistEventListener(SHOP_BUY_SUCCESS, function (slot0, slot1)
		uv0:RefreshUI()
	end)
end

function slot0.RefreshUI(slot0)
	slot0.recharge_shop_list = DrawTools.GetRechargeDrawGiftList(slot0.poolId)

	slot0.list:StartScroll(#slot0.recharge_shop_list)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData({
		id = slot0.recharge_shop_list[slot1]
	})
end

function slot0.OnItemOutOfDate(slot0, slot1)
	slot0:RefreshUI()
end

function slot0.OnShopBuyResult(slot0)
	slot0.list:Refresh()
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
