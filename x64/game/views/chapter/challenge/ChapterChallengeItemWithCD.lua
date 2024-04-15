local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterChallengeItemWithCD", var_0_0)

function var_0_1.AddCountdown(arg_1_0)
	return
end

function var_0_1.RefreshItemUI(arg_2_0)
	local var_2_0 = arg_2_0.isLock_

	arg_2_0:IsLock()

	if arg_2_0.isLock_ ~= var_2_0 then
		arg_2_0:RefreshLock()
		manager.notify:Invoke(CHALLENGE_CONTENT_REFRESH)
	end
end

return var_0_1
