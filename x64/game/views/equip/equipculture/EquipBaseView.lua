slot0 = class("EquipBaseView", ReduxView)

function slot0.Init(slot0)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, true)

	slot0.params_ = slot1

	slot0:OnEnter()
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
