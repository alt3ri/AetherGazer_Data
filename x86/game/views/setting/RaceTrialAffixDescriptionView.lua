slot1 = class("RaceTrialAffixDescriptionView", import("game.views.setting.AffixDescriptionView"))

function slot1.ItemRenderer(slot0, slot1, slot2)
	slot2:GetComponent("UIList")

	slot6 = slot0.data[slot1 + 1]
	slot2.transform:Find("icon"):GetComponent("Image").sprite = getAffixSprite(slot6)
	slot2.transform:Find("name"):GetComponent("Text").text = getAffixName(slot6) .. NumberTools.IntToRomam(slot6[2])
	slot2.transform:Find("text"):GetComponent("Text").text = getAffixDesc(slot6)
end

return slot1
