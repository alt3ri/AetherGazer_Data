manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function ()
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_2_0_SEAL) then
		uv0.UpdateTaskRedPoint(ActivityConst.ACTIVITY_2_0_SEAL)
	end
end)
manager.net:Bind(64101, function (slot0)
	XH1stSealData:OnServerData(slot0)
end)

return {
	Init = function ()
		uv0.UpdateTaskRedPoint(ActivityConst.ACTIVITY_2_0_SEAL)
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.XH1ST_SEAL, slot0), {
			RedPointConst.XH1ST_SEAL_TASK
		})
	end,
	UpdateTaskRedPoint = function (slot0)
		slot1 = false

		for slot6, slot7 in ipairs(AssignmentCfg.get_id_list_by_activity_id[slot0]) do
			if TaskData2:GetTask(slot7) ~= nil then
				if not TaskData2:GetTaskComplete(slot7) and AssignmentCfg[slot7].need <= slot9.progress then
					slot1 = true

					break
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.XH1ST_SEAL_TASK, slot1 and 1 or 0)
	end,
	ResetSeal = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64102, {
			activity_id = slot0,
			ticket_id = slot1
		}, 64103, uv0.OnResetSealCallback)
	end,
	OnResetSealCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			XH1stSealData:ResetTicket()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequestSeal = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64112, {
			activity_id = slot0,
			ticket_id = slot1
		}, 64113, uv0.OnRequestSealCallback)
	end,
	OnRequestSealCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(XH1ST_ON_SEAL_RESULT, slot0, slot1)
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
