slot1 = class("ChapterChallengeDamageTestItemView", import(".ChapterChallengeItemView"))

function slot1.ClickItem(slot0, slot1)
	slot0:Go("/damageTestMode")
end

function slot1.IsLock(slot0)
	slot0.isLock_ = false
end

return slot1
