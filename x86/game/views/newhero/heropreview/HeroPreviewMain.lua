local var_0_0 = class("HeroFileMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/CharacterGuideUI/CharacterFileMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.curHeroID_ = 0
	arg_4_0.curRecordID_ = 0
	arg_4_0.roleIndex_ = 0
	arg_4_0.roleTabs_ = {}
	arg_4_0.roleList_ = {}
	arg_4_0.curPageIndex_ = 0
	arg_4_0.subPages_ = {}
	arg_4_0.subPageIndex_ = {
		Archive = 2,
		Information = 1,
		Voice = 3
	}
	arg_4_0.subPagePrefabPath_ = {
		"Widget/System/CharacterGuideUI/CharacterFileInformationPageUI",
		"Widget/System/CharacterGuideUI/CharacterArchivePageUI",
		"Widget/System/CharacterGuideUI/CharacterVoicePageUI",
		"Widget/System/Hero_skill/HeroSkillPageUI",
		"Widget/System/Hero_key/HeroKeyUI",
		"Widget/System/Hero_god/HeroGodUI"
	}
	arg_4_0.subPageClass_ = {
		HeroPreviewFileInformationPage,
		HeroPreviewFileArchivePage,
		HeroPreviewFileVoicePage,
		HeroSkillPage,
		HeroWeaponPage,
		NewHeroAstrolabePage
	}
	arg_4_0.subPageTab_ = {
		arg_4_0.informationBtn_,
		arg_4_0.archiveBtn_,
		arg_4_0.voiceBtn_,
		arg_4_0.skillBtn_,
		arg_4_0.weaponBtn_,
		arg_4_0.astrolabeBtn_
	}
	arg_4_0.tipsLuaUIlist_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTipsItem), arg_4_0.tipsUIlist_, HeroFileMainTipsItem)
	arg_4_0.favorabilityController_ = arg_4_0.FavorabilityControllerEx_:GetController("favorability")
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.subPageTab_) do
		iter_5_1.onValueChanged:AddListener(function(arg_6_0)
			if arg_6_0 then
				arg_5_0:SwitchPage(iter_5_0)
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.FavorabilityBtn_, nil, function()
		arg_5_0:ShowFavorabilityTips()
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsCloseBtn_, nil, function()
		arg_5_0:HideFavorabilityTips()
	end)
end

function var_0_0.OnTop(arg_9_0)
	if arg_9_0.subPages_ then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.subPages_) do
			iter_9_1:OnTop()
		end
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.CameraEnter(arg_10_0)
	return
end

function var_0_0.OnEnter(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_11_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.PREVIEW)
	arg_11_0.changeHero_ = arg_11_0.curHeroID_ ~= arg_11_0.params_.hid
	arg_11_0.curHeroID_ = arg_11_0.params_.hid
	arg_11_0.curRecordID_ = HeroTools.GetHeroOntologyID(arg_11_0.curHeroID_)
	arg_11_0.heroInfo_ = arg_11_0.heroViewProxy_:GetHeroData(arg_11_0.curHeroID_)
	arg_11_0.isEnter = arg_11_0.params_.isEnter
	arg_11_0.enteredPage_ = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.subPages_) do
		arg_11_0:CheckPageEnter(iter_11_0)
	end

	arg_11_0:SwitchPage(arg_11_0.params_.pageID or 1, arg_11_0.changeHero_)
	arg_11_0:RefreshRoleTab()
	arg_11_0:RefreshCV()
	arg_11_0:CheckLocked()

	arg_11_0.subPageTab_[arg_11_0.params_.pageID or 1].isOn = true

	arg_11_0:RefreshFavorabilityIcon()
	ArchiveAction.CheckHeroTrustUpLvRedPoint(arg_11_0.curHeroID_)
	arg_11_0.animator_:Play("HeroFileMainUI", 0)
	arg_11_0.animator_:Update(0)
end

function var_0_0.CheckLocked(arg_12_0)
	SetActive(arg_12_0.archiveBtn_.gameObject, arg_12_0.heroInfo_.unlock == 1)
	SetActive(arg_12_0.voiceBtn_.gameObject, arg_12_0.heroInfo_.unlock == 1)
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_13_0:HideFavorabilityTips()
	arg_13_0:RemoveAllEventListener()

	if arg_13_0.subPages_ then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.subPages_) do
			iter_13_1:OnExit()
		end
	end

	HeroTools.StopTalk()
end

