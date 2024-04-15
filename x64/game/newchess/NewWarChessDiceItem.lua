slot0 = class("NewWarChessDiceItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "point")
	slot0.maskController_ = ControllerUtil.GetController(slot0.transform_, "mask")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.index_)
		end
	end)
end

function slot0.SetStatus(slot0, slot1)
	slot0.stateController_:SetSelectedIndex(slot1)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.diceData_ = slot2
	slot0.dicePoint_ = slot0.diceData_[1]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.diceData_.IsNew == true then
		slot0.animator_:Play("ani")
	else
		slot0.animator_:Play("empty")
	end

	slot0.stateController_:SetSelectedIndex(slot0.dicePoint_)

	if slot0.diceData_.hasInput then
		slot0.maskController_:SetSelectedState("true")
	else
		slot0.maskController_:SetSelectedState("false")
	end
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil

	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
