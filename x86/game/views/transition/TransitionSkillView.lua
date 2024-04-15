slot0 = class("TransitionSkillView", ReduxView)

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.transition,
		0
	})
end

function slot0.UIName(slot0)
	return "Widget/System/Hero_jumps/SubJumps/HeroJumpsSwitchUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.BuildContext(slot0)
	slot0.contex = {
		heroID = 0,
		curTabIdx = 1
	}
	slot0.controller = {
		comps = slot0.elementController_,
		lock = {
			Stage1 = "state1",
			Stage2 = "state2",
			Stage4 = "state4",
			name = "lock",
			Stage6 = "state6",
			Stage3 = "state3",
			Stage5 = "state5",
			Stage0 = "state0",
			comps = slot0.elementController_:GetController("lock")
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
			comps = slot0.elementController_:GetController("activate")
		}
	}
	slot0.view = {
		slotsModule = TransitionSkillSlotsModule.New(slot0.jumpviwerObj_, true),
		chipContainer = TransitionSkillListModule.New(slot0.chipModuleObj_),
		infoModule = TransitionSkillInfoModule.New(slot0.skillInfoObj_)
	}
end

function slot0.InitModule(slot0)
	slot0.view.chipContainer:RegisterTabListener(handler(slot0, slot0.OnTabSwitch))
	slot0.view.chipContainer:RegisterItemClickListener(handler(slot0, slot0.OnItemClick))
	slot0.view.chipContainer:RegisterRefreshJumpElement(handler(slot0, slot0.OnJumpElementChange))
	slot0.view.chipContainer:RegisterRefreshJumpSlotView(handler(slot0, slot0.OnJumpSlotRefresh))
	slot0.view.slotsModule:LockJumpAnim(false)
	slot0.view.slotsModule:LockSelect(true)
	slot0.view.slotsModule:SetShowLocked(false)
	slot0.view.infoModule:RegisterEquipBtnClickEmitter(handler(slot0, slot0.OnEquipBtnClick))
	slot0.view.infoModule:RegisterExchangeBtnClickEmitter(handler(slot0, slot0.OnExchangeBtnClick))
	slot0.view.infoModule:RegisterLevelUpBtnClickEmitter(handler(slot0, slot0.OnLevelUpBtnClick))

	slot0.resetTxt_.text = GetTips("ACTIVITY_SNOWBALL_ICE_RESET")
	slot0.exchangeTxt_.text = GetTips("EXCHANGE_TRANSITION_CHIP")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:InitModule()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		uv0:OnResetBtnClick()
	end)
	slot0:AddBtnListener(slot0.exchangeBtn_, nil, function ()
		uv0:OnAddElementBtnClick()
	end)
end

function slot0.OnEnter(slot0)
	slot0.contex.heroID = slot0.params_.heroID
	slot0.contex.curTabIdx = slot0.params_.index
	slot0.contex.type = slot0.params_.type

	slot0.view.slotsModule:RenderView({
		needRefresh = true,
		heroID = slot0.params_.heroID,
		type = slot0.contex.type,
		index = slot0.params_.index
	})
	slot0.view.chipContainer:RenderView({
		index = slot0.params_.index,
		heroID = slot0.params_.heroID
	})
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EXCLUSIVE_DESCRIPE")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.view.chipContainer:OnExit()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.view.chipContainer:Dispose()
	slot0.view.infoModule:Dispose()
	slot0.view.slotsModule:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnTabSwitch(slot0, slot1)
	slot0.view.slotsModule:JumpToSlot(slot1)

	slot0.contex.curTabIdx = slot1
end

function slot0.OnItemClick(slot0, slot1)
	slot0.view.infoModule:RenderView({
		skillID = slot1.skillID,
		level = slot1.level,
		heroID = slot0.contex.heroID,
		equipped = slot1.equipped
	})
end

function slot0.OnJumpElementChange(slot0, slot1)
	slot0.controller.activate.comps:SetSelectedState("state" .. slot1.totalElement - slot1.leftElement)
	slot0.controller.lock.comps:SetSelectedState("state" .. slot1.totalElement)

	slot0.elementCountTxt_.text = table.concat({
		slot1.leftElement,
		"/",
		slot1.totalElement
	})

	SetActive(slot0.exchangeBtn_.gameObject, slot0.view.chipContainer:GetCurGiftPoint() < 6)
end

function slot0.OnJumpSlotRefresh(slot0, slot1)
	slot0.view.slotsModule:RefreshSlot(slot1)
end

function slot0.OnResetBtnClick(slot0)
	slot0.view.chipContainer:ResetUseList()
	slot0.view.slotsModule:ClearSlot(slot0.contex.curTabIdx)
end

function slot0.OnAddElementBtnClick(slot0)
	if slot0.view.chipContainer:GetCurGiftPoint() < 6 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = slot0.view.chipContainer:GetCurGiftPoint(),
			heroID = slot0.contex.heroID,
			index = slot0.contex.curTabIdx
		})
	end
end

function slot0.OnEquipBtnClick(slot0)
	slot0.view.chipContainer:OnSkillEquip()
end

function slot0.OnExchangeBtnClick(slot0)
	slot0.view.chipContainer:OnSkillExchange()
end

function slot0.OnLevelUpBtnClick(slot0)
	slot0.view.chipContainer:OnSkillLevelUp()
end

return slot0
