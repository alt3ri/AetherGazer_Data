slot0 = class("NewHeroChipItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.selectController_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("select")
	slot0.lockController_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("lock")
	slot0.equipController_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("equip")

	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_(uv0.chipID_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.chipID_ = slot1
	slot0.curChipID_ = slot2

	slot0:RefreshUI()
end

function slot0.SetCallBack(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.RefreshUI(slot0)
	slot1 = ChipCfg[slot0.chipID_]
	slot0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", slot1.picture_id)
	slot0.name_.text = slot1.suit_name

	slot0:RefreshStatus()
	slot0:BindRedPoint()
end

function slot0.RefreshStatus(slot0)
	if ChipData:GetIsUnlockHeroChip(slot0.chipID_) then
		slot0.lockController_:SetSelectedState("no")
	else
		slot0.lockController_:SetSelectedState("yes")
	end

	slot1, slot2 = ChipData:GetHeroChipIsEnableByChipId(slot0.chipID_)

	if slot1 then
		slot0.equipController_:SetSelectedState("yes")
	else
		slot0.equipController_:SetSelectedState("no")
	end

	if slot0.chipID_ == slot0.curChipID_ then
		slot0.selectController_:SetSelectedState("yes")
	else
		slot0.selectController_:SetSelectedState("no")
	end
end

function slot0.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)

	slot0.clickFunc_ = nil
end

function slot0.BindRedPoint(slot0)
	slot1 = ChipCfg[slot0.chipID_]
	slot2 = nil

	manager.redPoint:bindUIandKey(slot0.redPoint_, ChipCfg[slot0.chipID_].cost_condition ~= "" and RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. slot1.spec_char .. "_" .. slot1.role_type_id .. "_" .. slot0.chipID_ or RedPointConst.CHIP_HERO_CHIP .. "_" .. slot1.spec_char .. "_" .. slot1.role_type_id .. "_" .. slot0.chipID_)
end

function slot0.UnbindRedPoint(slot0)
	slot1 = ChipCfg[slot0.chipID_]
	slot2 = nil

	manager.redPoint:unbindUIandKey(slot0.redPoint_, ChipCfg[slot0.chipID_].cost_condition ~= "" and RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. slot1.spec_char .. "_" .. slot1.role_type_id .. "_" .. slot0.chipID_ or RedPointConst.CHIP_HERO_CHIP .. "_" .. slot1.spec_char .. "_" .. slot1.role_type_id .. "_" .. slot0.chipID_)
end

return slot0
