slot0 = singletonClass("ActivityHeroLetterData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.SetData(slot0, slot1)
	uv0[slot1.activity_id] = slot1.sign
end

function slot0.SetRewardSign(slot0, slot1, slot2)
	uv0[slot1] = slot2 and 1 or 0
end

function slot0.GetRewwardSign(slot0, slot1)
	return uv0[slot1] or 1
end

return slot0
