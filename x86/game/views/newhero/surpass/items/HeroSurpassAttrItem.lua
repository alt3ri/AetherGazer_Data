slot0 = class("HeroSurpassAttrItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3, slot4)
	slot0:SetActive(true)

	slot0.num01Text_.text = slot2
	slot0.numText_.text = slot1

	if not slot1 or not slot2 then
		SetActive(slot0.arrowGo_, false)
	else
		SetActive(slot0.arrowGo_, true)
	end

	if slot3 then
		if slot4 then
			slot0.nameText_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(PublicAttrCfg[slot3].name))
		else
			slot0.nameText_.text = GetI18NText(slot5.name)
		end

		slot0.iconImg_.sprite = getSprite("Atlas/SystemCommonAtlas", slot5.icon)
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
