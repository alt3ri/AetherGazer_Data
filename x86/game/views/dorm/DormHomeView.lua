slot0 = class("DormHomeView", ReduxView)
slot1 = nil

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormitoryUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.likeBtnStateController = slot0.controller:GetController("praise")
	slot0.praiseAnimator = slot0.praiseGo_:GetComponent("Animator")
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvents()
	slot0:UpdataViewType()
	slot0:RefreshRoomNameInfo()
	slot0:RefreshDevInfo()
	slot0.quickView:OnEnter()
	slot0.tempquickGo_.transform:SetAsLastSibling()
	slot0.quickView:ShowView(false)
	slot0:UpdataDormitoryInternalRedPoint()
	slot0:RefreshRedPonit()
	slot0:AutoOpenSuitHelpPage()
	DormLuaBridge.SetIsCanEditTag(false)
	slot0:RefreshLikeNum()
	slot0:RefreshLikeBtnState()
end

function slot0.OnTop(slot0)
	slot0:HideUiInfo(true)
end

function slot0.UpdataViewType(slot0)
	slot0.sceneID_ = DormData:GetCurrectSceneID()

	if DormConst.DORM_VISIT_ROOM_MIN < slot0.sceneID_ then
		slot0.stateController:SetSelectedState("visit")

		if DormVisitTools:GetCurVisitPlayerType() == 1 then
			slot0.friendController:SetSelectedState("true")
		elseif slot1 == 2 then
			slot0.friendController:SetSelectedState("false")
		end

		SetActive(slot0.collectBtn_.gameObject, not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM))
	else
		slot0.stateController:SetSelectedState("room")

		if slot0.sceneID_ == DormVisitTools:GetCurTemplateExhibit() then
			slot0.exhibitController:SetSelectedState("true")
		else
			slot0.exhibitController:SetSelectedState("false")
		end
	end
end

function slot0.RefreshRoomNameInfo(slot0)
	if BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.PublicDorm or BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		slot0.roomName.text = GetTips("DORM_LOBBY_NAME")

		slot0.publicTextController:SetSelectedState("false")
	elseif BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm or BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		slot1 = DormitoryData:GetDormSceneData(slot0.sceneID_).archiveIDList[1]

		if BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			slot0.publicTextController:SetSelectedState("true")
		else
			slot0.publicTextController:SetSelectedState("false")
		end

		if slot1 and HeroRecordCfg.get_id_list_by_hero_id[slot1][1] then
			if HeroRecordCfg[slot2].name then
				slot0.roomName.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), GetI18NText(slot3))
			end

			slot0:RefreshRoomLevel()
		end
	end
end

function slot0.RefreshRedPonit(slot0)
	manager.redPoint:bindUIandKey(slot0.positionBtn_.transform, RedPointConst.DORM_PLACEMENT)
	manager.redPoint:bindUIandKey(slot0.fureidbtnBtn_.transform, RedPointConst.DORM_FURNITURE)

	slot4 = RedPointConst.DORM_SUIT_SHOP

	manager.redPoint:bindUIandKey(slot0.btn_storeBtn_.transform, slot4)

	for slot4 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		DormRedPointTools:UpdataDormFurRedPoint(slot0.sceneID_, slot4)
	end

	if DormTools:ShouldShowBirthdayBtn(slot0.sceneID_) then
		SetActive(slot0.birthdayBtn_.gameObject, true)
	else
		SetActive(slot0.birthdayBtn_.gameObject, false)
	end
end

