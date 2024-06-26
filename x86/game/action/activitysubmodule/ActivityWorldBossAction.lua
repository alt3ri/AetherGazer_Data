manager.net:Bind(61201, function (slot0)
	ActivityWorldBossData:InitWorldBossData(slot0)
	manager.notify:CallUpdateFunc(ACTIVITY_WORLD_BOSS_UPDATE)
	uv0.CheckRedPoint(slot0.activity_id)
end)
manager.net:Bind(61205, function (slot0)
	ActivityWorldBossData:InitWorldBossSocre(slot0)
end)
manager.notify:RegistListener(ZERO_REFRESH, function ()
	if ActivityData:GetActivityIsOpen(ActivityConst.NIEN_WORLD_BOSS) then
		ActivityWorldBossAction.QueryBossData(ActivityConst.NIEN_WORLD_BOSS)
	end
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.ACTIVITY_WORLD_BOSS then
		ActivityWorldBossAction.CheckRedPoint(slot0)
	end
end)

slot1 = nil

return {
	QueryHealthRward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(61202, {
			activity_id = slot0,
			damage_reward_id_list = slot1
		}, 61203, uv0.OnHealthRewardBack)
	end,
	OnHealthRewardBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward2(mergeReward2(slot0.reward_list))
			manager.notify:CallUpdateFunc(ACTIVITY_WORLD_BOSS_UPDATE)
			ActivityWorldBossAction.CheckRedPoint(slot1.activity_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryBossData = function (slot0, slot1)
		uv0 = slot1

		manager.net:SendWithLoadingNew(11006, {
			activity_id = {
				slot0
			}
		}, 11007, uv1.OnBossDataBack)
	end,
	OnBossDataBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if uv0 then
				uv0()
			end
		else
			ShowTips(slot0.result)
		end
	end,
	CheckRedPoint = function (slot0)
		if ActivityData:GetActivityIsOpen(slot0) then
			for slot5, slot6 in ipairs(ActivityWorldBossCfg[slot0].health_reward_list) do
				if ActivityWorldBossData:GetHealthRewardState(slot0, slot5) == 1 then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WORLD_BOSS, slot0), 1)

					return
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WORLD_BOSS, slot0), 0)
	end
}
