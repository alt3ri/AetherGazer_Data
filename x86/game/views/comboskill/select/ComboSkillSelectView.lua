local var_0_0 = class("ComboSkillSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroSkill/MeaningUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.comboSkillUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItemSelect), arg_3_0.uiList_, arg_3_0:GetComboSkillItemView())
end

function var_0_0.GetComboSkillItemView(arg_4_0)
	return ComboSkillSelectItem
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.buttonClose_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		if arg_7_0 == arg_7_1.pointerEnter and not arg_7_1.dragging then
			arg_5_0:Back()
		end
	end))
end

function var_0_0.RemoveListeners(arg_8_0)
	arg_8_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.heroList_ = arg_9_0.params_.heroList
	arg_9_0.trialHeroList_ = arg_9_0.params_.trailList
	arg_9_0.stageType_ = arg_9_0.params_.stageType
	arg_9_0.stageID_ = arg_9_0.params_.stageID
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.reserveParams_ = arg_9_0.params_.reserveParams
	arg_9_0.comboSkillID_ = arg_9_0.params_.comboSkillID
	arg_9_0.comboSkillIDList_ = arg_9_0:GetComboSkillList()

	arg_9_0.comboSkillUIList_:StartScroll(#arg_9_0.comboSkillIDList_, 1)
end

function var_0_0.GetComboSkillList(arg_10_0)
	return ComboSkillTools.GetComboSkillList(arg_10_0.heroList_, true)
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
	arg_12_0:RemoveListeners()
	arg_12_0.comboSkillUIList_:Dispose()

	arg_12_0.comboSkillUIList_ = nil
end

function var_0_0.RefreshItemSelect(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.comboSkillIDList_[arg_13_1]

	arg_13_2:RefreshUI(arg_13_0.stageType_, arg_13_0.stageID_, arg_13_0.activityID_, var_13_0, arg_13_0.comboSkillID_ == var_13_0, arg_13_0.heroList_, arg_13_0.reserveParams_)
end

return var_0_0
