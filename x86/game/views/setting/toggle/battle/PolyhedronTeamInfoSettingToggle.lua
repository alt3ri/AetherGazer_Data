local var_0_0 = class("PolyhedronTeamInfoSettingToggle", BaseSettingToggle)

function var_0_0.GetName(arg_1_0)
	return "PolyhedronTeamInfo"
end

function var_0_0.UIClass(arg_2_0)
	return PolyhedronTeamInfoSettingView
end

function var_0_0.GetPath(arg_3_0)
	return "Widget/System/PolyhedronBattle/PolyhedronRanksUI"
end

function var_0_0.Order(arg_4_0)
	return 9
end

function var_0_0.RedPointKey(arg_5_0)
	return nil
end

function var_0_0.Image(arg_6_0)
	return getSprite("Atlas/SettingAtlas", "icon_setting13")
end

function var_0_0.GetParams(arg_7_0)
	return nil
end

function var_0_0.IsSetting(arg_8_0)
	return false
end

return var_0_0
