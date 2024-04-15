slot0 = class("BattleBossChallengeSkillItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	SetActive(slot0.gameObject_, true)

	slot0.textName_.text = slot1.name
	slot0.textDesc_.text = slot1.info

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transformDesc_)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
