slot0 = class("SectionStageInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Show(true)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	slot0.icon_.sprite = HeroTools.GetSkillAttributeIcon(slot1)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
