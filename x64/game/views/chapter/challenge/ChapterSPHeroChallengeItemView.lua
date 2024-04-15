slot1 = class("ChapterSPHeroChallengeItemView", import(".ChapterChallengeItemView"))

function slot1.ClickItem(slot0, slot1)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_sp1284_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_sp1284_below")
	end

	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	SPHeroChallengeTools:EnterSystem(ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1)
end

return slot1
