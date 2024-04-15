slot0 = class("SummerHeroTrialActivityView", HeroTrialActivityView)

function slot0.UIName(slot0)
	return "UI/VersionUI/SummerUI/SummerHeroTrialUI"
end

function slot0.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = GetI18NText(slot1)
end

return slot0
