slot0 = class("AstrolabeAdjustView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_god/HeroGodDetailUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.infoSGo_ = {}
	slot0.astrolabeMessageView_ = AstrolabeInfoView.New(slot0, slot0.messageGo_)
	slot0.astrolabeUnlockView_ = AstrolabeUnlockView.New(slot0, slot0.unlockinfoGo_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.loadBtn_, nil, "ClickBtn")
	slot0:AddBtnListener(slot0.equipallBtn_, nil, "ClickBtn")
	slot0:AddBtnListener(slot0.canequipBtn_, nil, "ClickBtn")
	slot0:AddBtnListener(slot0.unloadBtn_, nil, "ClickBtn")
	slot0:AddBtnListener(slot0.hasequipedBtn_, nil, "ClickBtn")
	slot0:AddBtnListener(slot0.unequipBtn_, nil, "ClickBtn")
	slot0:AddBtnListener(slot0.unlock2Btn_, nil, "ClickBtn")
	slot0:AddBtnListener(slot0.btn_twoBtn_, nil, function ()
		uv0.heroProxy:AstrolabeUnloadAll(uv0.params_.heroId)
	end)
end

function slot0.ClickEquipallBtn(slot0)
end

function slot0.ClickHasEquipedBtn(slot0)
end

function slot0.ClickBtn(slot0)
	slot2 = HeroAstrolabeCfg[slot0.lastSelectItem_:GetItemInfo().id]

	if slot0.lastSelectItem_.nodeState == AstrolabeConst.NODE_STATE.LOCK then
		if slot2.unlock[1] and not checkGold(slot2.unlock[1][2], true) then
			return
		end

		ShowTips("ERROR_ASTROLABE_UNLOCK_CONDITION_NOT_MATCH")
	elseif slot3 == AstrolabeConst.NODE_STATE.CANLOCK then
		AstrolabeAction.AstrolabeUnlock(slot1.heroId, slot1.id)
	elseif slot3 == AstrolabeConst.NODE_STATE.UNLOCK then
		slot4 = slot0.isSp and AstrolabeConst.SPASTROLABE_MAX_NUM or AstrolabeConst.ASTROLABE_MAX_NUM

		if slot2.pos == 3 and not slot0.isSp then
			slot0.heroProxy:AstrolabeEquipAll(slot1.heroId, slot2.hero_astrolabe_suit_id)
		else
			if slot4 <= slot0.equipNum_ then
				ShowTips("TIP_ASTROLABE_NUM_MAX")

				return
			end

			if not slot0.heroProxy:GetLastIsEquiped(slot1.id, slot1.heroId) then
				slot6 = HeroAstrolabeCfg[HeroAstrolabeCfg[slot1.id].pre_astrolabe_id]

				ShowTips(string.format(GetTips("TIP_ASTROLABE_FRONT"), GetI18NText(slot6.suit_name), GetI18NText(slot6.name)))

				return
			end

			slot0.heroProxy:AstrolabeEquip(slot1.heroId, slot1.id)
		end
	elseif slot3 == AstrolabeConst.NODE_STATE.EQUIPED then
		if slot0.heroProxy:GetNextIsEquiped(slot1.id, slot1.heroId) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_ASTROLABE_UNINSTALL"),
				OkCallback = function ()
					uv0.heroProxy:AstrolabeUnload(uv1.heroId, uv1.id)
				end
			})
		else
			slot0.heroProxy:AstrolabeUnload(slot1.heroId, slot1.id)
		end
	end
end

function slot0.SelectItem(slot0, slot1)
	if slot0.lastSelectItem_ then
		slot0.lastSelectItem_:ShowSelect(false)
	end

	slot2 = slot1:GetItemInfo()

	slot1:ShowSelect(true)
	slot0.astrolabeMessageView_:RefreshUI(slot2, slot0.extra_)

	slot0.lastSelectItem_ = slot1

	slot0:RefreshState(slot2)

	if slot0.panelAni_ then
		slot0.panelAni_:Play("Fx_Common_right_cx", 0, 0)
	end
end

