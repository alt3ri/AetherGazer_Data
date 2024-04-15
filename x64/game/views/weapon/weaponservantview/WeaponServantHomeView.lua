slot0 = class("WeaponServantHomeView", ReduxView)

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Fade")
end

function slot0.UIName(slot0)
	return "Widget/System/Hero_servant/HeroServantUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		comps = slot0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			selectTab = {
				name = "selectTab",
				hold = "hold",
				callName = "callName"
			},
			inFullScreen = {
				False = "false",
				name = "inFullScreen",
				True = "true"
			},
			avatarShow = {
				False = "false",
				name = "avatarShow",
				True = "true"
			},
			emptyView = {
				False = "false",
				name = "emptyView",
				True = "true"
			}
		}
	}
	slot0.singleton = {
		viewDetail = WeaponServantMainDetailModule.New(slot0.mainDetailsObj_),
		listView = {
			viewHold = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantHoldListViewModule",
				detailBtnStyle = 1,
				uiRootPath = "Widget/System/Hero_servant/Module/HoldListViewModule",
				pageIdx = 1,
				detailNoHeroBtnStyle = 3,
				onServantItemClick = function (slot0)
					uv0:onHoldItemClick(slot0)
				end,
				OnRefresh = function ()
					uv0:OnHoldBtnClick()
				end
			},
			viewCallName = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantCallNameListViewModule",
				detailBtnStyle = 2,
				uiRootPath = "Widget/System/Hero_servant/Module/CallNameListViewModule",
				pageIdx = 2,
				detailNoHeroBtnStyle = 2,
				onServantItemClick = function (slot0)
					uv0:onCallNameItemClick(slot0)
				end,
				OnRefresh = function ()
					uv0:OnCallNameBtnClick()
				end
			}
		},
		viewFullList = {
			detailBtnStyle = 1,
			detailNoHeroBtnStyle = 3,
			uiRootPath = "Widget/System/Hero_servant/Module/FullScreenServantView",
			viewModulePath = "game.views.weapon.WeaponServantView.WeaponServantFullListViewModule",
			onServantItemClick = function (slot0)
				uv0:onFullListItemClick(slot0)
			end
		},
		avatarView = ServantAvatarViewModule.New(slot0.scaleImageObj_)
	}

	slot0.singleton.viewDetail:RegisteCallNameClickCallback(handler(slot0, slot0.onCallNameClick))
end

function slot0.InitContext(slot0)
	slot0.data = {
		isInAvatarShowView = false,
		heroId = 0,
		curViewIdx = 0,
		isOnFullScreenView = false,
		isOpen = true,
		isTalkCD = false
	}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:InitContext()
	slot0:AddEventListeners()
	slot0:RegistEventListener(SERVANT_REPLACE, handler(slot0, slot0.OnServantReplaced))
	slot0:RegistEventListener(SERVANT_SWITCH_TO_CALLNAME, handler(slot0, slot0.OnSwitchTo))

	slot0.data.heroId = slot0.params_.HeroID

	slot0:OnPreOpenPage()
	slot0:RefreshTabCount()
	slot0:ShowBar()
end

function slot0.ShowBar(slot0)
	if not slot0.data.isOpen then
		return
	end

	slot1 = {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	}

	if slot0.data and slot0.data.curViewIdx == 2 then
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(slot1)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar(slot1)
		manager.windowBar:RegistBackCallBack(function ()
			uv0:OnBackBtnClick()
		end)
	end

	manager.windowBar:SetGameHelpKey("SERVANT_AWAKE_DESC_1")
end

function slot0.OnPreOpenPage(slot0)
	if not slot0.params_.tempParams then
		slot1 = slot0.params_.isFullScreen

		if slot0.params_.race and slot2 ~= 0 then
			slot0:OnCallNameBtnClick(slot2, slot0.params_.servantID)
		else
			slot0:OnHoldBtnClick()
		end
	else
		slot0.data.heroId = slot0.params_.tempParams.HeroID or nil

		if slot1.isFullScreen ~= nil then
			if slot1.isFullScreen then
				slot0:OnFullScreenBtnClick(slot1.servantData)
			elseif slot1.viewIdx == 1 then
				slot0:OnHoldBtnClick(slot2)
			elseif slot2.id and slot2.id ~= 0 then
				slot0:OnCallNameBtnClick(slot0:GetServantRace(slot2.id), slot2.id)
			else
				slot0:OnCallNameBtnClick()
			end
		else
			slot0:OnHoldBtnClick()
		end
	end

	slot0.params_.tempParams = nil
