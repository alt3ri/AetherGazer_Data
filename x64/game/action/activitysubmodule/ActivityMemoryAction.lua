slot1 = false

return {
	Init = function (slot0)
		if uv0 then
			return
		end

		uv0 = true

		uv1.RefreshRedPoint(slot0)
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_MEMORY .. "_" .. slot0, {
			RedPointConst.ACTIVITY_MEMORY_OPEN .. "_" .. slot0,
			RedPointConst.ACTIVITY_TASK .. "_" .. ActivityMemoryTools.GetTaskActivityID(slot0)
		})
	end,
	RefreshRedPoint = function (slot0)
		if manager.redPoint:getTipValue(RedPointConst.ACTIVITY_MEMORY .. "_" .. slot0) == 1 then
			return
		end

		if not ActivityData:GetActivityData(slot0) or slot1:IsActivitying() then
			return
		end

		slot2 = false

		if ActivityTools.IsUnlockActivity(slot0) and not (getData(RedPointConst.ACTIVITY_MEMORY_OPEN, tostring(slot0)) or false) then
			slot2 = true
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_MEMORY_OPEN .. "_" .. slot0, slot2 and 1 or 0)
	end
}
