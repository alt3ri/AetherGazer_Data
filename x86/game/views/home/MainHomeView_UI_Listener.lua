slot0 = partialClass("MainHomeView", ReduxView)
slot1 = 0

function slot0.AddMiddlePanelUILisener(slot0)
	slot0:AddBtnListener(slot0.btn_changeChar, nil, function ()
		uv0:SwitchPosterGirlPanel(false)
		uv0:Go("/changePoster", {
			lastView = "home"
		})
	end)
	slot0:AddBtnListener(slot0.btn_skin, nil, function ()
		uv0:SwitchPosterGirlPanel(false)
		uv0:Go("/heroSkin", {
			heroID = uv0.userData_.poster_girl
		})
	end)
	slot0:AddBtnListener(slot0.btn_giftBtn_, nil, function ()
		uv0:SwitchPosterGirlPanel(false)
		uv0:Go("/heroArchive", {
			pageID = 3,
			heroID = uv0.userData_.poster_girl
		})
	end)
	slot0:AddBtnListener(slot0.btn_infoBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelpPro", {
			hideHomeBtn = 1,
			isPrefab = true,
			pages = GameSetting.home_scene_interactive_describe and GameSetting.home_scene_interactive_describe.value or {}
		})
	end)
	slot0:AddBtnListener(slot0.btn_DlcBtn_, nil, function ()
		if Time.realtimeSinceStartup < uv0 + 1 then
			return
		end

		uv0 = Time.realtimeSinceStartup

		HomeSceneSettingAction.ChangeSceneTab(uv1.skinId_)
	end)
	slot0:AddBtnListener(slot0.hideViewBtn_, nil, function ()
		uv0.isHide_ = true

		uv0:RefreshHide()
		uv0:StartViewHideTimer()
		uv0.animator_:Play("HomeUI_hide", -1, 0)
	end)
	slot0:AddBtnListener(slot0.showAniSkipBtn_, nil, function ()
		manager.posterGirl:SkipDebut()
		HomeSceneSettingData:SetIsPlay(uv0.skinId_)
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:OnClickBg()
	end)
end

