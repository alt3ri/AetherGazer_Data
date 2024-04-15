function slot0(slot0)
	if slot0 >= 5 then
		return "#FF9300"
	elseif slot0 >= 4 then
		return "#B200FF"
	else
		return "#000000"
	end
end

slot1 = class("DrawRecordItem", ReduxView)

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:BindCfgUI()

	slot0.colorCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot1.SetItemColor(slot0, slot1, slot2)
	if slot1 == ItemConst.ITEM_TYPE.HERO then
		slot0.colorCon_:SetSelectedState(tostring(slot2))
	elseif slot1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT and slot2 >= 4 then
		slot0.colorCon_:SetSelectedState(tostring(slot2))
	else
		slot0.colorCon_:SetSelectedState("white")
	end
end

function slot1.RefreshUI(slot0, slot1, slot2)
	slot3 = slot1.item
	slot6 = ItemCfg[slot3.id]
	slot0.num_label.text = manager.time:STimeDescS(slot1.draw_timestamp, "!%Y/%m/%d %H:%M")
	slot0.name_label.text = GetI18NText(ItemTools.getItemName(slot3.id))
	slot0.type_label.text = string.format("[%s]", GetTips(ItemConst.ITEM_TYPE_NAME[slot6.type]))

	slot0:SetItemColor(slot6.type, slot6.display_rare)
end

slot2 = class("TreasureRecordView", ReduxView)

function slot2.UIName(slot0)
	return "Widget/System/Pool/PoolRecordPopUI"
end

function slot2.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot2.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.pageNum_ = 1
end

function slot2.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollviewGo_, uv0)
end

function slot2.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgmask_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		if uv0.pageNum_ * 10 + 1 <= #uv0.record_list then
			uv0.pageNum_ = uv0.pageNum_ + 1
			uv0.pagenumText_.text = uv0.pageNum_

			uv0:UpdateData(uv0.pageNum_)
			uv0.scrollHelper_:StartScroll(#uv0.itemList_)
		end
	end)
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		if uv0.pageNum_ > 1 then
			uv0.pageNum_ = uv0.pageNum_ - 1
			uv0.pagenumText_.text = uv0.pageNum_

			uv0:UpdateData(uv0.pageNum_)
			uv0.scrollHelper_:StartScroll(#uv0.itemList_)
		end
	end)
end

function slot2.OnEnter(slot0)
	slot0.pageNum_ = 1

	if DrawData:GetDrawRecord(slot0.params_.poolId) then
		slot0.times = slot2.ssr_draw_times
		slot0.record_list = slot2.draw_record_list

		slot0:RefreshUI()
	else
		DrawAction.RequestRecord(slot1)
	end
end

function slot2.OnRequestRecord(slot0, slot1, slot2)
	if DrawData:GetDrawRecord(slot2.id) then
		slot0.times = slot3.ssr_draw_times
		slot0.record_list = slot3.draw_record_list or {}

		slot0:RefreshUI()
	end
end

function slot2.RefreshUI(slot0)
	slot0.pagenumText_.text = slot0.pageNum_

	slot0:UpdateData(slot0.pageNum_)
	slot0.scrollHelper_:StartScroll(#slot0.itemList_)
end

function slot2.UpdateData(slot0, slot1)
	slot0.itemList_ = {}

	for slot6 = (slot1 - 1) * 10 + 1, math.min(slot1 * 10, #slot0.record_list) do
		table.insert(slot0.itemList_, slot0.record_list[slot6])
	end
end

function slot2.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1], slot0.params_.poolId)
end

function slot2.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot2
