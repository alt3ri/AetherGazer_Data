slot0 = class("SoundSettingToggle", BaseSettingToggle)

function slot0.GetName(slot0)
	return "Sound"
end

function slot0.UIClass(slot0)
	return SoundSettingView
end

function slot0.GetPath(slot0)
	return "Widget/System/Setting/SoundSettingUI"
end

function slot0.Order(slot0)
	return 12
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting07")
end

function slot0.GetParams(slot0)
	return nil
end

function slot0.IsSetting(slot0)
	return true
end

return slot0
