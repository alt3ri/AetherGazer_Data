slot0 = partialClass("MainHomeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Main/HomeUI"
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

	slot0.page_ = {}
	slot0.clickCount_ = 0
	slot0.muteAudioHandler_ = handler(slot0, slot0.MuteAudio)
	slot0.shakingAniHandler_ = handler(slot0, slot0.ShakingAni)
	slot0.bannerView_ = BannerView.New(slot0, slot0.btnActivityGo_)
	slot0.activityEntraceView_ = ActivityEntraceView.New(slot0.activityListGo_)
	slot0.socializeCon_ = slot0.conExCollection_:GetController("socialize")
	slot0.hideCon_ = slot0.conExCollection_:GetController("hide")
	slot0.sceneCon_ = slot0.conExCollection_:GetController("scene")
	slot0.skinDrawCon_ = slot0.conExCollection_:GetController("skinDraw")
	slot0.drawLockCon_ = slot0.conExCollection_:GetController("drawLocked")
	slot0.dormLockCon_ = slot0.conExCollection_:GetController("dormLocked")
	slot0.guildCon_ = slot0.conExCollection_:GetController("guildLocked")
	slot0.shopCon_ = slot0.conExCollection_:GetController("shopLocked")
	slot0.textLimit_ = slot0.chatTxt_.gameObject:GetComponent("TextExtension")
	slot0.mutiTouchHelper_ = slot0.btn_girl.gameObject:GetComponent("MutiTouchHelper")

	slot0:SwitchPosterGirlPanel(false)
	SetActive(slot0.talkBubbleGo_, false)
end

function slot0.AddUIListeners(slot0)
	slot0:AddMiddlePanelUILisener()
	slot0:AddLeftPanelUIListener()
	slot0:AddRightPanelUIListener()
	slot0:AddUIListenersHome()
end

function slot0.InitBar(slot0)
	manager.windowBar:SwitchBar({
		INVITE_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(HOME_POSTER_TALK, handler(slot0, slot0.OnHomePosterTalk))
	slot0:CheckHomeSceneInteration(true)
	slot0:ClearHeroFilter()
end

function slot0.OnTop(slot0)
	if not slot0.wait_posetr_debut then
		slot0:OnTopFunc()
	end

	slot0:ClearHeroFilter()
end

function slot0.OnTopFunc(slot0)
	slot0:InitBar()
	RedPointAction.UpdateSDKRedPoint()
	slot0:CheckNeedPopWindow()
end

function slot0.OnExit(slot0)
	slot0.wait_posetr_debut = false

	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
	manager.loadScene:StopSceneSoundEffect()
	manager.notify:RemoveListener(MUTE_MAIN_AUDIO, slot0.muteAudioHandler_)

	slot4 = SHAKING_MOBILE
	slot5 = slot0.shakingAniHandler_

	manager.notify:RemoveListener(slot4, slot5)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0:MuteAudio()

	for slot4, slot5 in pairs(slot0.page_) do
		slot5:OnExit()
	end

	slot0.activityEntraceView_:OnExit()

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHAT) then
		ChatAction.EnterChatUI(2)
	end

	SetActive(slot0.btn_girl.gameObject, false)

	slot0.skinId_ = nil

	ItemTools.StopRefreshLimitRed()
	slot0:StopAllTimers()

	slot0.isHeroGiftOpen_ = nil
	slot0.params_.changePoster = nil

	AnimatorTools.Stop()
	slot0:UnBindRedPointUI()
end

function slot0.Dispose(slot0)
	slot0.muteAudioHandler_ = nil

	slot0.activityEntraceView_:Dispose()

	slot0.activityEntraceView_ = nil

	for slot4, slot5 in pairs(slot0.page_) do
		slot5:Dispose()
	end

	slot0.page_ = nil

	slot0:RemoveAllListeners()

	if slot0.bannerView_ then
		slot0.bannerView_:Dispose()

		slot0.bannerView_ = nil
	end

	if slot0.hideChangeBtnDelayTimer_ then
		slot0.hideChangeBtnDelayTimer_:Stop()

		slot0.hideChangeBtnDelayTimer_ = nil
	end

	slot0:RemovePosterTween()
	uv0.super.Dispose(slot0)
end

function slot0.OnEnterFunc(slot0)
	slot0:CheckIsNeedOpenWebPage()
	slot0:UpdateFollowGiftRedPoint()
	SurveyAction.UpdateSurveyRedPoint()
	ReduxFactory.GetInstance():OnMainHomeViewTop()
	slot0:RefreshPage()
	slot0:RefreshUserInfo()
	ItemTools.RefreshLimitRed()
	slot0:RefreshBanner()
	slot0:RefreshRealtimeUI()
	slot0:StartRefreshUITimer()
	slot0:UpdataOperationViewRedPoint()
	slot0:BindRedPointUI()
	slot0:RegistEventListener(PASSPORT_INIT, function ()
		uv0:CheckPassportBtn()
	end)
	slot0:CheckPassportBtn()
	slot0:UpdateChipRedPoint()
	slot0:UpdateFriendsRedPoint()
	SetActive(slot0.skinDrawRedPanel_, not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW))
	slot0:RefreshChat()
	SetActive(slot0.goNewbie_, not JumpTools.IsConditionLocked({
		2,
		GameSetting.newbie_unlock_level_id.value[1]
	}) and not ActivityNewbieTools.IsFinishAllActivity())

	slot2, slot3 = ActivityNewbieTools.CheckAdvanceTaskOpen()

	SetActive(slot0.btn_newbie_task.gameObject, slot2)

	if slot2 then
		slot4 = ActivityNewbieTools.GetAdvanceTaskCfg(slot3)
		slot0.newbieAdvanceTaskTitle_.text = GetTips(NoobVersionCfg[slot4.versionID].noob_advance_task_title[slot4.index])
	end

	SetActive(slot0.btn_regression.gameObject, RegressionData:IsRegressionOpen())
	SetActive(slot0.btn_newServer.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NEW_SERVER) and JumpTools.IsConditionLocked(NewServerCfg[ActivityConst.ACTIVITY_NEW_SERVER].open_condition[1]) == false)
	slot0:CheckLocked()
	slot0:CheckActivite()
	slot0.activityEntraceView_:OnEnter()
	BulletinData.SetIslogin(true)
	manager.rollTips:TryToCreatTips()
	manager.notify:RegistListener(MUTE_MAIN_AUDIO, slot0.muteAudioHandler_)
	manager.notify:RegistListener(SHAKING_MOBILE, slot0.shakingAniHandler_)
	slot0:RefreshHide()
