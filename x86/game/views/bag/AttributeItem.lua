slot0 = class("AttributeItem", ReduxView)
slot1 = {
	HeroConst.HERO_ATTRIBUTE.ATK,
	HeroConst.HERO_ATTRIBUTE.ARM,
	HeroConst.HERO_ATTRIBUTE.STA,
	HeroConst.HERO_ATTRIBUTE.CRITICAL
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:InitUI()
end

function slot0.RefreshData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.info_ = slot2
	slot0.isSingleEquip_ = slot3

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = {}
	slot3 = 0

	if slot0.isSingleEquip_ then
		slot2 = PublicAttrCfg[slot1.key]
		slot3 = math.floor(slot1.value)
	else
		slot4 = uv0[slot1.index]
		slot2 = PublicAttrCfg[slot4]
		slot3 = slot1.attrS[slot4] and math.floor(slot1.attrS[slot4]) or 0
	end

	if slot2.percent and slot2.percent == 1 then
		slot3 = slot3 / 10 .. "%"
	end

	slot0.addText_.text = slot3
	slot0.numNoAdd_ = slot3
	slot0.valStr_ = slot3
	slot0.name_.text = GetI18NText(slot2.name)
	slot0.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", slot2.icon)
end

function slot0.ShowAdd(slot0, slot1)
	if slot0.isSingleEquip_ then
		slot0:GetAddValueStr()

		if slot1 then
			slot0.addText_.text = slot0.numAdd_
		else
			slot0.addText_.text = slot0.numNoAdd_
		end
	end
end

function slot0.GetAddValueStr(slot0)
	slot1 = PublicAttrCfg[slot0.info_.key]

	if slot0.info_.race == slot0.info_.heroId then
		slot3 = math.floor(slot0.info_.value * (GameSetting.equip_hero_strengthen_num.value[1] - 1) + FLOAT_DELTA)

		if slot1.percent and slot1.percent == 1 then
			slot3 = math.floor(slot0.info_.value * slot2 / 10 + FLOAT_DELTA) .. "%"
		end

		slot0.numAdd_ = string.format("%s<color=#e78300>+%s</color>", slot0.valStr_, slot3)
	elseif slot0.info_.race and slot0.info_.race ~= 0 then
		slot2 = math.floor(slot0.info_.value * 0.2 + FLOAT_DELTA)

		if slot1.percent and slot1.percent == 1 then
			slot2 = math.floor(slot0.info_.value / 10 * 0.2 + FLOAT_DELTA) .. "%"
		end

		slot0.numAdd_ = string.format("%s<color=#e78300>+%s</color>", slot0.valStr_, slot2)
	else
		slot0.numAdd_ = slot0.valStr_
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
