slot0 = class("CommonItemPool", ReduxView)

function slot0.GetItemPath(slot0)
	if slot0.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.isSmall_ = slot3
	slot0.gameObject_ = manager.objectPool:Get(slot0:GetItemPath())
	slot0.transform_ = slot0.gameObject_.transform

	slot0.gameObject_.transform:SetParent(slot1.transform)

	slot0.commonItem_ = CommonItemView.New(slot0.gameObject_)

	slot0:SetData(slot2)
end

function slot0.SetData(slot0, slot1)
	slot0.commonItem_:SetData(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	manager.objectPool:Return(slot0:GetItemPath(), slot0.gameObject_)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
