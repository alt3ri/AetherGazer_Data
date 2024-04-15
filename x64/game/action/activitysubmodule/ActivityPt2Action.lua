slot1 = false

manager.net:Bind(64111, function (slot0)
	ActivityPt2Data:SetHardScore(slot0)
end)

return {
	Init = function ()
		ActivityPt2Data:Init()

		if uv0 then
			return
		end

		manager.net:Bind(64105, function (slot0)
			ActivityPt2Data:SetNormalData(slot0)
			ActivityPt2Action:RefreshRedPoint(slot0.activity_id)
		end)
		manager.net:Bind(64107, function (slot0)
			ActivityPt2Data:SetChallengeData(slot0)
			ActivityPt2Action:RefreshRedPoint(slot0.activity_id)
		end)
		manager.net:Bind(64109, function (slot0)
			ActivityPt2Data:SetHardData(slot0)
			ActivityPt2Action:RefreshRedPoint(slot0.activity_id)
		end)

		uv0 = true
	end,
	IsBlackActivity = function (slot0, slot1)
		if slot1 == 200042 then
			return true
		end

		return false
	end,
	InitRedPointKey = function (slot0)
		if ActivityPt2Action:IsBlackActivity(ActivityPt2Tools:GetTaskActivityID(slot0)) then
			return
		end

		manager.redPoint:addGroup(RedPointConst.ACTIVITY_PT_2 .. "_" .. slot0, {
			RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. slot0,
			RedPointConst.ACTIVITY_TASK .. "_" .. slot1
		})
	end,
	RefreshRedPoint = function (slot0, slot1)
		slot2 = nil

		for slot7, slot8 in ipairs(ActivityCfg.get_id_list_by_activity_theme[ActivityCfg[slot1].activity_theme]) do
			if ActivityCfg[slot8].activity_template == ActivityTemplateConst.ACTIVITY_PT_2 then
				slot2 = slot8

				break
			end
		end

		if manager.redPoint:getTipValue(RedPointConst.ACTIVITY_PT_2 .. "_" .. slot2) == 1 then
			return
		end

		slot4 = false

		if ActivityTools.GetActivityStatus(slot2) == 1 and ActivityTools.IsUnlockActivity(slot2) and not (getData(RedPointConst.ACTIVITY_PT_2_OPEN, tostring(slot2)) or false) then
			slot4 = true
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. slot2, slot4 and 1 or 0)
	end
}
