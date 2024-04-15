local var_0_0 = class("ChatWorldView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.switchChannelHandler_ = handler(arg_2_0, arg_2_0.OnSwitchChannel)

	manager.notify:RegistListener(CHAT_NEW_CHANNEL, arg_2_0.switchChannelHandler_)

	arg_2_0.isSoloHeartChange = arg_2_1

	arg_2_0:OnSwitchChannel()
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(CHAT_NEW_CHANNEL, arg_3_0.switchChannelHandler_)
end

function var_0_0.OnUpdate(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.inputFieldChannel_.onEndEdit:RemoveAllListeners()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0.inputFieldChannel_.onEndEdit:AddListener(function()
		if tonumber(arg_6_0.inputFieldChannel_.text) == ChatData:GetWorldChannelNum() then
			return
		end

		if arg_6_0.inputFieldChannel_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			arg_6_0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()

			return
		end

		local var_7_0 = tonumber(arg_6_0.inputFieldChannel_.text)

		if var_7_0 == nil or var_7_0 <= 0 then
			ShowTips("INPUT_CHANNEL_NUM")

			arg_6_0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()
		else
			if manager.time:GetServerTime() - ChatData:GetChannelTimestamp() < 5 then
				ShowTips("SWITCH_CHANNEL_FREQUENTLY")

				arg_6_0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()

				return
			end

			if var_7_0 > 10 and arg_6_0.isSoloHeartChange == nil then
				ShowTips("SOLO_HEART_DEMON_CHAT")

				arg_6_0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()

				return
			end

			ChatAction.SetWorldChannelNum(var_7_0, function(arg_8_0)
				if arg_8_0 == 0 then
					ChatData:SetChannelTimestamp()
				else
					arg_6_0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()

					ShowTips(arg_8_0)
				end
			end)
		end
	end)
end

function var_0_0.OnSwitchChannel(arg_9_0)
	arg_9_0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()
end

return var_0_0
