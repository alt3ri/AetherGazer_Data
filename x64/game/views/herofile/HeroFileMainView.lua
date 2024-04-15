slot0 = class("HeroFileMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_files/HeroFileMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.curHeroID_ = 0
	slot0.curRecordID_ = 0
	slot0.roleIndex_ = 0
	slot0.roleTabs_ = {}
	slot0.roleList_ = {}
	slot0.curPageIndex_ = 0
	slot0.subPages_ = {}
	slot0.subPageIndex_ = {
		Archive = 2,
		Information = 1,
		Voice = 4,
		Gift = 3
	}
	slot0.subPagePrefabPath_ = {
		"Widget/System/Hero_files/HeroFileInformationPageUI",
		"Widget/System/Hero_files/HeroFileArchivePageUI",
		"Widget/System/Hero_files/HeroFileGiftPageUI",
		"Widget/System/Hero_files/HeroFileVoicePageUI"
	}
	slot0.subPageClass_ = {
		HeroFileInformationPage,
		HeroFileArchivePage,
		HeroFileGiftPage,
		HeroFileVoicePage
	}
	slot0.subPageTab_ = {
		slot0.informationBtn_,
		slot0.archiveBtn_,
		slot0.giftBtn_,
		slot0.voiceBtn_
	}
	slot0.subPageTabState_ = {
		"Information",
		"Archive",
		"Gift",
		"Voice"
	}
	slot0.tipsLuaUIlist_ = LuaList.New(handler(slot0, slot0.IndexTipsItem), slot0.tipsUIlist_, HeroFileMainTipsItem)
	slot0.subPageTabController_ = slot0.tablistControllerEx_:GetController("tabSelect")
	slot0.favorabilityController_ = slot0.FavorabilityControllerEx_:GetController("favorability")
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.subPageTab_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:SwitchPage(uv1)
		end)
	end

	slot0:AddBtnListener(slot0.FavorabilityBtn_, nil, function ()
		uv0:ShowFavorabilityTips()
	end)
	slot0:AddBtnListener(slot0.tipsCloseBtn_, nil, function ()
		uv0:HideFavorabilityTips()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.curHeroID_ = slot0.params_.heroID
	slot0.curRecordID_ = HeroTools.GetHeroOntologyID(slot0.curHeroID_)
	slot0.curPageIndex_ = 0

	slot0:RefreshRoleTab()
	slot0:UpdateAvatarView()
	slot0:RefreshCV()
	slot0:SwitchPage(slot0.params_.pageID or 1)
	slot0:RefreshFavorabilityIcon()
	ArchiveAction.CheckHeroTrustUpLvRedPoint(slot0.curHeroID_)
	manager.redPoint:bindUIandKey(slot0.informationTrs_, string.format("%s_%s", RedPointConst.HERO_REALTION, slot0.curHeroID_))
	manager.redPoint:bindUIandKey(slot0.archiveTrs_, RedPointConst.HERO_HEARTLINK_ID .. slot0.curRecordID_)
	manager.redPoint:bindUIandKey(slot0.giftTrs_, string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, slot0.curHeroID_))
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0:HideFavorabilityTips()
	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.informationTrs_)
	manager.redPoint:unbindUIandKey(slot0.archiveTrs_)
	manager.redPoint:unbindUIandKey(slot0.giftTrs_)

	if slot0.subPages_[slot0.curPageIndex_] then
		slot0.subPages_[slot0.curPageIndex_]:Hide()
	end

	slot0.curPageIndex_ = 0
	slot0.params_.heroID = slot0.curHeroID_

	HeroTools.StopTalk()
end

function slot0.IndexTipsItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.curHeroID_)
end

function slot0.SwitchPage(slot0, slot1)
	if slot1 == slot0.subPageIndex_.Voice and not HeroTools.GetHeroIsUnlock(slot0.curHeroID_) then
		ShowTips("ERROR_HERO_NOT_UNLOCK")

		return
	end

	if slot1 == slot0.curPageIndex_ then
		return
	end

	if slot0.subPages_[slot0.curPageIndex_] then
		slot0.subPages_[slot0.curPageIndex_]:Hide()
	end

	slot0.subPageTabController_:SetSelectedState(slot0.subPageTabState_[slot1])

	if not slot0.subPages_[slot1] then
		slot0.subPages_[slot1] = slot0.subPageClass_[slot1].New(Object.Instantiate(Asset.Load(slot0.subPagePrefabPath_[slot1]), slot0.pagecontentTrs_), function (slot0)
			uv0:RefreshFavorabilityIcon(slot0)
		end)
	end

	slot0.subPages_[slot1]:Show(slot0.curRecordID_, slot0.curHeroID_)

	slot0.curPageIndex_ = slot1
	slot0.params_.pageID = slot1
end