function slot0.RefreshBar(slot0)
	if slot0.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})

		if #GameSetting.dorm_info_describe.value > 0 then
			manager.windowBar:SetGameHelpKey({
				view = "/gameHelpPro",
				type = "jump",
				params = {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = slot1
				}
			})
		end
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end

	manager.windowBar:RegistBackCallBack(function ()
		if DormVisitTools:GetIsOtherSystem() then
			if DormVisitTools:GetBackFunc() then
				slot1()
			else
				BackHomeTools:OtherSystemVisitExit()
				OpenPageUntilLoaded("/home")
			end

			return
		end

		if uv0.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
			JumpTools.OpenPageByJump("/dormChooseRoomView")
		else
			DormVisitTools:ClearVisitRoomData()

			if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
				BackHomeTools:BackHomeGotoMain()
				OpenPageUntilLoaded("/dormVisitView")
			else
				DormitoryData:VisitFlag(true)
				BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
			end
		end
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		BackHomeTools:BackHomeGotoMain()
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.positionBtn_.transform, RedPointConst.DORM_PLACEMENT)
	manager.redPoint:unbindUIandKey(slot0.fureidbtnBtn_.transform, RedPointConst.DORM_FURNITURE)
	manager.redPoint:unbindUIandKey(slot0.btn_storeBtn_.transform, RedPointConst.DORM_SUIT_SHOP)
	slot0.menuController:SetSelectedState("off")

	slot0.menuState = false

	slot0:RemoveAllEventListener()
	slot0.quickView:OnExit()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.cacheRoles = {}
	slot0.menuState = false
	slot0.menuController = ControllerUtil.GetController(slot0.btn_menuGo_.transform, "menu")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.exhibitController = ControllerUtil.GetController(slot0.exhib.transform, "state")
	slot0.publicTextController = ControllerUtil.GetController(slot0.transform_, "public")
	slot0.showUiController = ControllerUtil.GetController(slot0.btn_hideGo_.transform, "btn")
	slot0.friendController = ControllerUtil.GetController(slot0.transform_, "addFriend")
	slot0.menuAnimator = slot0:FindCom(typeof(Animator), "", slot0.menu_listTrs_)
	slot0.quickView = BackHomeQuickJumpView.New(slot0.tempquickGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.positionBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	slot0:AddBtnListenerScale(slot0.characterplacebtnBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormHeroDeployView")
	end)
	slot0:AddBtnListenerScale(slot0.templateBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormTemplateView", {
			pos = 1
		})
	end)
	slot0:AddBtnListenerScale(slot0.fureidbtnBtn_, nil, function ()
		DormHeroTools.HideAllCharacter()
		JumpTools.OpenPageByJump("/roomEdit")
		DormFurEditStateData:EnterEditState()
	end)
	slot0:AddBtnListenerScale(slot0.dormlevelBtn_, nil, function ()
		if BackHomeCfg[uv0.sceneID_].type ~= DormConst.BACKHOME_TYPE.PrivateDorm then
			return
		end

		if DormitoryData:GetArchiveIDViaRoomID(uv0.sceneID_)[1] then
			JumpTools.OpenPageByJump("/dormLevelInfoView", {
				archiveID = slot0
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.btn_storeBtn_, nil, function ()
		JumpTools.GoToSystem("/dormShop", {
			hideHomeBtn = true,
			shop = ShopConst.SHOP_ID.DORM_SHOP,
			shopList = DormTools:GetAllDormShopIDList()
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListenerScale(slot0.btn_menuBtn_, nil, function ()
		if uv0.menuState then
			uv0.menuController:SetSelectedState("off")

			uv0.menuState = false
		else
			uv0.menuController:SetSelectedState("on")

			uv0.menuState = true

			uv0.menuAnimator:Play("DormitoryUI_menu_list")
		end
	end)
	slot0:AddBtnListenerScale(slot0.exhibBtn_, nil, function ()
		if not DormVisitTools:GetCurTemplateExhibit() or uv0.sceneID_ ~= slot0 then
			DormAction:SetFurTemplateExhibit(uv0.sceneID_)
		else
			ShowTips(GetTips("DORM_DISPLAY_ALREADY"))
		end
	end)
	slot0:AddBtnListenerScale(slot0.collectBtn_, nil, function ()
		slot0, slot1 = DormVisitTools:CheckCanSaveTemplate()

		if slot0 then
			JumpTools.OpenPageByJump("/dormVisitTemplateView")
		else
			ShowTips(slot1)
		end
	end)
	slot0:AddBtnListenerScale(slot0.addFriendBtn_, nil, function ()
		if DormVisitTools:GetVisitUserID() then
			FriendsAction:TryToRequestToFriend(slot0, FriendConst.ADD_FRIEND_SOURCE.DORM)
		end
	end)
	slot0:AddBtnListenerScale(slot0.btn_hideBtn_, nil, function ()
		if uv0.uiShow then
			uv0:HideUiInfo(false)
		else
			uv0:HideUiInfo(true)
		end
	end)
	slot0:AddBtnListenerScale(slot0.giftBtn_, nil, function ()
		if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot0)[1]) then
			if slot2:GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
				slot5 = nil
				slot9 = pairs

				for slot9, slot10 in Dorm.storage:ForeachData(DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero), slot9) do
					slot5 = slot10
				end

				if slot5 then
					DormLuaBridge.ActAsClickToEntity(slot5)
				else
					print("未找到人物eid")
				end
			else
				JumpTools.OpenPageByJump("/dormHeroGiftView", {
					archiveID = slot1
				})
			end
		end
	end)
	slot0.quickView:AddClickCallBack(function ()
		manager.windowBar:HideBar()
	end)
	slot0.quickView:CloseCallBack(function ()
		uv0:RefreshBar()
	end)
	slot0:AddBtnListenerScale(slot0.reportBtn_, nil, function ()
		if DormVisitTools:GetVisitUserID() then
			if DormVisitTools:GetExhibitListByUserID(slot0) then
				JumpTools.OpenPageByJump("/chatReport", {
					reportType = ChatConst.CHAT_REPORT_TYPE.DORM,
					reportData = {
						nick = slot1.nick or "",
						userID = slot0,
						layout_uid = DormVisitTools:GetLayoutID(),
						architecture_id = slot1.architecture_id
					}
				}, ViewConst.SYSTEM_ID.CHAT_REPORT)
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.devbtnBtn_, nil, function ()
		DormData:ChangeDevModelFlag(not DormData:GetDevModelFlag())
		uv0:RefreshDevInfo()
	end)
	slot0:AddBtnListenerScale(slot0.likeBtn, nil, function ()
		if uv0.stateController:GetSelectedState() == "visit" then
			if DormVisitTools:GetCurVisitRoomData().todayLikeNum < GameSetting.dorm_room_like_limted.value[1] and slot1 then
				DormAction.LikeDormRoom(DormVisitTools:GetVisitUserID(), slot1.architecture_id, function ()
				end)
			else
				ShowTips("DORM_SINGLE_ROOM_PRAISE_NUM")
			end
		end
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(ON_PLAYER_CLICK_INTERACT, function (slot0, slot1)
		uv0.showUiController:SetSelectedState("off")
		SetActive(uv0.btn_hideBtn_.gameObject, false)
		manager.windowBar:HideBar()

		if DormConst.DORM_VISIT_ROOM_MIN < uv0.sceneID_ then
			return
		end

		Dorm.DormEntityManager.EnablePlayerInput = false

		DormUtils.ClearCharaHasSpecialVfx(slot0)
		DormUtils.HideCharaSpecialVfx(slot0)
		Timer.New(function ()
			uv0.showUiController:SetSelectedState("on")
			SetActive(uv0.btn_hideBtn_.gameObject, true)
			JumpTools.OpenPageByJump("/heroInteractView", {
				heroEID = uv1
			})
		end, DormConst.CHARACTER_INTERACT_CAMERA_MOVE_TIME, 1):Start()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.InteractCam)

		slot6 = pairs

		for slot6, slot7 in Dorm.storage:ForeachData(DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero), slot6) do
			if slot7 ~= slot0 then
				Dorm.DormEntityManager.FadeOutNearPoint(slot7, UnityEngine.Camera.main.transform, DormLuaBridge.GetCamFadeOtherCharaParam(nil, ))
			end
		end
	end)
	slot0:RegistEventListener(DORM_REFRESH_EXIBIT, function ()
		if uv0.sceneID_ == DormVisitTools:GetCurTemplateExhibit() then
			ShowTips(GetTips("DORM_DISPLAY_SET_SUCCESS"))
			uv0.exhibitController:SetSelectedState("true")
		else
			uv0.exhibitController:SetSelectedState("false")
		end
	end)
	slot0:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function ()
		ShowTips(GetTips("DORM_LEVEL_UP_TIPS"))
		uv0:RefreshRoomLevel()
	end)
	slot0:RegistEventListener(ON_DORM_CHARACTER_GRAB_STARTED, function ()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.UpCharacter)
	end)
	slot0:RegistEventListener(ON_DORM_CHARACTER_GRAB_RELEASED, function ()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.DownCharacter)
	end)
	slot0:RegistEventListener(ON_BEGIN_STORY, function (slot0)
		SetActive(uv0.birthdayBtn_.gameObject, false)
		manager.windowBar:HideBar()
		DormCharacterManager.GetInstance():OnBeginStory(slot0)
		DormFurnitureManager.GetInstance():OnBeginStory(slot0)
	end)
	slot0:RegistEventListener(ON_FINISH_STORY, function (slot0)
		GameObject.Destroy(uv0)

		uv0 = nil

		SetActive(uv1.gameObject_, true)
		uv1:RefreshBar()
		DormFurnitureManager.GetInstance():OnFinishStory(slot0)
		DormCharacterManager.GetInstance():OnFinishStory(slot0)
	end)
	slot0:RegistEventListener(DORM_LIKE_NUM_REFRESH, function ()
		uv0:RefreshLikeNum()
		uv0:RefreshLikeBtnState()
	end)
