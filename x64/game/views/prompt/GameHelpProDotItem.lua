slot0 = class("GameHelpProDotItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.selectController_ = slot0.controllerEx_:GetController("sel")
end

function slot0.SetData(slot0, slot1)
	if slot1 then
		slot0.selectController_:SetSelectedState("state1")
	else
		slot0.selectController_:SetSelectedState("state0")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
