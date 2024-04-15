slot1 = class("ChapterChallengeAdvanceTestItemView", import(".ChapterChallengeItemView"))

function slot1.ClickItem(slot0, slot1)
	slot0:Go("/advanceTestMain")
end

function slot1.IsLock(slot0)
	slot0.isLock_ = false
end

return slot1