end

function slot0.RefreshRoomLevel(slot0)
	if DormitoryData:GetDormLevel(slot0.sceneID_) then
		slot0.roomLevel.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), slot1)
	end
end

function slot0.UpdateView(slot0)
	slot0.attractiveLabel_.text = DormData:GetSceneAttractiveValue(DormData:GetCurrectSceneID())
end

function slot0.HideUiInfo(slot0, slot1)
	slot0.uiShow = slot1

	if slot0.uiShow then
		slot0.showUiController:SetSelectedState("on")
		slot0:RefreshBar()
	else
		slot0.showUiController:SetSelectedState("off")
		manager.windowBar:HideBar()
	end
end

function slot0.RefreshDevInfo(slot0)
	if DormData:GetDevModelFlag() then
		SetActive(slot0.devbtnBtn_.transform.gameObject, slot1)
	end

	SetActive(slot0.devText, slot1)
end

function slot0.AutoOpenSuitHelpPage(slot0)
	if not DormSuitData:GetSuitHelpFlag() then
		FrameTimer.New(function ()
			if not manager.guide:IsPlaying() and uv0.sceneID_ < DormConst.DORM_VISIT_ROOM_MIN then
				JumpTools.OpenPageByJump("gameHelpPro", {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = GameSetting.dorm_info_describe.value,
					startIndex = GameSetting.dorm_how_to_play_forced_eject.value[1]
				})
				DormSuitData:SetSuitHelpFlag(true)
			end
		end, 0.1, 1):Start()
	end
