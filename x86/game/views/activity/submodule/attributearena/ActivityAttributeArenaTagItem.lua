slot0 = class("ActivityAttributeArenaTagItem", ReduxView)

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
end

function slot0.SetData(slot0, slot1)
	if ActivityAttributeArenaCfg[slot1] then
		slot0.m_tag.sprite = HeroTools.GetSkillAttributeIcon(slot2.attribute)
	end
end

return slot0
