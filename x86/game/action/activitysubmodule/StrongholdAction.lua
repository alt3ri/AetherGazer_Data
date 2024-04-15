manager.net:Bind(65415, function (slot0)
	StrongholdData:InitData(slot0)
	uv0.CheckRewardRedPoint()
	uv0.CheckIncreaseRedPoint()
end)
manager.net:Bind(65417, function (slot0)
	StrongholdData:InitRoomExt(slot0)
end)
manager.net:Bind(65419, function (slot0)
	StrongholdData:InitStrongholdResultData(slot0)
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function (slot0)
	if slot0 == CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_1 or slot0 == CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_2 or slot0 == CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_3 then
		uv0.CheckRewardRedPoint()
		uv0.CheckIncreaseRedPoint()
	end
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function ()
	uv0.CheckTaskRedPoint()
end)

return {
	QueryChooseRoomSkillType = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = StrongholdData:GetStrongholdLevel(slot1)

		if slot3 < StrongholdData:GetSkillLimitLv() then
			ShowTips(string.format(GetTips("ACTIVITY_STRONGHOLD_TYPE_LIMIT_LV"), GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. slot1), slot6))

			return
		end

		manager.net:SendWithLoadingNew(65410, {
			room_id = slot0,
			type = slot1
		}, 65411, uv0.OnChooseRoomSkillTypeCallBack)
	end,
	OnChooseRoomSkillTypeCallBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	QueryUpgradeIncrease = function (slot0, slot1)
		slot3, slot4 = StrongholdData:GetStrongholdLevelAndIncreasePoint(slot0)
		slot5 = slot4 - StrongholdData:GetUsePoint(slot0)

		if not ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[slot1][StrongholdData:GetIncreaseLevel(slot0, slot1) + 1]] then
			return
		end

		if slot5 < slot9.cost then
			ShowTips("ACTIVITY_STRONGHOLD_LACK_INCREASE_POINT")

			return
		end

		manager.net:SendWithLoadingNew(65412, {
			activity_id = slot0,
			skill_id = slot1
		}, 65413, uv0.OnUpgradeIncreaseCallBack)
	end,
	OnUpgradeIncreaseCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			StrongholdData:UpgradeIncreaseLevel(slot1.activity_id, slot1.skill_id)
			manager.notify:CallUpdateFunc(STRONGHOLD_UPGRADE_INCREASE)
			uv0.CheckIncreaseRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(65420, {
			activity_id = slot0,
			reward_id = slot1
		}, 65421, uv0.OnRewardCallBack)
	end,
	OnRewardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			StrongholdData:UpdateReward(slot1.activity_id, slot1.reward_id)
			getReward(mergeReward2(slot0.reward_list))
			manager.notify:CallUpdateFunc(STRONGHOLD_UPDATE_REWARD)
			uv0.CheckRewardRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	UpgradeAltas = function (slot0, slot1)
		StrongholdData:UpgradeAltas(slot0, slot1)
	end,
	CheckRewardRedPoint = function ()
		for slot3, slot4 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
			slot5 = false

			if ActivityData:GetActivityIsOpen(slot4) then
				for slot9, slot10 in ipairs(ActivityStrongholdRewardCfg.all) do
					if StrongholdData:GetRewardState(slot4, slot10) == 0 then
						slot5 = true

						break
					end
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, slot4), slot5 and 1 or 0)
		end
	end,
	CheckIncreaseRedPoint = function ()
		for slot3, slot4 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
			slot5 = false

			if ActivityData:GetActivityIsOpen(slot4) then
				slot6, slot7 = StrongholdData:GetStrongholdLevelAndIncreasePoint(slot4)

				for slot13, slot14 in pairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id) do
					if ActivityStrongholdIncreaseCfg[slot14[StrongholdData:GetIncreaseLevel(slot4, slot13) + 1]] and slot17.cost <= slot7 - StrongholdData:GetUsePoint(slot4) then
						slot5 = true

						break
					end
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, slot4), slot5 and 1 or 0)
		end
	end,
	CheckTaskRedPoint = function ()
		for slot3, slot4 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
			slot5 = false

			if ActivityData:GetActivityIsOpen(slot4) then
				for slot10, slot11 in ipairs(ActivityCfg[slot4].sub_activity_list) do
					if ActivityTemplateConst.TASK == ActivityCfg[slot11].activity_template and #TaskTools:GetCanGetActivityTaskList(slot11) > 0 then
						slot5 = true

						break
					end
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, slot4), slot5 and 1 or 0)
		end
	end
}
