slot0 = class("StoreBtnView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.btnType_ = slot2
	slot0.btnIndex_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(COMMON_BTN_TYPE_SWITCH, uv0.btnType_, uv0.btnIndex_)
	end)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 == slot0.btnIndex_ then
		slot0.controller_:SetSelectedState("false")
	else
		slot0.controller_:SetSelectedState("true")
	end
end

return slot0
