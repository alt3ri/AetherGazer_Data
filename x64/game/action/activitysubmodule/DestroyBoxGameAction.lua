manager.net:Bind(72121, function (slot0)
	DestroyBoxGameData:InitData(slot0)
end)
manager.net:Bind(72125, function (slot0)
	DestroyBoxGameData:RefreshScore(slot0)
end)

return {
	RequestReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(72122, {
			main_activity_id = slot0,
			reward_id_list = slot1
		}, 72123, function (slot0)
			if isSuccess(slot0.result) then
				DestroyBoxGameData:UpdateReceiveRewardList(uv0, uv1)
				getReward2(slot0.item_list)
				uv2()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPoint = function (slot0)
		slot1 = string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 1, slot0)
		slot2 = string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 2, slot0)
		slot3 = string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 9, slot0)
		slot7 = {
			{},
			{},
			[9] = {}
		}

		for slot11, slot12 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			for slot16, slot17 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[slot12]) do
				if DestroyBoxGameCfg[slot17].difficult == 9 then
					slot20 = string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, slot18, slot12)

					manager.redPoint:addGroup(slot20, {
						string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, slot18, slot12),
						string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_CHALLENGE_REWARD, slot12)
					})
					table.insert(slot7[slot18], slot20)
				else
					table.insert(slot7[slot18], string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, slot18, slot12))
				end
			end
		end

		manager.redPoint:addGroup(slot1, slot4)
		manager.redPoint:addGroup(slot2, slot5)
		manager.redPoint:addGroup(slot3, slot6)
		manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(slot0), slot0), {
			string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, slot0),
			slot1,
			slot2,
			slot3
		})
	end,
	UpdateAllRedPoint = function (slot0)
		for slot4, slot5 in ipairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id[slot0]) do
			uv0.UpdateRedPoint(DestroyBoxGameCfg[slot5].activity_id)
		end
	end,
	UpdateRedPoint = function (slot0)
		if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() + 1 then
			for slot6, slot7 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[slot0]) do
				manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[slot7].difficult, slot0), 0)
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_CHALLENGE_REWARD, slot0), 0)
		elseif slot1.startTime <= slot2 then
			for slot6, slot7 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[slot0]) do
				if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_DESTROY_BOX_RAMGE + slot7) and DestroyBoxGameData:IsFinishPreStage(slot7) then
					manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[slot7].difficult, slot0), 1)
				end
			end
		end
	end,
	UpdateMainActivityRedPoint = function (slot0)
		if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, slot0), 0)
		end
	end,
	ClickBoxStageItem = function (slot0, slot1)
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_DESTROY_BOX_RAMGE + slot1)
		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[slot1].difficult, slot0), 0)
	end
}
