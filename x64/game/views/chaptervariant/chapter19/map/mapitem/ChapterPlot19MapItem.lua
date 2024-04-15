slot0 = class("ChapterPlot19MapItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot1), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.stateController_ = slot0.controllerEx_:GetController("break")
	slot0.fogController_ = slot0.controllerEx_:GetController("smoke")
	slot0.lineController_ = slot0.controllerEx_:GetController("line")

	if slot0.animator_ then
		slot0.animator_.enabled = false
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.PlayAnimator(slot0, slot1)
	if slot1 then
		slot0.mainAnimator_:Play("operation_bg_vermap02", 0, 0)
	else
		slot0.mainAnimator_:Play("map_noise", 0, 0)
	end

	slot0.mainAnimator_:Update(0)
end

function slot0.SetSelectState(slot0, slot1)
	if slot0.stateController_ == nil then
		return
	end

	slot0.stateController_:SetSelectedIndex(slot1)
end

function slot0.SetFogState(slot0, slot1)
	if slot0.fogController_ == nil then
		return
	end

	if slot1 then
		slot0.fogController_:SetSelectedState("state1")
	else
		slot0.fogController_:SetSelectedState("state0")
	end
end

function slot0.SetLineState(slot0, slot1)
	if slot0.lineController_ == nil then
		return
	end

	if slot1 then
		slot0.lineController_:SetSelectedState("state0")
	else
		slot0.lineController_:SetSelectedState("state1")
	end
end

function slot0.PlayFogAnimator(slot0)
	if slot0.animator_ then
		slot0.animator_.enabled = true
	end
end

return slot0
