slot0 = class("AffixSettingToggle", BaseSettingToggle)

function slot0.Ctor(slot0, slot1)
	slot0.params_ = slot1
end

function slot0.GetName(slot0)
	return "Affix"
end

function slot0.UIClass(slot0)
	if slot0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE then
		return SoloChallengeAffixDescriptionView
	elseif slot1:GetType() == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
		return RaceTrialAffixDescriptionView
	else
		return AffixDescriptionView
	end
end

function slot0.GetPath(slot0)
	return "Widget/System/Setting/AffixDescriptionUI"
end

function slot0.Order(slot0)
	return 16
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting08")
end

function slot0.GetParams(slot0)
	return slot0.params_.affixData
end

function slot0.IsSetting(slot0)
	return false
end

return slot0
