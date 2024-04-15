slot0 = class("SkillSettingToggle", BaseSettingToggle)

function slot0.Ctor(slot0, slot1)
	slot0.params_ = slot1
end

function slot0.GetName(slot0)
	return "Skill"
end

function slot0.UIClass(slot0)
	return SkillDescriptionView
end

function slot0.GetPath(slot0)
	return "Widget/System/Setting/SkillSettingUI"
end

function slot0.Order(slot0)
	return 20
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting11")
end

function slot0.GetParams(slot0)
	return slot0.params_.stageData
end

function slot0.IsSetting(slot0)
	return false
end

return slot0