function slot0.RefreshUI(slot0)
	slot0.heroInfo_ = slot0.heroProxy:GetHeroData(slot0.params_.heroId)
	slot0.isSp = HeroTools.IsSpHero(slot0.params_.heroId)

	SetActive(slot0.resetBtnGo_, slot0:Adjustable())
	slot0:RefreshAstrolabeInfo()
end

function slot0.RefreshAstrolabeInfo(slot0)
	if slot0.heroInfo_ then
		slot1 = slot0.isSp or slot0.heroProxy and slot0.heroProxy.isHideAstrolabeReset

		SetActive(slot0.btn_twoBtn_.gameObject, not slot1)
		SetActive(slot0.numText_.gameObject, not slot1)

		slot0.equipNum_ = #slot0.heroInfo_.using_astrolabe

		if not slot0.isSp then
			slot0.numText_.text = string.format(GetTips("ASTROLABE_NUM_MAX"), slot0.equipNum_, AstrolabeConst.ASTROLABE_MAX_NUM)
		end

		if slot0.heroProxy:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			slot0.titleText_.text = GetTips("ASTROLABE_TITLE_PREVIEW")
		else
			slot0.titleText_.text = GetTips("ASTROLABE_TITLE_COMMON")
		end

		slot0:RefreshAstrolabeView()
	end
end

function slot0.RefreshAstrolabeView(slot0)
	if slot0.heroInfo_ and slot0.astrolabeInfoView_ then
		if slot0.params_ and slot0.params_.isEnter then
			slot0.astrolabeInfoView_:LoadAstrolabeByPath(AstrolabeTools.GetAstrolabePrafabName(slot0.heroInfo_.id), slot0.heroInfo_.id)
			manager.heroRaiseTrack:SetAstrolableAtive(true)
			slot0.astrolabeInfoView_:PlayAni("TX_GodHood_02", 0, 1)

			slot0.params_.isEnter = false
		end

		slot0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.AdjustView)
		slot0.astrolabeInfoView_:RegistCallBack(handler(slot0, slot0.SelectItem))
		slot0.astrolabeInfoView_:SetProxy(slot0.heroProxy)
		slot0.astrolabeInfoView_:SetNodeNameIsHide(false)
		slot0.astrolabeInfoView_:RefreshData(slot0.heroInfo_, slot0:GetAstrolabeInfo(slot0.heroInfo_.id))
	end
end

function slot0.GetHeroAstrolabeInfoView(slot0)
	return HeroAstrolabeInfoView
end

function slot0.GetAstrolabeInfo(slot0, slot1)
	if slot0.heroProxy then
		return slot0.heroProxy:GetHeroAstrolabeS(slot1, slot0.viewDataType)
	end

	return {}
end

function slot0.CanLock(slot0)
	if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		return false
	end

	return true
end

function slot0.RefreshState(slot0, slot1)
	if not slot0:Adjustable() then
		slot0.stateController_:SetSelectedState("none")
		slot0:ChangeBar(false)

		return
	end

	slot2 = HeroAstrolabeCfg[slot1.id]

	if slot1.isUnlock or slot1.isEquiped then
		if slot1.isEquiped then
			if slot0.isSp then
				slot0.stateController_:SetSelectedState("spEquiped")
			else
				slot0.stateController_:SetSelectedState("unEquip")
			end
		elseif slot2.pos == 3 and not slot0.isSp then
			slot0.stateController_:SetSelectedState("equipAll")
		else
			slot0.stateController_:SetSelectedState("canEquip")
		end

		slot0:ChangeBar(false)
	else
		if slot0.isSp then
			slot0.stateController_:SetSelectedState("splock")
		elseif slot0:Adjustable() then
			if slot1.isCanLock then
				slot0.stateController_:SetSelectedState("lock")
			else
				slot0.stateController_:SetSelectedState("lock2")
			end

			slot0.astrolabeUnlockView_:RefreshUI(slot1)
		else
			slot0.stateController_:SetSelectedState("none")
		end

		slot0.astrolabeUnlockView_:RefreshUI(slot1)
		slot0:ChangeBar(true)
	end
end

function slot0.PlayHeroTalk(slot0, slot1)
	if slot0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(slot1, "echo")

	slot0.isTalkCD_ = true
	slot0.talkCDTimer_ = Timer.New(function ()
		uv0.isTalkCD_ = false
	end, 10, 1)

	slot0.talkCDTimer_:Start()
