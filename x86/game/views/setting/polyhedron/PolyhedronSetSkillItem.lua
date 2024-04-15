slot0 = class("PolyhedronSetSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.POLYHEDRON)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	if slot1 then
		slot2 = slot0:GetRealSkillId(slot1)
		slot3 = HeroSkillCfg[slot2]
		slot0.iconImg_.sprite = getSprite("Atlas/" .. slot1.heroId, slot2)
		slot0.nameText_.text = slot3.name

		slot0:RefreshLv(slot1)

		slot4 = HeroCfg[slot1.heroId]
		slot0.subnameText_.text = slot4.skill_subhead[table.indexof(slot4.skills, slot1.id)]

		for slot10, slot11 in pairs(slot3.element_type) do
			if slot0["typeIcon_" .. slot10] and SkillElementCfg[slot11].icon and slot13 ~= "" then
				SetActive(slot12.transform.gameObject, true)

				slot12.sprite = getSprite("Atlas/Hero_arrtAtlas", SkillElementCfg[slot11].icon)
			end
		end

		slot0.contentText_.text = HeroSkillCfg[slot2].simpleDesc

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentText_.transform)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
	end
end

function slot0.RefreshLv(slot0, slot1)
	if 0 <= 0 then
		slot0.lvText_.text = string.format("%d", slot1.lv + slot1.addSkillLv)
	else
		slot0.lvText_.text = string.format("<color=#F3DC5A>%d</color>", slot1.lv + slot1.addSkillLv + slot2)
	end
end

function slot0.GetRealSkillId(slot0, slot1)
	return slot0.heroViewProxy_:GetRealSkillId(slot1.heroId, slot1.id)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
