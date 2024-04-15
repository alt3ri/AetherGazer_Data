slot0 = class("GameSettingToggle", BaseSettingToggle)

function slot0.Ctor(slot0, slot1)
	slot0.info_ = slot1
end

function slot0.GetName(slot0)
	return "Game"
end

function slot0.UIClass(slot0)
	return GameSettingView
end

function slot0.GetPath(slot0)
	return "Widget/System/Setting/GameSettingUI"
end

function slot0.Order(slot0)
	return 13
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting03")
end

function slot0.GetParams(slot0)
	return slot0.info_
end

function slot0.IsSetting(slot0)
	return true
end

return slot0
