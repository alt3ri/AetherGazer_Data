slot0 = class("HeroPreviewChangeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/CharacterGuideUI/CharacterPreviewUI"
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

	slot0.heroInfoView_ = HeroPreviewInfoView.New(slot0.heroInfoGo_)
	slot0.emptyController_ = ControllerUtil.GetController(slot0.uiListGo_.transform, "empty")
	slot0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.PREVIEW)
end

function slot0.OnListChange(slot0, slot1)
	slot0.heroIdList_ = slot1

	slot0.heroHeadList_:StartScroll(#slot1)

	if #slot0.heroIdList_ > 0 then
		slot0.emptyController_:SetSelectedState("false")
		slot0:SelectHero(slot0.heroIdList_[1])
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		uv0:Go("/heroPreviewMain", {
			isEnter = true,
			hid = uv0.curHeroId_
		})
	end)
end

function slot0.HeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetProxy(slot0.heroViewProxy_)
	slot2:SetHeroId(slot3, slot0.type_)
	slot2:SetRedPointEnable(slot0.heroViewProxy_.showHeroHeadRedPoint)
	slot2:SetSelected(slot2.heroId_ == slot0.curHeroId_)
	slot2:SetRareIcon(HeroCfg[slot3].rare)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
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

	slot0.heroInfoView_:SetHeroInfo(slot0.curHeroInfo_)
	slot0:UpdateHeroView()
	slot0:UpdateAvatarView()
end

function slot0.UpdateHeroView(slot0)
end

function slot0.UpdateAvatarView(slot0)
	manager.heroRaiseTrack:SetModelState(slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot0.curHeroId_).id)
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	}, slot0.displayGo_)
	manager.heroRaiseTrack:SetAstrolableAtive(false)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.filterView_:OnEnter(slot0.heroViewProxy_)
	slot0.filterView_:SetHeroIdList(HeroTools.Sort(HeroData:GetHeroList(), true))

	slot2 = 1

	if slot0.params_.index then
		slot2 = slot0.params_.index
	else
		for slot6, slot7 in ipairs(slot0.heroIdList_) do
			if slot7 == slot0.curHeroId_ then
				slot2 = slot6

				break
			end
		end
	end

	slot0:SelectHero(slot0.heroIdList_[slot2])
	slot0.heroHeadList_:StartScroll(#slot0.heroIdList_, slot2)
end

function slot0.OnMainHomeViewTop(slot0)
	if slot0.filterView_ then
		slot0.filterView_:Reset()
	end

	slot0.pos_ = nil
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if #slot0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end

	slot0.params_.index = table.keyof(slot0.heroIdList_, slot0.curHeroId_)
	slot0.pos_ = slot0.heroHeadList_:GetScrolledPosition()

	slot0.heroInfoView_:OnExit()
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

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:Dispose()

		slot0.heroInfoView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
