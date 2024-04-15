slot0 = class("PolyhedronHeroInfoSettingTogglee", BaseSettingToggle)

function slot0.GetName(slot0)
	return "PolyhedronHeroInfo"
end

function slot0.UIClass(slot0)
	return PolyhedronHeroInfoSettingView
end

function slot0.GetPath(slot0)
	return "Widget/System/PolyhedronBattle/PolyhedronContingentUI"
end

function slot0.Order(slot0)
	return 10
end

function slot0.RedPointKey(slot0)
	return nil
end

function slot0.Image(slot0)
	return getSprite("Atlas/SettingAtlas", "icon_setting10")
end

function slot0.GetParams(slot0)
	return nil
end

function slot0.IsSetting(slot0)
	return false
end

return slot0