end

slot1 = {
	Sign = {
		"sign",
		{
			check = true,
			activityID = ActivityConst.SIGN
		},
		ViewConst.SYSTEM_ID.SIGN
	},
	Praise = {
		"praise"
	},
	ActivityAdvertise = {
		"activityAdvertise"
	},
	ChatMuted = {
		"chatMuted"
	},
	RegressionNewGift = {
		"regressionNewGift"
	}
}

function slot2(slot0, slot1, slot2)
	if slot2 then
		table.insert(slot0, slot1)
	end

	return slot2
end

function slot3(slot0)
	return function ()
		JumpTools.OpenPageByJump(unpack(uv0))
	end
end

function slot0.CheckWeakGuide(slot0)
end

function slot0.GetSpecialCom(slot0, slot1)
	if string.sub(slot1[1], 3) == "activityEntraceView_" and slot0.activityEntraceView_.itemUiList_:GetItemByIndex(slot1[2]) then
		return slot4.gameObject_
	end
end

function slot0.CheckNeedPopWindow(slot0)
	if manager.guide:IsPlaying() then
		SetActive(slot0.mask_, false)

		return
	end

	slot2 = RechargeData:HaveMonthCard() and not RechargeData:IsSignToday()
	slot3 = ActivityBigMonthCardToggle:Check()
	slot9, slot10, slot11 = ArchiveTools.NeedShowArchivePop()
	slot12, slot13, slot14 = HomeSceneSettingData:IsNeedSceenCheck()

	if SignTools.IsCanSign() or SurveyData:GetPraise() or RegressionData:CheckRegressionGift() or ChatData:IsMuted() and not ChatData:GetShowMutedTips() or ActivityAdvertiseTools.NeedShowAdvertise() or slot9 or slot12 or not LuaHidTools.HasSetRemapNotice() then
		SetActive(slot0.mask_, true)
	else
		SetActive(slot0.mask_, false)
		slot0:RealCheckWeakGuide()
	end

	if slot0.needToPlayTalk_ and not slot4 and not slot5 and not slot3 then
		slot0:PlayHeroGreeting()

		slot0.needToPlayTalk_ = false
	end

	if slot0.params_.isFirstCheck then
		if slot4 or slot5 or slot3 then
			slot0.needToPlayTalk_ = true
		else
			slot0:PlayHeroGreeting()
		end

		slot0.params_.isFirstCheck = false
	end

	slot17 = uv0({}, uv1(uv2.Sign), slot2 or slot3 or slot4) or uv0(slot16, uv1(uv2.Praise), slot5) or uv0(slot16, uv1(uv2.ActivityAdvertise), slot8) or uv0(slot16, uv1(uv2.ChatMuted), slot6) or uv0(slot16, uv1(uv2.RegressionNewGift), slot7) or uv0(slot16, uv1({
		"archiveHomePop",
		{
			heroID = slot10,
			type = slot11
		}
	}), slot9) or uv0(slot16, uv1({
		"homeChangeScenePop",
		{
			left = slot13,
			right = slot14
		}
	}), slot12) or uv0(slot16, LuaHidTools.QueryRemapNotice, slot15)

	slot0:StartShowTimer(slot16)
