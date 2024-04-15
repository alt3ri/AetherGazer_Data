slot0 = class("ChapterBaseVirtualItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
end

function slot0.OnEnter(slot0)
	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnExit(slot0)
	slot0:Show(false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

return slot0
