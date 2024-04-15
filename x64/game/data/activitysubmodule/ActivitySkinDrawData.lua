slot0 = singletonClass("ActivitySkinDrawData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
end

function slot0.InitDrawData(slot0, slot1)
	slot2 = slot1.activity_id
	uv0[slot2] = {
		all = {}
	}

	for slot8, slot9 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[slot0:GetPoolID(slot2)]) do
		uv0[slot2][slot9] = {
			id = slot9,
			num = ActivityLimitedDrawPoolCfg[slot9].total
		}

		table.insert(uv0[slot2].all, slot9)
	end

	for slot8, slot9 in ipairs(slot1.info) do
		slot10 = slot9.drop_id
		uv0[slot2][slot10] = {
			id = slot10,
			num = slot9.num
		}
	end
end

function slot0.GetPoolID(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityLimitedDrawPoolListCfg.all) do
		if table.indexof(ActivityLimitedDrawPoolListCfg[slot7].activity_id, slot1) then
			return slot7
		end
	end

	return 0
end

function slot0.RefreshData(slot0, slot1, slot2)
	if uv0[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			uv0[slot1][slot7].num = uv0[slot1][slot7].num - 1 >= 0 and slot8 - 1 or 0
		end
	end
end

function slot0.InitStoryData(slot0, slot1)
	slot2 = slot1.activity_id
	slot4 = ActivityLimitedSkinStoryCfg[slot2].main_activity_id
	uv0[slot4] = {
		activityID = slot2,
		mainActivityID = slot4,
		storyID = slot1.story_stage,
		isRead = slot1.is_read
	}
end

function slot0.FinishStory(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].isRead = 1
	end
end

function slot0.GetNotReadStoryID(slot0)
	for slot4, slot5 in pairs(uv0) do
		if ActivityData:GetActivityData(slot4):IsActivitying() then
			slot7 = ActivityTools.GetMainActivityId(slot4)

			return slot7, uv1[slot7]
		end
	end
end

function slot0.GetDrawInfo(slot0, slot1, slot2)
	return uv0[slot1][slot2]
end

function slot0.GetCurDrawPool(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetCurDrawPool(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetLastFile(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetLastFile(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

return slot0
