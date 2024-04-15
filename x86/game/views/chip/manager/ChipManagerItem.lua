slot0 = class("ChipManagerItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.handler_ = handler(slot0, slot0.RefreshEnabledUI)

	manager.notify:RegistListener(ENABLED_CHIP_MANAGER, slot0.handler_)

	slot0.stateControl = slot0.mimirControllerexcollection_:GetController("state")
	slot0.selectControl = slot0.mimirControllerexcollection_:GetController("select")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		uv0:Go("/chipManager", {
			chipManagerID = uv0.chipManagerID_
		})
	end)
end

function slot0.SetChipManagerID(slot0, slot1)
	slot0.chipManagerID_ = slot1
end

function slot0.RefreshUI(slot0, slot1)
	slot0.gameObject_.name = slot0.chipManagerID_
	slot0.adminCatImg_.sprite = ChipTools.GetChipManagerIcon(slot0.chipManagerID_)
	slot3 = table.keyof(slot0:GetUnlockChipManagerList(), slot0.chipManagerID_) == nil

	if slot1 then
		slot0.selectControl:SetSelectedState("selected")
	else
		slot0.selectControl:SetSelectedState("unselected")
	end

	if slot3 then
		slot0.stateControl:SetSelectedState("locked")
	elseif slot0.chipManagerDataTemplate_:GetISUseChipmanager(slot0.chipManagerID_) then
		slot0.stateControl:SetSelectedState("equiped")
	else
		slot0.stateControl:SetSelectedState("unequiped")
	end

	if slot0.chipManagerDataTemplate_ and not slot0.chipManagerDataTemplate_.isNoRed then
		slot0:BindRedPoint()
	end
end

function slot0.SetTemplateData(slot0, slot1)
	slot0.chipManagerDataTemplate_ = slot1
end

function slot0.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, slot0.handler_)

	slot0.handler_ = nil
end

function slot0.GetUnlockChipManagerList(slot0)
	return slot0.chipManagerDataTemplate_.unlockChipManagerIDList_
end

function slot0.GetEnabledChipManagerID(slot0)
	return ChipData:GetEnabledChipManagerID()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.notice_, string.format("%s_%s", RedPointConst.CHIP_MANAGER, slot0.chipManagerID_), {
		x = 0,
		y = 0
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.notice_)
end

return slot0
