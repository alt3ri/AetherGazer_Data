slot0 = class("ExchangeSplitItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
	SetActive(slot0.gameObject_, true)
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.SetItem), slot0.listGo_, ExchangeItemView)
end

function slot0.SetItem(slot0, slot1, slot2)
	slot2:SetData(slot0.data[slot1])
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.data = slot1
	slot0.titleIndex = slot2
	slot0.indexList = slot3
	slot0.index = slot4

	slot0:Show(true)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.list:StartScrollWithoutAnimator(#slot0.data)
	SetActive(slot0.titleGo_.gameObject, false)

	slot0.titleTxt_.text = ""

	for slot4, slot5 in ipairs(slot0.indexList) do
		if slot0.index == slot5 then
			SetActive(slot0.titleGo_.gameObject, true)

			if ShopConst.ITEM_TYPE_TO_LABEL[ItemCfg[getShopCfg(slot0.data[1].id).give_id].type] then
				slot0.titleTxt_.text = GetTips(ShopConst.ITEM_TYPE_TO_LABEL[slot7.type])
			else
				slot0.titleTxt_.text = GetTips("SHOP_LABLE_1")
			end
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.list:GetItemList()) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

function slot0.GetItemHeight(slot0)
	return slot0.rectGo_.sizeDelta.y
end

function slot0.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot0.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot0.GetIndex(slot0)
	return slot0.index
end

function slot0.IsActive(slot0)
	return true
end

function slot0.IsTimeBar(slot0)
	return false
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
