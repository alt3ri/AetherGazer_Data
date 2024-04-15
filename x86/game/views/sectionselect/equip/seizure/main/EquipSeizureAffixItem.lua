slot0 = class("EquipSeizureAffixItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	SetActive(slot0.gameObject_, true)
end

function slot0.SetData(slot0, slot1)
	slot0.affixID_ = slot1

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityAffixPoolCfg[slot0.affixID_]
	slot0.nameText_.text = slot1.name
	slot0.descText_.text = getAffixDesc(slot1.affix)
	slot0.iconImage_.sprite = getAffixSprite(slot1.affix)
end

return slot0
