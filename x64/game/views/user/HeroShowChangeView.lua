slot0 = class("HeroShowChangeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/UserInfor/HeroShowChangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, HeroLongHead)
	slot0.filterView_ = NewHeroListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))

	slot0.emptyController_ = ControllerUtil.GetController(slot0.uiListGo_.transform, "empty")
	slot0.showController_ = slot0.controller_:GetController("show")
	slot0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function slot0.OnListChange(slot0, slot1)
	slot0.heroIdList_ = slot1

	slot0.heroHeadList_:StartScroll(#slot0.heroIdList_)

	if #slot0.heroIdList_ > 0 then
		slot0.emptyController_:SetSelectedState("false")
		slot0:SelectHero(slot0.heroIdList_[1])
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		uv0:Go("/newHero", {
			isEnter = true,
			hid = uv0.curHeroId_,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT
		})
	end)
	slot0:AddBtnListener(slot0.showBtn_, nil, function ()
		uv0:SetHeroShowList(uv0.lastHeroID_, uv0.curHeroId_)
		uv0:Back()
		SendMessageManagerToSDK("changePosterGirl")
	end)
	slot0:AddBtnListener(slot0.unshowBtn_, nil, function ()
		uv0:SetHeroShowList(uv0.curHeroId_, nil)
		uv0:Back()
		SendMessageManagerToSDK("changePosterGirl")
	end)
end

function slot0.OnChangePosterGirl(slot0, slot1, slot2)
	if slot0.params_.lastView == "home" then
		JumpTools.OpenPageByJump("/home", {
			changePoster = true
		})
	else
		slot0:Back()
	end
end

function slot0.HeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetProxy(slot0.heroViewProxy_)
	slot2:SetHeroId(slot3, slot0.type_)
	slot2:SetRedPointEnable(slot0.heroViewProxy_.showHeroHeadRedPoint)
	slot2:SetSelected(slot2.heroId_ == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
	slot2:SetLable(slot0:CheckHeroIsShow(slot3) and GetTips("IS_IN_SHOW") or nil)
end

function slot0.SelectHero(slot0, slot1)
	slot0.curHeroId_ = slot1
	slot0.curHeroInfo_ = HeroData:GetHeroList()[slot0.curHeroId_]
	slot0.heroCfg_ = HeroCfg[slot1]
	slot4 = slot0.heroHeadList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetSelected(slot6.heroId_ == slot1)
	end

	slot0.showController_:SetSelectedState(tostring(slot0:CheckHeroIsShow(slot1)))
	slot0:UpdateHeroView()
	slot0:UpdateAvatarView()
end

function slot0.UpdateHeroView(slot0)
	slot0.nameText_.text = GetI18NText(slot0.heroCfg_.name)
	slot0.subNameText_.text = GetI18NText(slot0.heroCfg_.suffix)
	slot0.fightPowerText_.text = getBattlePower(HeroData:GetHeroData(slot0.curHeroId_))
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.UpdateAvatarView(slot0)
	manager.heroRaiseTrack:SetModelState(slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot0.curHeroId_).id)
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	}, false)
	manager.heroRaiseTrack:SetAstrolableAtive(false)
end

function slot0.OnEnter(slot0)
	slot0.filterView_:OnEnter(slot0.heroViewProxy_)
	slot0.filterView_:SetHeroIdList(HeroTools.Sort(HeroData:GetHeroList()))
	slot0.filterView_:SetExtraSorter(function (slot0, slot1)
		if uv0:CheckHeroIsShow(slot0.id) ~= uv0:CheckHeroIsShow(slot1.id) then
			return true, slot2 and not slot3
		end

		return false, false
	end)
	slot0:UpdateBar()

	slot0.lastHeroID_ = slot0.params_.heroID
	slot2 = 1

	if slot0.params_.index then
		slot2 = slot0.params_.index
	end

	slot0.filterView_:SetHeroIdList(slot0.heroIdList_, slot0.type_)
	slot0:SelectHero(slot0.heroIdList_[slot2])
	slot0.heroHeadList_:StartScroll(#slot0.heroIdList_, slot2)
end

function slot0.CheckHeroIsShow(slot0, slot1)
	for slot6, slot7 in pairs(PlayerData:GetHeroShowList()) do
		if slot7 == slot1 then
			return true
		end
	end

	return false
end

function slot0.OnMainHomeViewTop(slot0)
	if slot0.filterView_ then
		slot0.filterView_:Reset()
	end

	slot0.pos_ = nil
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
end

function slot0.OnExit(slot0)
	if slot0.filterView_ and slot0.filterView_.OnExit then
		slot0.filterView_:OnExit()
	end

	manager.windowBar:HideBar()

	if #slot0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end

	slot0.params_.index = table.keyof(slot0.heroIdList_, slot0.curHeroId_)
	slot0.pos_ = slot0.heroHeadList_:GetScrolledPosition()
end

function OnCameraEnter()
end

function slot0.Dispose(slot0)
	if slot0.heroHeadList_ then
		slot0.heroHeadList_:Dispose()

		slot0.heroHeadList_ = nil
	end

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.SetHeroShowList(slot0, slot1, slot2)
	if slot1 == nil and slot2 == nil then
		return
	end

	slot3 = PlayerData:GetHeroShowList()

	if slot1 == nil then
		for slot7 = 1, #slot3 do
			if slot3[slot7] == slot2 then
				table.remove(slot3, slot7)
			end
		end

		table.insert(slot3, slot2)
	elseif slot2 == nil then
		for slot7 = 1, #slot3 do
			if slot3[slot7] == slot1 then
				table.remove(slot3, slot7)

				break
			end
		end
	else
		slot4 = 0

		for slot8 = 1, #slot3 do
			if slot3[slot8] == slot2 then
				slot4 = slot8
			end
		end

		for slot8 = 1, #slot3 do
			if slot3[slot8] == slot1 then
				if slot4 == 0 then
					slot3[slot8] = slot2
				else
					slot3[slot4] = slot3[slot8]
					slot3[slot8] = slot3[slot4]
				end
			end
		end
	end

	PlayerAction.ChangeHeros(slot3)
end

return slot0