function var_0_0.IndexTipsItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_1, arg_14_0.curHeroID_)
end

function var_0_0.CheckPageEnter(arg_15_0, arg_15_1)
	if not arg_15_0.enteredPage_[arg_15_1] then
		arg_15_0.subPages_[arg_15_1]:OnEnter(arg_15_0.heroViewProxy_, arg_15_0.params_)

		arg_15_0.enteredPage_[arg_15_1] = true
	end
end

function var_0_0.SwitchPage(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == arg_16_0.curPageIndex_ and not arg_16_2 then
		if arg_16_0.subPages_[arg_16_0.curPageIndex_].UpdateView then
			arg_16_0.subPages_[arg_16_0.curPageIndex_]:UpdateView(arg_16_0.curRecordID_, arg_16_0.curHeroID_)
		end

		arg_16_0.subPages_[arg_16_0.curPageIndex_]:CameraEnter()

		return
	end

	if arg_16_0.subPages_[arg_16_0.curPageIndex_] then
		arg_16_0.subPages_[arg_16_0.curPageIndex_]:Hide()
	end

	if not arg_16_0.subPages_[arg_16_1] then
		local var_16_0 = Asset.Load(arg_16_0.subPagePrefabPath_[arg_16_1])
		local var_16_1 = Object.Instantiate(var_16_0, arg_16_0.pagecontentTrs_)

		if arg_16_1 < 4 then
			arg_16_0.subPages_[arg_16_1] = arg_16_0.subPageClass_[arg_16_1].New(var_16_1, function(arg_17_0)
				arg_16_0:RefreshFavorabilityIcon(arg_17_0)
			end)
		else
			arg_16_0.subPages_[arg_16_1] = arg_16_0.subPageClass_[arg_16_1].New(arg_16_0, var_16_1, function(arg_18_0)
				arg_16_0:RefreshFavorabilityIcon(arg_18_0)
			end)
		end
	end

	if arg_16_0.isEnter then
		arg_16_0:CheckPageEnter(arg_16_1)
	end

	if arg_16_0.subPages_[arg_16_1].SetHeroInfo then
		arg_16_0.subPages_[arg_16_1]:SetHeroInfo(arg_16_0.heroInfo_)
	end

	if arg_16_0.subPages_[arg_16_1].HideMaskMessage then
		arg_16_0.subPages_[arg_16_1]:HideMaskMessage()
	end

	arg_16_0.subPages_[arg_16_1]:Show(arg_16_0.curRecordID_, arg_16_0.curHeroID_)
	arg_16_0.subPages_[arg_16_1]:CameraEnter()

	arg_16_0.curPageIndex_ = arg_16_1
	arg_16_0.params_.pageID = arg_16_1

	if (arg_16_2 or arg_16_0.isEnter) and arg_16_0.curPageIndex_ == 1 then
		HeroTools.StopTalk()
		manager.heroRaiseTrack:PlayTalk()
	end
end

function var_0_0.RefreshFavorabilityIcon(arg_19_0, arg_19_1)
	local var_19_0 = {
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	}

	if arg_19_1 then
		arg_19_0.likeLvText_.text = var_19_0[arg_19_1]
	else
		local var_19_1 = ArchiveData:GetTrustLevel(arg_19_0.curHeroID_)

		if var_19_1 > 0 then
			arg_19_0.favorabilityController_:SetSelectedState("Trust")

			arg_19_0.trustLvText_.text = ArchiveTools.GetTrustLvDes(var_19_1)
		else
			arg_19_0.favorabilityController_:SetSelectedState("Like")

			local var_19_2 = LvTools.LoveExpToLevel(ArchiveData:GetArchive(arg_19_0.curRecordID_).exp)

			arg_19_0.likeLvText_.text = var_19_0[var_19_2]
		end
	end
end

function var_0_0.RefreshRoleTab(arg_20_0)
	arg_20_0.roleList_ = {}

	for iter_20_0, iter_20_1 in ipairs(HeroRecordCfg[arg_20_0.curRecordID_].hero_id) do
		if HeroCfg[iter_20_1].private ~= 1 and not HeroTools.GetIsHide(iter_20_1) then
			table.insert(arg_20_0.roleList_, iter_20_1)
		end
	end

	for iter_20_2 = 1, #arg_20_0.roleTabs_ do
		arg_20_0.roleTabs_[iter_20_2]:Hide()
		arg_20_0.roleTabs_[iter_20_2]:SetSelectState(false)
	end

	for iter_20_3 = 1, #arg_20_0.roleList_ do
		if not arg_20_0.roleTabs_[iter_20_3] then
			local var_20_0 = Object.Instantiate(arg_20_0.heroItemGo_, arg_20_0.heroTabTrs_)

			arg_20_0.roleTabs_[iter_20_3] = HeroFileRoleTabItem.New(var_20_0, function()
				arg_20_0:OnClickRoleTab(iter_20_3)
			end)
		end

		arg_20_0.roleTabs_[iter_20_3]:Show(arg_20_0.roleList_[iter_20_3])
		arg_20_0.roleTabs_[iter_20_3].animator_:Play("HeroFileMainUI_item02", 0)
		arg_20_0.roleTabs_[iter_20_3].animator_:Update(0)
		arg_20_0:UpdateAvatarView()

		if arg_20_0.roleList_[iter_20_3] == arg_20_0.curHeroID_ then
			arg_20_0.roleTabs_[iter_20_3]:SetSelectState(true)

			arg_20_0.roleIndex_ = iter_20_3
		end
	end
end

function var_0_0.RefreshCV(arg_22_0)
	local var_22_0 = SettingData:GetSoundSettingData().voice_language
	local var_22_1 = VoiceLanguageCfg[var_22_0].affix

	arg_22_0.cvText_.text = "CV " .. (GetI18NText(HeroRecordCfg[arg_22_0.curRecordID_]["cv_" .. var_22_1]) or "")
end

function var_0_0.OnClickRoleTab(arg_23_0, arg_23_1)
	if arg_23_1 == arg_23_0.roleIndex_ then
		return
	end

	if arg_23_0.roleTabs_[arg_23_0.roleIndex_] then
		arg_23_0.roleTabs_[arg_23_0.roleIndex_]:SetSelectState(false)
	end

	arg_23_0.roleTabs_[arg_23_1]:SetSelectState(true)

	arg_23_0.roleIndex_ = arg_23_1
	arg_23_0.curHeroID_ = arg_23_0.roleList_[arg_23_1]
	arg_23_0.params_.hid = arg_23_0.roleList_[arg_23_1]
	arg_23_0.curRecordID_ = HeroTools.GetHeroOntologyID(arg_23_0.curHeroID_)
	arg_23_0.heroInfo_ = arg_23_0.heroViewProxy_:GetHeroData(arg_23_0.curHeroID_)

	local var_23_0 = arg_23_0.curPageIndex_

	if arg_23_0.heroInfo_.unlock == 0 and (arg_23_0.curPageIndex_ == 2 or arg_23_0.curPageIndex_ == 3) then
		var_23_0 = 1
	end

	arg_23_0:RefreshFavorabilityIcon()
	arg_23_0:CheckLocked()
	arg_23_0:UpdateAvatarView()

	if arg_23_0.subPageTab_[var_23_0].isOn then
		arg_23_0:SwitchPage(var_23_0, true)
	end

	arg_23_0.subPageTab_[var_23_0].isOn = true

	ArchiveAction.CheckHeroTrustUpLvRedPoint(arg_23_0.curHeroID_)
	OperationRecorder.Record("hero", "hero_record_switch")
end

function var_0_0.UpdateAvatarView(arg_24_0)
	local var_24_0 = HeroTools.HeroUsingSkinInfo(arg_24_0.curHeroID_).id

	manager.heroRaiseTrack:SetModelState(var_24_0)
end

function var_0_0.ShowFavorabilityTips(arg_25_0)
	if ArchiveData:GetTrustLevel(arg_25_0.curHeroID_) > 0 then
		arg_25_0.tipsLuaUIlist_:StartScroll(HeroConst.HERO_TRUST_LV_MAX)
		SetActive(arg_25_0.FavorabilityTipsGo_, true)
	end
end

function var_0_0.HideFavorabilityTips(arg_26_0)
	SetActive(arg_26_0.FavorabilityTipsGo_, false)
end

function var_0_0.OnHeroTrustUpdate(arg_27_0)
	arg_27_0:RefreshFavorabilityIcon()
end

function var_0_0.OnSendGift(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0:RefreshFavorabilityIcon()
end

function var_0_0.Dispose(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.subPages_) do
		iter_29_1:Dispose()
	end

	for iter_29_2, iter_29_3 in pairs(arg_29_0.roleTabs_) do
		iter_29_3:Dispose()
	end

	arg_29_0.tipsLuaUIlist_:Dispose()
	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
