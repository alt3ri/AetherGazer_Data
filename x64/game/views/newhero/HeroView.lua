slot0 = class("HeroView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero/HeroUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.dirty_ = true
	slot0.curPageIndex_ = 1
	slot0.isChangePageAndBack_ = false
	slot0.pageIndexS_ = {
		weapon = 3,
		astrolabe = 6,
		skill = 2,
		transition = 5,
		chip = 7,
		property = 1,
		equip = 4
	}
	slot0.viewType_ = {
		[1.0] = 1,
		[2.0] = 2,
		[3] = ViewConst.SYSTEM_ID.WEAPON,
		[4] = ViewConst.SYSTEM_ID.HERO_EQUIP,
		[5] = ViewConst.SYSTEM_ID.TRANSITION,
		[6] = ViewConst.SYSTEM_ID.HERO_ASTROLABE,
		[7] = ViewConst.SYSTEM_ID.HERO_CHIP
	}
	slot0.sdkTeach_ = {
		"attribute",
		"skill",
		"weapon",
		"equip",
		"equip_skill",
		"astrolabe",
		"chip"
	}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitConfig(slot0)
	slot0.filterView_:SetExtraSorter(nil)
	slot0.filterView_:SetHeroIdList(HeroCfg.get_id_list_by_private[0])
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.mainPageController_ = ControllerUtil.GetController(slot0.transform_, "mainPage")
	slot0.astroToggleController_ = ControllerUtil.GetController(slot0.toggle6_.transform, "lock")
	slot0.chipToggleController_ = ControllerUtil.GetController(slot0.toggle7_.transform, "lock")
	slot0.trasitionToggleController_ = ControllerUtil.GetController(slot0.toggle5_.transform, "lock")
	slot0.pages_ = {}

	slot0:InitHeroHeadList()

	slot0.curScrollHelper_ = slot0.shortScrollHelper_

	if slot0.pageContainerPop_ ~= nil then
		slot0.pageContainerPop_.parent = slot0.pageContainer_.parent
	end

	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle2_,
		slot0.toggle3_,
		slot0.toggle4_,
		slot0.toggle5_,
		slot0.toggle6_,
		slot0.toggle7_
	}
	slot0.filterView_ = NewHeroListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))

	slot0.lockController_ = slot0.controller_:GetController("lock")
	slot0.strategyRedController_ = slot0.strategyCon_:GetController("redpoint")
end

function slot0.InitHeroHeadList(slot0)
	slot0.shortScrollHelper_ = LuaList.New(handler(slot0, slot0.ShortHeadRenderer), slot0.heroShortListGo_, HeroShortHead)
	slot0.completeScrollHelper_ = LuaList.New(handler(slot0, slot0.LongHeadRenderer), slot0.heroCompleteListGo_, HeroLongHead)
end

function slot0.CameraEnter(slot0)
end

