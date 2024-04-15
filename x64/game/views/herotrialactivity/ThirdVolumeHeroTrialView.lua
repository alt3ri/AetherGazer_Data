slot0 = class("ThirdVolumeHeroTrialView", HeroTrialActivityView)

function slot0.UIName(slot0)
	if ActivityTools.GetActivityTheme(slot0.params_.activityID) == ActivityConst.THEME.VOLUME_DOWN then
		return "UI/VolumeIIIDownUI/HeroTrial/VolumeIIIDownHeroTrialUI"
	else
		return "UI/VolumeIIIUI/VolumeHeroTrialUI"
	end
end

function slot0.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = GetI18NText(slot1)
end

return slot0
