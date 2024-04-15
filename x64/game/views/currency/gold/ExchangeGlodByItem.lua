slot0 = class("ExchangeGlodByItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.isEmptyController_ = slot0.controllerEx_:GetController("isEmpty")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiListGo_, CommonItemView)
end

function slot0.InitData(slot0)
	slot0.dataList_ = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]
end

function slot0.OnEnter(slot0)
	if not slot0:HasMaterial() then
		slot0.isEmptyController_:SetSelectedState("true")

		return
	else
		slot0.isEmptyController_:SetSelectedState("false")
	end

	slot0.selectIndex_ = 0
	slot0.selectNum_ = 1
	slot0.canUseMaxNum_ = 1

	for slot4, slot5 in ipairs(slot0.dataList_) do
		if ItemTools.getItemNum(slot5) > 0 then
			slot0.selectIndex_ = slot4
			slot0.selectNum_ = 1
			slot0.canUseMaxNum_ = slot6

			break
		end
	end

	slot0.uiList_:StartScroll(#slot0.dataList_)
	slot0:UpdatePreview(slot0.selectNum_)
end

function slot0.OnExit(slot0)
	slot0.uiList_:StopRender()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.canUseMaxNum_ <= uv0.selectNum_ then
			return false
		end

		if (uv0.pressCnt_ > 1 and (uv0.pressCnt_ == 2 and slot0 + 9 or slot0 + 10) or slot0 + 1) < uv0.canUseMaxNum_ then
			uv0:UpdatePreview(slot0)

			return true
		end

		uv0:UpdatePreview(uv0.canUseMaxNum_)

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ <= 1 then
			return false
		end

		if (uv0.pressCnt_ > 1 and (uv0.pressCnt_ == 2 and slot0 - 9 or slot0 - 10) or slot0 - 1) > 1 then
			uv0:UpdatePreview(slot0)

			return true
		end

		uv0:UpdatePreview(1)

		return false
	end)
	slot0:AddToggleListener(slot0.slider_, function (slot0)
		uv0.selectNum_ = slot0

		uv0:UpdatePreview(slot0)
	end)
end

function slot0.OnExchange(slot0)
	CommonAction.TryToUseItem({
		{
			item_info = {
				id = slot0.dataList_[slot0.selectIndex_],
				num = slot0.selectNum_
			},
			use_list = {}
		}
	})
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot3 = slot0.dataList_[slot1]
	slot5 = clone(ItemTemplateData)
	slot5.id = slot3
	slot5.number = ItemTools.getItemNum(slot3)
	slot5.need_count_down = true

	if slot1 == slot0.selectIndex_ then
		slot5.selectStyle = true
	else
		slot5.selectStyle = false
	end

	function slot5.clickFun(slot0)
		if uv0 > 0 and uv1.selectIndex_ ~= uv2 then
			uv1.selectIndex_ = uv2
			uv1.selectNum_ = 1
			uv1.canUseMaxNum_ = uv0

			uv1.uiList_:Refresh()
			uv1:UpdatePreview(uv1.selectNum_)
		end
	end

	slot2:SetData(slot5)
end

function slot0.GetSelectTotalValue(slot0)
	slot1 = 0
	slot3 = 0

	for slot7, slot8 in pairs(ItemCfg[slot0.dataList_[slot0.selectIndex_]].param or {}) do
		if slot8[1] == CurrencyConst.CURRENCY_TYPE_GOLD then
			slot3 = slot8[2]
		end
	end

	return slot3 * slot0.selectNum_
end

function slot0.UpdatePreview(slot0, slot1)
	slot0.selectNum_ = slot1
	slot2 = formatNumber(slot0:GetSelectTotalValue())
	slot0.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_LIST_EXCHANGE"), slot2, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_GOLD))
	slot0.getNumText_.text = slot2
	slot0.useCntText_.text = slot1

	slot0:RefreshSlider()
end

function slot0.RefreshSlider(slot0)
	slot0.slider_.maxValue = slot0.canUseMaxNum_

	if slot0.canUseMaxNum_ == 1 then
		slot0.slider_.minValue = 0
		slot0.slider_.interactable = false
	else
		slot0.slider_.minValue = 1
		slot0.slider_.interactable = true
	end

	if slot0.slider_.value ~= slot0.selectNum_ then
		slot0.slider_.value = slot0.selectNum_
	end

	slot0.addBtn_.interactable = slot0.selectNum_ < slot0.canUseMaxNum_
	slot0.delBtn_.interactable = slot0.selectNum_ > 1
end

function slot0.HasMaterial(slot0)
	for slot4, slot5 in ipairs(slot0.dataList_) do
		if ItemTools.getItemNum(slot5) > 0 then
			return true
		end
	end

	return false
end

return slot0
