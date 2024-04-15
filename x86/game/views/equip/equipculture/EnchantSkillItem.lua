slot0 = class("EnchantSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = slot0.transCon_:GetController("select")
	slot0.lockController_ = slot0.transCon_:GetController("lock")
	slot0.nullController_ = slot0.transCon_:GetController("null")
	slot0.popController_ = slot0.transCon_:GetController("pop")
	slot0.lelevelController_ = slot0.transCon_:GetController("level")

	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.RefreshData(slot0, slot1)
	slot0.info_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.info_ then
		slot0.nullController_:SetSelectedState("skill")

		if slot0.info_.preview then
			slot0.lockController_:SetSelectedState("unlock")
			slot0.popController_:SetSelectedState("pop")
			slot0.lelevelController_:SetSelectedState("off")

			slot0.lvMax_ = EquipSkillCfg[slot0.info_.id].lvmax
		elseif slot0.info_.unlockLevel and slot0.info_.equipLevel < slot0.info_.unlockLevel then
			slot0.lockController_:SetSelectedState("lock")

			slot0.lockDesc_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), slot0.info_.unlockLevel)
		else
			slot0.lockController_:SetSelectedState("unlock")
		end

		slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot1.icon)
		slot0.name_.text = GetI18NText(slot1.name)
		slot0.lv_.text = string.format("%s/%s", slot1.lvmax < slot0.info_.num and string.format("<color=#FF000B>%s</color>", slot0.info_.num) or slot0.info_.num, slot1.lvmax)

		if slot1.desc_spec_value ~= nil and slot1.desc_spec_value ~= "" then
			slot5 = string.gsub(GetCfgDescriptionWithValue(slot1.desc[1], tostring(slot1.upgrade / slot1.percent * (slot1.lvmax < slot0.info_.num and slot1.lvmax or slot0.info_.num))), tostring(slot4), slot1.desc_spec_value[slot0.info_.num])
		end

		slot0.desc_.text = GetI18NText(slot5)
	else
		slot0.nullController_:SetSelectedState("null")
	end
end

function slot0.ShowSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "select" or "unselect")
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0:clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
