slot1 = class("ChapterChallengeMythicItemView", import(".ChapterChallengeItemView"))

function slot1.GetLostTime(slot0)
	return MythicData:GetNextRefreshTime()
end

function slot1.ClickItem(slot0)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_mythic_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_mythic_below")
	end

	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	if MythicData:GetDifficulty() == MythicData:GetFinalId() then
		JumpTools.GoToSystem("/mythicUltimateView", nil, ViewConst.SYSTEM_ID.MYTHIC)
	else
		JumpTools.GoToSystem("/mythic", nil, ViewConst.SYSTEM_ID.MYTHIC)
	end
end

return slot1
