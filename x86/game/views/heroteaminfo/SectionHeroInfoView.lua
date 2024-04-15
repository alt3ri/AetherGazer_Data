slot1 = class("SectionHeroInfoView", import("game.views.newHero.HeroInfoView"))

function slot1.UpdateModuleView(slot0)
	SetActive(slot0.moduleView_.gameObject, false)
end

function slot1.UpdateUnlockBtnState(slot0)
	slot0.levelStateController_:SetSelectedState("maxLevel")
end

return slot1
