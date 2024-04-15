local var_0_0 = class("TransitionSkillView", ReduxView)

function var_0_0.CameraEnter(arg_1_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.transition,
		0
	})
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Hero_jumps/SubJumps/HeroJumpsSwitchUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.BuildContext(arg_5_0)
	arg_5_0.contex = {
		heroID = 0,
		curTabIdx = 1
	}
	arg_5_0.controller = {
		comps = arg_5_0.elementController_,
		lock = {
			Stage1 = "state1",
			Stage2 = "state2",
			Stage4 = "state4",
			name = "lock",
			Stage6 = "state6",
			Stage3 = "state3",
			Stage5 = "state5",
			Stage0 = "state0",
			comps = arg_5_0.elementController_:GetController("lock")
		},
		activate = {
			Stage1 = "state1",
			Stage2 = "state2",
			Stage4 = "state4",
			name = "activate",
			Stage6 = "state6",
			Stage3 = "state3",
			Stage5 = "state5",
			Stage0 = "state0",
			comps = arg_5_0.elementController_:GetController("activate")
		}
	}
	arg_5_0.view = {
		slotsModule = TransitionSkillSlotsModule.New(arg_5_0.jumpviwerObj_, true),
		chipContainer = TransitionSkillListModule.New(arg_5_0.chipModuleObj_),
		infoModule = TransitionSkillInfoModule.New(arg_5_0.skillInfoObj_)
	}
end

function var_0_0.InitModule(arg_6_0)
	arg_6_0.view.chipContainer:RegisterTabListener(handler(arg_6_0, arg_6_0.OnTabSwitch))
	arg_6_0.view.chipContainer:RegisterItemClickListener(handler(arg_6_0, arg_6_0.OnItemClick))
	arg_6_0.view.chipContainer:RegisterRefreshJumpElement(handler(arg_6_0, arg_6_0.OnJumpElementChange))
	arg_6_0.view.chipContainer:RegisterRefreshJumpSlotView(handler(arg_6_0, arg_6_0.OnJumpSlotRefresh))
	arg_6_0.view.slotsModule:LockJumpAnim(false)
	arg_6_0.view.slotsModule:LockSelect(true)
	arg_6_0.view.slotsModule:SetShowLocked(false)
	arg_6_0.view.infoModule:RegisterEquipBtnClickEmitter(handler(arg_6_0, arg_6_0.OnEquipBtnClick))
	arg_6_0.view.infoModule:RegisterExchangeBtnClickEmitter(handler(arg_6_0, arg_6_0.OnExchangeBtnClick))
	arg_6_0.view.infoModule:RegisterLevelUpBtnClickEmitter(handler(arg_6_0, arg_6_0.OnLevelUpBtnClick))

	arg_6_0.resetTxt_.text = GetTips("ACTIVITY_SNOWBALL_ICE_RESET")
	arg_6_0.exchangeTxt_.text = GetTips("EXCHANGE_TRANSITION_CHIP")
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
	arg_7_0:BuildContext()
	arg_7_0:InitModule()
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.resetBtn_, nil, function()
		arg_8_0:OnResetBtnClick()
	end)
	arg_8_0:AddBtnListener(arg_8_0.exchangeBtn_, nil, function()
		arg_8_0:OnAddElementBtnClick()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.contex.heroID = arg_11_0.params_.heroID
	arg_11_0.contex.curTabIdx = arg_11_0.params_.index
	arg_11_0.contex.type = arg_11_0.params_.type

	arg_11_0.view.slotsModule:RenderView({
		needRefresh = true,
		heroID = arg_11_0.params_.heroID,
		type = arg_11_0.contex.type,
		index = arg_11_0.params_.index
	})
	arg_11_0.view.chipContainer:RenderView({
		index = arg_11_0.params_.index,
		heroID = arg_11_0.params_.heroID
	})
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EXCLUSIVE_DESCRIPE")
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	arg_13_0.view.chipContainer:OnExit()
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	arg_14_0.view.chipContainer:Dispose()
	arg_14_0.view.infoModule:Dispose()
	arg_14_0.view.slotsModule:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.OnTabSwitch(arg_15_0, arg_15_1)
	arg_15_0.view.slotsModule:JumpToSlot(arg_15_1)

	arg_15_0.contex.curTabIdx = arg_15_1
end

function var_0_0.OnItemClick(arg_16_0, arg_16_1)
	arg_16_0.view.infoModule:RenderView({
		skillID = arg_16_1.skillID,
		level = arg_16_1.level,
		heroID = arg_16_0.contex.heroID,
		equipped = arg_16_1.equipped
	})
end

function var_0_0.OnJumpElementChange(arg_17_0, arg_17_1)
	local var_17_0 = "state" .. arg_17_1.totalElement - arg_17_1.leftElement
	local var_17_1 = "state" .. arg_17_1.totalElement

	arg_17_0.controller.activate.comps:SetSelectedState(var_17_0)
	arg_17_0.controller.lock.comps:SetSelectedState(var_17_1)

	arg_17_0.elementCountTxt_.text = table.concat({
		arg_17_1.leftElement,
		"/",
		arg_17_1.totalElement
	})

	SetActive(arg_17_0.exchangeBtn_.gameObject, arg_17_0.view.chipContainer:GetCurGiftPoint() < 6)
end

function var_0_0.OnJumpSlotRefresh(arg_18_0, arg_18_1)
	arg_18_0.view.slotsModule:RefreshSlot(arg_18_1)
end

function var_0_0.OnResetBtnClick(arg_19_0)
	arg_19_0.view.chipContainer:ResetUseList()
	arg_19_0.view.slotsModule:ClearSlot(arg_19_0.contex.curTabIdx)
end

function var_0_0.OnAddElementBtnClick(arg_20_0)
	if arg_20_0.view.chipContainer:GetCurGiftPoint() < 6 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = arg_20_0.view.chipContainer:GetCurGiftPoint(),
			heroID = arg_20_0.contex.heroID,
			index = arg_20_0.contex.curTabIdx
		})
	end
end

function var_0_0.OnEquipBtnClick(arg_21_0)
	arg_21_0.view.chipContainer:OnSkillEquip()
end

function var_0_0.OnExchangeBtnClick(arg_22_0)
	arg_22_0.view.chipContainer:OnSkillExchange()
end

function var_0_0.OnLevelUpBtnClick(arg_23_0)
	arg_23_0.view.chipContainer:OnSkillLevelUp()
end

return var_0_0
