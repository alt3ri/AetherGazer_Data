slot0 = class("NewUserAndPlayerInfoView", ReduxView)
slot1 = 1
slot2 = 860

function slot0.UIName(slot0)
	return "Widget/System/UserInfor/UserInfoUInew"
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

	slot1 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or not SDKTools.GetIsOverSea() and _G.CHANNEL_MASTER_ID ~= 1

	SetActive(slot0.userCenterBtn_.gameObject, not slot1)
	SetActive(slot0.logoutBtn_.gameObject, slot1)

	slot0.curTagList_ = {}
	slot0.tagItem_ = {}
	slot0.tagContentFitter_ = slot0.tagScrollPanel_:GetComponent("ContentSizeFitter")
	slot0.tagCon_ = ControllerUtil.GetController(slot0.transform_, "tag")
	slot0.likeCon_ = ControllerUtil.GetController(slot0.transform_, "like")
	slot0.dormCon_ = ControllerUtil.GetController(slot0.transform_, "dorm")
	slot0.guildCon_ = ControllerUtil.GetController(slot0.transform_, "guild")
	slot0.onlineCon_ = ControllerUtil.GetController(slot0.transform_, "online")
	slot0.newFriendCon_ = ControllerUtil.GetController(slot0.transform_, "newFriend")
	slot0.friendStateCon_ = ControllerUtil.GetController(slot0.transform_, "friendState")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.systemCon_ = ControllerUtil.GetController(slot0.transform_, "system")
	slot0.signCon_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("sign")
	slot0.tagSelectPanel_ = TagView.New(slot0.tagSelectPanelGo_)

	slot0.tagSelectPanel_:RegisterClickFunction(handler(slot0, slot0.TagSelectCallback))
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.nameBtn_, nil, function ()
		if table.keyof(uv0.operationInfo_, OperationConst.CHANGE_NICK) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		JumpTools.OpenPageByJump("changeName")
	end)
	slot0:AddBtnListener(slot0.changeNameBtn_, nil, function ()
		if table.keyof(uv0.operationInfo_, OperationConst.CHANGE_NICK) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		JumpTools.OpenPageByJump("changeName")
	end)
	slot0:AddBtnListener(slot0.signBtn_, nil, function ()
		uv0.signInput_.text = uv0.sign_

		SetActive(uv0.signInput_.gameObject, true)
		uv0.signInput_:ActivateInputField()
		SetActive(uv0.signTxt_.gameObject, false)
	end)
	slot0.signInput_.onEndEdit:AddListener(function ()
		if table.keyof(uv0.operationInfo_, OperationConst.CHANGE_SIGN) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")
			SetActive(uv0.signInput_.gameObject, false)
			SetActive(uv0.signTxt_.gameObject, true)

			return
		end

		if uv0.signInput_.text ~= nil and slot0 ~= "" and uv0.sign_ == slot0 then
			SetActive(uv0.signInput_.gameObject, false)
			SetActive(uv0.signTxt_.gameObject, true)

			return
		end

		slot0, slot2 = textLimit(slot0, GameSetting.personal_signature_max.value[1])

		if not slot2 then
			ShowTips("PERSONAL_SIGNATURE_MAX")
			SetActive(uv0.signInput_.gameObject, false)
			SetActive(uv0.signTxt_.gameObject, true)

			return
		end

		WordVerifyBySDK(slot0, function (slot0)
			slot1 = PlayerData:GetPlayerInfo()

			if not slot0 then
				ShowTips("SENSITIVE_WORD")
				uv0:RefreshSign(slot1.sign)
				SetActive(uv0.signInput_.gameObject, false)
				SetActive(uv0.signTxt_.gameObject, true)

				return
			end

			if slot1.sign == uv1 then
				SetActive(uv0.signInput_.gameObject, false)
				SetActive(uv0.signTxt_.gameObject, true)

				return
			end

			slot2 = false

			if uv1:find("\n") then
				uv1 = string.gsub(uv1, "\n", "")
				slot2 = true
			end

			PlayerAction.ChangeSign(uv1, slot2)
		end, JUDGE_MESSAGE_TYPE.PLAYER_SIGN)
	end)
	slot0:AddBtnListener(slot0.logoutBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_EXIT_GAME"),
			OkCallback = function ()
				OperationRecorder.Record("account_change", "account_change_confirm")
				BulletinData.OnLogout()
				manager.rollTips:OnLogout()
				GameToSDK.Logout()
			end,
			CancelCallback = function ()
				OperationRecorder.Record("account_change", "account_change_cancel")
			end
		})
	end)
	slot0:AddBtnListener(slot0.userCenterBtn_, nil, function ()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.servantbtnBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("userinfo_spirit")
		JumpTools.OpenPageByJump("/illuServantManual")
	end)
	slot0:AddBtnListener(slot0.illustratedAchievementBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("userinfo_achievement")

		if manager.windowBar:GetWhereTag() ~= nil then
			return
		end

		JumpTools.GoToSystem("/achievementManager", nil, ViewConst.SYSTEM_ID.ACHIEVEMENT)
	end)
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("userinfo_headportrait")
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	slot0:AddBtnListener(slot0.brithdayBtn_, nil, function ()
		JumpTools.OpenPageByJump("BirthdayView")
	end)
	slot0:AddBtnListener(slot0.tagBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("userinfo_usertag")
		uv0:ShowTagView()
	end)
	slot0:AddBtnListener(slot0.hideTagBtn_, nil, function ()
		uv0:HideTagView()
		PlayerAction.ChangTagList(uv0.curTagList_)
	end)
	slot0:AddBtnListener(slot0.likeBtn_, nil, function ()
		if not uv0.isForeign_ then
			JumpTools.OpenPageByJump("likeInfoPop", {
				index = 1
			})
		else
			if table.indexof(uv0.todaySendLike_, uv0.userID_) or GameSetting.profile_like_limitation.value[1] <= #uv0.todaySendLike_ then
				ShowTips("PROFILE_LIKE_REPEAT_PROMPT")

				return
			end

			PlayerAction.SendLike(uv0.userID_, PlayerAction.SendLikeSrc.PlayerInfo)
		end
	end)
	slot0:AddBtnListener(slot0.copyBtn_, nil, function ()
		UnityEngine.GUIUtility.systemCopyBuffer = uv0.userID_

		ShowTips("COPY_SUCCESS")
	end)
	slot0:AddBtnListener(slot0.illustratedStickerBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("userinfo_sticker")
		JumpTools.OpenPageByJump("/MainSticker", {
			index = 1,
			stickerInfo = uv0.stickerList_,
			stickerBg = uv0.stickerBg_,
			type = uv0.isForeign_ and 3 or 1
		})
	end)
	slot0:AddBtnListener(slot0.illustratedHeroBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("userinfo_hero")
		JumpTools.OpenPageByJump("showHeroPop", {
			userID = uv0.userID_,
			isForeign = uv0.isForeign_,
			heroList = uv0.heroList_
		})
	end)
	slot0:AddBtnListener(slot0.dormBtn_, nil, function ()
		if manager.windowBar:GetWhereTag() ~= nil then
			return
		end

		if not uv0.isForeign_ then
			if uv0.dormID_ == 0 then
				ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)))
			elseif GameDisplayCfg.dorm_begin_story.value[1] and not manager.story:IsStoryPlayed(slot0) then
				manager.story:StartStoryById(slot0, function (slot0)
					JumpTools.OpenPageByJump("/dormChooseRoomView")
				end)
			elseif BackHomeCfg[uv0.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
				BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
			else
				BackHomeTools:GotoBackHomeRoom(uv0.dormID_)
			end
		else
			if not uv0.dormID_ or uv0.dormID_ == 0 then
				ShowTips("PLAYER_DORM_LOCK")

				return
			end

			DormVisitTools:SetIsOtherSystem(true)
			DormVisitTools:SetBackFunc(function ()
				OpenPageUntilLoaded("/playerinfo", {
					isForeign = uv0.isForeign_
				})
			end)
			SDKTools.SendMessageToSDK("backhome_dorm_visit_jump", {
				backhome_source = 1
			})
			DormAction:OtherSystemAskSingleFurTemplateExhibit(uv0.userID_)
		end
	end)
	slot0:AddBtnListener(slot0.guildBtn_, nil, function ()
		if JumpTools.IsSystemOperationStoped(ViewConst.SYSTEM_ID.GUILD) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		slot0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD)

		if not uv0.isForeign_ and slot0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.GUILD, slot0))

			return
		end

		if GuildData.IsGuildValid(uv0.guildID_) then
			ForeignInfoAction:SearchGuildInfo(uv0.guildID_, 1)
		end
	end)
	slot0:AddBtnListener(slot0.buttonAdd_, nil, function ()
		if uv0.newFriendCon_:GetSelectedState() == "1" then
			ShowTips("PROFILE_FRIENDS_APPLYING")

			return
		end

		FriendsAction:TryToRequestToFriend(uv0.userID_, FriendConst.ADD_FRIEND_SOURCE.PLAYER_INFO)
		uv0.newFriendCon_:SetSelectedState(1)
	end)
	slot0:AddBtnListener(slot0.buttonTalk_, nil, function ()
		if not FriendsData:GetFreshFlag() then
			FriendsAction:TryToRefreshFriendsView(1, function ()
				ChatFriendData:AddCacheFriend(uv0.userID_)
				JumpTools.OpenPageByJump("chat", {
					ignoreBG = true,
					chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
					friendID = uv0.userID_
				}, ViewConst.SYSTEM_ID.CHAT)
			end)

			return
		end

		ChatFriendData:AddCacheFriend(uv0.userID_)
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
			friendID = uv0.userID_
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	slot0:AddBtnListener(slot0.buttonDeleteFriend_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_DELETE_QUEST"), uv0.nick_),
			OkCallback = function ()
				FriendsAction:TryToDelectFromMyFriendsList(uv0.userID_)
				uv0:Back()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonMore_, nil, function ()
		if uv0.isPop_ then
			uv0.isPop_ = false

			uv0:HidePop()

			return
		end

		SetActive(uv0.goPop_, true)
		uv0:AddClickTimer()

		uv0.isPop_ = true
	end)
	slot0:AddBtnListener(slot0.buttonReport_, nil, function ()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.USER,
			reportData = {
				nick = uv0.nick_,
				userID = uv0.userID_
			}
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	slot0:AddBtnListener(slot0.buttonBlackList_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_MOVE_TO_BLACLIST_QUEST"), uv0.nick_),
			OkCallback = function ()
				FriendsAction:TryToAddToBlacklist(uv0.userID_)
				uv0:Back()
			end
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.isForeign_ = slot0.params_.isForeign

	SetActive(slot0.likeAddGo_, false)
	slot0:HideTagView()
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if not slot0.isForeign_ then
		slot0.stateCon_:SetSelectedState("user")
		slot0.signCon_:SetSelectedIndex(1)
		slot0:BindRedPoint()

		slot0.operationInfo_ = OperationData:GetOperationOpenList()

		slot0:RefreshUserData()
		slot0:RefreshExpInfo(slot0.lv_, slot0.exp_)
	else
		slot0.stateCon_:SetSelectedState("player")
		slot0:HidePop()
		slot0:RefreshPlayerData()
		slot0:RefreshFriendState()
		slot0:RefreshOnlineState()
		slot0.signCon_:SetSelectedIndex(FriendsData:IsFriend(slot0.userID_) and 1 or 0)
	end

	slot0:RefreshSystem()
	slot0:RefreshBtn()
	slot0:RefreshIP(slot0.ip_)
	slot0:RefreshID(slot0.userID_)
	slot0:RefreshName(slot0.nick_)
	SetActive(slot0.signInput_.gameObject, false)
	SetActive(slot0.signTxt_.gameObject, true)
	slot0:RefreshSign(slot0.sign_)
	slot0:RefreshLvInfo(slot0.lv_)
	slot0:RefreshHead(slot0.headIconID_)
	slot0:RefreshFrame(slot0.iconFrameID_)
	slot0:RefreshGuild(slot0.guildID_, slot0.guildName_, slot0.guildIcon_)
	slot0:RefreshBirthday()
	slot0:RefreshTag(slot0.tagList_)
	slot0:RefreshCardBg(slot0.cardBg_)
	slot0:RefreshDorm(slot0.dormID_, slot0.dormName_)
	slot0:RefreshAchievement()
	slot0:RefreshLike(slot0.likeCnt_)

	if not slot0.params_.maskScene then
		slot0:RefreshGirl(slot0.postGirl_)
		slot0:RefreshScene()
	end

	slot0:RefreshBgImage()
end

function slot0.RefreshUserData(slot0)
	slot1 = PlayerData:GetPlayerInfo()
	slot0.ip_ = slot1.ip
	slot0.nick_ = slot1.nick
	slot0.sign_ = slot1.sign
	slot0.lv_ = slot1.userLevel
	slot0.userID_ = slot1.userID
	slot0.exp_ = slot1.remain_exp
	slot0.headIconID_ = slot1.portrait
	slot0.iconFrameID_ = slot1.icon_frame
	slot0.birthdayMonth_ = slot1.birthday_month
	slot0.birthdayDay_ = slot1.birthday_day
	slot0.likeCnt_ = slot1.likes
	slot0.cardBg_ = slot1.card_bg_id
	slot0.tagList_ = PlayerData:GetUsingTagListInfo()
	slot0.postGirl_ = HeroTools.HeroUsingSkinInfo(slot1.poster_girl).id

	if GuildData:GetGuildInfo() and slot3.id and slot3.name then
		slot0.guildID_ = slot3.id
		slot0.guildName_ = slot3.name
		slot0.guildIcon_ = slot3.icon
	else
		slot0.guildID_ = GuildData.INVALID_GUILD
		slot0.guildName_ = ""
		slot0.guildIcon_ = 0
	end

	slot0.dormID_ = 0
	slot0.dormName_ = ""

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		slot0.dormID_ = DormVisitTools:GetCurTemplateExhibit() == 0 and DormConst.PUBLIC_DORM_ID or slot4

		if BackHomeCfg[slot0.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot0.dormName_ = GetTips("DORM_LOBBY_NAME")
		elseif HeroRecordCfg.get_id_list_by_hero_id[DormitoryData:GetDormSceneData(slot0.dormID_).archiveIDList[1]][1] and HeroRecordCfg[slot6].name then
			slot0.dormName_ = string.format(GetTips("DORM_HERO_ROOM_NAME"), slot7)
		end
	end

	slot0.heroList_ = {}

	for slot8, slot9 in ipairs(PlayerData:GetHeroShowList()) do
		slot10 = HeroData:GetHeroData(slot9)
		slot0.heroList_[slot8] = {
			hero_id = slot9,
			star = slot10.star,
			level = slot10.level,
			using_skin = slot10.using_skin
		}
	end

	slot0.stickerList_ = slot1.sticker_show_info
	slot0.stickerBg_ = slot1.sticker_background
	slot0.heroAll_ = 0
	slot0.heroNum_ = HeroData:GetHeroNum()

	for slot10, slot11 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if not HideInfoData:GetHeadIconHideList()[slot11] then
			slot0.heroAll_ = slot0.heroAll_ + 1
		end
	end

	slot0.weaponServantAll_ = 0
	slot9 = IllustratedData
	slot11 = slot9
	slot0.weaponServantNum_ = table.length(slot9.GetServantInfo(slot11))

	for slot10, slot11 in ipairs(WeaponServantCfg.all) do
		if not ServantTools.GetIsHide(slot11) and (IllustratedData:GetServantInfo()[slot11] or WeaponServantCfg[slot11].display_type ~= 1) then
			slot0.weaponServantAll_ = slot0.weaponServantAll_ + 1
		end
	end

	slot0.stickerAll_ = #ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NORMAL_STICKER]
	slot0.stickerNum_ = #slot1.all_sticker_list

	for slot10, slot11 in ipairs(slot1.all_sticker_list) do
		if ItemCfg[slot11].sub_type == ItemConst.ITEM_SUB_TYPE.SPECIAL_STICKER then
			slot0.stickerAll_ = slot0.stickerAll_ + 1
		end
	end

	slot0.achieveAll_ = AchievementData:GetAchievementTotalCnt()
	slot0.achieveNum_ = AchievementData:GetFinishAchievementCnt()
end

function slot0.RefreshPlayerData(slot0)
	slot1 = ForeignInfoData:GetCurForeignDetailInfo()
	slot0.ip_ = slot1.ip
	slot0.nick_ = slot1.nick
	slot0.sign_ = slot1.sign
	slot0.lv_ = slot1.level
	slot0.userID_ = slot1.user_id
	slot0.headIconID_ = slot1.icon
	slot0.iconFrameID_ = slot1.icon_frame
	slot0.isOnline_ = slot1.is_online
	slot0.likeCnt_ = slot1.likes
	slot0.cardBg_ = slot1.card_bg_id
	slot0.tagList_ = slot1.used_tag_list
	slot0.postGirl_ = slot1.postGril
	slot0.guildID_ = slot1.guildID
	slot0.guildName_ = slot1.guildName
	slot0.guildIcon_ = slot1.guildIcon
	slot0.dormID_ = slot1.backhome_architecture_id
	slot0.dormName_ = ""

	if slot0.dormID_ ~= 0 then
		if BackHomeCfg[slot0.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot0.dormName_ = GetTips("DORM_LOBBY_NAME")
		else
			slot0.dormName_ = string.format(GetTips("DORM_HERO_ROOM_NAME"), HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[slot1.hero_id_list[1]][1]].name)
		end
	end

	slot0.heroList_ = {}

	for slot7, slot8 in ipairs(slot1.hero_list) do
		slot0.heroList_[slot7] = {
			hero_id = slot8.hero_id,
			star = slot8.star,
			level = 0,
			using_skin = slot8.using_skin
		}
	end

	slot0.stickerList_ = slot1.sticker_show_info
	slot0.stickerBg_ = slot1.sticker_background
	slot4 = slot1.hero_static_info
	slot0.heroNum_ = slot4.not_hide_num + slot4.hide_num
	slot0.heroAll_ = 0

	for slot10, slot11 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if not HideInfoData:GetHeadIconHideList()[slot11] then
			slot0.heroAll_ = slot0.heroAll_ + 1
		end
	end

	slot0.heroAll_ = slot0.heroAll_ + slot4.cfg_hide_num
	slot7 = slot1.weapon_servant_static_info
	slot0.weaponServantNum_ = slot7.not_hide_num + slot7.hide_num
	slot0.weaponServantAll_ = 0

	for slot11, slot12 in ipairs(WeaponServantCfg.all) do
		if not ServantTools.GetIsHide(slot12) and WeaponServantCfg[slot12].display_type ~= 1 then
			slot0.weaponServantAll_ = slot0.weaponServantAll_ + 1
		end
	end

	slot0.weaponServantAll_ = slot0.weaponServantAll_ + slot7.cfg_hide_num
	slot8 = slot1.sticker_static_info
	slot0.stickerNum_ = slot8.not_hide_num + slot8.cfg_hide_num
	slot0.stickerAll_ = #ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NORMAL_STICKER] + slot8.cfg_hide_num
	slot0.achieveNum_ = slot1.achievement_static_info.not_hide_num
	slot0.achieveAll_ = 0

	for slot13, slot14 in ipairs(AchievementCfg.all) do
		if AchievementCfg[slot14].is_hide ~= 1 then
			slot0.achieveAll_ = slot0.achieveAll_ + 1
		end
	end

	slot0.achieveAll_ = slot0.achieveAll_ + slot9.cfg_hide_num
	slot0.todaySendLike_ = PlayerData:GetTodaySendLikeList() or {}
end

function slot0.RefreshSystem(slot0)
	slot0.systemCon_:SetSelectedState(manager.windowBar:GetWhereTag() == nil and "on" or "off")
end

function slot0.RefreshBtn(slot0)
	slot0.signBtn_.interactable = not slot0.isForeign_
	slot0.headBtn_.interactable = not slot0.isForeign_
	slot0.nameBtn_.interactable = not slot0.isForeign_
	slot0.changeNameBtn_.interactable = not slot0.isForeign_
	slot0.servantbtnBtn_.interactable = not slot0.isForeign_
	slot0.illustratedAchievementBtn_.interactable = not slot0.isForeign_
end

function slot0.RefreshExpInfo(slot0, slot1, slot2)
	if LvTools.GetIsMaxLv(slot1, "user") then
		slot0.expTxt_.text = "-/-"
		slot0.progressTrs_.value = 1
	else
		slot3 = GameLevelSetting[slot1].user_level_exp
		slot0.expTxt_.text = string.format("%d/%d", slot2, slot3)
		slot0.progressTrs_.value = slot2 / slot3
	end
end

function slot0.RefreshFriendState(slot0)
	if FriendsData:GetInfoByID(slot0.userID_) then
		if slot1.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			slot0.friendStateCon_:SetSelectedState("myFriend")
		elseif slot2 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
			slot0.friendStateCon_:SetSelectedState("newFriend")
			slot0.newFriendCon_:SetSelectedState(slot1.isDeal and 1 or 0)
		elseif slot2 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
			slot0.friendStateCon_:SetSelectedState("request")
			slot0.newFriendCon_:SetSelectedState(1)
		end
	else
		slot0.friendStateCon_:SetSelectedState("newFriend")
		slot0.newFriendCon_:SetSelectedState(FriendsData:IsInRequest(slot0.userID_) and 1 or 0)
	end
end

function slot0.RefreshOnlineState(slot0)
	slot0.onlineCon_:SetSelectedState(slot0.isOnline_ == 1 and "on" or "off")
end

function slot0.RefreshIP(slot0, slot1)
	SetActive(slot0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	slot0.ipTxt_.text = slot1

	if slot0.ipGo_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.ipGo_.transform)
	end
end

function slot0.RefreshID(slot0, slot1)
	slot0.uid_.text = slot1
end

function slot0.RefreshName(slot0, slot1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		slot2, slot0.name_.text = wordVerify(slot1, {
			isReplace = true
		})
	else
		slot0.name_.text = slot1
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.namePanel_)
end

function slot0.RefreshSign(slot0, slot1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		slot2, slot3 = wordVerify(string.gsub(slot1, "\n", ""), {
			isReplace = true
		})
		slot0.signTxt_.text = slot3 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or slot3
	else
		slot0.signTxt_.text = slot1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or slot1
	end
end

function slot0.RefreshHead(slot0, slot1)
	slot0.headIcon_.sprite = ItemTools.getItemSprite(slot1)

	slot0.headIcon_:SetNativeSize()
end

function slot0.RefreshFrame(slot0, slot1)
	slot0.headFrameIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1)

	slot0.headFrameIcon_:SetNativeSize()
end

function slot0.RefreshLvInfo(slot0, slot1)
	slot0.lvTxt_.text = slot1
end

function slot0.RefreshGuild(slot0, slot1, slot2, slot3)
	if slot1 == 0 or slot1 == "0" then
		slot0.guildCon_:SetSelectedState("false")
	else
		slot0.guildTxt_.text = slot2

		if ClubHeadIconCfg[slot3] then
			slot0.guildIconImg_.sprite = getSpriteViaConfig("ClubHeadIcon", slot4.icon_bg)
		end

		slot0.guildCon_:SetSelectedState("true")
	end
end

function slot0.RefreshBirthday(slot0)
	SetActive(slot0.birthdayPanelGo_, not slot0.isForeign_)

	if slot0.birthdayDay_ == 0 then
		SetActive(slot0.brithdayBtn_.gameObject, not slot0.isForeign_)
		SetActive(slot0.brithdayTxt_.gameObject, false)
	else
		SetActive(slot0.brithdayBtn_.gameObject, false)
		SetActive(slot0.brithdayTxt_.gameObject, true)

		slot0.brithdayTxt_.text = string.format(GetTips("OTHER_BIRTHDAY"), slot0.birthdayMonth_, slot0.birthdayDay_)
	end
end

function slot0.RefreshDorm(slot0, slot1, slot2)
	if slot1 == 0 then
		slot0.dormCon_:SetSelectedState("false")
	else
		slot0.dormText_.text = slot2

		slot0.dormCon_:SetSelectedState("true")
	end
end

function slot0.RefreshTag(slot0, slot1)
	slot0.curTagList_ = slot1

	slot0.tagCon_:SetSelectedState(#slot1 > 0 and "off" or "on")
	slot0:StopTagScroll()

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.tagItem_[slot5] then
			slot0.tagItem_[slot5] = NewUserAndPlayerInfoTagItem.New(Object.Instantiate(slot0.tagTemplate_, slot0.tagContent_))
		end

		slot0.tagItem_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.tagItem_ do
		slot0.tagItem_[slot5]:Show(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.tagPanel_)

	if slot0.tagContent_.transform.rect.width <= uv0 then
		slot0.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.tagScrollPanel_)
	else
		slot0.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		slot0.tagScrollPanel_.sizeDelta = Vector2(slot2, slot0.tagScrollPanel_.sizeDelta.y)
		slot0.tagContent_.anchoredPosition = Vector3.New(0, slot0.tagContent_.anchoredPosition.y, 0)

		if slot0.isTagShow_ then
			return
		end

		slot0.tagScrollTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
			if uv0.tagContent_.anchoredPosition.x <= -1 * uv0.tagContent_.transform.rect.width then
				uv0.tagContent_.anchoredPosition = Vector3.New(uv1, uv0.tagContent_.anchoredPosition.y, 0)
			end

			uv0.tagContent_.anchoredPosition = Vector3.New(uv0.tagContent_.anchoredPosition.x - uv2, uv0.tagContent_.anchoredPosition.y, 0)
		end, -1, true)
	end
end

function slot0.RefreshCardBg(slot0, slot1)
	slot2 = ProfileBusinessCardCfg[slot1]

	if slot2.type == 1 then
		slot0.cardBgIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/UserInfor/" .. slot2.resource)
	elseif slot2.type == 2 then
		-- Nothing
	elseif slot2.type == 3 then
		-- Nothing
	end
end

function slot0.RefreshAchievement(slot0)
	slot0.heroTxt_.text = slot0.heroNum_ .. "/" .. slot0.heroAll_

	if slot0.heroNum_ == slot0.heroAll_ then
		slot0.heroPre_.text = "100%"
	else
		slot0.heroPre_.text = math.floor(slot0.heroNum_ * 100 / slot0.heroAll_) .. "%"
	end

	slot0.stickerTxt_.text = slot0.stickerNum_ .. "/" .. slot0.stickerAll_

	if slot0.stickerNum_ == slot0.stickerAll_ then
		slot0.stickerPre_.text = "100%"
	else
		slot0.stickerPre_.text = math.floor(slot0.stickerNum_ * 100 / slot0.stickerAll_) .. "%"
	end

	slot0.weaponServantTxt_.text = slot0.weaponServantNum_ .. "/" .. slot0.weaponServantAll_

	if slot0.weaponServantNum_ == slot0.weaponServantAll_ then
		slot0.weaponServantPre_.text = "100%"
	else
		slot0.weaponServantPre_.text = math.floor(slot0.weaponServantNum_ * 100 / slot0.weaponServantAll_) .. "%"
	end

	slot0.achieveTxt_.text = slot0.achieveNum_ .. "/" .. slot0.achieveAll_

	if slot0.achieveNum_ == slot0.achieveAll_ then
		slot0.achievePre_.text = "100%"
	else
		slot0.achievePre_.text = math.floor(slot0.achieveNum_ * 100 / slot0.achieveAll_) .. "%"
	end
end

function slot0.RefreshLike(slot0, slot1)
	if slot1 >= 10000 then
		slot0.like_.text = string.format("%.1f", slot1 / 1000) .. "K"
	else
		slot0.like_.text = slot1
	end

	if not slot0.isForeign_ then
		slot0.likeCon_:SetSelectedState("on")
	else
		slot0.likeCon_:SetSelectedState(table.indexof(slot0.todaySendLike_, slot0.userID_) and "off" or "on")
	end
end

function slot0.RefreshGirl(slot0, slot1)
	if slot0.isForeign_ then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.playerInfo_other, slot1)
	else
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.playerInfo)
	end
end

function slot0.RefreshScene(slot0)
	if not slot0.isForeign_ then
		if CameraCfg["playerInfo_" .. HomeSceneSettingData:GetCurScene()] then
			manager.ui:SetMainCamera(slot2)
		else
			manager.ui:SetMainCamera("playerInfo", false, false)
		end
	else
		slot0:DestoryBackGround()

		slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
		slot0.backGroundTrs_ = slot0.backGround_.transform
		slot5 = GameSetting.profile_other_players_coordinate.value

		slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

		slot0.backGroundTrs_.localPosition = Vector3(slot5[1], slot5[2], slot5[3])
		slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
		slot0.backGroundTrs_.localScale = Vector3(11, 11, 1)
		slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. manager.loadScene:GetHomeShouldLoadSceneName(ForeignInfoData:GetCurForeignDetailInfo().post_background_id))

		manager.ui:SetMainCamera("playerInfo", false, true)
	end
