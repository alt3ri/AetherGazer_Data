slot0 = class("WeaponView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_key/HeroKeyDetailsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.buildContext(slot0)
	slot0.context = {
		controllerWrap = {
			comps = slot0.gameObject_:GetComponent("ControllerExCollection"),
			state = {
				selectDetail = {
					False = "false",
					name = "selectDetail",
					True = "true"
				},
				selectUp = {
					False = "false",
					name = "selectUp",
					True = "true"
				}
			}
		},
		tabGroup = {
			{
				btnState = "selectDetail",
				OnEnter = handler(slot0, slot0.SwitchToDetailTab)
			},
			{
				btnState = "selectUp",
				OnEnter = handler(slot0, slot0.SwitchToLvUpTab)
			}
		},
		data = {
			heroId = 0,
			curPageIdx = 0,
			proxyTag = 0,
			weaponInfo = {}
		},
		syntheiseHandle = handler(slot0, slot0.OnSynthesiseSuccess)
	}
	slot0.pageView = {
		detailView = {
			viewPath = "game.views.weapon.WeaponSubView.WeaponDetailView",
			name = "detailView",
			uiRootPath = "Widget/System/Hero_key/HeroKeyMessageUI",
			pageIdx = 1,
			stateName = "Detail"
		},
		lvupView = {
			viewPath = "game.views.weapon.WeaponSubView.WeaponLvupView",
			name = "lvupView",
			uiRootPath = "Widget/System/Hero_key/HeroKeyLevelUpUI",
			pageIdx = 2,
			stateName = "LvUp",
			barCurrency = {
				CurrencyConst.CURRENCY_TYPE_GOLD
			}
		},
		breakView = {
			viewPath = "game.views.weapon.WeaponSubView.WeaponBreakSubView",
			name = "breakView",
			uiRootPath = "Widget/System/Hero_key/HeroKeyBreakUI",
			pageIdx = 3,
			stateName = "Break",
			barCurrency = {
				CurrencyConst.CURRENCY_TYPE_GOLD
			}
		}
	}
end

function slot0.InitContext(slot0)
	slot1 = slot0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.data = {
		heroId = 0,
		curPageIdx = 0,
		proxyTag = 0,
		curTabIdx = -1,
		weaponInfo = {},
		type = slot1,
		dataPorxy = HeroViewDataProxy.New(slot1)
	}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:buildContext()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.OnEnter(slot0)
	slot4 = ON_SYNTHESISE_USE_ITEM_SUCCESS
	slot5 = slot0.context.syntheiseHandle

	manager.notify:RegistListener(slot4, slot5)

	for slot4, slot5 in pairs(slot0.pageView) do
		if slot5.view then
			slot5.view:OnEnter()
		end
	end

	slot1 = 1

	if slot0.params_.state and slot0.params_.state == "strength" then
		slot1 = 2
	end

	slot0:InitContext()
	slot0:SetHeroId(slot0.params_.HeroID)
	slot0:UpdateWeaponInfo()
	slot0:ResetWeaponView()
	slot0:BuildTabDesc()
	slot0:SwitchToTab(slot1, true)
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		1,
		HeroRaiseTrackConst.HeroServantType.weapon
	}, slot0.displayGo_)
end

function slot0.OnExit(slot0)
	slot4 = ON_SYNTHESISE_USE_ITEM_SUCCESS
	slot5 = slot0.context.syntheiseHandle

	manager.notify:RemoveListener(slot4, slot5)

	for slot4, slot5 in pairs(slot0.pageView) do
		if slot5.view then
			slot5.view:OnExit()
		end
	end

	manager.windowBar:HideBar()
end

function slot0.DisposeContext(slot0)
	slot0.context.controllerWrap.comps = nil

	for slot4, slot5 in pairs(slot0.pageView) do
		slot5.viewObj = nil

		if slot5.view then
			slot5.view:Dispose()

			slot5.view = nil
		end
	end
end

function slot0.Dispose(slot0)
	slot0:DisposeContext()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == CurrencyConst.CURRENCY_TYPE_GOLD then
			uv0:OnGoldChange()
		end
	end)
	slot0:RegistEventListener(WEAPON_BREAK, function ()
		uv0:OnWeaponBreak()
		uv0:ChangeWindowBar()
	end)
	slot0:RegistEventListener(WEAPON_STR, function ()
		uv0:OnWeaponLvUp()
		uv0:ChangeWindowBar()
	end)
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 2 do
		slot0:AddToggleListener(slot0[string.format("tabToggle%d_", slot4)], function (slot0)
			if uv0.data.curTabIdx == uv1 then
				return
			end

			uv0:OnTabSwitch(uv1, slot0)
		end)
	end
end

function slot0.OnTabSwitch(slot0, slot1, slot2)
	if slot2 then
		slot0:SwitchToTab(slot1, true)
		OperationRecorder.Record("hero", string.format("weaponPage2%d", slot1))
	end
end

function slot0.SwitchToTab(slot0, slot1, slot2)
	slot0.data.curTabIdx = slot1

	for slot7, slot8 in pairs(slot0.context.tabGroup) do
		if slot7 == slot1 then
			slot0:SwitchControllerState(slot3[slot7].btnState, "true")

			if slot2 then
				slot3[slot7].OnEnter(true)
			end
		else
			slot0:SwitchControllerState(slot3[slot7].btnState, "false")
		end
	end
end

function slot0.OnWeaponBreak(slot0)
	slot0:ShowBreakTips()
	slot0:UpdateWeaponInfo()
	slot0:SwitchToTab(2, false)
	slot0:SwitchToView(slot0.pageView.lvupView, true)
	slot0:BuildTabDesc()
