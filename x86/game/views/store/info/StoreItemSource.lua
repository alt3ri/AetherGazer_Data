slot0 = class("StoreItemSource", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateController_ = slot0.accessbtnControllerexcollection_:GetController("btnState")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		JumpTools.JumpToPage2(uv0.sourceData_)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.sourceData_ = slot1

	if JumpTools.GetLinkIsLocked(slot1) then
		slot0.stateController_:SetSelectedState("locked")
	else
		slot0.stateController_:SetSelectedState("unlocked")
	end

	slot0.nameText_.text, slot0.frontText_.text = JumpTools.GetName(slot1)
end

return slot0
