slot0 = class("WeaponServantDetailsView", ReduxView)

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function slot0.OnTop(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function slot0.UIName(slot0)
	return "Widget/System/Hero_servant/HeroServantDetailUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		comps = slot0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			tabDetails = {
				False = "False",
				name = "tabDetails",
				True = "True"
			},
			tabBeyond = {
				False = "False",
				name = "tabBeyond",
				True = "True"
			},
			tabStory = {
				False = "False",
				name = "tabStory",
				True = "True"
			},
			avatarShow = {
				False = "false",
				name = "avatarShow",
				True = "true"
			}
		}
	}
	slot0.tabGroup = {
		{
			btnState = "tabDetails",
			OnEnter = handler(slot0, slot0.SwitchToDetailPage)
		},
		{
			btnState = "tabBeyond",
			OnEnter = handler(slot0, slot0.SwitchToBeyondPage)
		},
		{
			btnState = "tabStory",
			OnEnter = handler(slot0, slot0.SwitchToStory)
		}
	}
	slot0.page = {
		detailView = {
			name = "detailView",
			uiRootPath = "Widget/System/Hero_servant/Module/MainServantDetailModule",
			pageIdx = 1,
			stateName = "Detail",
			viewPath = WeaponServantDetailModule
		},
		beyondView = {
			name = "beyondView",
			barCurrency = true,
			uiRootPath = "Widget/System/Hero_servant/Module/MainBeyondView",
			pageIdx = 2,
			stateName = "beyond",
			viewPath = WeaponServantBeyondModule
		},
		storyView = {
			name = "storyView",
			uiRootPath = "Widget/System/Hero_servant/Module/MainStoryView",
			pageIdx = 3,
			stateName = "Story",
			viewPath = WeaponServantStoryModule
		}
	}
	slot0.constVar = {
		tabPrefix = "tabObj%d_",
		avatarView = ServantAvatarViewModule.New(slot0.scaleImageObj_)
	}
end

function slot0.InitContext(slot0)
	slot0.data = {
		isInAvatarShowView = false,
		curPageIdx = 0,
		servantId = 0,
		heroId = 0,
		servantData = {}
	}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0[string.format("tabToggle%d_", slot4)], function (slot0)
			if slot0 then
				uv0:SwitchToTab(uv1, true)
			end
		end)
	end

	slot0:AddBtnListener(slot0.showBtn_, nil, function ()
		uv0:OnShowBtnClick()
	end)
	slot0:AddBtnListener(slot0.gachaBtn_, nil, function ()
		uv0:OnGachaBtnClick()
	end)
	slot0.constVar.avatarView:RegisterCloseCallback(function ()
		uv0:EnterAvatarShow(false)
	end)

	slot0.eventHandler = {
		promoteHandler = handler(slot0, slot0.OnBeyondSuccess)
	}

	slot0:RegistEventListener(SERVANT_PROMOTE, slot0.eventHandler.promoteHandler)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnBeyondSuccess(slot0)
	slot0:ChangeBar()
end

function slot0.ChangeBeyondBarShow(slot0)
	slot2 = {
		BACK_BAR,
		HOME_BAR
	}

	if not slot0:CheckIsArriveMax(slot0:GetServantData()) then
		table.insert(slot2, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(slot2)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar(slot2)
	end
end

function slot0.CheckIsArriveMax(slot0, slot1)
	return slot1.stage >= GameSetting.weapon_promote_max.value[WeaponServantCfg[slot1.id].starlevel] + 1
end

function slot0.ChangeBar(slot0, slot1)
	if not slot0.params_.id then
		if not slot1 then
			for slot5, slot6 in pairs(slot0.page) do
				if slot6.view and slot6.pageIdx == slot0.data.curPageIdx then
					slot1 = slot6

					break
				end
			end
		end

		if slot1 and slot1.pageIdx == 2 then
			slot0:ChangeBeyondBarShow()
		else
			manager.windowBar:SwitchBar({
				BACK_BAR,
				HOME_BAR
			})
		end
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end
end

function slot0.OnEnter(slot0)
	slot0:InitContext()

	slot0.data.servantData = slot0.params_.servantData or {
		locked = false,
		id = slot0.params_.id,
		stage = slot0.params_.stage or 5
	}
	slot0.data.heroId = slot0.params_.heroId

	slot0:PreOpenLogic()
	slot0:RenderView()
end

function slot0.PreOpenLogic(slot0)
	slot2 = slot0.data.servantData.uid == nil

	if slot0.params_.openContext then
		if slot1.disableTabList then
			for slot7 = 1, 3 do
				if slot0[string.format(slot0.constVar.tabPrefix, slot7)] then
					SetActive(slot8, not slot3[slot7])
				end
			end
		else
			for slot7 = 1, 3 do
				if slot0[string.format(slot0.constVar.tabPrefix, slot7)] then
					SetActive(slot8, true)
				end
			end
		end

		slot0:SwitchToTab(slot1.tabIndex or 1, true)
	else
		if slot2 then
			if slot0[string.format(slot0.constVar.tabPrefix, 2)] then
				SetActive(slot3, false)
			end
		elseif slot0[string.format(slot0.constVar.tabPrefix, 2)] then
			SetActive(slot3, true)
		end

		slot0:SwitchToTab(1, true)
	end

	slot0:EnterAvatarShow(false)
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.page) do
		if slot5 and slot5.view then
			slot5.view:OnExit()
		end
	end

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.page) do
		if slot5 and slot5.view then
			slot5.viewObj = nil

			slot5.view:Dispose()

			slot5.view = nil
		end
	end

	slot0.constVar.avatarView:Dispose()

	slot0.constVar.avatarView = nil

	uv0.super.Dispose(slot0)
