slot0 = class("AccumulativeGachaPoint", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.controller_ = slot0.lastControllerexcollection_:GetController("default0")
end

function slot0.SetIsDraw(slot0, slot1)
	if slot1 then
		slot0.controller_:SetSelectedState("light")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

function slot0.SetPosX(slot0, slot1)
	if slot0.gameObject_ then
		slot0.transform_.localPosition = Vector3.New(slot1, 0, 0)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
