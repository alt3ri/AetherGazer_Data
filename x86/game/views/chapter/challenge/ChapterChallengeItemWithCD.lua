slot1 = class("ChapterChallengeItemWithCD", import(".ChapterChallengeItemView"))

function slot1.AddCountdown(slot0)
end

function slot1.RefreshItemUI(slot0)
	slot0:IsLock()

	if slot0.isLock_ ~= slot0.isLock_ then
		slot0:RefreshLock()
		manager.notify:Invoke(CHALLENGE_CONTENT_REFRESH)
	end
end

return slot1
