slot0 = class("RemindSettingToggle", BaseSettingToggle)

function slot0.GetName(slot0)
	return "Remind"
end

function slot0.UIClass(slot0)
	return RemindSettingView
end

function slot0.GetPath(slot0)
	return "Widget/System/Setting/RemindSettingUI"
end

function slot0.Order(slot0)
	return 15
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting05")
end

function slot0.GetParams(slot0)
	return nil
end

function slot0.IsSetting(slot0)
	return true
end

return slot0
