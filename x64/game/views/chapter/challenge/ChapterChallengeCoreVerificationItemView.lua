local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterChallengeCoreVerificationItemView", var_0_0)

function var_0_1.GetLostTime(arg_1_0)
	return
end

function var_0_1.ClickItem(arg_2_0)
	if arg_2_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_attribute_above")

		arg_2_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_attribute_below")
	end

	JumpTools.GoToSystem("/coreVerificationMain", nil, ViewConst.SYSTEM_ID.CORE_VERIFICATION)
end

return var_0_1
