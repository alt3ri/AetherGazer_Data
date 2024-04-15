slot1 = class("ChapterChallengeBossItemView", import(".ChapterChallengeItemView"))

function slot1.GetLostTime(slot0)
	if BattleBossChallengeData:GetNextRefreshTime() < manager.time:GetServerTime() then
		return manager.time:GetServerTime() + 604800
	end

	return slot1
end

function slot1.ClickItem(slot0)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_boss_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_boss_below")
	end

	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	BattleBossChallengeAction.EnterBossChallenge()
end

return slot1