end

function slot0.UpdataDormitoryInternalRedPoint(slot0)
	slot1 = {}

	if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot1 = {
			RedPointConst.DORM_FULL_PUBLIC_SUIT,
			RedPointConst.DORM_PART_SUIT
		}
	elseif slot3 == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot1 = {
			RedPointConst.DORM_FULL_PRIVATE_SUIT,
			RedPointConst.DORM_PART_SUIT
		}
	end

	manager.redPoint:addGroup(RedPointConst.DORM_SUIT, slot1, true)
	DormRedPointTools:UpdataSuitRedPoint()
end

function slot0.RefreshLikeNum(slot0)
	if slot0.stateController:GetSelectedState() == "room" then
		if DormitoryData:GetDormSceneData(DormData:GetCurrectSceneID()) then
			slot0.likeNum.text = NumberTools.RetractNumberForWindBar(slot2.likeNum)
		end

		if DormitoryData:GetLastLikeNum() < slot2.likeNum then
			slot0.praiseAnimator:Play("btn_praise", 0, 0)
		end

		DormitoryData:SetLastLikeNum(slot2.likeNum)
	end
end

function slot0.RefreshLikeBtnState(slot0)
	if slot0.stateController:GetSelectedState() == "visit" then
		if DormVisitTools:GetCurVisitRoomData().todayLikeNum and slot1.todayLikeNum > 0 then
			slot0.likeBtnStateController:SetSelectedState("true")
		else
			slot0.likeBtnStateController:SetSelectedState("false")
		end

		slot0.curLikeNum.text = NumberTools.RetractNumberForWindBar(slot1.likeNum)
	end
end

function slot0.Dispose(slot0)
	slot0.quickView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