function slot0.OnListChange(slot0, slot1, slot2, slot3)
	slot0.heroIdList_ = slot1
	slot0.guidePlaying, slot0.gudieId_ = manager.guide:IsPlaying()

	if slot0.guidePlaying and slot0.gudieId_ ~= 46 then
		table.sort(slot0.heroIdList_, function (slot0, slot1)
			return slot0 == 1084
		end)
	end

	slot0.completeScrollHelper_:StartScroll(#slot0.heroIdList_)

	if #slot0.heroIdList_ > 0 then
		slot4 = slot0.curHeroId_

		if slot0.dirty_ then
			slot5 = nil

			if slot0.isEnter and slot0.params_.hid then
				if table.indexof(slot0.heroIdList_, slot0.params_.hid) then
					slot5 = slot0.params_.hid
				end
			else
				slot5 = slot0.heroIdList_[1]
			end

			slot0:SelectHero(slot5)
		else
			if table.indexof(slot0.heroIdList_, slot0.curHeroId_) then
				slot0:SelectHero(slot0.curHeroId_)

				slot4 = slot0.curHeroId_
			else
				slot0:SelectHero(slot0.heroIdList_[1])

				slot4 = slot0.heroIdList_[1]
			end

			if not (slot4 ~= slot0.curHeroId_ and true or false) then
				manager.audio:PlayUIAudioByVoice("hero_change")
			end
		end
	end

	slot6 = slot0.completeScrollHelper_
	slot8 = slot6

	for slot7, slot8 in pairs(slot6.GetItemList(slot8)) do
		slot8:ShowFavorability(slot3 == 2)
	end
end

function slot0.ShortHeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetProxy(slot0.heroViewProxy_)
	slot2:SetHeroId(slot3, slot0.type_, slot0.tempHeroList_)
	slot2:SetRedPointEnable(slot0.heroViewProxy_.showHeroHeadRedPoint)
	slot2:SetSelected(slot2.heroId_ == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function slot0.LongHeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetProxy(slot0.heroViewProxy_)
	slot2:SetHeroId(slot3, slot0.type_, slot0.tempHeroList_)
	slot2:SetRedPointEnable(slot0.heroViewProxy_.showHeroHeadRedPoint)
	slot2:SetSelected(slot2.heroId_ == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function slot0.GetCurHeroInfo(slot0, slot1)
	return slot0.heroViewProxy_:GetHeroData(slot1)
end

function slot0.SelectHero(slot0, slot1)
	slot0.changeHero = slot1 ~= slot0.curHeroId_ and true or false
	slot0.curHeroId_ = slot1
	slot0.curHeroInfo_ = slot0:GetCurHeroInfo(slot0.curHeroId_)

	HeroAction.UpdateModuleRedPointByHeroID(slot0.curHeroId_)
	AstrolabeAction.UpdateHeroAstrolabeCanUnLockRed(slot0.curHeroInfo_.id)

	slot6 = slot0.curScrollHelper_

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetSelected(slot6.heroId_ == slot1)
	end

	if slot0.curHeroInfo_.unlock == 0 then
		if slot0.curPageIndex_ == slot0.pageIndexS_.chip then
			slot0.toggles_[1].isOn = true
		end

		slot0:SwitchPage(1)
	elseif slot0.dirty_ then
		if slot0.params_.pageIndex then
			slot0:SwitchPage(slot0.params_.pageIndex)

			slot0.params_.pageIndex = nil
		else
			slot0:SwitchPage(_G.heroViewPageIndex_ or 1)
		end

		slot0.dirty_ = false
	else
		slot0:SwitchPage(slot0.curPageIndex_)
	end

	slot0:UpdateHeroView()

	if slot0.curHeroInfo_.unlock == 1 and slot0.mainPageController_:GetSelectedState() == "detail" then
		slot0.toggles_[slot0.curPageIndex_].isOn = true
	end

	slot0.params_.hid = slot1

	slot0.pages_[slot0.curPageIndex_]:PlayEnterAni()

	slot2 = slot0.mainPageController_:GetSelectedState()

	if slot0.curPageIndex_ == slot0.pageIndexS_.chip then
		if slot0.mainPageController_:GetSelectedState() == "list" then
			if ChipData:GetHeroIsHaveChip(slot0.curHeroId_) == false then
				slot0.isChangePageAndBack_ = true
			else
				slot0.isChangePageAndBack_ = false
			end
		elseif ChipData:GetHeroIsHaveChip(slot0.curHeroId_) == false then
			slot0:SwitchPage(1)

			slot0.toggles_[slot0.curPageIndex_].isOn = true
		end
	end

	if slot2 == "detail" and (slot0.curPageIndex_ == slot0.pageIndexS_.equip or slot0.curPageIndex_ == slot0.pageIndexS_.weapon or slot0.curPageIndex_ == slot0.pageIndexS_.transition) then
		manager.audio:PlayEffect("ui_system", "page", "")
	elseif slot2 == "detail" and slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	if (slot0.changeHero or slot0.isEnter) and slot0.curPageIndex_ == 1 and not slot0.params_.isBack then
		HeroTools.StopTalk()
		manager.heroRaiseTrack:PlayTalk()
	end

	slot0.changeHero = false

	SetActive(slot0.toggle7_.gameObject, ChipData:GetHeroIsHaveChip(slot0.curHeroId_) and not slot0.heroViewProxy_.hideChipToggle)
end

function slot0.SwitchToDetail(slot0)
	if slot0.heroIdList_ and #slot0.heroIdList_ <= 0 then
		slot0.filterView_:RefreshSort(true)
		slot0.filterView_:Reset()
	end

	slot0.pageType_ = "detail"
	slot0.curScrollHelper_ = slot0.shortScrollHelper_

	slot0.mainPageController_:SetSelectedState(slot0.pageType_)

	if table.indexof(slot0.heroIdList_, slot0.curHeroId_) then
		slot0.shortScrollHelper_:StartScroll(#slot0.heroIdList_, slot1)
	end

	if slot0.pages_[1] then
		slot0.pages_[1]:SwichToDetail()
	end

	if slot0.isChangePageAndBack_ then
		slot0.isChangePageAndBack_ = false

		slot0:SwitchPage(1)

		slot0.toggles_[slot0.curPageIndex_].isOn = true
	end
end

function slot0.AddUIListener(slot0)
	slot4 = slot0.allHeroBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		uv0:SwitchPage(1)
		uv0.pages_[1]:SwichToAll(uv0, uv0.SwitchToDetail)

		uv0.toggles_[1].isOn = true
		uv0.pageType_ = "list"
		uv0.curScrollHelper_ = uv0.completeScrollHelper_

		uv0.mainPageController_:SetSelectedState(uv0.pageType_)

		if table.indexof(uv0.heroIdList_, uv0.curHeroId_) then
			uv0.completeScrollHelper_:StartScroll(#uv0.heroIdList_, slot0)
		end
	end)

	for slot4, slot5 in pairs(slot0.toggles_) do
		slot5.onValueChanged:AddListener(function (slot0)
			if slot0 then
				uv0:SwitchPage(uv1)

				if uv1 == 1 then
					OperationRecorder.Record("hero", "propertyPage")
				elseif uv1 == 2 then
					OperationRecorder.Record("hero", "skillPage")
				elseif uv1 == 3 then
					OperationRecorder.Record("hero", "weaponPage")
				elseif uv1 == 4 then
					OperationRecorder.Record("hero", "equipPage")
				elseif uv1 == 5 then
					OperationRecorder.Record("hero", "transition")
				elseif uv1 == 6 then
					OperationRecorder.Record("hero", "astroPage")
				elseif uv1 == 7 then
					OperationRecorder.Record("hero", "chipPage")
				end
			end
		end)
	end

	slot0:AddBtnListener(slot0.cultureGravureBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("hero_teach_" .. uv0.sdkTeach_[uv0.curPageIndex_])
		JumpTools.OpenPageByJump("/cultureGravureView", {
			selectIndex = 1,
			heroID = uv0.curHeroInfo_.id
		})
	end)
end

function slot0.SwitchPage(slot0, slot1)
	slot2 = true
	slot3 = ""
	slot2, slot3 = slot0:CheckConditionByType(slot0.viewType_[slot1])

	if slot0.heroViewProxy_.unlockToggle then
		slot2 = true
	end

	if not slot2 then
		ShowTips(slot3)

		slot0.toggles_[slot0.curPageIndex_].isOn = true

		return
	end

	if slot0.curPageIndex_ == slot1 and not slot0.changeHero then
		slot0.pages_[slot0.curPageIndex_]:SetHeroInfo(slot0.curHeroInfo_)
		slot0.pages_[slot0.curPageIndex_]:UpdateView()
		slot0.pages_[slot0.curPageIndex_]:CameraEnter()

		return
	end

	if slot0.pages_[slot0.curPageIndex_] then
		slot4:Hide()
	end

	slot5 = slot0.curPageIndex_
	slot0.curPageIndex_ = slot1
	_G.heroViewPageIndex_ = slot1

	if not slot0.pages_[slot1] then
		slot6 = slot0.heroViewProxy_:GetUIClassByType(slot0.curPageIndex_)

		if slot0.heroViewProxy_:GetUIPrefabByType(slot0.curPageIndex_) and slot6 then
			slot0.pages_[slot1] = slot6.New(slot0, Object.Instantiate(Asset.Load(slot7), slot0.pageContainer_))
		end
	end

	if slot0.isEnter then
		slot0:CheckPageEnter(slot0.curPageIndex_)
	end

	slot0.pages_[slot0.curPageIndex_]:SetHeroInfo(slot0.curHeroInfo_)

	if slot0.pages_[slot0.curPageIndex_].HideMaskMessage then
		slot0.pages_[slot0.curPageIndex_]:HideMaskMessage()
	end

	slot0.pages_[slot0.curPageIndex_]:Show()
	slot0.pages_[slot0.curPageIndex_]:CameraEnter()

	if slot0.mainPageController_:GetSelectedState() == "list" or slot0.curHeroInfo_.unlock == 0 then
		for slot9, slot10 in ipairs(slot0.toggles_) do
			slot10.isOn = slot9 == slot0.curPageIndex_
		end
	end

	if slot0.curPageIndex_ == slot0.pageIndexS_.equip then
		manager.audio:PlayEffect("ui_system", "equip_appear", "")
	elseif slot0.curPageIndex_ == slot0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	slot0:RecordStay(slot5)
end

function slot0.UpdateAvatarView(slot0)
	manager.heroRaiseTrack:SetModelState(slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot0.curHeroId_).id)
end

function slot0.CheckPageEnter(slot0, slot1)
	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter(slot0.heroViewProxy_, slot0.params_)

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.UpdateHeroView(slot0)
	slot0:UpdateAvatarView()
	slot0.lockController_:SetSelectedState(slot0.curHeroInfo_.unlock == 0 and "true" or "false")
	slot0.strategyRedController_:SetSelectedState(tostring(HeroData:GetHeroStrategyRedPoint(slot0.curHeroId_) and slot0.curHeroInfo_.unlock > 0))
	SetActive(slot0.cultureGravureBtn_.gameObject, not slot0.heroViewProxy_.hideCultureGrvureBtn and slot0.curHeroInfo_.unlock > 0)

	slot1 = HeroCfg[slot0.curHeroId_].study_stage[1]

	if slot0.heroViewProxy_.showRedPoint then
		manager.redPoint:bindUIandKey(slot0.toggle1_.transform, RedPointConst.HERO_PROPERTY_PAGE .. slot0.curHeroInfo_.id)
		manager.redPoint:bindUIandKey(slot0.toggle3_.transform, RedPointConst.HERO_WEAPON .. slot0.curHeroInfo_.id)
		manager.redPoint:bindUIandKey(slot0.toggle6_.transform, RedPointConst.ASTROLABE_UNLOCK)
	end
end

function slot0.OnTop(slot0)
	slot0.curHeroInfo_ = slot0:GetCurHeroInfo(slot0.curHeroId_)

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:OnTop()
		end
	end

	if slot0.heroViewProxy_.showInfoWindowBar then
		table.insert({
			BACK_BAR,
			HOME_BAR
		}, INFO_BAR)
	end

	if slot0.heroViewProxy_.showCurrencyWindowBar then
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_VITALITY)
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_GOLD)
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_DIAMOND)
		manager.windowBar:SwitchBar(slot1)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	else
		manager.windowBar:SwitchBar(slot1)
	end

	if slot0.heroViewProxy_.showInfoWindowBar then
		slot2 = SettingData:GetCurrentLanguageKey()

		ChipAction.UpdateHeroChipRedPoint()
		HeroAction.UpdateModuleRedPointByHeroID(slot0.curHeroId_)

		slot3 = GameSetting.hero_view_describe and GameSetting.hero_view_describe.value or {}

		manager.windowBar:RegistInfoCallBack(function ()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = uv0
			})
		end)
	end

	manager.windowBar:RegistBackCallBack(function ()
		if uv0.mainPageController_:GetSelectedState() == "list" then
			uv0:SwitchToDetail()
		else
			JumpTools:Back()
		end
	end)

	if manager.windowBar:GetWhereTag() ~= "guildActivity" and slot2 ~= "chess" and slot2 ~= "newchess" then
		manager.windowBar:RegistHomeCallBack(function ()
			gameContext:Go("/home", nil, , true)
		end)
	end

	if slot0.params_.nextJump ~= nil then
		slot0:HandleNextJump(slot0.params_.nextJump)

		slot0.params_.nextJump = nil
	end
