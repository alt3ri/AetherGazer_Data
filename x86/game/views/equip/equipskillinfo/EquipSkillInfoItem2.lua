slot0 = class("EquipSkillInfoItem2", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot4 = EquipSkillCfg[slot1]
	slot0.lv_.text = GetTips("LEVEL") .. slot3

	if slot4.desc_spec_value ~= nil and slot4.desc_spec_value ~= "" then
		slot0.desc_.text = string.gsub(desc, tostring(slot4.upgrade / slot4.percent * slot3), slot4.desc_spec_value[i])
	else
		slot0.desc_.text = GetCfgDescriptionWithValue(slot4.desc[1], tostring(slot5))
	end

	slot0.infoCG_.alpha = slot3 <= slot2 and 1 or 0.5
end

return slot0
