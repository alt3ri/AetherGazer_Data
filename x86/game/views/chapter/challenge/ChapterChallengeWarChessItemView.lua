slot0 = class("ChapterChallengeWarChessItemView", import(".ChapterChallengeItemView"))

function slot0.ClickItem(slot0, slot1)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_warchess_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_warchess_below")
	end

	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	JumpTools.GoToSystem("/warChessStage", {
		chapterClientID = slot1
	}, ViewConst.SYSTEM_ID.WARCHESS)
end

return slot0
