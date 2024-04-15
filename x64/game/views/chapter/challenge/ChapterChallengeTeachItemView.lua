slot1 = class("ChapterChallengeTeachItemView", import(".ChapterChallengeItemView"))

function slot1.ClickItem(slot0, slot1)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_teach_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_teach_below")
	end

	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	JumpTools.GoToSystem("/teachStage", {}, ViewConst.SYSTEM_ID.BATTLE_TEACH)
end

return slot1
