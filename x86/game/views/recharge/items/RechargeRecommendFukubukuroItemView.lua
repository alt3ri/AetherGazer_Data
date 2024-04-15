slot0 = class("RechargeRecommendFukubukuroItemView", RechargeRecommendBgItemView)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CommonItem)
end

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_rareBtn, function ()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = uv0.itemId
		})
	end)
end

function slot0.UpdateView(slot0)
	uv0.super.UpdateView(slot0)

	slot0.itemId = 30041
	slot0.items = ItemCfg[slot0.itemId].param

	slot0.list:StartScroll(#slot0.items)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.items[slot1]

	slot2:RefreshData({
		id = slot3[1],
		number = slot3[2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
