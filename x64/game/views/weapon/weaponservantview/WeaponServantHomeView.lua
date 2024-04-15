local var_0_0 = class("WeaponServantHomeView", ReduxView)

function var_0_0.CameraEnter(arg_1_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Fade")
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Hero_servant/HeroServantUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.controller = {
		comps = arg_4_0.gameObject_:GetComponent("ControllerExCollection"),
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
	arg_4_0.singleton = {
		viewDetail = WeaponServantMainDetailModule.New(arg_4_0.mainDetailsObj_),
		listView = {
			viewHold = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantHoldListViewModule",
				detailBtnStyle = 1,
				uiRootPath = "Widget/System/Hero_servant/Module/HoldListViewModule",
				pageIdx = 1,
				detailNoHeroBtnStyle = 3,
				onServantItemClick = function(arg_5_0)
					arg_4_0:onHoldItemClick(arg_5_0)
				end,
				OnRefresh = function()
					arg_4_0:OnHoldBtnClick()
				end
			},
			viewCallName = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantCallNameListViewModule",
				detailBtnStyle = 2,
				uiRootPath = "Widget/System/Hero_servant/Module/CallNameListViewModule",
				pageIdx = 2,
				detailNoHeroBtnStyle = 2,
				onServantItemClick = function(arg_7_0)
					arg_4_0:onCallNameItemClick(arg_7_0)
				end,
				OnRefresh = function()
					arg_4_0:OnCallNameBtnClick()
				end
			}
		},
		viewFullList = {
			detailBtnStyle = 1,
			detailNoHeroBtnStyle = 3,
			uiRootPath = "Widget/System/Hero_servant/Module/FullScreenServantView",
			viewModulePath = "game.views.weapon.WeaponServantView.WeaponServantFullListViewModule",
			onServantItemClick = function(arg_9_0)
				arg_4_0:onFullListItemClick(arg_9_0)
			end
		},
		avatarView = ServantAvatarViewModule.New(arg_4_0.scaleImageObj_)
	}

	arg_4_0.singleton.viewDetail:RegisteCallNameClickCallback(handler(arg_4_0, arg_4_0.onCallNameClick))
end

function var_0_0.InitContext(arg_10_0)
	arg_10_0.data = {
		isInAvatarShowView = false,
		heroId = 0,
		curViewIdx = 0,
		isOnFullScreenView = false,
		isOpen = true,
		isTalkCD = false
	}
end

function var_0_0.Init(arg_11_0)
	arg_11_0:BindCfgUI()
	arg_11_0:BuildContext()
	arg_11_0:AddUIListener()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:InitContext()
	arg_12_0:AddEventListeners()
	arg_12_0:RegistEventListener(SERVANT_REPLACE, handler(arg_12_0, arg_12_0.OnServantReplaced))
	arg_12_0:RegistEventListener(SERVANT_SWITCH_TO_CALLNAME, handler(arg_12_0, arg_12_0.OnSwitchTo))

	arg_12_0.data.heroId = arg_12_0.params_.HeroID

	arg_12_0:OnPreOpenPage()
	arg_12_0:RefreshTabCount()
	arg_12_0:ShowBar()
end