end

function slot0.OnAstrolabeUnlock(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot0:RefreshUI()
		slot0.astrolabeMessageView_:RefreshUI(slot0.lastSelectItem_:GetItemInfo())
		slot0:RefreshState(slot0.lastSelectItem_:GetItemInfo())
		slot0.astrolabeUnlockView_:OnAstrolabeUnlock(slot1, slot2)

		if slot0.astrolabeInfoView_ then
			slot0.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnAstrolabeEquip(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		ShowTips("ASTROLABE_BIND")
		slot0:RefreshUI()
		slot0.astrolabeMessageView_:RefreshUI(slot0.lastSelectItem_:GetItemInfo())
		slot0:RefreshState(slot0.lastSelectItem_:GetItemInfo())
		slot0:PlayHeroTalk(slot0.heroInfo_.id)

		if slot0.astrolabeInfoView_ then
			slot0.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnAstrolabeUnload(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if slot2.astrolabe_id then
			ShowTips("ASTROLABE_UNBIND")
		else
			ShowTips("ASTROLABE_RESET")
		end

		slot0:RefreshUI()
		slot0.astrolabeMessageView_:RefreshUI(slot0.lastSelectItem_:GetItemInfo())
		slot0:RefreshState(slot0.lastSelectItem_:GetItemInfo())

		if slot0.astrolabeInfoView_ then
			slot0.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(slot1.result)
	end
end

function slot0.ChangeBar(slot0, slot1)
	if slot1 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_GOLD
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot0.OnTop(slot0)
	if slot0.lastSelectItem_ then
		if slot0.heroInfo_ and slot0.astrolabeInfoView_ then
			slot0.astrolabeInfoView_:RefreshData(slot0.heroInfo_, slot0:GetAstrolabeInfo(slot0.heroInfo_.id))
		end

		if slot0.lastSelectItem_:GetItemInfo() ~= nil and not slot1.isUnlock then
			slot0.astrolabeUnlockView_:RefreshCost()
			slot0:RefreshState(slot1)
		end
	end

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:RefreshRedPoint()
	end
end

function slot0.OnEnter(slot0)
	slot0.heroProxy = slot0.params_.heroProxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	slot0.viewDataType = slot0.heroProxy.viewDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.astrolabeInfoView_ = manager.heroRaiseTrack.astrolableController

	if slot0.panelAni_ then
		slot0.panelAni_:Play("Fx_Common_right_cx", 0, 0)
	end

	slot0:ShowDefaultBar()
	slot0:RefreshUI()

	if slot0.astrolabeUnlockView_ then
		slot0.astrolabeUnlockView_:SetProxy(slot0.heroProxy)
	end

	if slot0.astrolabeMessageView_ then
		slot0.astrolabeMessageView_:SetProxy(slot0.heroProxy)
	end

	if slot0.params_.selectPos and slot1[1] ~= 0 then
		slot0:SelectItem(slot0.astrolabeInfoView_:GetItem(slot1[1], slot1[2]))
	else
		slot0:SelectItem(slot0.astrolabeInfoView_:GetFirstSelectItem())
	end
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		5,
		1
	}, false)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.lastSelectItem_ then
		slot0.lastSelectItem_:ShowSelect(false)

		slot0.lastSelectItem_ = nil
	end

	if slot0.astrolabeUnlockView_ then
		slot0.astrolabeUnlockView_:OnExit()
	end

	if slot0.talkCDTimer_ then
		slot0.talkCDTimer_:Stop()

		slot0.talkCDTimer_ = nil
	end

	slot0.isTalkCD_ = nil
end

function slot0.Adjustable(slot0)
	if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		return false
	end

	if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.FOREIGN then
		return false
	end

	if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		return false
	end

	return true
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.astrolabeMessageView_ then
		slot0.astrolabeMessageView_:Dispose()

		slot0.astrolabeMessageView_ = nil
	end

	if slot0.astrolabeUnlockView_ then
		slot0.astrolabeUnlockView_:Dispose()

		slot0.astrolabeUnlockView_ = nil
	end
end

return slot0
