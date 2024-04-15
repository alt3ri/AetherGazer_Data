slot0 = singletonClass("InviteData")
slot1 = {
	Init = function (slot0)
		slot0.selectHeroIndex = nil
	end,
	InitInviteData = function (slot0, slot1)
		slot0.activityId = slot1.activity_id
		slot0.inviteTimes = slot1.invite_times
		slot0.selectHeroId = nil
		slot0.completePlotTable = {}
		slot0.heroPlotTable = {}
		slot0.heroPlotList = {}
		slot0.drawItemId = 0

		for slot5, slot6 in pairs(ActivityInviteCfg.get_id_list_by_activity_id[slot0.activityId]) do
			if #ActivityInviteCfg[slot6].reward_list ~= 0 then
				slot0.drawItemId = ItemCfg[slot7.reward_list[1][1]].param[1]
			end

			if slot0.heroPlotTable[slot7.hero_id] == nil then
				slot0.heroPlotTable[slot7.hero_id] = {}
			end

			table.insert(slot0.heroPlotTable[slot7.hero_id], slot7)
		end

		for slot5, slot6 in pairs(slot0.heroPlotTable) do
			table.sort(slot6, function (slot0, slot1)
				return slot0.stage < slot1.stage
			end)
			table.insert(slot0.heroPlotList, slot6)
		end

		slot0.poolID = DrawTools.GetActivityPoolIdByTicketId(slot0.drawItemId)

		for slot5, slot6 in ipairs(slot1.invite_list) do
			slot0.completePlotTable[slot6] = true
		end

		slot0:UpdateData()
	end,
	UpdateData = function (slot0)
		slot0.completeHeroTable = {}

		for slot5, slot6 in pairs(slot0.completePlotTable) do
			slot1 = 0 + 1

			if slot0.completeHeroTable[ActivityInviteCfg[slot5].hero_id] == nil then
				slot0.completeHeroTable[slot7.hero_id] = {}
			end

			table.insert(slot0.completeHeroTable[slot7.hero_id], slot5)
		end

		for slot5, slot6 in pairs(slot0.completeHeroTable) do
			if #slot6 < uv0(slot0.heroPlotTable[slot5]) then
				slot0.selectHeroId = slot5
			end
		end

		if slot1 % 7 == 0 and (slot0.inviteTimes == 0 or GameSetting.activity_invite_daily_opportunities.value[1] <= slot0.inviteTimes) then
			slot0.selectHeroId = nil
		end

		slot0.allComplete = slot1 == #ActivityInviteCfg.get_id_list_by_activity_id[slot0.activityId]

		slot0:SelectIdToIndex()
	end,
	SelectIdToIndex = function (slot0)
		for slot4, slot5 in ipairs(slot0.heroPlotList) do
			if slot5[1].hero_id == slot0.selectHeroId then
				slot0.selectHeroIndex = slot4
			end
		end
	end,
	UpdateCompletePlotData = function (slot0, slot1)
		if ActivityInviteCfg[slot1.plot_id].stage ~= 0 then
			slot0.inviteTimes = slot0.inviteTimes - 1
		end

		slot0.completePlotTable[slot1.plot_id] = true

		slot0:UpdateData()
		slot0:UpdateReward(slot1.plot_id)
	end,
	UpdateReward = function (slot0, slot1)
		slot3 = nil

		for slot8, slot9 in pairs(slot0.heroPlotTable[ActivityInviteCfg[slot1].hero_id]) do
			if slot9.stage == slot4.stage and slot0.completePlotTable[slot9.id] then
				slot2 = 0 + 1

				if #slot9.reward_list > 0 then
					slot3 = slot9.reward_list
				end
			end
		end

		if slot2 == 3 then
			manager.notify:CallUpdateFunc(INVITE_PLOT_GET_REWARD, slot3)
		end
	end
}

function slot2(slot0)
	for slot5, slot6 in pairs(slot0) do
		slot1 = 0 + 1
	end

	return slot1
end

function slot0.Init(slot0)
	uv0:Init()
end

function slot0.InitInviteData(slot0, slot1)
	uv0:InitInviteData(slot1)
end

function slot0.UpdateCompletePlotData(slot0, slot1)
	uv0:UpdateCompletePlotData(slot1)
end

function slot0.GetDataByPara(slot0, slot1)
	return uv0[slot1]
end

return slot0
