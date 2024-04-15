slot0 = class("PreviewHeroDataTemplate", TemplateHeroDataTemplate)

function slot0.Init(slot0, slot1)
	uv0.super.Init(slot0, slot1)
end

function slot0.GetType(slot0)
	return HeroConst.HERO_DATA_TYPE.PREVIEW
end

return slot0
