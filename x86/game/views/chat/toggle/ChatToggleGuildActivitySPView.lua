local var_0_0 = import(".ChatToggleBaseView")
local var_0_1 = class("ChatToggleGuildActivitySPView", var_0_0)

function var_0_1.Show(arg_1_0, arg_1_1)
	var_0_1.super.Show(arg_1_0, arg_1_1)

	if arg_1_1 then
		arg_1_0:RefreshGuildActivityToggle(toggle)
	end
end

function var_0_1.RefreshGuildActivityToggle(arg_2_0, arg_2_1)
	local var_2_0 = GuildActivitySPData:GetCurRunActivityID()
	local var_2_1 = ActivityData:GetActivityIsOpen(var_2_0) or arg_2_0.toggle_.isOn == arg_2_0.chatToggleID_ or manager.windowBar:GetWhereTag() == "guildActivitySP"

	SetActive(arg_2_0.gameObject_, var_2_1)
end

function var_0_1.OnClickToggle(arg_3_0)
	if arg_3_0:IsLock() then
		ShowTips("ACTIVITY_CLUB_NOT_JOIN")
		manager.notify:Invoke(CHAT_REVERT_TOGGLE)

		return
	end

	arg_3_0:Go("chat", {
		chatToggleID = arg_3_0.chatToggleID_
	})
end

function var_0_1.IsLock(arg_4_0)
	return not GuildActivitySPData:HaveRegister()
end

return var_0_1
