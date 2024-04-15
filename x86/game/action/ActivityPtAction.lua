manager.net:Bind(28019, function (slot0)
	ActivityPtData:TaskDailyGetRewardInit(slot0.pt_list)
	ActivityPtAction:UpdateActivityPt()
end)

return {
	TaskDailyGetReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(28016, {
			need_active_point = ActivityPtData:GetGiftPt(slot2, slot1),
			activity_pt_id = slot2
		}, 28017, function (slot0)
			if isSuccess(slot0.result) then
				ActivityPtData:TaskDailySubmit({
					activityID = uv0,
					activityPt = uv1
				})
				uv2:UpdateActivityPt()

				if #mergeReward2(slot0.reward_list or {}) > 0 then
					getReward2(slot1)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	UpdateActivityPt = function (slot0)
		TaskRedPoint:UpdateDailyTaskRedTip()
		TaskRedPoint:UpdateWeekTaskRedTip()
		MoonBoData:FreshCanGetCount()
		manager.notify:CallUpdateFunc(ACTIVITY_PT_UPDATE)
	end
}
