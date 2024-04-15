slot0 = singletonClass("KagutsuchiFishingEventData")
slot0.EnumFishRarity = {
	S = {
		order = 3,
		name = "S"
	},
	A = {
		order = 2,
		name = "A"
	},
	B = {
		order = 1,
		name = "B"
	}
}

function slot2(slot0)
	return GameSetting.activity_kagutsuchi_card_level_up_need.value[slot0.order][2]
end

function slot0.InitFromServer(slot0, slot1)
	slot0.activityID = slot1.activity_id
	slot0.dailyGameCount = slot1.today_fish_num

	slot0:UpdateFishRemain(slot1.fish_list)
end

function slot0.UpdateFishRemain(slot0, slot1)
	slot0.fishRemain = {}

	for slot6, slot7 in ipairs(HanafudaCardCfg.all) do
		slot0.fishRemain[slot7] = uv0(uv1.S)
	end

	for slot6, slot7 in ipairs(slot1) do
		slot0.fishRemain[slot7.id] = slot0.fishRemain[slot7.id] - slot7.num > 0 and slot8 or nil
	end
end

function slot0.OnFishingGameFinish(slot0, slot1, slot2)
	if slot2 then
		slot0.dailyGameCount = slot0.dailyGameCount + 1
		slot0.fishRemain[slot1] = nullable(slot0.fishRemain, slot1) and (slot3 > 1 and slot3 - 1 or nil)
	end
end

function slot0.TestRarity(slot0)
	if uv0(uv1.S) <= uv0(uv1.S) - slot0 then
		return uv1.S
	elseif uv0(uv1.A) <= slot2 then
		return uv1.A
	else
		return uv1.B
	end
end

function slot0.GetRemainFishForUpgrade(slot0, slot1)
	return slot0.fishRemain[slot1] or 0
end

function slot0.GetRarity(slot0, slot1)
	return uv0.TestRarity(slot0:GetRemainFishForUpgrade(slot1))
end

function slot0.FishNotYetGet(slot0, slot1)
	return uv0(uv1.S) - slot0:GetRemainFishForUpgrade(slot1) == 0
end

function slot0.GetNextRarity(slot0, slot1)
	if uv0(uv1.S) <= uv0(uv1.S) - slot0:GetRemainFishForUpgrade(slot1) then
		return nil, 
	elseif uv0(uv1.A) <= slot4 then
		return uv1.S, slot2
	else
		return uv1.A, uv0(uv1.A) - slot4
	end
end

function slot0.GetRestGameCount(slot0)
	return math.max(0, GameSetting.activity_kagutsuchi_fish_times_max.value[1] - KagutsuchiFishingEventData.dailyGameCount)
end

return slot0