function var_0_0.ShowBar(arg_13_0)
	if not arg_13_0.data.isOpen then
		return
	end

	local var_13_0 = {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	}

	if arg_13_0.data and arg_13_0.data.curViewIdx == 2 then
		table.insert(var_13_0, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(var_13_0)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar(var_13_0)
		manager.windowBar:RegistBackCallBack(function()
			arg_13_0:OnBackBtnClick()
		end)
	end

	manager.windowBar:SetGameHelpKey("SERVANT_AWAKE_DESC_1")
end

function var_0_0.OnPreOpenPage(arg_15_0)
	if not arg_15_0.params_.tempParams then
		local var_15_0 = arg_15_0.params_.isFullScreen
		local var_15_1 = arg_15_0.params_.race
		local var_15_2 = arg_15_0.params_.servantID

		if var_15_1 and var_15_1 ~= 0 then
			arg_15_0:OnCallNameBtnClick(var_15_1, var_15_2)
		else
			arg_15_0:OnHoldBtnClick()
		end
	else
		local var_15_3 = arg_15_0.params_.tempParams

		arg_15_0.data.heroId = var_15_3.HeroID or nil

		if var_15_3.isFullScreen ~= nil then
			local var_15_4 = var_15_3.servantData

			if var_15_3.isFullScreen then
				arg_15_0:OnFullScreenBtnClick(var_15_4)
			elseif var_15_3.viewIdx == 1 then
				arg_15_0:OnHoldBtnClick(var_15_4)
			elseif var_15_4.id and var_15_4.id ~= 0 then
				arg_15_0:OnCallNameBtnClick(arg_15_0:GetServantRace(var_15_4.id), var_15_4.id)
			else
				arg_15_0:OnCallNameBtnClick()
			end
		else
			arg_15_0:OnHoldBtnClick()
		end
	end

	arg_15_0.params_.tempParams = nil
end

function var_0_0.RecordPageStatus(arg_16_0)
	arg_16_0.params_.tempParams = {
		isFullScreen = arg_16_0.data.isOnFullScreenView,
		HeroID = arg_16_0.data.heroId,
		servantData = clone(arg_16_0.data.curServantData or {}),
		viewIdx = arg_16_0.data.curViewIdx
	}
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0.data.isOpen = false

	arg_17_0:RecordPageStatus()

	if arg_17_0.data.isOnFullScreenView then
		arg_17_0:EnterFullScreenView(false)
	end

	arg_17_0:RemoveAllEventListener()

	if arg_17_0.data.talkCDTimer_ then
		arg_17_0.data.talkCDTimer_:Stop()

		arg_17_0.data.talkCDTimer_ = nil
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.singleton.listView) do
		if arg_17_0.data.curViewIdx == iter_17_1.pageIdx and iter_17_1.viewModule then
			iter_17_1.viewModule:OnExit()
		end
	end

	arg_17_0.singleton.viewDetail:OnExit()
	manager.windowBar:HideBar()
	arg_17_0:RemoveNotifyListeners()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveAllListeners()
	arg_18_0:RemoveAllEventListener()
	arg_18_0.singleton.viewDetail:Dispose()

	if arg_18_0.singleton.viewFullList.viewModule then
		arg_18_0.singleton.viewFullList.viewModule:Dispose()
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.singleton.listView) do
		if iter_18_1 and iter_18_1.viewModule then
			iter_18_1.viewObj = nil

			iter_18_1.viewModule:Dispose()

			iter_18_1.viewModule = nil
		end
	end

	arg_18_0.singleton.avatarView:Dispose()

	arg_18_0.singleton.avatarView = nil

	if arg_18_0.data.talkCDTimer_ then
		arg_18_0.data.talkCDTimer_:Stop()

		arg_18_0.data.talkCDTimer_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.OnServantReplaced(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2.servant_id == 0 then
		ShowTips("SUCCESS_REMOVE_SERVANT")
	else
		ShowTips("SUCCESS_EQUIP_SERVANT")
		arg_19_0:PlayHeroTalk()
	end
end

function var_0_0.OnSwitchTo(arg_20_0, arg_20_1)
	if arg_20_0.data.isOnFullScreenView then
		arg_20_0:EnterFullScreenView(false)
		arg_20_0:ShowBar()
	end

	local var_20_0 = arg_20_1.openTab
	local var_20_1 = arg_20_1.race
	local var_20_2 = arg_20_1.servantID
	local var_20_3 = arg_20_1.HeroID

	if var_20_3 then
		arg_20_0.data.heroId = var_20_3
	end

	if var_20_1 and var_20_1 ~= 0 then
		arg_20_0:OnCallNameBtnClick(var_20_1, var_20_2)
	elseif var_20_0 == "hold" then
		arg_20_0:OnHoldBtnClick({
			uid = arg_20_1.servantUID
		})
	end
end

function var_0_0.AddUIListener(arg_21_0)
	arg_21_0:AddBtnListener(arg_21_0.holdBtn_, nil, function()
		if arg_21_0.data.curViewIdx == arg_21_0.singleton.listView.viewHold.pageIdx then
			return
		end

		arg_21_0:OnHoldBtnClick()
	end)
	arg_21_0:AddBtnListener(arg_21_0.callNameBtn_, nil, function()
		if arg_21_0.data.curViewIdx == arg_21_0.singleton.listView.viewCallName.pageIdx then
			return
		end

		arg_21_0:OnCallNameBtnClick()
	end)
	arg_21_0:AddBtnListener(arg_21_0.showIconBtn_, nil, function()
		arg_21_0:ControlIconScaleClick()
	end)
	arg_21_0:AddBtnListener(arg_21_0.showPathBtn_, nil, function()
		arg_21_0:OnPathClick()
	end)
	arg_21_0.singleton.avatarView:RegisterCloseCallback(function()
		arg_21_0:EnterAvatarShow(false)
	end)
end

function var_0_0.AddEventListeners(arg_27_0)
	return
end

function var_0_0.RemoveNotifyListeners(arg_28_0)
	return
end

function var_0_0.OnHoldBtnClick(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.singleton.listView.viewHold
	local var_29_1 = arg_29_0.singleton.viewDetail

	arg_29_0:SwitchControllerState(arg_29_0.controller.state.selectTab.name, arg_29_0.controller.state.selectTab.hold)
	arg_29_0:EnterViewOrInst(var_29_0, true)
	var_29_0.viewModule:RegisterFullScreenCallback(function()
		arg_29_0:OnFullScreenBtnClick()
	end)
	arg_29_0:RefreshHoldServantList(arg_29_1)

	if arg_29_0.data.heroId then
		var_29_1:SwitchBtnStyle(var_29_0.detailBtnStyle)
	else
		var_29_1:SwitchBtnStyle(var_29_0.detailNoHeroBtnStyle)
	end

	arg_29_0:ShowBar()
end

function var_0_0.OnCallNameBtnClick(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.singleton.listView.viewCallName
	local var_31_1 = arg_31_0.singleton.viewDetail

	arg_31_0:SwitchControllerState(arg_31_0.controller.state.selectTab.name, arg_31_0.controller.state.selectTab.callName)
	arg_31_0:EnterViewOrInst(var_31_0, true)
	arg_31_0:RefreshCallNameServantList(arg_31_1, arg_31_2)
	var_31_1:SwitchBtnStyle(var_31_0.detailBtnStyle)
	arg_31_0:ShowBar()
end

function var_0_0.OnBackBtnClick(arg_32_0)
	if arg_32_0.data.isOnFullScreenView then
		arg_32_0:EnterFullScreenView(false)
		arg_32_0:RefreshView()
		arg_32_0:ShowBar()
	else
		arg_32_0:Back()
	end
end

function var_0_0.OnFullScreenBtnClick(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.singleton.viewDetail

	arg_33_0:EnterFullScreenView(true, arg_33_1)

	if arg_33_0.data.heroId then
		var_33_0:SwitchBtnStyle(arg_33_0.singleton.viewFullList.detailBtnStyle)
	else
		var_33_0:SwitchBtnStyle(arg_33_0.singleton.viewFullList.detailNoHeroBtnStyle)
	end
end

function var_0_0.ControlIconScaleClick(arg_34_0)
	arg_34_0:EnterAvatarShow(true)
end

function var_0_0.OnPathClick(arg_35_0)
	local var_35_0 = arg_35_0.data.curServantData

	if not var_35_0 then
		return
	end

	local var_35_1 = var_35_0.id

	ShowPopItemOnly(POP_SOURCE_ITEM, {
		var_35_1,
		"servant"
	})
end

function var_0_0.onCallNameClick(arg_36_0)
	arg_36_0:OnCallNameBtnClick()
end

function var_0_0.onShowEmptyView(arg_37_0)
	return
end

function var_0_0.PlayHeroTalk(arg_38_0)
	if arg_38_0.data.heroId and arg_38_0.data.heroId ~= 0 then
		if arg_38_0.data.isTalkCD then
			return
		end

		HeroTools.PlayTalk(arg_38_0.data.heroId, "equip")

		arg_38_0.data.isTalkCD = true
		arg_38_0.data.talkCDTimer_ = Timer.New(function()
			arg_38_0.data.isTalkCD = false
		end, 10, 1)

		arg_38_0.data.talkCDTimer_:Start()
	end
end

function var_0_0.SwitchControllerState(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0.controller.comps:GetController(arg_40_1)

	if var_40_0 then
		var_40_0:SetSelectedState(arg_40_2)
	end
end

function var_0_0.onHoldItemClick(arg_41_0, arg_41_1)
	arg_41_0:SelectServant(arg_41_1)
end

function var_0_0.onCallNameItemClick(arg_42_0, arg_42_1)
	arg_42_0:SelectServant(arg_42_1)
end

function var_0_0.onFullListItemClick(arg_43_0, arg_43_1)
	arg_43_0:SelectServant(arg_43_1)
end

function var_0_0.SelectServant(arg_44_0, arg_44_1)
	if not arg_44_1 then
		return
	end

	local var_44_0 = arg_44_0.data.curServantData

	arg_44_0.data.curServantData = arg_44_1

	arg_44_0.singleton.viewDetail:OnRenderServant(arg_44_1, arg_44_0.data.heroId)

	if not arg_44_0.data.isOnFullScreenView then
		manager.heroRaiseTrack:SetWeaponServantID(arg_44_1.id)
	end

	arg_44_0.singleton.avatarView:SetAvatarSprite(arg_44_1.id)
end

function var_0_0.RefreshView(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.singleton.listView) do
		if arg_45_0.data.curViewIdx == iter_45_1.pageIdx then
			local var_45_0 = iter_45_1.OnRefresh

			if var_45_0 then
				var_45_0()

				break
			end
		end
	end
end

function var_0_0.RefreshHoldServantList(arg_46_0, arg_46_1)
	local var_46_0

	if arg_46_1 then
		var_46_0 = arg_46_1.uid
	end

	arg_46_0.singleton.listView.viewHold.viewModule:RefreshList({
		heroId = arg_46_0.data.heroId,
		jumpUid = var_46_0,
		emptyCallback = function(arg_47_0)
			if arg_47_0 then
				arg_46_0:SwitchControllerState(arg_46_0.controller.state.emptyView.name, arg_46_0.controller.state.emptyView.True)
				manager.heroRaiseTrack:PlayServantAnim("Fade")
			else
				arg_46_0:SwitchControllerState(arg_46_0.controller.state.emptyView.name, arg_46_0.controller.state.emptyView.False)
				manager.heroRaiseTrack:PlayServantAnim("Light")
			end
		end
	})
end

function var_0_0.RefreshCallNameServantList(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0.singleton.listView.viewCallName.viewModule:EnterPage({
		heroId = arg_48_0.data.heroId,
		race = arg_48_1,
		servantID = arg_48_2
	})
	arg_48_0:SwitchControllerState(arg_48_0.controller.state.emptyView.name, arg_48_0.controller.state.emptyView.False)
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function var_0_0.RefreshFullListServantList(arg_49_0, arg_49_1)
	if arg_49_0.singleton.viewFullList.viewModule then
		local var_49_0

		if arg_49_1 then
			var_49_0 = arg_49_1.uid
		end

		arg_49_0.singleton.viewFullList.viewModule:RefreshList({
			heroId = arg_49_0.data.heroId,
			jumpUid = var_49_0
		})
	end
end

function var_0_0.EnterFullScreenView(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0.data.isOnFullScreenView = arg_50_1

	if arg_50_1 then
		arg_50_0:EnterFullListOrInst()
		arg_50_0:RefreshFullListServantList(arg_50_2)
		arg_50_0:SwitchControllerState(arg_50_0.controller.state.inFullScreen.name, arg_50_0.controller.state.inFullScreen.True)
		arg_50_0.singleton.viewFullList.viewModule:OnEnter()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
	else
		arg_50_0:SwitchControllerState(arg_50_0.controller.state.inFullScreen.name, arg_50_0.controller.state.inFullScreen.False)

		if arg_50_0.singleton.viewFullList.viewModule then
			arg_50_0.singleton.viewFullList.viewModule:OnExit()
		end

		manager.heroRaiseTrack:PlayServantAnim("Light")
		manager.heroRaiseTrack:SetWeaponServantID(arg_50_0.data.curServantData.id)
		arg_50_0:OnHoldBtnClick()
		arg_50_0:RefreshTabCount()
	end
end

function var_0_0.RefreshTabCount(arg_51_0)
	arg_51_0:RefreshCallNameCount()
	arg_51_0:RefreshFullServantCount()
end

function var_0_0.RefreshCallNameCount(arg_52_0)
	local var_52_0 = WeaponServantData:GetWeaponServantList()
	local var_52_1 = 0

	for iter_52_0, iter_52_1 in pairs(var_52_0) do
		local var_52_2 = WeaponServantCfg[iter_52_1.id].race

		if WeaponServantCfg[iter_52_1.id].type == 3 then
			var_52_1 = var_52_1 + 1
		end
	end

	arg_52_0.callNameNumTxt_.text = var_52_1
end

function var_0_0.RefreshFullServantCount(arg_53_0)
	local var_53_0 = ServantTools.GetServantShowCount()
	local var_53_1 = GameSetting.max_weapon_servant.value[1]

	arg_53_0.haveNumTxt_.text = table.concat({
		var_53_0,
		"/",
		var_53_1
	})
end

function var_0_0.EnterFullListOrInst(arg_54_0)
	local var_54_0 = arg_54_0.singleton.viewFullList

	arg_54_0:InstView(var_54_0, arg_54_0.fullPageContainer_)
end

function var_0_0.EnterViewOrInst(arg_55_0, arg_55_1, arg_55_2)
	arg_55_0:InstView(arg_55_1, arg_55_0.pageContainer_)

	local var_55_0 = arg_55_0.data.curViewIdx

	arg_55_0.data.curViewIdx = arg_55_1.pageIdx

	local var_55_1

	if arg_55_2 then
		for iter_55_0, iter_55_1 in pairs(arg_55_0.singleton.listView) do
			if iter_55_1.viewModule then
				if iter_55_1.pageIdx ~= arg_55_0.data.curViewIdx then
					iter_55_1.viewObj:SetActive(false)
				else
					iter_55_1.viewObj:SetActive(true)
				end

				if iter_55_1.pageIdx == var_55_0 then
					var_55_1 = iter_55_1.viewModule
				end
			end
		end

		if var_55_0 ~= arg_55_0.data.curViewIdx then
			if var_55_1 then
				var_55_1:OnExit()
			end

			arg_55_1.viewModule:OnEnter()
		end
	else
		arg_55_1.viewObj:SetActive(true)
	end
end

function var_0_0.InstView(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if not arg_56_1.viewModule then
		local var_56_0 = Asset.Load(arg_56_1.uiRootPath)

		arg_56_1.viewObj = Object.Instantiate(var_56_0, arg_56_2)
		arg_56_1.viewModule = import(arg_56_1.viewModulePath).New(arg_56_1.viewObj)

		if arg_56_1.onServantItemClick then
			arg_56_1.viewModule:RegisterClickCallback(arg_56_1.onServantItemClick)
		end
	end
end

function var_0_0.GetServantRace(arg_57_0, arg_57_1)
	if arg_57_1 then
		return WeaponServantCfg[arg_57_1].race
	else
		return 1
	end
end

function var_0_0.EnterAvatarShow(arg_58_0, arg_58_1)
	arg_58_0.data.isInAvatarShowView = arg_58_1

	if arg_58_1 then
		manager.windowBar:HideBar()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
		arg_58_0.singleton.avatarView:EnterAvatarView(true)
		arg_58_0:SwitchControllerState(arg_58_0.controller.state.avatarShow.name, arg_58_0.controller.state.avatarShow.True)
	else
		arg_58_0:ShowBar()
		manager.windowBar:RegistBackCallBack(function()
			arg_58_0:OnBackBtnClick()
		end)

		if not arg_58_0.data.isOnFullScreenView then
			manager.heroRaiseTrack:SetWeaponServantID(arg_58_0.data.curServantData.id)
			manager.heroRaiseTrack:PlayServantAnim("Light")
		end

		arg_58_0.singleton.avatarView:EnterAvatarView(false)
		arg_58_0:SwitchControllerState(arg_58_0.controller.state.avatarShow.name, arg_58_0.controller.state.avatarShow.False)
		arg_58_0:RestoreListPostion()
	end
end

function var_0_0.RestoreListPostion(arg_60_0)
	for iter_60_0, iter_60_1 in pairs(arg_60_0.singleton.listView) do
		if arg_60_0.data.curViewIdx == iter_60_1.pageIdx and iter_60_1.viewModule then
			iter_60_1.viewModule:RestoreListPostion()
		end
	end
end

return var_0_0
