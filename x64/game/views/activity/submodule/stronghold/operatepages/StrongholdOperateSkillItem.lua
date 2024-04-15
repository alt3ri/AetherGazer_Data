slot0 = class("StrongholdOperateSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.skill_type = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.RefreshUI(slot0)
	for slot4 = 1, 3 do
		slot0["m_skillDes" .. slot4].text = getAffixDesc(StrongholdData:GetSkillAffix(slot0.skill_type, slot4))

		if slot4 == 1 then
			slot0.m_name.text = getAffixName(slot5)
		end
	end

	slot0.m_icon.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. slot0.skill_type)
	slot1, slot2, slot3, slot4 = StrongholdData:GetStrongholdLevel(slot0.skill_type)

	if slot2 < StrongholdData:GetSkillLimitLv() then
		slot0.lockController:SetSelectedIndex(1)

		slot0.m_lockLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_TYPE_LIMIT_LV"), GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. slot0.skill_type), slot5)
	else
		slot0.lockController:SetSelectedIndex(0)
	end
end

return slot0
