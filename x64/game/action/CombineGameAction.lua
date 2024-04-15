manager.net:Bind(78051, function (slot0)
	CombineGameData:InitServerData(slot0)
	CombineGameAction.UpdateGameRedPoint()
	CombineGameAction.BindRedPoint()

	slot2, slot3 = KagutsuchiGachaData:GetDrawCost(KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1], 1)

	CombineGameAction.UpdatePoolRedPoint(slot2)
	manager.notify:CallUpdateFunc(COMBINE_GAME_NEW_SERVER_DATA)
end)
manager.notify:RegistListener(MATERIAL_MODIFY, function (slot0)
	CombineGameAction.UpdatePoolRedPoint(slot0)
end)

return {
	GameWin = function (slot0, slot1)
		slot3 = CombineGameData:GetDataByPara("activityId")
		slot4 = nil
		slot8 = 0
		slot1 = math.max(slot1, slot8)

		for slot8, slot9 in ipairs(ActivityCombineLevelCfg.all) do
			if ActivityCombineLevelCfg[slot8].type == CombineGameConst.TypeConst.ENDLESS then
				slot4 = slot8
			end
		end

		if slot0 ~= slot4 then
			slot1 = nil
		end

		if ActivityCombineLevelCfg[slot0].type == slot2.DAILY and CombineGameData:GetDataByPara("nowDay") ~= slot0 then
			ShowTips("STAGE_REFRESH_DATA")

			return
		end

		manager.net:SendWithLoadingNew(78052, {
			activity_id = slot3,
			reward_id = slot0,
			score = slot1
		}, 78053, uv0.GameWinCallBack)
	end,
	GameWinCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CombineGameData:UpdateStageData(slot1)
			getReward(formatRewardCfgList(ActivityCombineLevelCfg[slot1.reward_id].reward_list))
			manager.notify:CallUpdateFunc(COMBINE_GAME_NEW_SERVER_DATA)
			CombineGameAction.UpdateGameRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	UpdatePoolRedPoint = function (slot0)
		slot2, slot3 = KagutsuchiGachaData:GetDrawCost(KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1], 1)

		if slot2 == nil then
			return
		end

		if slot2 == slot0 then
			slot5 = KagutsuchiGachaData:GetPoolRemains(slot1)

			manager.redPoint:setTip(RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN", KagutsuchiGachaData:GetMaxDrawTimes(slot1) > 1 and slot5 > 0 and 1 or 0)
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE", slot4 == 1 and slot5 > 0 and 1 or 0)
		end
	end,
	UpdateGameRedPoint = function ()
		slot0 = CombineGameData:GetDataByPara("nowDay")
		slot1 = CombineGameData:GetDataByPara("activityId")
		slot3 = {}
		slot4 = nil

		for slot8, slot9 in ipairs(ActivityCombineLevelCfg.all) do
			if ActivityCombineLevelCfg[slot9].type == 1 then
				manager.redPoint:setTip(string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot1), slot1, slot9), CombineGameData:GetDataByPara("stageDataTable")[slot9] == true and 0 or 1)
			end

			if slot10.type == 4 then
				table.insert(slot3, slot9)
			end
		end

		slot5 = {}

		for slot9, slot10 in ipairs(slot3) do
			manager.redPoint:setTip(string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot1), slot1, slot10), slot2[slot4] == true and slot2[slot10] ~= true and 1 or 0)
			table.insert(slot5, slot11)
		end

		table.insert(slot5, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot1), slot1, slot4))
		manager.redPoint:addGroup(string.format("%s%s_TEACH", ActivityTools.GetRedPointKey(slot1), slot1), slot5)
		manager.redPoint:setTip(string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(slot1), slot1), slot2[slot0] ~= true and slot2[slot4] == true and 1 or 0)
	end,
	BindRedPoint = function ()
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL, {
			RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN",
			RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE"
		})

		slot0 = CombineGameData:GetDataByPara("activityId")
		slot2 = string.format("%s%s", ActivityTools.GetRedPointKey(slot0), slot0)

		manager.redPoint:addGroup(slot2, {
			slot2 .. "_DAILY",
			slot2 .. "_TEACH",
			string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK),
			RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL
		})
	end
}
