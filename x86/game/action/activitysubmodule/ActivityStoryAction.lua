manager.net:Bind(11029, function (slot0)
	StoryStageActivityData:InitData(slot0)

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.info) do
		if not table.keyof(slot1, ActivityStoryChapterCfg[slot6.chapter_id].activity_id) then
			table.insert(slot1, slot8)
		end
	end

	for slot5, slot6 in ipairs(slot1) do
		for slot11, slot12 in pairs(ActivityCfg[uv0.GetStoryChapterID(slot6)].sub_activity_list) do
			if not table.keyof(slot1, slot12) then
				uv0.UpdateRedPoint(slot12, 1)
			end
		end

		uv0.UpdateRedPoint(slot6, 1)
	end
end)

return {
	GetStoryChapterID = function (slot0)
		for slot4, slot5 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STORY]) do
			if table.keyof(ActivityCfg[slot5].sub_activity_list, slot0) then
				return slot5
			end
		end

		return slot0
	end,
	UpdateRedPoint = function (slot0, slot1)
		if StoryStageActivityData:GetRedPoint(slot0) then
			return
		end

		if (ActivityReprintExCfg[slot0] and ActivityReprintExCfg[slot0].originActivityID or slot0) == ActivityConst.HELLA_STORY_STAGE_HERMES then
			if table.length(StoryStageActivityData:GetStageData(ActivityStoryChapterCfg.get_id_list_by_activity_id[slot0][1])) <= 0 then
				manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot0) .. slot0, 0)

				return
			end

			manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot0) .. slot0, slot1)

			if slot1 == 0 then
				StoryStageActivityData:SetRedPoint(slot0)
			end
		elseif slot2 == ActivityConst.SUMMER_STORY_SEABED or slot2 == ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT then
			if ActivityTools.IsUnlockActivity(slot0) == false then
				return
			end

			if table.length(StoryStageActivityData:GetStageData(ActivityStoryChapterCfg.get_id_list_by_activity_id[slot0][1])) <= 0 then
				return
			end

			manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot0) .. slot0, slot1)

			if slot1 == 0 then
				StoryStageActivityData:SetRedPoint(slot0)
			end
		end
	end
}
