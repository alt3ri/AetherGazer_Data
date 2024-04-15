slot1 = {}

manager.net:Bind(83027, function (slot0)
	ActivityHeroEnhanceData:InitData(slot0)
	Timer.New(function ()
		ActivityHeroEnhanceAction.InitRedPoint(uv0)
	end, 1, 0):Start()
end)

function slot2(slot0)
	if ActivityHeroEnhanceTools.IsCfgHeroLock(slot0) then
		return false
	end

	for slot5, slot6 in ipairs(slot0.stage_list) do
		if not ActivityHeroEnhanceData:IsStageClear(slot0.activity_id, slot6) and ActivityHeroEnhanceTools.IsCfgStageUnlock(slot0, slot6) then
			return true
		end
	end

	return false
end

manager.notify:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.ACTIVITY_HERO_ENHANCE then
		uv0.UpdateRedPoint(slot0)
	end
end)

return {
	ActivateTalent = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(83028, {
			activity_id = slot0,
			hero_id = slot1,
			talent_id = slot2
		}, 83029, function (slot0, slot1)
			uv0.OnActivateTalent(slot0, slot1, uv1)
		end)
	end,
	OnActivateTalent = function (slot0, slot1, slot2)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)

			return
		end

		ActivityHeroEnhanceData:ActivateTalent(slot1.activity_id, slot1.talent_id)
		slot2(slot1.activity_id, slot1.talent_id)
	end,
	DeactivateTalent = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(83030, {
			activity_id = slot0,
			talent_id = slot1
		}, 83031, function (slot0, slot1)
			uv0.OnDeactivateTalent(slot0, slot1, uv1)
		end)
	end,
	OnDeactivateTalent = function (slot0, slot1, slot2)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)

			return
		end

		ActivityHeroEnhanceData:DeactivateTalent(slot1.activity_id, slot1.talent_id)
		slot2(slot1.activity_id, slot1.talent_id)
	end,
	InitRedPoint = function (slot0)
		uv0[slot0.activity_id] = {}

		uv1.UpdateRedPoint(slot0.activity_id)
	end,
	UpdateRedPoint = function (slot0)
		slot1 = ActivityTools.GetRedPointKey(slot0) .. slot0

		manager.redPoint:addGroup(slot1, {
			string.format("%s_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, slot1)
		})

		if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[slot0] == nil then
			return
		end

		uv0[slot0] = uv0[slot0] or {}
		slot4 = {}

		for slot8, slot9 in ipairs(slot3) do
			if uv0[slot0][string.format("%s_%d_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, ActivityHeroEnhanceCfg[slot9].hero_id, slot1)] then
				manager.redPoint:setTip(slot12, 0)
			else
				manager.redPoint:setTip(slot12, uv1(slot10) and 1 or 0)
			end

			table.insert(slot4, slot12)
		end

		manager.redPoint:addGroup(slot2, slot4)
	end,
	BanRedPoint = function (slot0, slot1)
		if uv0[slot0] then
			uv0[slot0][slot1] = true

			uv1.UpdateRedPoint(slot0)
		end
	end
}