end

function slot0.RecordPageStatus(slot0)
	slot0.params_.tempParams = {
		isFullScreen = slot0.data.isOnFullScreenView,
		HeroID = slot0.data.heroId,
		servantData = clone(slot0.data.curServantData or {}),
		viewIdx = slot0.data.curViewIdx
	}
end

function slot0.OnExit(slot0)
	slot0.data.isOpen = false

	slot0:RecordPageStatus()

	if slot0.data.isOnFullScreenView then
		slot0:EnterFullScreenView(false)
	end

	slot0:RemoveAllEventListener()

	if slot0.data.talkCDTimer_ then
		slot0.data.talkCDTimer_:Stop()

		slot0.data.talkCDTimer_ = nil
	end

	for slot4, slot5 in pairs(slot0.singleton.listView) do
		if slot0.data.curViewIdx == slot5.pageIdx and slot5.viewModule then
			slot5.viewModule:OnExit()
		end
	end

	slot0.singleton.viewDetail:OnExit()
	manager.windowBar:HideBar()
	slot0:RemoveNotifyListeners()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	slot0.singleton.viewDetail:Dispose()

	if slot0.singleton.viewFullList.viewModule then
		slot0.singleton.viewFullList.viewModule:Dispose()
	end

	for slot4, slot5 in pairs(slot0.singleton.listView) do
		if slot5 and slot5.viewModule then
			slot5.viewObj = nil

			slot5.viewModule:Dispose()

			slot5.viewModule = nil
		end
	end

	slot0.singleton.avatarView:Dispose()

	slot0.singleton.avatarView = nil

	if slot0.data.talkCDTimer_ then
		slot0.data.talkCDTimer_:Stop()

		slot0.data.talkCDTimer_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnServantReplaced(slot0, slot1, slot2, slot3)
	if slot2.servant_id == 0 then
		ShowTips("SUCCESS_REMOVE_SERVANT")
	else
		ShowTips("SUCCESS_EQUIP_SERVANT")
		slot0:PlayHeroTalk()
	end
end