function slot0.RefreshFavorabilityIcon(slot0, slot1)
	if slot1 then
		slot0.likeLvText_.text = ({
			"Ⅰ",
			"Ⅱ",
			"Ⅲ",
			"Ⅳ",
			"Ⅴ",
			"Ⅵ",
			"Ⅶ",
			"Ⅷ",
			"Ⅸ"
		})[slot1]
	elseif ArchiveData:GetTrustLevel(slot0.curHeroID_) > 0 then
		slot0.favorabilityController_:SetSelectedState("Trust")

		slot0.trustLvText_.text = ArchiveTools.GetTrustLvDes(slot3)
	else
		slot0.favorabilityController_:SetSelectedState("Like")

		slot0.likeLvText_.text = slot2[LvTools.LoveExpToLevel(ArchiveData:GetArchive(slot0.curRecordID_).exp)]
	end
end

function slot0.RefreshRoleTab(slot0)
	slot0.roleList_ = {}
	slot4 = slot0.curRecordID_

	for slot4, slot5 in ipairs(HeroRecordCfg[slot4].hero_id) do
		if HeroCfg[slot5].private ~= 1 and not HeroTools.GetIsHide(slot5) then
			table.insert(slot0.roleList_, slot5)
		end
	end

	for slot4 = 1, #slot0.roleTabs_ do
		slot0.roleTabs_[slot4]:Hide()
		slot0.roleTabs_[slot4]:SetSelectState(false)
	end

	for slot4 = 1, #slot0.roleList_ do
		if not slot0.roleTabs_[slot4] then
			slot0.roleTabs_[slot4] = HeroFileRoleTabItem.New(Object.Instantiate(slot0.heroItemGo_, slot0.heroTabTrs_), function ()
				uv0:OnClickRoleTab(uv1)
			end)
		end

		slot0.roleTabs_[slot4]:Show(slot0.roleList_[slot4])

		if slot0.roleList_[slot4] == slot0.curHeroID_ then
			slot0.roleTabs_[slot4]:SetSelectState(true)

			slot0.roleIndex_ = slot4
		end
	end
end

function slot0.RefreshCV(slot0)
	slot0.cvText_.text = "CV " .. (GetI18NText(HeroRecordCfg[slot0.curRecordID_]["cv_" .. VoiceLanguageCfg[SettingData:GetSoundSettingData().voice_language].affix]) or "")
end

function slot0.OnClickRoleTab(slot0, slot1)
	if slot0.curPageIndex_ == slot0.subPageIndex_.Voice and not HeroTools.GetHeroIsUnlock(slot0.roleList_[slot1]) then
		ShowTips("ERROR_HERO_NOT_UNLOCK")

		return
	end

	if slot1 == slot0.roleIndex_ then
		return
	end

	if slot0.roleTabs_[slot0.roleIndex_] then
		slot0.roleTabs_[slot0.roleIndex_]:SetSelectState(false)
	end

	slot0.roleTabs_[slot1]:SetSelectState(true)

	slot0.roleIndex_ = slot1
	slot0.curHeroID_ = slot0.roleList_[slot1]

	slot0.subPages_[slot0.curPageIndex_]:Show(slot0.curRecordID_, slot0.curHeroID_)
	slot0:RefreshFavorabilityIcon()
	slot0:UpdateAvatarView()
	ArchiveAction.CheckHeroTrustUpLvRedPoint(slot0.curHeroID_)
	manager.redPoint:bindUIandKey(slot0.informationTrs_, string.format("%s_%s", RedPointConst.HERO_REALTION, slot0.curHeroID_))
	manager.redPoint:bindUIandKey(slot0.giftTrs_, string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, slot0.curHeroID_))
	OperationRecorder.Record("hero", "hero_record_switch")
end

function slot0.UpdateAvatarView(slot0)
	manager.heroRaiseTrack:SetModelState(HeroTools.HeroUsingSkinInfo(slot0.curHeroID_).id)
end

function slot0.ShowFavorabilityTips(slot0)
	if ArchiveData:GetTrustLevel(slot0.curHeroID_) > 0 then
		slot0.tipsLuaUIlist_:StartScroll(HeroConst.HERO_TRUST_LV_MAX)
		SetActive(slot0.FavorabilityTipsGo_, true)
	end
end

function slot0.HideFavorabilityTips(slot0)
	SetActive(slot0.FavorabilityTipsGo_, false)
end

function slot0.OnHeroTrustUpdate(slot0)
	if slot0.subPages_[slot0.subPageIndex_.Gift] then
		slot0.subPages_[slot0.subPageIndex_.Gift]:OnHeroTrustUpdate()
	end

	slot0:RefreshFavorabilityIcon()
end

function slot0.OnSendGift(slot0, slot1, slot2)
	if slot0.subPages_[slot0.subPageIndex_.Gift] then
		slot0.subPages_[slot0.subPageIndex_.Gift]:OnSendGift()
	end

	slot0:RefreshFavorabilityIcon()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.subPages_) do
		slot5:Dispose()
	end

	for slot4, slot5 in pairs(slot0.roleTabs_) do
		slot5:Dispose()
	end

	slot0.tipsLuaUIlist_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
