slot0 = partialClass("MainHomeView", ReduxView)

function slot0.CheckIsNeedOpenWebPage(slot0)
	if GameToSDK.GetData("{\"dataType\" : \"GetWebPageURL\"}") == "{}" then
		slot1 = nil
	end

	print("check webPageUrl", slot1)

	if not string.isNullOrEmpty(slot1) then
		LuaForUtil.OpenWebView(slot1, true)
	end
end

function slot0.UpdateFollowGiftRedPoint(slot0)
	slot1 = getData("SDK", "followGift") or 1

	if not table.keyof(OperationData:GetOperationOpenList(), OperationConst.ATTENTION) then
		slot1 = 0
	end

	manager.redPoint:setTip(RedPointConst.FOLLOW_GIFT, slot1)
end

function slot0.UpdateDormArchitectureRedPoint(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(DormData:GetAllHeroInDorm()) do
		slot9 = slot7.heroID
		slot2[slot8] = (slot2[slot7.architectureID] or 0) + DormTools.getHeroEarn(slot9) + DormData:GetDormHero(slot9):GetEarnings()
	end

	for slot6, slot7 in pairs(slot2) do
		if GameSetting.dorm_entrance_red_dot_need.value[1] < slot7 then
			manager.redPoint:setTip(RedPointConst.DORM_TOTAL_EARN, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.DORM_TOTAL_EARN, 0)
end

function slot0.UpdateDormSpecialEventRedPoint(slot0)
	if #DormData:GetSpecialEvents() ~= 0 then
		manager.redPoint:setTip(RedPointConst.DORM_SPECIAL_EVENT, 1)
	else
		manager.redPoint:setTip(RedPointConst.DORM_SPECIAL_EVENT, 0)
	end
end

function slot0.UpdataSettingNewFunctionRedPoint(slot0)
	manager.redPoint:setTip(RedPointConst.SETTING_REMIND, getData("setting", "newFunction") or 1)
end

function slot0.UpdateSubModuleRedDot(slot0)
	slot0:UpdateDailyFatigueRedDot()
end

function slot0.UpdateDailyFatigueRedDot(slot0)
	manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, DailyFatigueData:GetRedCount())
end

function slot0.UpdataOperationViewRedPoint(slot0)
	if RedPointData:GetRedPointOpen(RED_POINT_ID.ACTIVITY) and table.keyof(OperationData:GetOperationOpenList(), OperationConst.ACTIVITY) ~= nil then
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 1)
	else
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.FORUM) and table.keyof(slot1, OperationConst.FORUM) ~= nil then
		manager.redPoint:setTip(RedPointConst.FORUM, 1)
	else
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.SHOP_TAOBAO) and table.keyof(slot1, OperationConst.SHOP_TAOBAO) ~= nil then
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 1)
	else
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.INFOMATION) and table.keyof(slot1, OperationConst.INFOMATION) ~= nil then
		manager.redPoint:setTip(RedPointConst.INFOMATION, 1)
	else
		manager.redPoint:setTip(RedPointConst.INFOMATION, 0)
	end
end

function slot0.UpdateChipRedPoint(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) then
		ChipAction:UpdateChipRed()
	end
end