end

function slot0.OnEnter(slot0)
	slot0.type_ = slot0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.tempHeroList_ = slot0.params_.tempHeroList
	slot0.heroViewProxy_ = HeroViewDataProxy.New(slot0.type_)
	slot0.isEnter = slot0.params_.isEnter

	if slot0.params_.isSkillReturn then
		slot0.leftAnimator_:Update(0)
	end

	if slot0.tempHeroList_ then
		slot0.heroViewProxy_:SetTempHeroList(slot0.tempHeroList_)
	end

	slot0.enteredPage_ = {}

	if slot0.params_.pageIndex or slot0.params_.isEnter then
		slot0.dirty_ = true
	end

	slot0.heroIdList_ = slot0.heroViewProxy_:GetHeroIDList()

	if (slot0.dirty_ or slot0.guidePlaying) and slot0.filterView_ then
		slot0.filterView_:Reset()
	end

	slot0.filterView_:OnEnter(slot0.heroViewProxy_)
	slot0.filterView_:SetExtraSorter(slot0.heroViewProxy_:GetExFilterSorterFunc())

	if (slot0.type_ == HeroConst.HERO_DATA_TYPE.TRIAL or slot0.type_ == HeroConst.HERO_DATA_TYPE.CUSTOM) and slot0.params_.hid and table.indexof(slot0.tempHeroList_, slot0.params_.hid) then
		slot0.params_.hid = SkinCfg[HeroStandardSystemCfg[slot1].hero_id].hero
	end

	slot1 = 1

	for slot5, slot6 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot5)
	end

	for slot6, slot7 in ipairs(slot0.heroIdList_) do
		-- Nothing
	end

	slot0.filterView_:SetHeroIdList({
		[slot6] = {
			id = slot7,
			trialID = slot0.heroViewProxy_:GetHeroData(slot7).tempID or 0,
			type = slot0.type_,
			heroViewProxy = slot0.heroViewProxy_
		}
	})
	slot0:RegistEventListener(HERO_DATA_MODIFY, handler(slot0, slot0.OnHeroUpdate))
	slot0:RegistEventListener(HERO_PIECE_MODIFY, handler(slot0, slot0.OnHeroUpdate))
	slot0:RegistEventListener(HERO_UNLOCK_SUCCESS, handler(slot0, slot0.OnHeroUnlock))

	slot6 = FAVORITE_HERO

	slot0:RegistEventListener(slot6, handler(slot0, slot0.OnHeroFavorite))

	for slot6 = 1, #slot0.heroIdList_ do
		if slot0.curHeroId_ == slot0.heroIdList_[slot6] then
			slot1 = slot6

			break
		end
	end

	slot0:SwitchToDetail()

	if slot0.heroIdList_ and #slot0.heroIdList_ <= 0 then
		slot0.filterView_:RefreshSort(true)
		slot0.filterView_:Reset()
	end

	slot0.shortScrollHelper_:StartScroll(#slot0.heroIdList_, slot1)
	slot0:CheckLocked()

	slot0.params_.isBack = false
end

function slot0.OnHeroFavorite(slot0)
	slot0.curScrollHelper_:Refresh()
end

function slot0.CheckLocked(slot0)
	SetActive(slot0.toggle5_.gameObject, not slot0.heroViewProxy_.hideTransitionToggle)
	SetActive(slot0.allHeroBtn_.gameObject, not slot0.heroViewProxy_.hideFilterBtn)

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_CHIP) then
		slot0.chipToggleController_:SetSelectedState("true")
	else
		slot0.chipToggleController_:SetSelectedState("false")
		manager.redPoint:bindUIandKey(slot0.toggle7_.transform, RedPointConst.CHIP_HERO_CHIP .. "_" .. slot0.curHeroId_)
	end

	slot0.astroToggleController_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) and not slot0.heroViewProxy_.unlockToggle and "true" or "false")
	slot0.trasitionToggleController_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION) and not slot0.heroViewProxy_.unlockToggle and "true" or "false")
