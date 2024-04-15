slot0 = class("PopFukubukuroProbabilityView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Recharge/FukubukuroProbabilityPopUI"
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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, PopFukubukuroProbabilityItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_mask, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
end

function slot0.OnEnter(slot0)
	slot0.itemId = slot0.params_.itemId

	if ItemCfg[slot0.itemId] and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == slot1.sub_type then
		slot0.probabilitys = slot1.param
		slot0.weight = 0

		for slot5, slot6 in ipairs(slot0.probabilitys) do
			slot0.weight = slot0.weight + slot6[3]
		end

		slot0.list:StartScroll(#slot0.probabilitys)
	else
		slot0.list:StartScroll(0)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.probabilitys[slot1], slot0.probabilitys, slot0.weight)
end

return slot0