end

function slot0.TagSelectCallback(slot0, slot1)
	slot0:RefreshTag(slot1)
end

function slot0.HidePop(slot0)
	SetActive(slot0.goPop_, false)
end

function slot0.ShowTagView(slot0)
	PlayerData:DealOverdueTagList()
	PlayerData:ClearTagRed()

	slot0.isTagShow_ = true

	slot0.tagSelectPanel_:Show(true)
	slot0.tagSelectPanel_:RefreshUI()
	SetActive(slot0.hideTagBtn_.gameObject, true)
	slot0:RefreshTag(slot0.curTagList_)
end

function slot0.HideTagView(slot0)
	slot0.isTagShow_ = false

	slot0.tagSelectPanel_:Show(false)
	SetActive(slot0.hideTagBtn_.gameObject, false)
end

function slot0.AddClickTimer(slot0)
	slot0:StopTimer()

	slot0.buttonUp_ = 0
	slot0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
		if Input.GetMouseButtonUp(0) then
			uv0.buttonUp_ = uv0.buttonUp_ + 1

			if uv0.buttonUp_ >= 2 then
				uv0:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

				uv0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function slot0.StopTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

function slot0.StopTagScroll(slot0)
	if slot0.tagScrollTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.tagScrollTimer_)

		slot0.tagScrollTimer_ = nil
	end
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.brithdayBtn_.transform, RedPointConst.BRITHDAY)
	manager.redPoint:bindUIandKey(slot0.stickerRedPanel_, RedPointConst.STICKER_ROOT)
	manager.redPoint:bindUIandKey(slot0.headBtn_.transform, RedPointConst.USER_CUSTOM)
	manager.redPoint:bindUIandKey(slot0.tagBtn_.transform, RedPointConst.TAG)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.brithdayBtn_.transform, RedPointConst.BRITHDAY)
	manager.redPoint:unbindUIandKey(slot0.stickerRedPanel_, RedPointConst.STICKER_ROOT)
	manager.redPoint:unbindUIandKey(slot0.headBtn_.transform, RedPointConst.USER_CUSTOM)
	manager.redPoint:unbindUIandKey(slot0.tagBtn_.transform, RedPointConst.TAG)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.Back(nil, {
			userID = uv0.userID_
		})
	end)
