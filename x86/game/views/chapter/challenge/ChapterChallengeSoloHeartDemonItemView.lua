slot1 = class("ChapterChallengeSoloHeartDemonItemView", import(".ChapterChallengeItemView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
end

function slot1.ClickItem(slot0, slot1)
	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	JumpTools.GoToSystem("/soloHeartDemonMain", {})
end

function slot1.GetLostTime(slot0)
	return SoloHeartDemonData:GetDataByPara("remainTime")
end

return slot1