function slot0.OnSwitchTo(slot0, slot1)
	if slot0.data.isOnFullScreenView then
		slot0:EnterFullScreenView(false)
		slot0:ShowBar()
	end

	slot2 = slot1.openTab
	slot3 = slot1.race
	slot4 = slot1.servantID

	if slot1.HeroID then
		slot0.data.heroId = slot5
	end

	if slot3 and slot3 ~= 0 then
		slot0:OnCallNameBtnClick(slot3, slot4)
	elseif slot2 == "hold" then
		slot0:OnHoldBtnClick({
			uid = slot1.servantUID
		})
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.holdBtn_, nil, function ()
		if uv0.data.curViewIdx == uv0.singleton.listView.viewHold.pageIdx then
			return
		end

		uv0:OnHoldBtnClick()
	end)
	slot0:AddBtnListener(slot0.callNameBtn_, nil, function ()
		if uv0.data.curViewIdx == uv0.singleton.listView.viewCallName.pageIdx then
			return
		end

		uv0:OnCallNameBtnClick()
	end)
	slot0:AddBtnListener(slot0.showIconBtn_, nil, function ()
		uv0:ControlIconScaleClick()
	end)
	slot0:AddBtnListener(slot0.showPathBtn_, nil, function ()
		uv0:OnPathClick()
	end)
	slot0.singleton.avatarView:RegisterCloseCallback(function ()
		uv0:EnterAvatarShow(false)
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.RemoveNotifyListeners(slot0)
end

function slot0.OnHoldBtnClick(slot0, slot1)
	slot2 = slot0.singleton.listView.viewHold

	slot0:SwitchControllerState(slot0.controller.state.selectTab.name, slot0.controller.state.selectTab.hold)
	slot0:EnterViewOrInst(slot2, true)
	slot2.viewModule:RegisterFullScreenCallback(function ()
		uv0:OnFullScreenBtnClick()
	end)
	slot0:RefreshHoldServantList(slot1)

	if slot0.data.heroId then
		slot0.singleton.viewDetail:SwitchBtnStyle(slot2.detailBtnStyle)
	else
		slot3:SwitchBtnStyle(slot2.detailNoHeroBtnStyle)
	end

	slot0:ShowBar()
end

function slot0.OnCallNameBtnClick(slot0, slot1, slot2)
	slot3 = slot0.singleton.listView.viewCallName

	slot0:SwitchControllerState(slot0.controller.state.selectTab.name, slot0.controller.state.selectTab.callName)
	slot0:EnterViewOrInst(slot3, true)
	slot0:RefreshCallNameServantList(slot1, slot2)
	slot0.singleton.viewDetail:SwitchBtnStyle(slot3.detailBtnStyle)
	slot0:ShowBar()
end

function slot0.OnBackBtnClick(slot0)
	if slot0.data.isOnFullScreenView then
		slot0:EnterFullScreenView(false)
		slot0:RefreshView()
		slot0:ShowBar()
	else
		slot0:Back()
	end
end

function slot0.OnFullScreenBtnClick(slot0, slot1)
	slot0:EnterFullScreenView(true, slot1)

	if slot0.data.heroId then
		slot0.singleton.viewDetail:SwitchBtnStyle(slot0.singleton.viewFullList.detailBtnStyle)
	else
		slot2:SwitchBtnStyle(slot0.singleton.viewFullList.detailNoHeroBtnStyle)
	end
end

function slot0.ControlIconScaleClick(slot0)
	slot0:EnterAvatarShow(true)
end

function slot0.OnPathClick(slot0)
	if not slot0.data.curServantData then
		return
	end

	ShowPopItemOnly(POP_SOURCE_ITEM, {
		slot1.id,
		"servant"
	})
end

function slot0.onCallNameClick(slot0)
	slot0:OnCallNameBtnClick()
end

function slot0.onShowEmptyView(slot0)
end

function slot0.PlayHeroTalk(slot0)
	if slot0.data.heroId and slot0.data.heroId ~= 0 then
		if slot0.data.isTalkCD then
			return
		end

		HeroTools.PlayTalk(slot0.data.heroId, "equip")

		slot0.data.isTalkCD = true
		slot0.data.talkCDTimer_ = Timer.New(function ()
			uv0.data.isTalkCD = false
		end, 10, 1)

		slot0.data.talkCDTimer_:Start()
	end
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.controller.comps:GetController(slot1) then
		slot4:SetSelectedState(slot2)
	end
end

function slot0.onHoldItemClick(slot0, slot1)
	slot0:SelectServant(slot1)
end

function slot0.onCallNameItemClick(slot0, slot1)
	slot0:SelectServant(slot1)
end

function slot0.onFullListItemClick(slot0, slot1)
	slot0:SelectServant(slot1)
end

function slot0.SelectServant(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot0.data.curServantData
	slot0.data.curServantData = slot1

	slot0.singleton.viewDetail:OnRenderServant(slot1, slot0.data.heroId)

	if not slot0.data.isOnFullScreenView then
		manager.heroRaiseTrack:SetWeaponServantID(slot1.id)
	end

	slot0.singleton.avatarView:SetAvatarSprite(slot1.id)
end

function slot0.RefreshView(slot0)
	for slot4, slot5 in pairs(slot0.singleton.listView) do
		if slot0.data.curViewIdx == slot5.pageIdx and slot5.OnRefresh then
			slot6()

			break
		end
	end
end

function slot0.RefreshHoldServantList(slot0, slot1)
	slot2 = nil

	if slot1 then
		slot2 = slot1.uid
	end

	slot0.singleton.listView.viewHold.viewModule:RefreshList({
		heroId = slot0.data.heroId,
		jumpUid = slot2,
		emptyCallback = function (slot0)
			if slot0 then
				uv0:SwitchControllerState(uv0.controller.state.emptyView.name, uv0.controller.state.emptyView.True)
				manager.heroRaiseTrack:PlayServantAnim("Fade")
			else
				uv0:SwitchControllerState(uv0.controller.state.emptyView.name, uv0.controller.state.emptyView.False)
				manager.heroRaiseTrack:PlayServantAnim("Light")
			end
		end
	})
end

function slot0.RefreshCallNameServantList(slot0, slot1, slot2)
	slot0.singleton.listView.viewCallName.viewModule:EnterPage({
		heroId = slot0.data.heroId,
		race = slot1,
		servantID = slot2
	})
	slot0:SwitchControllerState(slot0.controller.state.emptyView.name, slot0.controller.state.emptyView.False)
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function slot0.RefreshFullListServantList(slot0, slot1)
	if slot0.singleton.viewFullList.viewModule then
		slot2 = nil

		if slot1 then
			slot2 = slot1.uid
		end

		slot0.singleton.viewFullList.viewModule:RefreshList({
			heroId = slot0.data.heroId,
			jumpUid = slot2
		})
	end
end

function slot0.EnterFullScreenView(slot0, slot1, slot2)
	slot0.data.isOnFullScreenView = slot1

	if slot1 then
		slot0:EnterFullListOrInst()
		slot0:RefreshFullListServantList(slot2)
		slot0:SwitchControllerState(slot0.controller.state.inFullScreen.name, slot0.controller.state.inFullScreen.True)
		slot0.singleton.viewFullList.viewModule:OnEnter()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
	else
		slot0:SwitchControllerState(slot0.controller.state.inFullScreen.name, slot0.controller.state.inFullScreen.False)

		if slot0.singleton.viewFullList.viewModule then
			slot0.singleton.viewFullList.viewModule:OnExit()
		end

		manager.heroRaiseTrack:PlayServantAnim("Light")
		manager.heroRaiseTrack:SetWeaponServantID(slot0.data.curServantData.id)
		slot0:OnHoldBtnClick()
		slot0:RefreshTabCount()
	end
end

function slot0.RefreshTabCount(slot0)
	slot0:RefreshCallNameCount()
	slot0:RefreshFullServantCount()
end

function slot0.RefreshCallNameCount(slot0)
	for slot6, slot7 in pairs(WeaponServantData:GetWeaponServantList()) do
		slot8 = WeaponServantCfg[slot7.id].race

		if WeaponServantCfg[slot7.id].type == 3 then
			slot2 = 0 + 1
		end
	end

	slot0.callNameNumTxt_.text = slot2
end

function slot0.RefreshFullServantCount(slot0)
	slot0.haveNumTxt_.text = table.concat({
		ServantTools.GetServantShowCount(),
		"/",
		GameSetting.max_weapon_servant.value[1]
	})
end

function slot0.EnterFullListOrInst(slot0)
	slot0:InstView(slot0.singleton.viewFullList, slot0.fullPageContainer_)
end

function slot0.EnterViewOrInst(slot0, slot1, slot2)
	slot0:InstView(slot1, slot0.pageContainer_)

	slot3 = slot0.data.curViewIdx
	slot0.data.curViewIdx = slot1.pageIdx
	slot4 = nil

	if slot2 then
		for slot8, slot9 in pairs(slot0.singleton.listView) do
			if slot9.viewModule then
				if slot9.pageIdx ~= slot0.data.curViewIdx then
					slot9.viewObj:SetActive(false)
				else
					slot9.viewObj:SetActive(true)
				end

				if slot9.pageIdx == slot3 then
					slot4 = slot9.viewModule
				end
			end
		end

		if slot3 ~= slot0.data.curViewIdx then
			if slot4 then
				slot4:OnExit()
			end

			slot1.viewModule:OnEnter()
		end
	else
		slot1.viewObj:SetActive(true)
	end
end

function slot0.InstView(slot0, slot1, slot2, slot3)
	if not slot1.viewModule then
		slot1.viewObj = Object.Instantiate(Asset.Load(slot1.uiRootPath), slot2)
		slot1.viewModule = import(slot1.viewModulePath).New(slot1.viewObj)

		if slot1.onServantItemClick then
			slot1.viewModule:RegisterClickCallback(slot1.onServantItemClick)
		end
	end
end

function slot0.GetServantRace(slot0, slot1)
	if slot1 then
		return WeaponServantCfg[slot1].race
	else
		return 1
	end
end

function slot0.EnterAvatarShow(slot0, slot1)
	slot0.data.isInAvatarShowView = slot1

	if slot1 then
		manager.windowBar:HideBar()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
		slot0.singleton.avatarView:EnterAvatarView(true)
		slot0:SwitchControllerState(slot0.controller.state.avatarShow.name, slot0.controller.state.avatarShow.True)
	else
		slot0:ShowBar()
		manager.windowBar:RegistBackCallBack(function ()
			uv0:OnBackBtnClick()
		end)

		if not slot0.data.isOnFullScreenView then
			manager.heroRaiseTrack:SetWeaponServantID(slot0.data.curServantData.id)
			manager.heroRaiseTrack:PlayServantAnim("Light")
		end

		slot0.singleton.avatarView:EnterAvatarView(false)
		slot0:SwitchControllerState(slot0.controller.state.avatarShow.name, slot0.controller.state.avatarShow.False)
		slot0:RestoreListPostion()
	end
end

function slot0.RestoreListPostion(slot0)
	for slot4, slot5 in pairs(slot0.singleton.listView) do
		if slot0.data.curViewIdx == slot5.pageIdx and slot5.viewModule then
			slot5.viewModule:RestoreListPostion()
		end
	end
end

return slot0
