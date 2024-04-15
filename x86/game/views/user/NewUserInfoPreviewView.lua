slot0 = class("NewUserInfoPreviewView", ReduxView)
slot1 = 1
slot2 = 860

function slot0.UIName(slot0)
	return "UI/Main/PlayercardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
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

	slot0.tagItem_ = {}
	slot0.tagContentFitter_ = slot0.tagScrollPanel_:GetComponent("ContentSizeFitter")
	slot0.tagCon_ = ControllerUtil.GetController(slot0.transform_, "tag")
	slot0.dormCon_ = ControllerUtil.GetController(slot0.transform_, "dorm")
	slot0.guildCon_ = ControllerUtil.GetController(slot0.transform_, "guild")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshUserData()
	slot0:RefreshExpInfo(slot0.lv_, slot0.exp_)
	slot0:RefreshIP(slot0.ip_)
	slot0:RefreshID(slot0.userID_)
	slot0:RefreshName(slot0.nick_)
	SetActive(slot0.signInput_.gameObject, false)
	SetActive(slot0.signTxt_.gameObject, true)
	slot0:RefreshSign(slot0.sign_)
	slot0:RefreshLvInfo(slot0.lv_)
	slot0:RefreshHead(slot0.headIconID_)
	slot0:RefreshFrame(slot0.iconFrameID_)
	slot0:RefreshGuild(slot0.guildID_, slot0.guildName_)
	slot0:RefreshBirthday()
	slot0:RefreshTag(slot0.tagList_)
	slot0:RefreshCardBg(slot0.cardBg_)
	slot0:RefreshDorm(slot0.dormID_, slot0.dormName_)
	slot0:RefreshAchievement()
	slot0:RefreshLike(slot0.likeCnt_)
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
	slot0.cardBg_ = slot0.params_.previewID
	slot0.tagList_ = PlayerData:GetUsingTagListInfo()

	if GuildData:GetGuildInfo() and slot2.id and slot2.name then
		slot0.guildID_ = slot2.id
		slot0.guildName_ = slot2.name
	else
		slot0.guildID_ = 0
		slot0.guildName_ = ""
	end

	slot0.dormID_ = 0
	slot0.dormName_ = ""

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		slot0.dormID_ = DormVisitTools:GetCurTemplateExhibit() == 0 and DormConst.PUBLIC_DORM_ID or slot3

		if BackHomeCfg[slot0.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot0.dormName_ = GetTips("DORM_LOBBY_NAME")
		elseif HeroRecordCfg.get_id_list_by_hero_id[DormitoryData:GetDormSceneData(slot0.dormID_).archiveIDList[1]][1] and HeroRecordCfg[slot5].name then
			slot0.dormName_ = string.format(GetTips("DORM_HERO_ROOM_NAME"), slot6)
		end
	end

	slot0.heroAll_ = 0
	slot0.heroNum_ = HeroData:GetHeroNum()

	for slot8, slot9 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if not HideInfoData:GetHeadIconHideList()[slot9] then
			slot0.heroAll_ = slot0.heroAll_ + 1
		end
	end

	slot0.weaponServantAll_ = 0
	slot0.weaponServantNum_ = table.length(IllustratedData:GetServantInfo())

	for slot8, slot9 in ipairs(WeaponServantCfg.all) do
		if not ServantTools.GetIsHide(slot9) and (IllustratedData:GetServantInfo()[slot9] or WeaponServantCfg[slot9].display_type ~= 1) then
			slot0.weaponServantAll_ = slot0.weaponServantAll_ + 1
		end
	end

	slot0.stickerAll_ = #ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NORMAL_STICKER]
	slot0.stickerNum_ = #slot1.all_sticker_list

	for slot8, slot9 in ipairs(slot1.all_sticker_list) do
		if ItemCfg[slot9].sub_type == ItemConst.ITEM_SUB_TYPE.SPECIAL_STICKER then
			slot0.stickerAll_ = slot0.stickerAll_ + 1
		end
	end

	slot0.achieveAll_ = AchievementData:GetAchievementTotalCnt()
	slot0.achieveNum_ = AchievementData:GetFinishAchievementCnt()
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
end

function slot0.RefreshSign(slot0, slot1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		slot2, slot3 = wordVerify(slot1, {
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

function slot0.RefreshGuild(slot0, slot1, slot2)
	if slot1 == 0 then
		slot0.guildCon_:SetSelectedState("false")
	else
		slot0.guildTxt_.text = slot2

		slot0.guildCon_:SetSelectedState("true")
	end
end

function slot0.RefreshBirthday(slot0)
	if slot0.birthdayDay_ == 0 then
		slot0.brithdayTxt_.text = GetTips("UNSET_BIRTHDAY")
	else
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

	slot0.cardName_.text = "<" .. ItemTools.getItemName(slot1) .. ">"
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
	if slot1 > 10000 then
		slot0.like_.text = string.format("%.1f%%", slot1 / 1000) .. "K"
	else
		slot0.like_.text = slot1
	end
end

function slot0.StopTagScroll(slot0)
	if slot0.tagScrollTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.tagScrollTimer_)

		slot0.tagScrollTimer_ = nil
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0:StopTagScroll()

	for slot4, slot5 in ipairs(slot0.tagItem_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.tagItem_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
