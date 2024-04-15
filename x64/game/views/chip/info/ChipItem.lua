slot0 = class("ChipItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockControl = slot0.mimirchipControllerexcollection_:GetController("lock")
	slot0.selectControl = slot0.mimirchipControllerexcollection_:GetController("select")
	slot0.equipControl = slot0.mimirchipControllerexcollection_:GetController("equip")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		manager.notify:Invoke(ON_CLICK_CHIP_ITEM, uv0.chipID_)
	end)
end

function slot0.SetChipID(slot0, slot1)
	slot0.chipID_ = slot1
end

function slot0.SetTemplateData(slot0, slot1)
	slot0.chipManagerDataTemplate_ = slot1
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.gameObject_.name = slot0.chipID_
	slot3 = ChipCfg[slot0.chipID_]
	slot0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", slot3.picture_id)
	slot0.name_.text = GetI18NText(slot3.suit_name)
	slot4 = slot0:GetUnlockChipIDList()

	if slot0.chipID_ == slot1 then
		slot0.selectControl:SetSelectedState("yes")
	else
		slot0.selectControl:SetSelectedState("no")
	end

	if slot0.chipManagerDataTemplate_:GetIsUnlockChip(slot0.chipID_) then
		slot0.lockControl:SetSelectedState("no")
	else
		slot0.lockControl:SetSelectedState("yes")
	end

	if slot0.chipManagerDataTemplate_:GetIsUesChipID(slot0.chipID_) then
		slot0.equipControl:SetSelectedState("yes")
	else
		slot0.equipControl:SetSelectedState("no")
	end

	if slot0.chipManagerDataTemplate_ and not slot0.chipManagerDataTemplate_.isNoRed then
		slot0:BindRedPoint()
	end
end

function slot0.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
end

function slot0.GetUnlockChipIDList(slot0)
	return ChipData:GetUnlockChipIDList()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.notice_, string.format("%s_%s", RedPointConst.CHIP_CHIP, slot0.chipID_), {
		x = 0,
		y = 0
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.notice_)
end

return slot0
