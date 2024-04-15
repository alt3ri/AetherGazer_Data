slot0 = class("MoonPartyShareView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyShareUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if manager.time:GetServerTime() - MoonCakeData:GetLastShareTimestamp() < GameSetting.activity_mid_autumn_party_share_interval.value[1] then
			ShowTips("SEND_MESSAGE_FREQUENTLY")

			return
		end

		if ChatData:IsMuted() then
			uv0.inputField_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		if uv0.inputField_.text == "" then
			slot1 = GetTips("MID_AUTUMN_FESTIVAL_PARTY_SHARE_EMPTY_TIPS")
		end

		uv0.inputField_.text, slot4 = textLimit(slot1, GameSetting.club_share_max.value[1])

		if not slot4 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), slot2))

			return
		end

		if not nameRule(slot3, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(slot3, function (slot0, slot1)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")
			else
				ChatAction.SendChatNormalJump(ChatConst.CHAT_CHANNEL_MOON_CAKE, uv0, string.format("%s_%s", ViewConst.JUMP_SPECIAL_ID.MOON_CAKE, USER_ID), slot1, function (slot0)
					uv0:SendMessageResult(slot0)
				end)
				SDKTools.SendMessageToSDK("activity_mid_autumn_phase2_party_share", {
					activity_id = uv1.activityID_,
					content = uv0
				})
			end
		end, JUDGE_MESSAGE_TYPE.ACTIVITY_MOON_CAKE)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.inputField_.text = ""
end

function slot0.SendMessageResult(slot0, slot1)
	if isSuccess(slot1.result) then
		MoonCakeData:SetLastShareTimestamp()
		ChatData:SetSendTextTimestamp()

		slot0.inputField_.text = ""

		slot0:Back()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_MOON_CAKE
		}, ViewConst.SYSTEM_ID.CHAT)
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function ()
				uv0:Back()
			end
		})
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		slot0.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(slot1.result)
	end
end

return slot0
