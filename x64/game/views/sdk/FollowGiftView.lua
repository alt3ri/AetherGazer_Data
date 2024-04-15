slot0 = class("FollowGiftView", ReduxView)
slot1 = ""
slot2 = ""
slot3 = ""
slot4 = ""

function slot0.UIName(slot0)
	return "Widget/System/Medium/WelfareUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.weChatList_ = LuaList.New(handler(slot0, slot0.RefreshWeChatReward), slot0.wechatlistTrs_, CommonItemView)
	slot0.weiboList_ = LuaList.New(handler(slot0, slot0.RefreshWeiboReward), slot0.weibolistTrs_, CommonItemView)
	slot0.bilibiliList_ = LuaList.New(handler(slot0, slot0.RefreshBilibiliReward), slot0.bilibiliTrs_, CommonItemView)
	slot0.twitterList_ = LuaList.New(handler(slot0, slot0.RefreshTwitterReward), slot0.twitterTrs_, CommonItemView)
	slot0.facebookList_ = LuaList.New(handler(slot0, slot0.RefreshFacebookReward), slot0.facebookTrs_, CommonItemView)
	slot0.discordList_ = LuaList.New(handler(slot0, slot0.RefreshDiscordReward), slot0.discordTrs_, CommonItemView)
	slot0.youtubeList_ = LuaList.New(handler(slot0, slot0.RefreshYoutubeReward), slot0.youtubeTrs_, CommonItemView)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.wechatBtn_, nil, function ()
		uv0:Go("followPop")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 51,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.weiboBtn_, nil, function ()
		GameToSDK.SendMessage(SDKTools.ToJsonFormat({
			messageType = "GetPlatformData",
			platform = OperationConst.PLATFORM.WEIBO
		}))
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 52,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.bilibiliBtn_, nil, function ()
		if OperationAction.GetOperationUrl("FOLLOW_BILIBILI") then
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.BILIBILI)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	slot0:AddBtnListener(slot0.twitterBtn_, nil, function ()
		if OperationAction.GetOperationUrl("FOLLOW_TWITTER") then
			Application.OpenURL(slot0)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.TWITTER)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	slot0:AddBtnListener(slot0.facebookBtn_, nil, function ()
		uv0 = OperationAction.GetOperationUrl("Facebook_PageId") or ""

		if OperationAction.GetOperationUrl("FOLLOW_FACEBOOK") then
			uv1:SendMessageToFollow(1, uv2, slot0, uv0, uv3, uv4)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.FACEBOOK)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	slot0:AddBtnListener(slot0.discordBtn_, nil, function ()
		uv0 = OperationAction.GetOperationUrl("Discord_AuthUrl") or ""
		uv1 = OperationAction.GetOperationUrl("DISCORDCLIENTID") or ""
		uv2 = OperationAction.GetOperationUrl("DISCORDCLIENTSECRET") or ""

		if OperationAction.GetOperationUrl("FOLLOW_DISCORD") then
			uv3:SendMessageToFollow(0, uv0, slot0, uv4, uv1, uv2)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.DISCORD)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	slot0:AddBtnListener(slot0.youtubeBtn_, nil, function ()
		if OperationAction.GetOperationUrl("FOLLOW_YOUTUBE") then
			uv0:SendMessageToFollow(2, uv1, slot0, uv2, uv3, uv4)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.YOUTUBE)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
end

function slot0.SendMessageToFollow(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	SendMessageToSDK(string.format("{\"messageType\" : \"SocialMediaFollow\",\"type\" : \"%d\",\"authUrl\" : \"%s\",\"invitationUrl\" : \"%s\",\"pageId\" : \"%s\",\"discordClientId\" : \"%s\",\"discordClientSecret\" : \"%s\"}", slot1, slot2, slot3, slot4, slot5, slot6))
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()
	slot0.weChatList_:StartScroll(#GameSetting.wechat_follow_reward.value)
	slot0.weiboList_:StartScroll(#GameSetting.weibo_follow_reward.value)
	slot0.bilibiliList_:StartScroll(#GameSetting.bilibili_follow_reward.value)
	slot0.twitterList_:StartScroll(#GameSetting.twitter_follow_reward.value)
	slot0.facebookList_:StartScroll(#GameSetting.facebook_follow_reward.value)
	slot0.discordList_:StartScroll(#GameSetting.discord_follow_reward.value)
	slot0.youtubeList_:StartScroll(#GameSetting.youtube_follow_reward.value)
	slot0:RegistEventListener(GET_PLATFORM_DATA_CALLBACK, function (slot0)
		if slot0.code == 0 then
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.WEIBO)
		elseif slot0.code ~= 2 then
			ShowTips(slot0.message or "")
		end
	end)
	slot0:RegistEventListener(SOCAIL_DISCORD_CANCEL, function (slot0)
		if slot0.code == 0 then
			ShowTips("ERROR_DISCORD_SUBSCRIB_FAILED")
		end
	end)
end

function slot0.RefreshWeChatReward(slot0, slot1, slot2)
	slot3 = GameSetting.wechat_follow_reward.value[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3[1]
	slot4.number = slot3[2]

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.RefreshWeiboReward(slot0, slot1, slot2)
	slot3 = GameSetting.weibo_follow_reward.value[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3[1]
	slot4.number = slot3[2]

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.RefreshBilibiliReward(slot0, slot1, slot2)
	slot3 = GameSetting.bilibili_follow_reward.value[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3[1]
	slot4.number = slot3[2]

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.RefreshTwitterReward(slot0, slot1, slot2)
	slot3 = GameSetting.twitter_follow_reward.value[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3[1]
	slot4.number = slot3[2]

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.RefreshFacebookReward(slot0, slot1, slot2)
	slot3 = GameSetting.facebook_follow_reward.value[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3[1]
	slot4.number = slot3[2]

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.RefreshDiscordReward(slot0, slot1, slot2)
	slot3 = GameSetting.discord_follow_reward.value[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3[1]
	slot4.number = slot3[2]

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.RefreshYoutubeReward(slot0, slot1, slot2)
	slot3 = GameSetting.youtube_follow_reward.value[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3[1]
	slot4.number = slot3[2]

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.weChatList_:Dispose()
	slot0.weiboList_:Dispose()
	slot0.bilibiliList_:Dispose()
	slot0.twitterList_:Dispose()
	slot0.facebookList_:Dispose()
	slot0.discordList_:Dispose()
	slot0.youtubeList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
