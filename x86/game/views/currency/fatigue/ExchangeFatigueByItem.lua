slot0 = class("ExchangeFatigueByItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.isEmptyController_ = slot0.controllerEx_:GetController("isEmpty")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiListGo_, CommonItemView)
end

function slot0.InitData(slot0)
	slot0.dataList_ = StoreTools.GetMaterialListBySubTypes({
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY,
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID
	})

	table.sort(slot0.dataList_, function (slot0, slot1)
		if ((ItemTools.GetItemExpiredTimeByInfo(slot0) or 0) > 0 and 1 or 0) ~= ((ItemTools.GetItemExpiredTimeByInfo(slot1) or 0) > 0 and 1 or 0) then
			return slot5 < slot4
		end

		if slot2 ~= slot3 then
			return slot2 < slot3
		end

		return slot0.id < slot1.id
	end)
end

function slot0.OnEnter(slot0)
	if #slot0.dataList_ <= 0 then
		slot0.isEmptyController_:SetSelectedState("true")

		return
	else
		slot0.isEmptyController_:SetSelectedState("false")
	end

	slot0.selectDic_ = {}

	slot0.uiList_:StartScroll(#slot0.dataList_)
	slot0:UpdatePreview()
end

function slot0.OnExit(slot0)
	slot0.uiList_:StopRender()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil
end

function slot0.OnExchange(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(slot0.selectDic_) do
		if slot7 > 0 then
			slot2 = 0 + slot7

			table.insert(slot1, {
				item_info = {
					id = tonumber(string.split(slot6, "_")[1]),
					num = slot10,
					time_valid = tonumber(string.split(slot6, "_")[2] or 0)
				},
				use_list = {}
			})
		end
	end

	if #slot1 == 0 or slot2 == 0 then
		ShowTips("TIP_CHOOSE_EMPTY")

		return
	end

	if slot0:GetSelectTotalVitality() + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return false
	end

	CommonAction.TryToUseItem(slot1)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot3 = slot0.dataList_[slot1].id
	slot4 = slot0.dataList_[slot1].timeValid
	slot5 = clone(ItemTemplateData)
	slot5.id = slot3
	slot5.number = slot0.dataList_[slot1].num
	slot5.timeValid = slot4
	slot5.need_count_down = true
	slot5.topAmountValue = slot0.selectDic_[slot0:GetKey(slot3, slot4)] or 0

	function slot5.longClickFun(slot0, slot1, slot2)
		if slot2.dragging then
			return false
		end

		uv0:AddSelect(uv1, uv2)
		uv3:RefreshTopAmount(uv0.selectDic_[uv4])
		uv0:UpdatePreview()

		return true
	end

	function slot5.clickAmountFun(slot0)
		uv0:DeleteSelect(uv1, uv2)
		uv3:RefreshTopAmount(uv0.selectDic_[uv4])
		uv0:UpdatePreview()

		return true
	end

	slot2:SetData(slot5)
end

function slot0.GetKey(slot0, slot1, slot2)
	return string.format("%d_%s", slot1, tostring(slot2))
end

function slot0.AddSelect(slot0, slot1, slot2)
	if not slot0.selectDic_[slot0:GetKey(slot1, slot2)] then
		slot0.selectDic_[slot3] = 0
	end

	slot4 = ItemTools.getItemNum(slot1, slot2)

	if slot0:GetSelectTotalVitality() + ItemCfg[slot1].param[1][2] + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return
	end

	slot0.selectDic_[slot3] = math.min(slot4, slot0.selectDic_[slot3] + 1)
end

function slot0.DeleteSelect(slot0, slot1, slot2)
	if not slot0.selectDic_[slot0:GetKey(slot1, slot2)] then
		slot0.selectDic_[slot3] = 0
	end

	slot0.selectDic_[slot3] = math.max(slot0.selectDic_[slot3] - 1, 0)
end

function slot0.GetSelectTotalVitality(slot0)
	for slot5, slot6 in pairs(slot0.selectDic_) do
		slot8 = string.split(slot5, "_")[2]
		slot1 = 0 + ItemCfg[tonumber(string.split(slot5, "_")[1])].param[1][2] * slot6
	end

	return slot1
end

function slot0.UpdatePreview(slot0)
	slot1 = slot0:GetSelectTotalVitality()
	slot0.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_LIST_EXCHANGE"), slot1, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_VITALITY))
	slot0.getNumText_.text = slot1
end

function slot0.HasMaterial(slot0)
	return #slot0.dataList_ > 0
end

return slot0