end

function slot0.OnWeaponLvUp(slot0)
	slot0:UpdateWeaponInfo()

	slot1 = slot0.data.weaponInfo
	slot3 = GameSetting.weapon_exp_limit.value[slot1.breakthrough + 1]

	if slot1.level == HeroConst.WEAPON_LV_MAX then
		slot0:SwitchToTab(1, true)
	elseif slot1.level == slot3 then
		slot0:SwitchToTab(2, false)
		slot0:SwitchToView(slot0.pageView.breakView, true)
	end

	slot0:BuildTabDesc()
end

function slot0.ShowBreakTips(slot0)
	JumpTools.OpenPageByJump("weaponBreak", {
		heroID = slot0.data.heroId,
		breakthrough = slot0.data.weaponInfo.breakthrough
	})
end

function slot0.OnSynthesiseSuccess(slot0)
	slot0:OnGoldChange()
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.context.controllerWrap.comps:GetController(slot1) then
		slot4:SetSelectedState(slot2)
	end
end

function slot0.ResetWeaponView(slot0)
	if slot0:GetHeroId() and slot1 ~= 0 then
		manager.heroRaiseTrack:SetModelState(HeroTools.HeroUsingSkinInfo(slot1).id)
	end
end

function slot0.BuildTabDesc(slot0)
	if slot0:CheckWeaponCanBreakUp() then
		slot0.tab2Txt_.text = GetTips("TIP_BREAK")
	else
		slot0.tab2Txt_.text = GetTips("TIP_STRENGTH")
	end
end

function slot0.OnGoldChange(slot0)
	if slot0.data.curPageIdx == slot0.pageView.lvupView.pageIdx then
		slot0.pageView.lvupView.view:OnGoldChange()
	elseif slot0.data.curPageIdx == slot0.pageView.breakView.pageIdx then
		slot0.pageView.breakView.view:OnGoldChange()
	end
end

function slot0.SwitchToDetailTab(slot0, slot1)
	slot0:SwitchToView(slot0.pageView.detailView, slot1)
end

function slot0.SwitchToLvUpTab(slot0, slot1)
	if slot0:CheckWeaponCanBreakUp() then
		slot0:SwitchToView(slot0.pageView.breakView, slot1)
	else
		slot0:SwitchToView(slot0.pageView.lvupView, slot1)
	end
end

function slot0.IsMeetShowBar(slot0, slot1)
	if not slot1 or not slot1.barCurrency then
		return false
	end

	if slot1.pageIdx == 2 then
		if slot0:GetWeaponInfo() then
			return slot2.level ~= HeroConst.WEAPON_LV_MAX
		else
			return false
		end
	end

	return true
end

function slot0.ChangeWindowBar(slot0, slot1)
	if not slot1 then
		for slot5, slot6 in pairs(slot0.pageView) do
			if slot6.view and slot6.pageIdx == slot0.data.curPageIdx then
				slot1 = slot6

				break
			end
		end
	end

	slot2 = {
		BACK_BAR,
		HOME_BAR
	}

	if slot0:IsMeetShowBar(slot1) then
		for slot6, slot7 in pairs(slot1.barCurrency) do
			table.insert(slot2, slot7)
		end

		slot6 = slot2

		manager.windowBar:SwitchBar(slot6)

		for slot6, slot7 in pairs(slot1.barCurrency) do
			manager.windowBar:SetBarCanAdd(slot7, true)
		end
	else
		manager.windowBar:SwitchBar(slot2)
	end
end

function slot0.SwitchToView(slot0, slot1, slot2)
	if slot1 then
		slot0:ChangeWindowBar(slot1)

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
	slot1:ShowWeaponInfo(slot0:GetHeroId(), slot0:GetWeaponInfo(), slot0.data.type)
end

function slot0.EnterViewOrInst(slot0, slot1, slot2)
	if not slot1.view then
		slot1.viewObj = Object.Instantiate(Asset.Load(slot1.uiRootPath), slot0.pageContainer_)
		slot1.view = import(slot1.viewPath).New(slot1.viewObj)

		slot1.view:OnEnter()
	end

	if slot2 then
		for slot6, slot7 in pairs(slot0.pageView) do
			if slot7.view then
				if slot7.pageIdx ~= slot0.data.curPageIdx then
					slot7.viewObj:SetActive(false)
				else
					slot7.viewObj:SetActive(true)
				end
			end
		end
	else
		slot1.viewObj:SetActive(true)
	end
end

function slot0.UpdateWeaponInfo(slot0)
	if slot0:GetHeroId() and slot1 ~= 0 then
		slot0.data.weaponInfo = deepClone(slot0.data.dataPorxy:GetHeroWeaponInfo(slot1))
	end
end

function slot0.GetWeaponInfo(slot0)
	return slot0.data.weaponInfo
end

function slot0.SetHeroId(slot0, slot1)
	slot0.data.heroId = slot1
end

function slot0.GetHeroId(slot0)
	return slot0.data.heroId
end

function slot0.GetControllerState(slot0)
	return slot0.context.controllerWrap.state
end

function slot0.CheckWeaponCanBreakUp(slot0)
	if slot0:GetWeaponInfo() then
		if GameSetting.weapon_exp_limit.value[slot1.breakthrough + 1] == slot1.level and slot1.level ~= HeroConst.WEAPON_LV_MAX then
			return true
		end
	else
		return false
	end

	return false
end

return slot0
