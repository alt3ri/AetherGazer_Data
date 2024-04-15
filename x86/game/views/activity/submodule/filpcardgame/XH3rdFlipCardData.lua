slot0 = singletonClass("XH3rdFlipCardData")

function slot0.OnReceiveFlipCardData(slot0, slot1)
	slot2 = slot1.activity_id
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.clue_list) do
		table.insert(slot3, {
			clue_id = slot8.clue_id,
			is_viewed = slot8.is_viewed
		})
	end

	uv0.data = {
		activity_id = slot2,
		clue_list = slot3
	}

	XH3rdFlipCardAction.UpdateClueRedPoint()
end

function slot0.UpdateClueData(slot0, slot1)
	slot2 = true

	for slot6, slot7 in ipairs(uv0.data.clue_list) do
		if slot7.clue_id == slot1 then
			slot7.is_viewed = true
			slot2 = false

			break
		end
	end

	if slot2 then
		table.insert(uv0.data.clue_list, {
			is_viewed = false,
			clue_id = slot1
		})
	end

	XH3rdFlipCardAction.UpdateClueRedPoint()
end

function slot0.CheckClueIsGetted(slot0, slot1)
	for slot5, slot6 in ipairs(uv0.data.clue_list) do
		if slot6.clue_id == slot1 then
			return true
		end
	end

	return false
end

function slot0.GetActivityID(slot0)
	return slot0.data.activity_id
end

function slot0.CheckClueIsViewed(slot0, slot1)
	for slot5, slot6 in ipairs(uv0.data.clue_list) do
		if slot6.clue_id == slot1 then
			return slot6.is_viewed
		end
	end

	return false
end

function slot0.GetClueList(slot0, slot1)
	if uv0.data and uv0.data.activity_id == slot1 then
		return uv0.data.clue_list
	end

	return {}
end

return slot0
