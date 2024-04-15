return {
	GetOpenActivityCfgIDList = function ()
		slot0 = {}

		for slot4 = #ActivityAdvertiseCfg.all, 1, -1 do
			if ActivityTools.GetActivityStatus(ActivityAdvertiseCfg[ActivityAdvertiseCfg.all[slot4]].activity_id) == 1 and uv0.UnDisplayedAdvertise(slot5) then
				table.insert(slot0, slot5)
			end
		end

		table.sort(slot0, function (slot0, slot1)
			if ActivityAdvertiseCfg[slot1].order < ActivityAdvertiseCfg[slot0].order then
				return true
			elseif slot2 < slot3 then
				return false
			else
				return slot0 < slot1
			end
		end)

		return slot0
	end,
	NeedShowAdvertise = function ()
		if uv0.GetOpenActivityCfgIDList()[1] == nil then
			return false
		end

		return uv0.UnDisplayedAdvertise(slot0)
	end,
	UnDisplayedAdvertise = function (slot0)
		slot1 = ActivityAdvertiseCfg[slot0].activity_id

		if ActivityAdvertiseData:GetOpenAdvertiseFlag(slot0) or manager.time:IsToday(getData("activityAdvertise", tostring(slot0)) or 0) and (getData("activityAdvertise", "prompt" .. slot0) or false) then
			return false
		end

		return true
	end,
	StopAllAdvertise = function ()
		slot0 = {}

		for slot4 = #ActivityAdvertiseCfg.all, 1, -1 do
			if ActivityTools.GetActivityStatus(ActivityAdvertiseCfg[ActivityAdvertiseCfg.all[slot4]].activity_id) == 1 then
				table.insert(slot0, slot5)
			end
		end

		for slot5, slot6 in ipairs(slot0) do
			saveData("activityAdvertise", tostring(slot6), manager.time:GetServerTime())
			ActivityAdvertiseData:SetOpenAdvertiseFlag(slot6, true)

			slot7 = ActivityAdvertiseData:GetDefaultPrompt()

			if not getData("activityAdvertise", "prompt" .. slot6) and slot7 then
				saveData("activityAdvertise", "prompt" .. slot6, slot7)
			end
		end
	end
}
