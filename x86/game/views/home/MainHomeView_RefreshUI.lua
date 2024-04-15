slot0 = partialClass("MainHomeView", ReduxView)

function slot0.RefreshPage(slot0)
	SetActive(slot0.btn_girl.gameObject, true)
end

function slot0.RefreshUserInfo(slot0)
	slot1 = slot0.userData_
	slot0.name_.text = GetI18NText(slot1.nick)
	slot0.uid_.text = string.format("%d", slot1.userID)
	slot0.level_.text = string.format("%d", slot1.userLevel)
	slot2 = slot0.userData_.remain_exp

	if LvTools.GetIsMaxLv(slot0.userData_.userLevel, "user") then
		slot0.expImg_.fillAmount = 1
	else
		slot0.expImg_.fillAmount = GameLevelSetting[slot3].user_level_exp == 0 and 0 or slot2 / slot4
	end
end

function slot0.RefreshDeviceMessage(slot0)
	if manager.time:STimeDescS(manager.time:GetServerTime(), "!%H:%M") ~= slot0.lastTimeString_ then
		slot0.time_.text = slot1
		slot0.lastTimeString = slot1
	end

	if slot0.__isPc == nil then
		slot2 = GameToSDK.IsPCPlatform()
		slot0.__isPc = slot2

		if slot2 then
			SetActive(slot0.signal_, false)
			SetActive(slot0.wifi_, false)
			SetActive(slot0.batteryGo_, false)
		end
	end

	if slot0.__isPc then
		return
	end

	if Application.internetReachability ~= slot0.lastNetMessage_ then
		SetActive(slot0.signal_, slot2 == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork)
		SetActive(slot0.wifi_, slot2 == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork)

		slot0.lastNetMessage_ = slot2
	end

	if UnityEngine.SystemInfo.batteryLevel ~= slot0.lastBatteryLevel_ then
		slot0.battery_.fillAmount = slot3
		slot0.lastBatteryLevel_ = slot3
	end
end

function slot0.RefreshVitalityLimit(slot0)
	if not StoreTools.getMaterialMinTimestamp() then
		SetActive(slot0.vitalityTimerGo_, false)

		return
	end

	slot0.vitalityTimerText_.text = ItemTools.GetItemCountdownText(slot1)

	SetActive(slot0.vitalityTimerGo_, true)
end

function slot0.RefreshRealtimeUI(slot0)
	slot0:RefreshDeviceMessage()
	slot0:RefreshVitalityLimit()
	slot0:UpdateSubModuleRedDot()
end

function slot0.RefreshBanner(slot0)
	slot2 = #ActivityTools.GetCurrentAdvInfo() > 0

	SetActive(slot0.btnActivityGo_, slot2)

	if slot2 then
		slot0.bannerView_:RefreshData(slot0, {
			space = 0,
			vertical = true,
			data = slot1,
			onclick = function (slot0)
				if not ActivityTools.IsValidAdv(slot0.id) then
					ShowTips("TIME_OVER")
					uv0:RefreshBanner()

					return
				end

				ActivityTools.ClickAdv(slot0)
				OperationRecorder.RecordButtonTouch("homepage_banner_" .. slot0.id)
				OperationRecorder.Record("home", "activity_open")
			end
		})
	end
end

function slot0.RefreshHide(slot0)
	slot0.hideCon_:SetSelectedState(slot0.isHide_ and "true" or "false")
	SetActive(slot0.bgmaskBtn_.gameObject, slot0.isHide_)

	if slot0.isHide_ then
		manager.windowBar:HideBar()
	else
		slot0:InitBar()
	end
end

function slot0.RefreshReceiveMessage(slot0)
	slot0:ClearMsgTimer()
	slot0:RefreshWorldChat()

	slot0.msgTimer_ = Timer.New(function ()
		uv0:RefreshWorldChat()
	end, 2, -1)

	slot0.msgTimer_:Start()
end

