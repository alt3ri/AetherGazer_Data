slot0 = class("GraphicSettingToggle", BaseSettingToggle)

function slot0.GetName(slot0)
	return "Graphic"
end

function slot0.UIClass(slot0)
	return GraphicSettingView
end

function slot0.GetPath(slot0)
	return "Widget/System/Setting/FrameSettingUI"
end

function slot0.Order(slot0)
	return 11
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting06")
end

function slot0.GetParams(slot0)
	return nil
end

function slot0.IsSetting(slot0)
	return true
end

return slot0
