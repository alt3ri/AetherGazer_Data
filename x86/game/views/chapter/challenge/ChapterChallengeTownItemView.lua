slot1 = class("ChapterChallengeTownItemView", import(".ChapterChallengeItemView"))

function slot1.ClickItem(slot0, slot1)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_tower_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_tower_below")
	end

	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	JumpTools.GoToSystem("/towerStage", nil, ViewConst.SYSTEM_ID.TOWER)
end

return slot1