end

function slot0.OnChangeNickname(slot0, slot1)
	slot0:RefreshName(slot1.nick)
end

function slot0.OnChangeSign(slot0, slot1, slot2, slot3)
	SetActive(slot0.signInput_.gameObject, false)
	SetActive(slot0.signTxt_.gameObject, true)

	slot0.sign_ = slot2.sign

	slot0:RefreshSign(slot2.sign)

	if slot3 then
		ShowTips("NOT_SUPPORTED_LINE_FEED")
	else
		ShowTips("SUCCESS_CHANGE_SIGNATURE")
	end
end

function slot0.OnChangePortrait(slot0)
	slot0:RefreshHead(PlayerData:GetPlayerInfo().portrait)
end

function slot0.OnChangeFrame(slot0)
	slot0:RefreshFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function slot0.OnChangeBirthday(slot0)
	slot0.birthdayMonth_, slot0.birthdayDay_ = PlayerData:GetPlayerBrithday()

	slot0:RefreshBirthday()
end

function slot0.OnChangeCardBg(slot0, slot1)
	slot2 = PlayerData:GetPlayerInfo()

	slot0:RefreshCardBg(slot1)
end

function slot0.OnChangTagList(slot0)
	slot0.tagList_ = PlayerData:GetUsingTagListInfo()

	slot0:RefreshTag(slot0.tagList_)
