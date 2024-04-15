slot0 = class("SkinTrialSelect109", SkinTrialActivitySelectView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/SkinTrial/VolumeSkinTrialUI_" .. slot0.params_.skinTrialID
end

function slot0.RefreshUI(slot0)
	slot2 = SkinTrialTools.GetHeroStandardID(slot0.skinTrialID_)
	slot3 = HeroStandardSystemCfg[slot2].skin_id
	slot4 = HeroStandardSystemCfg[slot2].hero_id
	slot0.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[slot4].name), GetI18NText(HeroCfg[slot4].suffix))

	if SettingData:GetCurrentLanguage() == "fr" or slot5 == "de" then
		slot0.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[slot4].name), GetI18NText(HeroCfg[slot4].suffix))
	end

	slot0.skinDescText_.text = GetI18NText(SkinCfg[slot3].desc)

	slot0:RefreshReward()
end

return slot0
