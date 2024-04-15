slot0 = class("HeroPropertyPage", HeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController_ = slot0.controller_:GetController("lock")
	slot0.favoriteController_ = slot0.favorBtnController_:GetController("follow")
	slot0.favoriteShowController_ = slot0.favorBtnController_:GetController("favor")
	slot0.detailController_ = slot0.heroInfoController_:GetController("detail")
	slot0.heroInfoView_ = HeroInfoView.New(slot0, slot0.infoViewGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.archiveBtn_, nil, function ()
		uv0:Go("/heroArchive", {
			pageID = 1,
			heroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.storyBtn_, nil, function ()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = HeroRecordCfg.get_id_list_by_hero_id[uv0.heroInfo_.id][1]
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 1,
			record_id = HeroRecordCfg.get_id_list_by_hero_id[uv0.heroInfo_.id][1]
		})
	end)
	slot0:AddBtnListener(slot0.favoriteBtn_, nil, function ()
		if HeroData:IsFavorite(uv0.heroInfo_.id) then
			HeroAction.SetFavoriteHeroOff(uv0.heroInfo_.id)
		else
			HeroAction.SetFavoriteHeroOn(uv0.heroInfo_.id)
		end
	end)
	slot0:AddBtnListener(slot0.skinBtn_, nil, function ()
		uv0:Go("/heroSkin", {
			heroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.heroDisplayBtn_, nil, function ()
		JumpTools.OpenPageByJump("/heroDisplay", {
			heroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		uv0.detailController_:SetSelectedState("true")

		if uv0.callback_ then
			uv0.callback_(uv0.detailHandler_)
		end
	end)
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1
	slot0.unlockDirty_ = true

	if slot0.heroInfo_ == nil then
		slot0.unlockDirty_ = false
	elseif slot2.unlock == 1 and slot1.unlock == 1 then
		slot0.unlockDirty_ = false
	elseif slot2.unlock == 0 and slot1.unlock == 0 and slot2 == slot1 then
		slot0.unlockDirty_ = false
	end

	slot0.heroInfoView_:SetHeroInfo(slot0.heroInfo_)

	if slot0.unlockDirty_ then
		slot0.animator_:Play("Fx_HeroArrtUI_right_cx", 0, 0)
	end
end

function slot0.RefreshFavorite(slot0)
	slot0.favoriteShowController_:SetSelectedState(tostring(slot0.heroViewProxy_.showfavorBtn and slot0.heroInfo_.unlock == 1))
	slot0.favoriteController_:SetSelectedState(HeroData:IsFavorite(slot0.heroInfo_.id) == false and "false" or "true")
end

function slot0.OnHeroFavorite(slot0)
	slot0:RefreshFavorite()
end

function slot0.UpdateView(slot0)
	slot0.archiveID_ = HeroTools.GetHeroOntologyID(slot0.heroInfo_.id)

	if #HeroRecordCfg[slot0.archiveID_].plot_id > 0 then
		slot0.storyBtn_.gameObject:SetActive(true)
	else
		slot0.storyBtn_.gameObject:SetActive(false)
	end

	manager.redPoint:bindUIandKey(slot0.archiveBtn_.transform, RedPointConst.HERO_ARCHIVE_ID .. slot0.heroInfo_.id, {
		x = 40,
		y = 40
	})
	manager.redPoint:bindUIandKey(slot0.storyBtn_.transform, RedPointConst.HERO_HEART_STORY_ROOT_ID .. HeroTools.GetHeroOntologyID(slot0.heroInfo_.id), {
		x = 40,
		y = 40
	})
	manager.redPoint:bindUIandKey(slot0.skinBtn_.transform, RedPointConst.HERO_SKIN_ID .. slot0.heroInfo_.id, {
		x = 40,
		y = 40
	})
	slot0.heroInfoView_:UpdateView(slot0.heroInfo_)
	slot0:RefreshFavorite()
	slot0:CheckLocked()
end

function slot0.CheckLocked(slot0)
	slot0.lockController_:SetSelectedState(tostring(not (slot0.heroInfo_.unlock ~= 0 and slot0.heroViewProxy_.isSelf)))
end

function slot0.Show(slot0)
	uv0.super.Show(slot0)
	slot0:UpdateView()
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0
	}, slot0.displayGo_)
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:OnEnter(slot1)
	end

	slot0:RegistEventListener(HERO_DATA_MODIFY, handler(slot0, slot0.OnHeroModify))
	slot0:RegistEventListener(FAVORITE_HERO, handler(slot0, slot0.OnHeroFavorite))
end

function slot0.SwichToAll(slot0, slot1, slot2)
	slot0.detailController_:SetSelectedState("false")

	slot0.callback_ = slot2
	slot0.detailHandler_ = slot1
end

function slot0.SwichToDetail(slot0)
	slot0.detailController_:SetSelectedState("true")
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:OnExit()
	end

	manager.redPoint:unbindUIandKey(slot0.archiveBtn_.transform)
	manager.redPoint:unbindUIandKey(slot0.storyBtn_.transform)
	manager.redPoint:unbindUIandKey(slot0.skinBtn_.transform)
end

function slot0.OnHeroModify(slot0, slot1)
	if slot1 == slot0.heroInfo_.id then
		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:Dispose()

		slot0.heroInfoView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