end

function slot0.OnHeroUnlock(slot0, slot1)
	if slot1 == slot0.curHeroId_ then
		HeroTools.StopTalk()

		slot0.curHeroInfo_ = slot0.heroViewProxy_:GetHeroData(slot0.curHeroInfo_.id)

		slot0.filterView_:UpdateList()
		slot0.curScrollHelper_:Refresh()

		slot0.curPageIndex_ = 1

		slot0:UpdateHeroView()
		slot0:SwitchPage(slot0.curPageIndex_)
	end
end

function slot0.OnServantLock(slot0, slot1, slot2)
	slot0.pages_[3]:OnServantLock(slot1, slot2)
end

function slot0.OnHeroSkillUpgrade(slot0, slot1, slot2)
	if isSuccess(slot1.result) and slot2.hero_id == slot0.curHeroId_ and slot0.pages_[slot0.pageIndexS_.skill] and slot0.curPageIndex_ == slot0.pageIndexS_.skill then
		slot0.pages_[slot0.pageIndexS_.skill]:OnHeroSkillUpgrade(slot1, slot2)
	end
end

function slot0.OnHeroStarUp(slot0, slot1, slot2)
	if isSuccess(slot1.result) and slot2.id == slot0.curHeroId_ and slot0.pages_[slot0.pageIndexS_.star] and slot0.curPageIndex_ == slot0.pageIndexS_.star then
		slot0.pages_[slot0.pageIndexS_.star]:OnHeroStarUp(slot1, slot2)
	end