end

function slot0.RemovePosterTween(slot0)
	if slot0.posterTween_ then
		slot0.posterTween_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(slot0.posterTween_.id)

		slot0.posterTween_ = nil
	end
end

function slot0.HideTimeline(slot0)
	if slot0.timelines_ then
		slot5 = true
		slot1 = slot0.timelines_:GetComponentsInChildren(typeof(UnityEngine.Transform), slot5)
		slot6 = slot1

		for slot5, slot6 in pairs(slot1.ToTable(slot6)) do
			if slot6.name ~= slot0.timelines_.name then
				SetActive(slot6.gameObject, false)
			end
		end
	end
end

function slot0.OnClickBg(slot0)
	if slot0.isHide_ then
		slot0:StartViewHideTimer()
	end
end

function slot0.OnHomeSignUpdate(slot0)
	slot0:CheckNeedPopWindow()
end

function slot0.OnChangeNickname(slot0, slot1)
	slot0.name_.text = GetI18NText(slot1.nick)
end

function slot0.OnHeroGiftReward(slot0)
	slot0:CheckHeroGiftActivite()
end

function slot0.ShowPosterGirlBtn(slot0)
	slot0:SwitchPosterGirlPanel(true)

	if slot0.hideChangeBtnDelayTimer_ ~= nil then
		slot0.hideChangeBtnDelayTimer_:Reset()
	else
		slot0.hideChangeBtnDelayTimer_ = Timer.New(handler(slot0, slot0.HidePosterGirlBtn), 3, 1)

		slot0.hideChangeBtnDelayTimer_:Start()
	end
end

function slot0.HidePosterGirlBtn(slot0)
	slot0:SwitchPosterGirlPanel(false)

	if slot0.hideChangeBtnDelayTimer_ ~= nil then
		slot0.hideChangeBtnDelayTimer_:Stop()

		slot0.hideChangeBtnDelayTimer_ = nil
	end
end

function slot0.SwitchPosterGirlPanel(slot0, slot1)
	SetActive(slot0.changeGirlBtn, slot1)
	SetActive(slot0.changeSkinBtn, slot1)
	SetActive(slot0.btn_giftGo_, slot1)

	if slot1 then
		if SkinSceneActionCfg[HeroTools.HeroUsingSkinInfo(slot0.userData_.poster_girl).id] and HomeSceneSettingData:GetUsedState(slot3.special_scene_id) ~= SceneConst.HOME_SCENE_TYPE.LOCK and HomeSceneSettingCfg[slot3.special_scene_id].limit_display ~= 1 then
			SetActive(slot0.btn_DlcGo_, true)
		else
			SetActive(slot0.btn_DlcGo_, false)
		end

		if slot3 and HomeSceneSettingData:GetCurScene() == 6001 and slot3.special_scene_id == HomeSceneSettingData:GetCurScene() and manager.posterGirl:GetViewDirect() == PosterGirlConst.ViewDirect.center then
			SetActive(slot0.btn_infoGo_, true)
		else
			SetActive(slot0.btn_infoGo_, false)
		end
	else
		SetActive(slot0.btn_infoGo_, false)
		SetActive(slot0.btn_DlcGo_, false)
	end
end

function slot0.MuteAudio(slot0)
	HeroTools.StopTalk()

	if slot0.multiTouchTimer_ ~= nil then
		slot0.multiTouchTimer_:Stop()

		slot0.multiTouchTimer_ = nil
	end

	SetActive(slot0.talkBubbleGo_, false)
end

function slot0.ShakingAni(slot0)
	manager.posterGirl:DoShacking()
end

function slot0.OnHomeSceneChange(slot0, slot1, slot2)
	manager.transition:OnlyShowEffect(true, function ()
		manager.loadScene:ForceSetShouldLoadSceneName("home", function ()
			uv0:MuteAudio()
			uv0:SetCamera()
			manager.posterGirl:RefreshModel()

			if manager.posterGirl:CheckDebut() then
				manager.windowBar:SwitchBar({})
				uv0.sceneCon_:SetSelectedState("off")
			end

			uv0:HidePosterGirlBtn()
			manager.transition:OnlyShowEffect(false)
		end)
	end)