function slot0.UpdateFriendsRedPoint(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
		FriendsAction:UpdateFriendsRedTip()
	end
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.btn_mail_transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:bindUIandKey(slot0.btn_combat_transform, RedPointConst.COMBAT)
	manager.redPoint:bindUIandKey(slot0.btn_goddess_transform, RedPointConst.GODDESS)
	manager.redPoint:bindUIandKey(slot0.btn_task_transform, RedPointConst.TASK)
	manager.redPoint:bindUIandKey(slot0.hero_transform, RedPointConst.HERO)
	manager.redPoint:bindUIandKey(slot0.btn_friends_.transform, RedPointConst.FRIEND)
	manager.redPoint:bindUIandKey(slot0.btn_passport.transform, RedPointConst.PASSPORT)
	manager.redPoint:bindUIandKey(slot0.btn_shop.transform, RedPointConst.RECHARGE_ENTER)
	manager.redPoint:bindUIandKey(slot0.btn_message.transform, RedPointConst.ILLU_MAIN)
	manager.redPoint:bindUIandKey(slot0.transformNewbie_, RedPointConst.NEWBIE_POINT)
	manager.redPoint:bindUIandKey(slot0.btnGuild_.transform, RedPointConst.GUILD)
	manager.redPoint:bindUIandKey(slot0.btn_regression.transform, RedPointConst.REGRESSION)
	manager.redPoint:bindUIandKey(slot0.btnPreviewTask_.transform, RedPointConst.PREVIEW_TASK)
	manager.redPoint:bindUIandKey(slot0.btn_menu.transform, RedPointConst.MAIN_HOME_MENU)
	manager.redPoint:bindUIandKey(slot0.btn_callback.transform, RedPointConst.RECALL)
	manager.redPoint:bindUIandKey(slot0.btn_newbie_task.transform, RedPointConst.NOOB_ADVANCE)
	manager.redPoint:bindUIandKey(slot0.btn_dorm_.transform, RedPointConst.BACKHOME)
	manager.redPoint:bindUIandKey(slot0.skinDrawRedPanel_, RedPointConst.ACTIVITY_DRAW)
	manager.redPoint:bindUIandKey(slot0.btn_draw.transform, RedPointConst.DRAW)
	manager.redPoint:bindUIandKey(slot0.btn_chat.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.redPoint:bindUIandKey(slot0.btn_newServer.transform, RedPointConst.ACTIVITY_NEW_SERVER)
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.btn_mail_transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:unbindUIandKey(slot0.btn_combat_transform, RedPointConst.COMBAT)
	manager.redPoint:unbindUIandKey(slot0.btn_goddess_transform, RedPointConst.GODDESS)
	manager.redPoint:unbindUIandKey(slot0.btn_task_transform, RedPointConst.TASK)
	manager.redPoint:unbindUIandKey(slot0.hero_transform, RedPointConst.HERO)
	manager.redPoint:unbindUIandKey(slot0.btn_friends_.transform, RedPointConst.FRIEND)
	manager.redPoint:unbindUIandKey(slot0.btn_passport.transform, RedPointConst.PASSPORT)
	manager.redPoint:unbindUIandKey(slot0.btn_shop.transform, RedPointConst.RECHARGE_ENTER)
	manager.redPoint:unbindUIandKey(slot0.btn_message.transform, RedPointConst.ILLU_MAIN)
	manager.redPoint:unbindUIandKey(slot0.transformNewbie_, RedPointConst.NEWBIE_POINT)
	manager.redPoint:unbindUIandKey(slot0.btnGuild_.transform, RedPointConst.GUILD)
	manager.redPoint:unbindUIandKey(slot0.btn_regression.transform, RedPointConst.REGRESSION)
	manager.redPoint:unbindUIandKey(slot0.btnPreviewTask_.transform, RedPointConst.PREVIEW_TASK)
	manager.redPoint:unbindUIandKey(slot0.btn_menu.transform, RedPointConst.MAIN_HOME_MENU)
	manager.redPoint:unbindUIandKey(slot0.btn_callback.transform, RedPointConst.RECALL)
	manager.redPoint:unbindUIandKey(slot0.btn_newbie_task.transform, RedPointConst.NOOB_ADVANCE)
	manager.redPoint:unbindUIandKey(slot0.btn_dorm_.transform, RedPointConst.BACKHOME)
	manager.redPoint:unbindUIandKey(slot0.skinDrawRedPanel_, RedPointConst.ACTIVITY_DRAW)
	manager.redPoint:unbindUIandKey(slot0.btn_draw.transform, RedPointConst.DRAW)
	manager.redPoint:unbindUIandKey(slot0.btn_chat.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.redPoint:unbindUIandKey(slot0.btn_newServer.transform, RedPointConst.ACTIVITY_NEW_SERVER)
end
