slot1 = class("SoloChallengeAffixDescriptionView", import("game.views.setting.AffixDescriptionView"))

function slot1.RenderItme(slot0, slot1, slot2)
	slot1.icon.sprite = getAffixSprite(slot2)
	slot1.name.text = getAffixName(slot2)
	slot1.desc.text = getAffixDesc(slot2)
	slot1.icon.color = Color.white
end

return slot1