end

function slot0.SetCamera(slot0)
	if CameraCfg["home_" .. HomeSceneSettingData:GetCurScene()] then
		manager.ui:SetMainCamera(slot2)
	else
		manager.ui:SetMainCamera("home")
	end
end

function slot0.CheckIsNeedPlayShowingAni(slot0)
	slot1 = false

	if slot0.params_.changePoster then
		slot0.params_.changePoster = nil

		if not slot0.assistantVoiceTime_ or HeroConst.SET_ASSISTANT_VOICE_CD <= Time.realtimeSinceStartup - slot0.assistantVoiceTime_ then
			slot0.assistantVoiceTime_ = Time.realtimeSinceStartup

			manager.posterGirl:DoShowing()

			slot1 = true
		end
	end
end

function slot0.CheckHomeSceneInteration(slot0)
	manager.windowBar:ClearWhereTag()
	slot0:SetCamera()

	slot0.isHide_ = false
	slot0.userData_ = PlayerData:GetPlayerInfo()
	slot0.skinId_ = HeroTools.HeroUsingSkinInfo(slot0.userData_.poster_girl).id

	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.home)
	manager.posterGirl:InitTouchHelp(slot0.mutiTouchHelper_)

	if not manager.guide:IsPlaying() and manager.posterGirl:CheckDebut() then
		slot0.wait_posetr_debut = true

		manager.windowBar:SwitchBar({})
		slot0.sceneCon_:SetSelectedState("off")
	else
		slot0.sceneCon_:SetSelectedState("on")
		slot0:OnEnterFunc()
		slot0:CheckIsNeedPlayShowingAni()
	end

	manager.loadScene:SetHomeSceneSoundEffect()
end

function slot0.OnHomeDebutOver(slot0)
	if slot0.wait_posetr_debut then
		slot0:OnEnterFunc()
		slot0:OnTopFunc()
	end

	slot0:InitBar()
	slot0.sceneCon_:SetSelectedState("on")

	slot0.wait_posetr_debut = false
end

function slot0.PlayHeroGreeting(slot0)
	manager.posterGirl:DoGreeting()
end

function slot0.DelayToPlayMultiTouchInteraction(slot0)
	slot0.clickCount_ = slot0.clickCount_ + 1

	if slot0.multiTouchTimer_ == nil then
		slot0.multiTouchTimer_ = Timer.New(function ()
			if uv0.multiTouchTimer_ then
				uv0.multiTouchTimer_:Stop()

				uv0.multiTouchTimer_ = nil
			end

			if uv0.clickCount_ >= 3 then
				SDKTools.SendMessageToSDK("poster_touch", {
					touch_times = 3,
					position = 0,
					hero_id = uv0.skinId_,
					scene_id = HomeSceneSettingData:GetCurScene()
				})
				manager.posterGirl:DoQuickTouch()
			else
				SDKTools.SendMessageToSDK("poster_touch", {
					touch_times = 1,
					position = 0,
					hero_id = uv0.skinId_,
					scene_id = slot0
				})
				manager.posterGirl:DoTouch()
			end

			uv0.clickCount_ = 0
		end, 0.5, 1)

		slot0.multiTouchTimer_:Start()
	end
end

function slot0.OnHomePosterTalk(slot0, slot1, slot2, slot3)
	if HeroVoiceDescCfg.Get(tonumber(slot1), slot2[1]) then
		if not isNil(slot0.talkBubbleGo_) then
			SetActive(slot0.talkBubbleGo_, true)
		end

		if not isNil(slot0.talkLabel_) then
			slot0.talkLabel_.text = slot5
		end

		if slot0.talkBubbleTimer_ ~= nil then
			slot0.talkBubbleTimer_:Stop()

			slot0.talkBubbleTimer_ = nil
		end

		slot0.talkBubbleTimer_ = TimeTools.StartAfterSeconds(slot3 / 1000, function ()
			if not isNil(uv0.talkBubbleGo_) then
				SetActive(uv0.talkBubbleGo_, false)
			end

			if uv0.talkBubbleTimer_ ~= nil then
				uv0.talkBubbleTimer_:Stop()

				uv0.talkBubbleTimer_ = nil
			end
		end, {})
	end
end

function slot0.ClearHeroFilter(slot0)
	HeroData:SetupHeroMainOpenStatus(false)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

return slot0
