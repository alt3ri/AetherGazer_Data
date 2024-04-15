manager.net:Bind(65301, function (slot0)
	if ActivityTools.GetActivityType(slot0.activity_id) ~= ActivityTemplateConst.TANGRAM_PUZZLE then
		return
	end

	if not TangramPuzzleData:IsInited(slot1) then
		uv0.InitRedPoint(slot1)
		TangramPuzzleTools.InitConfig(slot1)
	end

	TangramPuzzleData:InitData(slot0)
	uv0.RefreshClueRedPoint(slot1)
end)

return {
	MovePuzzle = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(65302, {
			activity_id = slot0,
			puzzle_id = TangramPuzzleData:GetCurPuzzleDic(slot0)[slot1],
			target_position = slot2
		}, 65303, function (slot0)
			if isSuccess(slot0.result) then
				TangramPuzzleData:ExchangePuzzle(uv0, uv1, uv2)
				manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_MOVE, uv1, uv2)

				if uv3 ~= nil then
					uv3(uv1, uv2)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RotateRegion = function (slot0, slot1, slot2)
		slot3 = TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(slot0)[slot1]
		slot6 = nil

		manager.net:SendWithLoadingNew(65302, {
			activity_id = slot0,
			puzzle_id = TangramPuzzleData:GetCurPuzzleDic(slot0)[slot3[1]],
			target_position = (slot2 > 0 ~= true or slot3[2]) and slot3[#slot3]
		}, 65303, function (slot0)
			if isSuccess(slot0.result) then
				TangramPuzzleData:RetateRegion(uv0, uv1, uv2)
				manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_REGION_ROTATE, uv1, uv2)
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
				TangramPuzzleData:SetRegionReceivedDic(uv0, uv1)
				uv2.RefreshClueRedPoint(uv0)
				manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_REGION_RECEIVED, uv1, slot0.reward_list)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ReceiveFinalReward = function (slot0)
		manager.net:SendWithLoadingNew(65304, {
			activity_id = slot0,
			award_id = {
				0
			}
		}, 65305, function (slot0)
			if isSuccess(slot0.result) then
				getReward2(slot0.reward_list)
				TangramPuzzleData:SetRegionReceivedDic(uv0, {
					0
				})
				manager.notify:CallUpdateFunc(TANGRAM_PUUZLE_FINAL_REWARD_RECEIVED)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	OPERATION_TYPE = {
		FULL_AUTO_PUT = 8,
		CLUE = 3
	},
	Operation = function (slot0, slot1, slot2, slot3)
		if slot1 == uv0.OPERATION_TYPE.CLUE then
			-- Nothing
		elseif slot1 == uv0.OPERATION_TYPE.ROTATE then
			slot4.extra = slot2.regionID
		end

		manager.net:SendWithLoadingNew(65306, {
			activity_id = slot0,
			type = slot1,
			extra = slot2.clueID
		}, 65307, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 == uv1.OPERATION_TYPE.FULL_AUTO_PUT then
					manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_AUTO_PUT)
				elseif uv0 == uv1.OPERATION_TYPE.CLUE then
					TangramPuzzleData:SetCurClueDic(uv3, uv2.extra)
					uv1.RefreshClueRedPoint(uv3)
					manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_CLUE_UPDATE)
				end

				if uv4 ~= nil then
					uv4()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPoint = function (slot0)
		slot1 = string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE, slot0)
		slot2 = string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE_CLUE, slot0)
		slot3 = nil

		for slot8, slot9 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot9].activity_template == ActivityTemplateConst.TASK then
				slot3 = slot9

				break
			end
		end

		manager.redPoint:addGroup(slot1, {
			string.format("%s_%d", RedPointConst.ACTIVITY_TASK, slot3),
			slot2
		})
	end,
	RefreshClueRedPoint = function (slot0)
		slot1 = 0
		slot2 = TangramPuzzleData:GetCurClueDic(slot0)

		for slot7, slot8 in pairs(TangramPuzzleTools.GetClueListByRegionType(slot0)) do
			slot9 = false

			if TangramPuzzleTools.IsAllRegionReceived(slot0, slot7) then
				for slot13, slot14 in ipairs(slot8) do
					if not slot2[slot14] then
						slot9 = true
						slot1 = 1

						break
					end
				end
			end

			if slot9 then
				break
			end
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE_CLUE, slot0), slot1)
	end
}
