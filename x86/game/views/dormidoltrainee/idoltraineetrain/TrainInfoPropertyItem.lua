slot0 = class("TrainInfoPropertyItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.value_.text = slot1
	slot0.total_.text = "/" .. slot2
	slot0.bar_.value = slot1 / slot2
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
