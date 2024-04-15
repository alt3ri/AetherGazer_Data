slot0 = singletonClass("CoreVerificationData")
slot1 = {}
slot2 = {}
slot3 = 0
slot4 = 0
slot5 = 0
slot6 = {}
slot7 = {}
slot8 = {}
slot9 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
	uv5 = {}
	uv6 = 1
	uv7 = 2

	for slot4, slot5 in pairs(CoreVerificationInfoCfg.get_id_list_by_cycle) do
		uv0[slot4] = {
			{},
			{}
		}

		for slot9, slot10 in ipairs(slot5) do
			slot11 = CoreVerificationInfoCfg[slot10]
			uv0[slot4][slot11.boss_type][slot11.difficult] = slot10
		end
	end

	uv2[1] = {}
	uv2[2] = {}
	uv2[3] = {}
	uv2[4] = {}

	for slot4, slot5 in pairs(CoreVerificationRewardCfg.all) do
		if CoreVerificationRewardCfg[slot5].reward_type == 1 or slot6.reward_type == 2 then
			if not uv2[slot6.reward_type][slot6.cycle] then
				uv2[slot6.reward_type][slot6.cycle] = {}
			end

			table.insert(uv2[slot6.reward_type][slot6.cycle], slot5)
		else
			table.insert(uv2[slot6.reward_type], slot5)
		end
	end

	slot0:SetUpdateCycleCallBack()
end

function slot0.UpdateCycleInfo(slot0, slot1)
	uv0 = slot1.now_cycle
	uv1 = slot1.next_cycle
	uv2 = slot1.refresh_timestamp

	for slot5, slot6 in ipairs(slot1.stage_info) do
		uv3[slot6.id] = {
			passState = slot6.sign == 1,
			passTime = slot6.sign == 1 and slot6.min_time / 1000 or 3600
		}
	end

	for slot5, slot6 in ipairs(slot1.reward_list) do
		uv4[slot6] = true
	end

	uv5[1] = {}
	uv5[2] = {}

	for slot5, slot6 in ipairs(slot1.lock_list) do
		for slot10, slot11 in ipairs(slot6.hero_list) do
			table.insert(uv5[slot6.boss_type], slot11)
		end
	end

	uv6 = {
		0,
		0
	}
	slot3 = uv7[uv0][2]

	for slot7, slot8 in ipairs(uv7[uv0][1]) do
		if uv3[slot8] and uv3[slot8].passState then
			uv6[1] = slot7
		end
	end

	for slot7, slot8 in ipairs(slot3) do
		if uv3[slot8] and uv3[slot8].passState then
			uv6[2] = slot7
		end
	end
end

function slot0.BattleStageData(slot0, slot1, slot2, slot3)
	slot4 = CoreVerificationInfoCfg[slot1]

	if uv0[slot4.boss_type] < slot4.difficult then
		uv0[slot5] = slot6
	end

	for slot10, slot11 in ipairs(slot2) do
		if not table.keyof(uv1[slot5], slot11) then
			table.insert(uv1[slot5], slot11)
		end
	end

	if uv2[slot4.id] then
		uv2[slot4.id].passState = true

		if slot3 < uv2[slot4.id].passTime then
			uv2[slot4.id].passTime = slot3
		end
	else
		uv2[slot4.id] = {
			passState = true,
			passTime = slot3
		}
	end

	CoreVerificationAction.UpdateRewardRedPoints()
end

function slot0.UpdateRewardData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.reward_list) do
		uv0[slot6] = true
	end
end

function slot0.GetBossUICfgByBossType(slot0, slot1)
	return BossChallengeUICfg[CoreVerificationInfoCfg[uv0[uv1][slot1][1]].stage_id] or BossChallengeUICfg[3090009]
end

function slot0.GetRecommendByBossType(slot0, slot1)
	return CoreVerificationInfoCfg[uv0[uv1][slot1][1]].recommend
end

function slot0.GetLockHeroByBossType(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetDiffListByBossType(slot0, slot1)
	return uv0[uv1][slot1]
end

function slot0.GetLockHeroByInfoID(slot0, slot1, slot2)
	if slot2 then
		return uv0[CoreVerificationInfoCfg[slot1].boss_type]
	elseif slot3 == 1 then
		return uv0[2]
	elseif slot3 == 2 then
		return uv0[1]
	end

	return uv0[1]
end

function slot0.GetMaxPassByBossType(slot0, slot1)
	slot2 = uv0[slot1] > 0
	slot3 = uv0[slot1] > 0 and uv0[slot1] or 1

	return slot2, slot3, slot2 and uv3[uv1[uv2][slot1][slot3]].passTime or 0
end

function slot0.GetMaxUnlockByBossType(slot0, slot1)
	slot2 = 1

	for slot7, slot8 in ipairs(uv0[uv1][slot1]) do
		if uv2[slot8 - 1] and CoreVerificationInfoCfg[slot8].unlock_level <= PlayerData:GetPlayerInfo().userLevel then
			slot2 = slot7
		end
	end

	return slot2
end

function slot0.GetStageInfoByTypeAndDiff(slot0, slot1, slot2)
	return uv2[uv0[uv1][slot1][slot2]]
end

function slot0.GetInfoCfgByTypeAndDiff(slot0, slot1, slot2)
	return CoreVerificationInfoCfg[uv0[uv1][slot1][slot2]]
end

function slot0.GetAffixByTypeAndDiff(slot0, slot1, slot2)
	return CoreVerificationInfoCfg[uv0[uv1][slot1][slot2]].affix_type
end

function slot0.GetRewardListByType(slot0, slot1)
	if slot1 == 1 or slot1 == 2 then
		return uv0[slot1][uv1]
	else
		return uv0[slot1]
	end
end

function slot0.CheckFirstReward(slot0)
	for slot5, slot6 in ipairs(uv0[4]) do
		if not uv1[slot6] then
			return "true"
		end
	end

	return "false"
end

function slot0.GetCurCycleInfo(slot0)
	return uv0[uv1]
end

function slot0.GetPreviewInfo(slot0)
	return uv0[uv1]
end

function slot0.GetRefreshTime(slot0)
	return uv0
end

function slot0.GetTaskProcess(slot0, slot1)
	slot4 = 0

	if ConditionCfg[CoreVerificationRewardCfg[slot1].condition].type == 11300 then
		slot4 = slot3.params[2] <= uv0[slot3.params[1]] and 1 or 0
	elseif slot3.type == 11302 then
		slot4 = slot3.params[1] <= uv0[1] and slot5 <= uv0[2] and 1 or 0
	elseif slot3.type == 11301 then
		slot5 = slot3.params[1]
		slot4 = uv3[uv1[uv2][1][slot5]] and uv3[uv1[uv2][2][slot5]] and 1 or 0
	elseif slot3.type == 11303 then
		slot4 = uv3[uv1[uv2][slot3.params[1]][slot3.params[2]]] and 1 or 0
	end

	return slot4, slot3.progress_show, slot4 == 1, uv4[slot1] or false
end

function slot0.IsStageProcess(slot0)
	return uv0[1] > 0 or uv0[2] > 0
end

slot10 = nil

function slot0.SetUpdateCycleCallBack(slot0)
	function uv0()
		ShowTips("STAGE_REFRESH_DATA")
		JumpTools.GoToSystem("/coreVerificationMain", nil, ViewConst.SYSTEM_ID.CORE_VERIFICATION)
	end
end

function slot0.InvokeUpdateCycleCallBack(slot0)
	if uv0 then
		uv0()

		uv0 = nil
	end
end

return slot0
