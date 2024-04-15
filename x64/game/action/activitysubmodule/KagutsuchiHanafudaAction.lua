manager.net:Bind(76001, function (slot0)
	HanafudaData:InitFromServer(slot0)
	uv0.RefreshRedPonit()
end)

return {
	SendHanafudaGameOver = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(76010, {
			activity_id = slot0,
			is_success = slot1 and 0 or 1,
			combine_id_list = slot2
		}, 76011, function (slot0, slot1)
			uv0.handleHanafudaGameOverResult(slot0, slot1, uv1)
		end)
	end,
	handleHanafudaGameOverResult = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			slot4 = math.max(0, math.min(GameSetting.activity_kagutsuchi_fatigue_hanafuda_card_recover.value[1], GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] - KagutsuchiWorkData:GetStamina()))

			HanafudaData:UpdateStreakInfo(slot1.is_success)
			HanafudaData:AddToCompleteCardCombineList(slot1.combine_id_list)

			if slot2 then
				slot2()
			end

			uv0.RefreshRedPonit()
		else
			ShowTips(slot0.result)
		end
	end,
	SendGetCombineReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(76012, {
			activity_id = slot0,
			combine_id = slot1
		}, 76013, function (slot0, slot1)
			uv0.handleGetCombineRewardResult(slot0, slot1, uv1)
		end)
	end,
	handleGetCombineRewardResult = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			getReward(formatRewardCfgList(HanafudaCardCombineCfg[slot1.combine_id].reward_item_list))
			HanafudaData:RewardedCardCombineListByID(slot1.combine_id)

			if slot2 then
				slot2()
			end

			uv0.RefreshRedPonit()
		else
			ShowTips(slot0.result)
		end
	end,
	RefreshRedPonit = function ()
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, HanafudaData:GetActivityID()), HanafudaData:GetIsTasksUnRewarded() and 1 or 0)
	end
}
