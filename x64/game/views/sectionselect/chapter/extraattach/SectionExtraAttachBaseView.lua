slot0 = class("SectionExtraAttachBaseView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
end

function slot0.OnEnter(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnExit(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.RefreshUI(slot0)
end

return slot0