end

function slot0.OnHeroUpdate(slot0, slot1)
	slot4 = slot0.shortScrollHelper_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		if slot6.heroId_ == slot1 then
			slot6:SetHeroData(slot1, slot6.heroDataType_)
		end
	end

	slot4 = slot0.completeScrollHelper_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		if slot6.heroId_ == slot1 then
			slot6:SetHeroData(slot1, slot6.heroDataType_)
		end
	end

	if slot1 == slot0.curHeroId_ then
		slot0:UpdateHeroView()
	end
end

function slot0.CheckConditionByType(slot0, slot1)
	if not table.keyof(ViewConst.SYSTEM_ID, slot1) then
		return true, ""
	end

	if not JumpTools.IsSystemLocked(slot1) then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(slot1, slot2)
	end
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.dirty_ = true
	_G.heroViewPageIndex_ = 1
end

function slot0.GetPopContainer(slot0)
	return slot0.pageContainerPop_
end

function slot0.OnExit(slot0)
	if slot0.type_ == HeroConst.HERO_DATA_TYPE.COOPERATION then
		slot0.dirty_ = true
	end

	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if #slot0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()

		if slot0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			slot0:InitConfig()
		end
	end

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:OnExit()
		end
	end

	slot0.filterView_:OnExit()
	manager.redPoint:unbindUIandKey(slot0.toggle1_.transform)
	manager.redPoint:unbindUIandKey(slot0.toggle3_.transform)
	manager.redPoint:unbindUIandKey(slot0.toggle6_.transform)
	manager.redPoint:unbindUIandKey(slot0.toggle5_.transform)
	manager.redPoint:unbindUIandKey(slot0.toggle7_.transform)
	slot0:RecordStay(slot0.curPageIndex_)

	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end

	HeroTools.StopTalk()
