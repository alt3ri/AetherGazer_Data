slot0 = class("DormRhythmMistakeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.touchbtnBtn_.gameObject.transform, "state")
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.stateController:SetSelectedState("true")
	else
		slot0.stateController:SetSelectedState("false")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
