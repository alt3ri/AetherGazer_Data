manager.net:Bind(61071, function (slot0)
	SequentialBattleData:InitData(slot0)
	uv0.UpdateRedPoint(slot0.activity_id)
end)
manager.notify:RegistListener(ZERO_REFRESH, function ()
	for slot3, slot4 in pairs(uv0.refreshActivityIDList_) do
		uv0.UpdateRedPoint(slot4)
	end
end)

return {
	SaveAllTeam = function (slot0, slot1)
		ReserveAction.SaveContData(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, slot0, slot1)
	end,
	ResetTeam = function (slot0, slot1)
		ReserveAction.ResetContData(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, slot0, slot1)
	end,
	ReceiveReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(61072, {
			activty_id = slot0,
			award_id = slot1
		}, 61073, function (slot0)
			uv0(slot0)
		end)
	end,
	initActivityIDList_ = {},
	refreshActivityIDList_ = {},
	InitRedPoint = function (slot0)
		if table.keyof(uv0.initActivityIDList_, slot0) then
			return
		end

		table.insert(uv0.initActivityIDList_, slot0)

		slot1 = {}

		for slot5, slot6 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			slot7 = string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE, slot6)

			manager.redPoint:addGroup(slot7, {
				string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot6),
				string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot6)
			})
			table.insert(slot1, slot7)
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE, slot0), slot1)
	end,
	UpdateRedPoint = function (slot0)
		uv0.InitRedPoint(SequentialBattleChapterCfg[slot0].main_id)

		if table.keyof(uv0.refreshActivityIDList_, slot0) == nil then
			table.insert(uv0.refreshActivityIDList_, slot0)
		end

		if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0).stopTime and slot3 > (getData("sequentialBattle", "activityID_" .. slot0) or 0) and #SequentialBattleData:GetChapterData(slot0).historyFinishStage < #SequentialBattleChapterCfg[slot0].stage_id then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot0), 0)
		end
	end,
	StopRedPoint = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot0), 0)
	end,
	ClickDayRedPoint = function (slot0)
		if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot0)) ~= 0 then
			manager.redPoint:setTip(slot1, 0)
			saveData("sequentialBattle", "activityID_" .. slot0, _G.gameTimer:GetNextDayFreshTime())
		end
	end,
	ResetData = function (slot0)
		uv0.initActivityIDList_ = {}
		uv0.refreshActivityIDList_ = {}
	end
}
