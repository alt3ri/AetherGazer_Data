slot1 = class("ChapterChallengeCoreVerificationItemView", import(".ChapterChallengeItemView"))

function slot1.GetLostTime(slot0)
end

function slot1.ClickItem(slot0)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_attribute_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_attribute_below")
	end

	JumpTools.GoToSystem("/coreVerificationMain", nil, ViewConst.SYSTEM_ID.CORE_VERIFICATION)
end

return slot1
