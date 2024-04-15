manager.net:Bind(65201, function (slot0)
	DormLinkGameData:InitLevelInfo(slot0)
end)

return {
	ClearanceLevel = function (slot0, slot1, slot2)
		slot3, slot4 = DormLinkGameTools:ChecklevelUnLock(slot1)

		if slot3 then
			slot5 = DormLinkGameData:GetLastPoint()
			slot6 = slot2.gameTime
			slot7 = {}

			if slot2.useItemList then
				for slot11, slot12 in pairs(slot2.useItemList) do
					table.insert(slot7, {
						id = slot11,
						num = slot12
					})
				end
			end

			manager.net:SendWithLoadingNew(65210, {
				id = slot1,
				point = slot5,
				remain_time = slot6,
				item_list = slot7
			}, 65211, uv0.ClearanceLevelCallBack)
		else
			if slot4 == DormLinkGameConst.LevelLockType.stop then
				ShowTips("TIME_OVER")
			end

			DormLinkGameData:FailedClear()
		end
	end,
	ClearanceLevelCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormLinkGameData:SuccessClear(slot1)
		else
			print("结算失败")
		end
	end,
	GetLevelAward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(65212, {
			reward_id = slot1
		}, 65213, uv0.GetLevelAwardCallBack)
	end,
	GetLevelAwardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if ActivityLinkGameRewardCfg[slot1.reward_id] then
				DormLinkGameData:SetRewardInfo(slot1.reward_id, true)

				for slot8, slot9 in ipairs(mergeReward2(slot0.reward_list)) do
					if ItemCfg[slot9.id].use == 2 then
						table.insert({}, {
							item_info = {
								id = slot9.id,
								num = slot9.num
							},
							use_list = {}
						})
					end
				end

				getReward2(slot3, nil, function ()
					CommonAction.TryToUseItem(uv0)
				end, true)
				manager.notify:Invoke(DORM_LINK_REFRESH_LEVEL_AWARD, slot1.reward_id)
			end
		else
			print("领取关卡奖励失败")
		end
	end
}
