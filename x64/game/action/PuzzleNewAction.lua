slot1 = false
slot2 = {}

manager.net:Bind(65301, function (slot0)
	if ActivityTools.GetActivityType(slot0.activity_id) ~= ActivityTemplateConst.PUZZLE_NEW then
		return
	end

	if not uv0 then
		uv1.InitRedPoint()

		uv0 = true
	end

	if not uv2[slot1] then
		uv2[slot1] = true

		PuzzleNewTools.InitConfig(slot1)
	end

	PuzzleNewData:InitData(slot0)
end)

return {
	MovePuzzle = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(65302, {
			activity_id = slot0,
			puzzle_id = slot1,
			target_position = slot2
		}, 65303, function (slot0)
			if isSuccess(slot0.result) then
				PuzzleNewData:RefreshPlayRedPoint(uv0)

				if uv1 ~= nil then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ReceiveRegionReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(65304, {
			activity_id = slot0,
			award_id = slot1
		}, 65305, function (slot0)
			if isSuccess(slot0.result) then
				PuzzleNewData:SetRegionReceivedList(uv0, uv1)
				manager.notify:CallUpdateFunc(PUZZLE_NEW_REGION_RECEIVED, uv1, slot0.reward_list)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	OPERATION_TYPE = {
		CHECK = 3,
		PUT = 2,
		CHECK_TIPS = 5,
		AUTO_PUT = 6
	},
	Operation = function (slot0, slot1, slot2, slot3)
		if slot1 == uv0.OPERATION_TYPE.CHECK or slot1 == uv0.OPERATION_TYPE.CHECK_TIPS then
			-- Nothing
		end

		manager.net:SendWithLoadingNew(65306, {
			activity_id = slot0,
			type = slot1,
			extra = slot3
		}, 65307, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 == uv1.OPERATION_TYPE.PUT then
					PuzzleNewData:RefreshPieceRedPoint(uv2)
					PuzzleNewData:RefreshPlayRedPoint(uv2)
					manager.notify:CallUpdateFunc(PUZZLE_NEW_UPDATE)
				elseif uv0 == uv1.OPERATION_TYPE.AUTO_PUT then
					PuzzleNewData:RefreshPlayRedPoint(uv2)
					manager.notify:CallUpdateFunc(PUZZLE_NEW_UPDATE)
				elseif uv0 == uv1.OPERATION_TYPE.CHECK then
					PuzzleNewData:SetCurCheckList(uv2, uv3)
					manager.notify:CallUpdateFunc(PUZZLE_NEW_CHECK_UPDATE)
				elseif uv0 == uv1.OPERATION_TYPE.CHECK_TIPS then
					PuzzleNewData:SetCheckTipsList(uv2, uv3)
					manager.notify:CallUpdateFunc(PUZZLE_NEW_CHECK_UPDATE)
				end

				if uv4 ~= nil then
					uv4()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPoint = function ()
		slot1, slot2, slot3, slot4 = nil

		for slot8, slot9 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.PUZZLE_NEW]) do
			slot1 = string.format("%s_%d", RedPointConst.PUZZLE_NEW, slot9)

			manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PLAY, slot9), {
				string.format("%s_%d", RedPointConst.PUZZLE_NEW_PIECE, slot9)
			})

			slot10 = nil

			for slot15, slot16 in ipairs(ActivityCfg[slot9].sub_activity_list) do
				if ActivityCfg[slot16].activity_template == ActivityTemplateConst.TASK then
					slot10 = slot16

					break
				end
			end

			manager.redPoint:addGroup(slot1, {
				string.format("%s_%d", RedPointConst.ACTIVITY_TASK, slot10),
				slot3
			})
		end
	end
}
