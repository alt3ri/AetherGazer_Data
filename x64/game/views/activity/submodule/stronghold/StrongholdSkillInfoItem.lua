slot0 = class("StrongholdSkillInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.SetData(slot0, slot1, slot2)
	slot6 = slot2

	slot0.selectController:SetSelectedIndex(slot6)

	for slot6 = 1, 3 do
		slot7 = StrongholdData:GetSkillAffix(slot1, slot6)

		if slot6 == 1 then
			slot0.m_name.text = getAffixName(slot7)
		end

		slot0["m_skillText" .. slot6].text = getAffixDesc(slot7)
	end

	slot0.m_icon.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. slot1)
end

return slot0