function slot0.RefreshWorldChat(slot0)
	slot1 = ChatData:GetWorldChatData()

	if slot1[#slot1] then
		slot3 = ""
		slot4 = ""

		if slot2.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or slot2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			slot3 = slot2.id == USER_ID and (PlayerData:GetPlayerInfo().nick or "") or slot2.nick or ""
			slot4 = slot2.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and (slot2.content or "") or string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(slot2.content)].name))
		end

		slot5 = ""

		if slot3 ~= "" then
			slot5 = slot3 .. ":" .. slot4
		end

		slot0.textLimit_:SetText(slot5)

		return
	end

	slot0.textLimit_:SetText("")
end

function slot0.RefreshSkinDrawBtn(slot0)
	slot1, slot2 = ActivitySkinDrawData:GetNotReadStoryID()

	if slot1 and ActivityData:GetActivityData(slot1):IsActivitying() then
		SetActive(slot0.skinDrawBtn_.gameObject, true)
		slot0.skinDrawCon_:SetSelectedState(slot2 and slot2.isRead == 0 and "story" or "draw")
	else
		SetActive(slot0.skinDrawBtn_.gameObject, false)
	end
end

function slot0.RefreshChat(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHAT) then
		ChatAction.EnterChatUI(1)
		slot0:RefreshReceiveMessage()
		slot0.socializeCon_:SetSelectedState("on")
	else
		slot0.textLimit_:SetText("")
		slot0.socializeCon_:SetSelectedState("off")
	end
end

function slot0.Render(slot0)
end

function slot0.CheckPassportBtn(slot0)
	SetActive(slot0.btn_passport.gameObject, PassportData:IsOpen() and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.PASSPORT_MAIN))
end

function slot0.CheckLocked(slot0)
	slot0.drawLockCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DRAW) and "true" or "false")
	slot0.dormLockCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) and "true" or "false")
	slot0.guildCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD) and "true" or "false")
	slot0.shopCon_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) and "true" or "false")

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) then
		SetActive(slot0.shopRedPoint, false)
	elseif manager.redPoint:getTipValue(RedPointConst.RECHARGE_ENTER) >= 1 then
		SetActive(slot0.shopRedPoint, true)
	else
		SetActive(slot0.shopRedPoint, false)
	end
end

function slot0.CheckRecallActivity(slot0)
	if ActivityData:GetActivityData(ActivityConst.RECALL_INVITE).stopTime == 1 or slot0.userData_.userLevel < ActivityRecallData:GetDataByPara("recallLevel") or ActivityRecallData:GetDataByPara("recallActivityID") == nil then
		SetActive(slot0.btn_callback.gameObject, false)
	else
		SetActive(slot0.btn_callback.gameObject, manager.time:GetServerTime() < slot1.stopTime)
	end
end

function slot0.CheckActivite(slot0)
	function slot1()
		uv0:CheckHeroGiftActivite()
		uv0:CheckPreviewTaskActivity()
		uv0:CheckRecallActivity()
		uv0:RefreshSkinDrawBtn()
		AdminCatExploreData:UpdateRegionRedPoint()
	end

	slot1()

	slot0.activiteTime_ = Timer.New(slot1, 1, -1)

	slot0.activiteTime_:Start()
end

function slot0.CheckHeroGiftActivite(slot0)
	if slot0.isHeroGiftOpen_ == (ActivityData:GetActivityIsOpen(ActivityConst.HELLA_HERO_GIFT) and HeroGiftData:GetReceiveHeroGift(ActivityConst.HELLA_HERO_GIFT) == 0) then
		return
	end

	slot0.isHeroGiftOpen_ = slot1

	SetActive(slot0.btnHeroGiftGo_, slot1)
end

function slot0.CheckPreviewTaskActivity(slot0)
	if slot0.isPreviewTaskOpen_ == ActivityData:GetActivityIsOpen(PreviewTaskData:GetCurActivityID()) then
		return
	end

	slot0.isPreviewTaskOpen_ = slot2

	SetActive(slot0.btnPreviewTaskGo_, slot2)
	SetActive(slot0.advanceTestBtn_, ActivityData:GetActivityIsOpen(AdvanceTestData:GetMainActivityID()))
end
