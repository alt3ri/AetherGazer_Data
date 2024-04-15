slot0 = singletonClass("ActivityAffixSelectData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
end

function slot0.OnPushMainActivityData(slot0, slot1)
	slot2 = slot1.activity_id
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.got_reward_list) do
		table.insert(slot3, slot8)
	end

	uv0[slot2] = {
		got_reward_list = slot3
	}

	manager.notify:Invoke(AFFIX_SELECT_MAIN_ACTIVITY_UPDATE, {})
end

function slot0.OnPushSubActivityData(slot0, slot1)
	slot2 = {
		activityId = slot1.activity_id,
		clearState = slot1.first_clear_reward_apply_state,
		affixList = {},
		point = slot1.point
	}

	for slot6, slot7 in ipairs(slot1.custom_affix_list) do
		table.insert(slot2.affixList, slot7)
	end

	uv0[slot1.activity_id] = slot2

	manager.notify:Invoke(AFFIX_SELECT_SUB_ACTIVITY_UPDATE, {})
end

function slot0.GetClearState(slot0, slot1)
	if not uv0[slot1] then
		error("找不到对应的活动，未开启")

		return 0
	end

	return slot2.clearState
end

function slot0.HaveGotScoreReward(slot0, slot1, slot2)
	if not table.indexof(uv0[slot1] and uv0[slot1].got_reward_list or {}, slot2) then
		return false
	end

	return true
end

function slot0.OnGetFirstBonus(slot0, slot1)
	if not uv0[slot1] then
		error("找不到对应的活动，未开启")
	end

	slot2.clearState = 3

	manager.notify:Invoke(AFFIX_SELECT_FIRST_BONUS_UPDATE, slot1)
end

function slot0.OnSetAffix(slot0, slot1, slot2)
	if not uv0[slot1] then
		error("找不到对应的活动，未开启")
	end

	slot3.affixList = slot2

	manager.notify:Invoke(AFFIX_SELECT_CUSTOM_AFFIX_UPDATE, slot1)
end

function slot0.GetSubActivityData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetOpenedSubActivityDatas(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(ActivityCfg[slot1].sub_activity_list) do
		table.insert(slot2, uv0[slot8])
	end

	return slot2
end

function slot0.GetGodRewardList(slot0, slot1)
	return uv0[slot1] and uv0[slot1].got_reward_list or {}
end

function slot0.GetCurrentActivityReward(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1]) do
		if slot0:GetRewardStatus(slot1, slot7) == 1 or slot8 == 2 then
			return slot7
		end
	end

	return slot2[#slot2]
end

function slot0.ScoreRewardGetCount(slot0, slot1)
	return #(uv0[slot1] and uv0[slot1].got_reward_list or {})
end

function slot0.GetTotalScore(slot0, slot1)
	for slot7, slot8 in ipairs(ActivityCfg[slot1].sub_activity_list) do
		if uv0[slot8] then
			slot2 = 0 + uv0[slot8].point
		end
	end

	return slot2
end

function slot0.GetLevelScore(slot0, slot1)
	for slot8, slot9 in ipairs(uv0[slot1].affixList) do
		slot3 = ActivityAffixSelectCfg[slot1].base_point + ActivityAffixPoolCfg[slot9].point
	end

	return slot3
end

function slot0.GetRewardStatus(slot0, slot1, slot2)
	slot3 = false

	if table.indexof(uv0[slot1] and uv0[slot1].got_reward_list or {}, slot2) then
		slot3 = true
	end

	if slot3 then
		return 0
	end

	if ActivityPointRewardCfg[slot2].need <= slot0:GetTotalScore(slot1) then
		return 2
	end

	return 1
end

function slot0.OnScoreRewardGet(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if uv0[ActivityPointRewardCfg[slot6].activity_id] and not table.indexof(uv0[slot8].got_reward_list, slot6) then
			table.insert(uv0[slot8].got_reward_list, slot6)
		end
	end
end

function slot0.GetAffix(slot0, slot1)
	table.insert({}, ActivityAffixSelectCfg[slot1].boss_affix)

	if uv0[slot1] then
		for slot10, slot11 in ipairs(slot5.affixList) do
			table.insert(slot4, ActivityAffixPoolCfg[slot11].affix)
		end
	end

	return slot4
end

function slot0.ReadInnerRedPoint(slot0, slot1)
	uv0[slot1] = true
end

function slot0.HaveReadInnerPoint(slot0, slot1)
	return uv0[slot1] ~= nil
end

return slot0