function slot0.AddRightPanelUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.btnPreviewTask_, nil, function ()
		JumpTools.OpenPageByJump("previewTaskMain")
	end)
	slot0:AddBtnListenerScale(slot0.btn_task, nil, function ()
		JumpTools.GoToSystem("/task", {
			initNormalizedPosition = true,
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)
	slot0:AddBtnListenerScale(slot0.btn_mail, nil, function ()
		OperationRecorder.RecordButtonTouch("homepage_mail")

		if MailData.GetTotal() > #MailData.GetMailSort() then
			MailData.GetMailListFromServer(handler(uv0, function ()
				JumpTools.GoToSystem("/mailBox")
			end))
		else
			slot0()
		end

		MailData.ClickMailBtn(manager.time:GetServerTime())
	end)
	slot0:AddBtnListenerScale(slot0.btn_menu, nil, function ()
		JumpTools.OpenPageByJump("menuPop")
	end)
	slot0:AddBtnListener(slot0.skinDrawBtn_, nil, function ()
		slot0, slot1 = ActivitySkinDrawData:GetNotReadStoryID()

		if slot0 and ActivityData:GetActivityData(slot0):IsActivitying() then
			if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) then
				if slot1 and slot1.isRead == 0 then
					uv0:MuteAudio()
					manager.story:StartStoryById(ActivityLimitedSkinStoryCfg[slot1.activityID].story_id, function ()
						manager.loadScene:ForceSetShouldLoadSceneName("home", function ()
							ActivitySkinDrawAction.FinishStory(uv0.activityID)
							JumpTools.GoToSystem("/activityskinDraw", {
								activityID = uv1
							}, ViewConst.SYSTEM_ID.SKIN_DRAW)
						end)
					end)
				else
					JumpTools.GoToSystem("/activityskinDraw", {
						activityID = slot0
					}, ViewConst.SYSTEM_ID.SKIN_DRAW)
				end
			else
				ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.SKIN_DRAW, JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW)))
			end
		else
			SetActive(uv0.skinDrawBtn_.gameObject, false)
		end
	end)
	slot0:AddBtnListener(slot0.btn_combat, nil, function ()
		if getData("SDK", "btn_homepage_combat") == nil or not TimeMgr:IsSameDay(slot0, TimeMgr:GetServerTime()) then
			saveData("SDK", "btn_homepage_combat", TimeMgr:GetServerTime())
			OperationRecorder.RecordButtonTouch("homepage_combat")
		end

		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.MAIN
		}, ViewConst.SYSTEM_ID.BATTLE)
	end)
	slot0:AddBtnListenerScale(slot0.btn_goddess, nil, function ()
		HeroData:SetupHeroMainOpenStatus(true)
		JumpTools.GoToSystem("/newHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT
		}, ViewConst.SYSTEM_ID.HERO)
	end)
	slot0:AddBtnListenerScale(slot0.btn_shop, nil, function ()
		OperationRecorder.RecordButtonTouch("homepage_shop")
		JumpTools.GoToSystem("/rechargeEnter", nil, ViewConst.SYSTEM_ID.SHOP_ENTER)
	end)
	slot0:AddBtnListenerScale(slot0.btn_backPake, nil, function ()
		JumpTools.GoToSystem("/bag", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	slot0:AddBtnListenerScale(slot0.btnGuild_, nil, function ()
		if JumpTools.IsSystemOperationStoped(ViewConst.SYSTEM_ID.GUILD) then
			ShowTips("ERROR_FUNCTION_STOP")

			return nil
		end

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD) then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.GUILD, slot0))

			return
		end

		if GuildData:GetGuildInfo().id == nil then
			GuildAction.EnterGuild()
		else
			GuildAction.RequiredGuildInfo(function (slot0)
				if isSuccess(slot0.result) then
					JumpTools.OpenPageByJump("/guildEntrace/guildMain")
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end)
	slot0:AddBtnListenerScale(slot0.btn_dorm_, nil, function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, slot0))

			return nil
		end

		BackHomeDataManager:EnterBackHomeSystem(function ()
			manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)

			if GameDisplayCfg.dorm_begin_story.value[1] and not manager.story:IsStoryPlayed(slot0) then
				manager.story:StartStoryById(slot0, function (slot0)
					JumpTools.OpenPageByJump("/dormChooseRoomView")
				end)
			else
				JumpTools.OpenPageByJump("/dormChooseRoomView")
			end
		end)
	end)
	slot0:AddBtnListenerScale(slot0.btn_draw, nil, function ()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function slot0.AddLeftPanelUIListener(slot0)
	slot0:AddBtnListener(slot0.appearViewBtn_, nil, function ()
		uv0:StopViewHideTimer()
		SetActive(uv0.appearViewBtn_.gameObject, false)

		uv0.isHide_ = false

		uv0:RefreshHide()
		uv0.animator_:Play("HomeUI_cx", -1, 0)
	end)
	slot0:AddBtnListener(slot0.btn_message, nil, function ()
		OpenPageUntilLoaded("/userinfo", {
			page = "info"
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)
	end)
	slot0:AddBtnListener(slot0.btn_callback, nil, function ()
		ActivityRecallAction.RequestOpenRecallView(ActivityConst.RECALL_MAIN, function ()
			JumpTools.GoToSystem("/recallMain", nil)
		end)
	end)
	slot0:AddBtnListenerScale(slot0.btn_regression, nil, function ()
		RegressionAction.CheckRegressionStory({
			isEnter = true,
			Inited = false
		})
	end)
	slot0:AddBtnListenerScale(slot0.buttonNewbie_, nil, function ()
		ActivityNewbieTools.GotoMainView()
	end)
	slot0:AddBtnListenerScale(slot0.btn_newbie_task, nil, function ()
		ActivityNewbieTools.GotoNoobAdvanceTaskView()
	end)
	slot0:AddBtnListenerScale(slot0.advanceTestBtn_, nil, function ()
		JumpTools.GoToSystem("/advanceTestMain")
	end)
	slot0:AddBtnListenerScale(slot0.btn_passport, nil, function ()
		OperationRecorder.RecordButtonTouch("homepage_bp")

		if not PassportData:IsOpen() then
			ShowTips("NOT_IN_OPEN_TIME")

			return
		end

		JumpTools.OpenPageByJump("/passportMain", nil, ViewConst.SYSTEM_ID.PASSPORT_MAIN)
	end)
	slot0:AddBtnListenerScale(slot0.btn_gm, nil, function ()
		JumpTools.GoToSystem("gm")
	end)
	slot0:AddBtnListenerScale(slot0.btn_heroInteractionGM, nil, function ()
		JumpTools.GoToSystem("heroInteractionGM", {
			skinId = uv0.skinId_
		})
	end)
	slot0:AddBtnListener(slot0.btn_story, nil, function ()
		JumpTools.GoToSystem("/storylist")
	end)
	slot0:AddBtnListenerScale(slot0.btn_newServer, nil, function ()
		JumpTools.OpenPageByJump("/activityNewServerMain")
	end)
	slot0:AddBtnListenerScale(slot0.btn_friends_, nil, function ()
		slot0 = ViewConst.SYSTEM_ID.FRIEND
		slot1 = JumpTools.IsSystemLocked(slot0)

		if slot0 and slot1 then
			ShowTips(JumpTools.GetSystemLockedTip(slot0, slot1))

			return
		end

		FriendsAction:TryToRefreshFriendsView(FriendsConst.FRIEND_TYPE.MY_FRIENDS, function ()
			JumpTools.GoToSystem("/friendsUI", {
				friendPage = FriendsConst.FRIEND_TYPE.MY_FRIENDS
			}, ViewConst.SYSTEM_ID.FRIEND)
		end)
	end)
	slot0:AddBtnListenerScale(slot0.btn_chat, nil, function ()
		JumpTools.GoToSystem("/chat", {
			chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
end

function slot0.AddUIListenersHome(slot0)
	function slot0.mutiTouchHelper_.OnIdle()
		manager.posterGirl:TouchHelpIdle()
	end

	function slot0.mutiTouchHelper_.OnSingleDrag(slot0, slot1)
		manager.posterGirl:TouchHelpSingleDrag(slot0, slot1)
	end

	function slot0.mutiTouchHelper_.OnMutiDrag(slot0)
		manager.posterGirl:TouchHelpMutiDrag(slot0)
	end

	function slot0.mutiTouchHelper_.OnClick()
		if manager.posterGirl:GetViewDirect() == 0 then
			uv0:ShowPosterGirlBtn()
		end

		uv0:DelayToPlayMultiTouchInteraction()
	end
end