end

function slot0.RenderView(slot0)
	manager.heroRaiseTrack:SetWeaponServantID(slot0.data.servantData.id)
	slot0.constVar.avatarView:SetAvatarSprite(slot0.data.servantData.id)
end

function slot0.SwitchToTab(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0.tabGroup) do
		if slot7 == slot1 then
			slot0:SwitchControllerState(slot3[slot7].btnState, "True")

			if slot2 then
				slot3[slot7].OnEnter(true)
			end
		else
			slot0:SwitchControllerState(slot3[slot7].btnState, "False")
		end
	end
end

function slot0.SwitchToBeyondPage(slot0, slot1)
	slot0:SwitchToView(slot0.page.beyondView, slot1)
end

function slot0.SwitchToStory(slot0, slot1)
	slot0:SwitchToView(slot0.page.storyView, slot1)
end

function slot0.SwitchToDetailPage(slot0, slot1)
	slot0:SwitchToView(slot0.page.detailView, slot1)
end

function slot0.SwitchToView(slot0, slot1, slot2)
	if slot1 then
		slot0:ChangeBar(slot1)

		if slot0.data.curPageIdx ~= slot1.pageIdx then
			slot0.data.curPageIdx = slot1.pageIdx

			slot0:EnterViewOrInst(slot1, true)
			slot0:RefreshPageView(slot1.view)
		elseif slot2 then
			slot0.data.curPageIdx = slot1.pageIdx

			slot0:EnterViewOrInst(slot1, false)
			slot0:RefreshPageView(slot1.view)
		end
	end
end

function slot0.RefreshPageView(slot0, slot1)
	slot1:OnRenderModule({
		servantData = slot0:GetServantData(),
		heroId = slot0:GetHeroId()
	})
end

function slot0.EnterViewOrInst(slot0, slot1, slot2)
	if not slot1.view then
		slot1.viewObj = Object.Instantiate(Asset.Load(slot1.uiRootPath), slot0.pageContainer_)
		slot1.view = slot1.viewPath.New(slot1.viewObj)
	end

	if slot2 then
		for slot6, slot7 in pairs(slot0.page) do
			if slot7.view then
				if slot7.pageIdx ~= slot0.data.curPageIdx then
					slot7.view:OnExit()
					slot7.viewObj:SetActive(false)
				else
					slot7.view:OnEnter()
					slot7.viewObj:SetActive(true)
				end
			end
		end
	else
		slot1.viewObj:SetActive(true)
	end
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.controller.comps:GetController(slot1) then
		slot4:SetSelectedState(slot2)
	end
end

function slot0.GetServantData(slot0)
	return slot0.data.servantData
end

function slot0.GetHeroId(slot0)
	return slot0.data.heroId
end

function slot0.OnShowBtnClick(slot0)
	slot0:EnterAvatarShow(true)
end

function slot0.OnGachaBtnClick(slot0)
	if not slot0:GetServantData() then
		return
	end

	ShowPopItemOnly(POP_SOURCE_ITEM, {
		slot1.id,
		"servant"
	})
end

function slot0.EnterAvatarShow(slot0, slot1)
	slot0.data.isInAvatarShowView = slot1

	if slot1 then
		manager.windowBar:HideBar()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
		slot0.constVar.avatarView:EnterAvatarView(true)
		slot0:SwitchControllerState(slot0.controller.state.avatarShow.name, slot0.controller.state.avatarShow.True)
	else
		slot0:ChangeBar()
		manager.heroRaiseTrack:SetWeaponServantID(slot0:GetServantData().id)
		manager.heroRaiseTrack:PlayServantAnim("Light")
		slot0.constVar.avatarView:EnterAvatarView(false)
		slot0:SwitchControllerState(slot0.controller.state.avatarShow.name, slot0.controller.state.avatarShow.False)
	end
end

return slot0
