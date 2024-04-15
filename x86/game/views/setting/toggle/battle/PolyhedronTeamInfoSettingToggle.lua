slot0 = class("PolyhedronTeamInfoSettingToggle", BaseSettingToggle)

function slot0.GetName(slot0)
	return "PolyhedronTeamInfo"
end

function slot0.UIClass(slot0)
	return PolyhedronTeamInfoSettingView
end

function slot0.GetPath(slot0)
	return "Widget/System/PolyhedronBattle/PolyhedronRanksUI"
end

function slot0.Order(slot0)
	return 9
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting13")
end

function slot0.GetParams(slot0)
	return nil
end

function slot0.IsSetting(slot0)
	return false
end

return slot0
