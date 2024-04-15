slot0 = class("HeroSkillAddTipsItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	SetActive(slot0.gameObject_, true)

	slot0.nametextText_.text = slot1.titleName
	slot0.messagetextText_.text = slot1.showDesc
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
