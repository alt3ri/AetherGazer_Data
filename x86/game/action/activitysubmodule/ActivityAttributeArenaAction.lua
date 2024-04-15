manager.net:Bind(72301, function (slot0)
	ActivityAttributeArenaData:InitData(slot0)
	uv0.CheckRedPoint(slot0.activity_id)
	manager.notify:CallUpdateFunc(ACTIVITY_ATTRIBUTE_ARENA_UPDATE)

	if ActivityAttributeArenaData:GetRound(slot0.activity_id) ~= 0 and slot1 ~= ActivityAttributeArenaData:GetRound(slot0.activity_id) then
		BattleFieldAction.ClearMultiTeam(slot0.activity_id, BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA, 0)

		return
	end
end)
manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function ()
	for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ATTRIBUTE_ARENA] or {}) do
		uv0.CheckRedPoint(slot5)
	end
end)

return {
	QueryResetScore = function (slot0, slot1)
		manager.net:SendWithLoadingNew(72302, {
			activity_id = slot0,
			index = slot1
		}, 72303, uv0.ResetScoreBack)
	end,
	ResetScoreBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityAttributeArenaData:ResetData(slot1.activity_id, slot1.index)
			manager.notify:CallUpdateFunc(ACTIVITY_ATTRIBUTE_ARENA_RESET)
			ShowTips("ACTIVITY_ATTRIBUTE_ARENE_RESET_SUCCESS")
		else
			ShowTips(slot0.result)
		end
	end,
	CheckRedPoint = function (slot0)
		slot2 = 0

		for slot6, slot7 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot7].activity_template == ActivityTemplateConst.TASK then
				slot2 = slot7

				break
			end
		end

		if slot2 == 0 or not ActivityData:GetActivityIsOpen(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, slot0), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, slot0), 0)

			return
		end

		slot3 = true
		slot4 = false

		for slot9, slot10 in pairs(TaskTools:GetActivityTaskList(slot2) or {}) do
			if not TaskData2:GetTaskComplete(slot10.id) then
				slot3 = false

				if AssignmentCfg[slot10.id].need <= TaskData2:GetTask(slot10.id).progress then
					slot4 = true
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, slot0), slot4 and 1 or 0)

		if not ActivityAttributeArenaData:GetRead(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, slot0), not slot3 and 1 or 0)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, slot0), 0)
		end
	end,
	SetRead = function (slot0)
		ActivityAttributeArenaData:SetRead(slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, slot0), 0)
	end
}
