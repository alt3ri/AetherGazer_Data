slot0 = class("HeroTrammelsComboMissionItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot3 = ComboSkillLevelCfg[slot1]

	if slot3.condition_type ~= 1 then
		slot6 = string.format(slot3.des, HeroSkillCfg[ComboSkillCfg[slot2].skill_id].name)
	end

	slot0.m_des.text = slot6
	slot7, slot8, slot9 = ComboSkillTools.CheckComboSkillUpContion(slot1, slot2)

	if slot7 then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)
	end

	slot0.m_process.text = slot8 .. "/" .. slot9
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
