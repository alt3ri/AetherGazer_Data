slot1 = class("ChapterChallengeAbyssItemView", import(".ChapterChallengeItemWithCD"))

function slot1.ClickItem(slot0, slot1)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_abyss_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_abyss_below")
	end

	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	JumpTools.GoToSystem("/abyssMain", {}, ViewConst.SYSTEM_ID.BATTLE_ABYSS)
end

function slot1.GetLostTime(slot0)
	return AbyssData:GetRefreshTimestamp()
end

return slot1
