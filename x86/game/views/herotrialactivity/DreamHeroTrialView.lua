slot1 = class("DreamHeroTrialView", import("game.views.heroTrialActivity.HeroTrialActivityView"))

function slot1.UIName(slot0)
	return "UI/EmptyDream/HeroTrial/EDreamHeroTrialUI"
end

function slot1.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", GetI18NText(slot2[1]), GetI18NText(slot2[2]))
end

return slot1
