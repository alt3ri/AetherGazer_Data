slot0 = class("PolyhedronAdditionSettingToggle", BaseSettingToggle)

function slot0.GetName(slot0)
	return "PolyhedronAddition"
end

function slot0.UIClass(slot0)
	return PolyhedronAdditionSettingView
end

function slot0.GetPath(slot0)
	return "Widget/System/PolyhedronBattle/PolyhedronSettingUI"
end

function slot0.Order(slot0)
	return 8
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting12")
end

function slot0.GetParams(slot0)
	return nil
end

function slot0.IsSetting(slot0)
	return false
end

return slot0
