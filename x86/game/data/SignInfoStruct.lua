slot0 = class("SignInfoStruct")

function slot0.Ctor(slot0, slot1)
	slot0.activity_id = slot1.activity_id

	slot0:Update(slot1)
end

function slot0.Update(slot0, slot1)
	slot0.sign_num = slot1.sign_num or 0
	slot0.today_buy_num = slot1.today_buy_num or 0
	slot0.left_sign_time = slot1.left_sign_time or 1
end

function slot0.SignDay(slot0)
	return slot0.sign_num or 0
end

function slot0.TotalSignDay(slot0)
	return ActivityCumulativeSignCfg[slot0.activity_id] and #slot1.config_list or 7
end

function slot0.CumulativeLoginDay(slot0)
	return slot0.sign_num + slot0.left_sign_time
end

function slot0.TodayBuyNum(slot0)
	return slot0.today_buy_num or 0
end

function slot0.LeftSignTimes(slot0)
	return slot0.left_sign_time or 0
end

function slot0.OnSignSuccess(slot0, slot1)
	slot0:Update(slot1)
end

function slot0.EndTime(slot0)
	return ActivityData:GetActivityData(slot0.activity_id).stopTime
end

function slot0.OnCrossDay(slot0)
	if slot0:CumulativeLoginDay() < slot0:TotalSignDay() then
		slot0.left_sign_time = 1
	end
end

function slot0.IsReSign(slot0)
	if slot0.left_sign_time > 0 then
		return false
	end

	if slot0:TotalSignDay() <= slot0:CumulativeLoginDay() then
		return false
	end

	return math.max(slot1 - math.ceil((slot0:EndTime() - manager.time:GetServerTime()) / 86400) - slot0.today_buy_num, 0) > 0
end

function slot0.ReSignNum(slot0)
	if slot0.left_sign_time > 0 then
		return 0
	end

	if slot0:TotalSignDay() <= slot0:CumulativeLoginDay() then
		return 0
	end

	return math.max(slot1 - math.ceil((slot0:EndTime() - manager.time:GetServerTime()) / 86400) - slot0.today_buy_num, 0)
end

function slot0.SignRewardList(slot0)
	if slot0.reward_list then
		return slot0.reward_list
	end

	slot0.reward_list = {}

	if not ActivityCumulativeSignCfg[slot0.activity_id] then
		print("ActivityCumulativeSignCfg不存在对应活动的配置------>", slot0.activity_id)

		return
	end

	for slot5, slot6 in ipairs(slot1.config_list) do
		table.insert(slot0.reward_list, SignCfg[slot6].reward)
	end

	return slot0.reward_list
end

function slot0.RedDotCount(slot0)
	return slot0.left_sign_time
end

return slot0
