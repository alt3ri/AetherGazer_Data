slot0 = class("PolyhedronHeroDataTemplate", TemplateHeroDataTemplate)

function slot0.Init(slot0, slot1)
	uv0.super.Init(slot0, slot1)

	slot3 = {}

	for slot7, slot8 in pairs(HeroCfg[slot0.id].astrolabe or {}) do
		for slot13, slot14 in pairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot8] or {}) do
			table.insert(slot3, slot14)
		end
	end

	slot0.unlocked_astrolabe = slot3
end

function slot0.GetType(slot0)
	return HeroConst.HERO_DATA_TYPE.POLYHEDRON
end

return slot0
