local var_0_0 = class("ComboSkillInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroSkill/SkillMeaningUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.comboSkillUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshComboSkillItem), arg_3_0.uiList_, ComboSkillItem)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_5_0.heroId = arg_5_0.params_.heroID
	arg_5_0.comboSkillList_ = ComboSkillTools.GetHeroComboSkill(arg_5_0.params_.heroID)

	arg_5_0.comboSkillUIList_:StartScroll(#arg_5_0.comboSkillList_, 1)
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	if arg_7_0.comboSkillUIList_ then
		arg_7_0.comboSkillUIList_:Dispose()

		arg_7_0.comboSkillUIList_ = nil
	end
end

function var_0_0.RefreshComboSkillItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_0.comboSkillList_[arg_8_1], arg_8_0.heroId)
end

return var_0_0
