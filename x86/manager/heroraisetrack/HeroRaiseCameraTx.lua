slot0 = class("HeroRaiseCameraTx")

function slot0.Ctor(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.animator_ = nil
end

function slot0.Init(slot0, slot1)
	slot0.transform_ = Object.Instantiate(Asset.Load(slot1), manager.ui.mainCamera.transform)

	if not isNil(slot0.transform_) then
		slot0.gameObject_ = slot0.transform_.gameObject
		slot0.animator_ = slot0.transform_:GetComponent(typeof(Animator))

		if isNil(slot0.animator_) then
			slot0.animator_ = slot0.transform_:GetComponentInChildren(typeof(Animator))
		end
	end
end

function slot0.PlayAnim(slot0, slot1)
	if isNil(slot0.animator_) then
		return
	end

	slot0.animator_:Play(slot1)
end

function slot0.CheckValid(slot0)
	if isNil(slot0.gameObject_) then
		return false
	end

	return true
end

function slot0.Dispose(slot0)
	if not isNil(slot0.gameObject_) then
		Object.Destroy(slot0.gameObject_)
	end

	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.animator_ = nil
end

return slot0
