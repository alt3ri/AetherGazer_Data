manager.notify:RegistListener(BATTLE_STAGE_PLOT_CHANGE, function (slot0)
	uv0.UpdateDailySignRedPoint()
	uv0.UpdateSevenDaySignRedPoint()
end)

return {
	UpdateDailySignRedPoint = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SIGN) then
			return false
		end

		manager.redPoint:setTip(RedPointConst.SIGN_DAILY, SignTools.GetDailySignIndex() ~= 0 and 1 or 0)
	end,
	UpdateSevenDaySignRedPoint = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SIGN) then
			return false
		end

		for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}) do
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, slot5), SignTools.GetSevenDaySignIndex(slot5) ~= 0 and 1 or 0)
		end
	end,
	OnActivityUpdate = function (slot0, slot1)
		for slot6, slot7 in ipairs(slot1) do
			if ActivityTools.GetActivityIsRootOrSub(slot7.activity_id) == true and ActivityTools.CheckMainActivityIsCommon(slot7.activity_id) then
				-- Nothing
			end

			if slot8 and slot8 ~= true and ActivityTools.CheckMainActivityIsCommon(slot8) then
				slot2[slot8] = true
			end
		end

		for slot6, slot7 in pairs({
			[slot7.activity_id] = true
		}) do
			slot0:UpdateMainActivityNewTag(slot6)
		end
	end,
	UpdateMainActivityNewTag = function (slot0, slot1)
		if slot1 and ActivityTools.CheckMainActivityIsCommon(slot1) and ActivityCfg[slot1] then
			if ActivityData:GetActivityIsOpen(slot1) then
				slot4 = {
					[slot9.id] = slot8
				}

				for slot8, slot9 in ipairs(getData("activityCommon", "NewTag" .. slot1) or {}) do
					-- Nothing
				end

				if slot2.activity_template == ActivityTemplateConst.MAIN_ACTIVITY then
					for slot10, slot11 in ipairs(slot2.sub_activity_list or {}) do
						slot0:DipatchSubActivityNewTag(slot11, slot3, slot4)
					end
				end

				saveData("activityCommon", "NewTag" .. slot1, slot3)
			else
				saveData("activityCommon", "NewTag" .. slot1, {})

				if slot2.activity_template == ActivityTemplateConst.MAIN_ACTIVITY then
					for slot8, slot9 in ipairs(slot2.sub_activity_list or {}) do
						if ActivityTools.GetActivityIsRootOrSub(slot9) then
							manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot9) .. slot9, 0, RedPointStyle.SHOW_NEW_TAG)
						end
					end
				end
			end
		end
	end,
	DipatchSubActivityNewTag = function (slot0, slot1, slot2, slot3)
		if slot1 and ActivityData:GetActivityIsOpen(slot1) and ActivityTools.GetActivityIsRootOrSub(slot1) then
			slot4 = false

			if not slot3[slot1] then
				slot4 = true

				table.insert(slot2, {
					needNew = true,
					id = slot1
				})
			elseif slot2[slot3[slot1]].needNew then
				slot4 = true
			end

			if slot4 then
				manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot1) .. slot1, 1, RedPointStyle.SHOW_NEW_TAG)
			end
		else
			manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot1) .. slot1, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end,
	CancelSubActivityNewTag = function (slot0, slot1)
		if not slot1 then
			return
		end

		if ActivityTools.GetActivityIsRootOrSub(slot1) == true or slot2 == false then
			return
		end

		if not ActivityTools.CheckMainActivityIsCommon(slot2) then
			return
		end

		slot4 = -1

		for slot8, slot9 in ipairs(getData("activityCommon", "NewTag" .. slot2) or {}) do
			if slot9.id == slot1 then
				slot9.needNew = false
				slot4 = slot8

				break
			end
		end

		if slot4 ~= -1 then
			saveData("activityCommon", "NewTag" .. slot2, slot3)
			manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot1) .. slot1, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end
}