end

function slot0.OnGetLike(slot0)
	slot0.likeCnt_ = PlayerData:GetPlayerInfo().likes

	slot0:RefreshLike(slot0.likeCnt_)
end

function slot0.OnSendLike(slot0)
	slot0.todaySendLike_ = PlayerData:GetTodaySendLikeList() or {}

	SetActive(slot0.likeAddGo_, true)

	slot0.likeCnt_ = slot0.likeCnt_ + 1

	slot0:RefreshLike(slot0.likeCnt_)
end

function slot0.OnFriendsDelect(slot0, slot1)
	if slot1 == slot0.userID_ then
		slot0:Back()
	end
end

function slot0.OnCheckForeignInfo(slot0, slot1)
	slot0.params_.isForeign = slot1.isForeign
	slot0.isForeign_ = slot1.isForeign

	slot0:OnEnter()
end

function slot0.DestoryBackGround(slot0)
	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)

		slot0.backGround_ = nil
	end
end

function slot0.RefreshBgImage(slot0)
	if manager.windowBar:GetWhereTag() == "canteen" or slot1 == "dorm" or slot1 == "danceGame" or slot1 == "minigame" then
		SetActive(slot0.bgImg_.gameObject, true)

		slot0.bgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. manager.loadScene:GetHomeShouldLoadSceneName(ForeignInfoData:GetCurForeignDetailInfo().post_background_id))
	else
		SetActive(slot0.bgImg_.gameObject, false)
	end
end

function slot0.OnExit(slot0)
	slot0:StopTagScroll()
	slot0:StopTimer()
	manager.windowBar:HideBar()
	slot0.tagSelectPanel_:OnExit()

	slot4 = PosterGirlConst.ViewTag.null

	manager.posterGirl:SetViewTag(slot4)

	for slot4, slot5 in ipairs(slot0.tagItem_) do
		slot5:OnExit()
	end

	slot0:DestoryBackGround()
	manager.ui:ResetMainCamera()

	slot0.stickerList_ = {}

	slot0:UnbindRedPoint()
	slot0:HidePop()
end

function slot0.Dispose(slot0)
	slot0.signInput_.onEndEdit:RemoveAllListeners()
	slot0.tagSelectPanel_:Dispose()

	for slot4, slot5 in ipairs(slot0.tagItem_) do
		slot5:Dispose()
	end

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