end

function slot0.Dispose(slot0)
	slot0.mainPageController_:RemoveAllListeners()
	slot0:RemoveAllListeners()

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	if slot0.shortScrollHelper_ then
		slot0.shortScrollHelper_:Dispose()

		slot0.shortScrollHelper_ = nil
	end

	if slot0.completeScrollHelper_ then
		slot0.completeScrollHelper_:Dispose()

		slot0.completeScrollHelper_ = nil
	end

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:Dispose()
		end

		slot0.pages_ = nil
	end

	if slot0.toggles_ then
		for slot4, slot5 in pairs(slot0.toggles_) do
			slot5.onValueChanged:RemoveAllListeners()
		end

		slot0.toggles_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == slot0.pageIndexS_.property then
		slot3 = 20101
	elseif slot1 == slot0.pageIndexS_.skill then
		slot3 = 20102
	elseif slot1 == slot0.pageIndexS_.weapon then
		slot3 = 20103
	elseif slot1 == slot0.pageIndexS_.equip then
		slot3 = 20104
	elseif slot1 == slot0.pageIndexS_.astrolabe then
		slot3 = 20105
	end

	OperationRecorder.RecordStayView("STAY_VIEW_HERO", slot2, slot0.curHeroId_, slot3)
	slot0:UpdateLastOpenTime()
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
end

function slot0.HandleNextJump(slot0, slot1)
	if slot1[1] == 231 then
		for slot5, slot6 in ipairs(slot0.heroIdList_) do
			if #HeroRecordCfg[HeroTools.GetHeroOntologyID(slot6)].plot_id > 0 then
				table.insert(slot1, slot6)
				slot0:SelectHero(slot6)
				JumpTools.JumpToPage2(slot1)

				return
			end
		end
	else
		table.insert(slot1, slot0.curHeroId_)
		JumpTools.JumpToPage2(slot1)

		return
	end
end

return slot0
