slot0 = singletonClass("BigMonthCardData")
slot1 = {
	sign_days = 0,
	is_expire_tip = 0,
	template_id = 0,
	monthly_card_timestamp = 0,
	is_sign = 0,
	have_sign = {},
	daily_record = {}
}
slot2 = false

function slot0.Init(slot0)
	uv0.monthly_card_timestamp = 0
	uv0.is_sign = 0
	uv0.sign_days = 0
	uv0.have_sign = {}
	uv0.daily_record = {}
	uv0.is_expire_tip = 0
	uv0.template_id = 0
	uv1 = false
end

function slot0.InitData(slot0, slot1)
	uv0.monthly_card_timestamp = slot1.buy_timestamp
	uv0.is_sign = slot1.is_sign
	uv0.sign_days = slot1.total_sign_times
	uv0.have_sign = slot1.total_sign_receive_list
	uv0.is_expire_tip = slot1.is_expire_tip
	uv0.template_id = slot1.template_id

	slot0:InitRecord(slot1.daily_record)
end

function slot0.UpdateIsSign(slot0, slot1)
	uv0.is_sign = slot1
end

function slot0.UpdateSignData(slot0, slot1)
	uv0.sign_days = slot1
end

function slot0.InitRecord(slot0, slot1)
	uv0.daily_record = {}

	for slot5, slot6 in ipairs(slot1 or {}) do
		uv0.daily_record[slot6.index] = slot6.times
	end
end

function slot0.IsSignToday(slot0)
	return uv0.is_sign == 1
end

function slot0.HaveMonthCard(slot0)
	return uv0.monthly_card_timestamp > 0 and TimeMgr.GetInstance():GetServerTime() < slot0:GetMonthCardDeadTime()
end

function slot0.SignToday(slot0)
	uv0.is_sign = 1
	uv0.sign_days = uv0.sign_days + 1
end

function slot0.SignAccumulate(slot0, slot1)
	table.insert(uv0.have_sign, slot1)
end

function slot0.IsNeedAccumulatSign(slot0)
	if uv0.template_id == 0 then
		return false
	end

	slot2 = false

	for slot7, slot8 in ipairs(BigMonthCardAccumulationCfg.get_id_list_by_template_id[slot1]) do
		if BigMonthCardAccumulationCfg[slot8].accumulation <= uv0.sign_days and not table.indexof(uv0.have_sign, slot8) then
			slot2 = true

			break
		end
	end

	return slot2
end

function slot0.ResetSign(slot0)
	uv0.is_sign = 0
end

function slot0.GetMonthCardDeadTime(slot0)
	slot1 = nil

	if tonumber(manager.time:STimeDescS(uv0.monthly_card_timestamp, "!%H")) < GameSetting.refresh_time1.value[1][1] then
		slot1 = manager.time:Table2ServerTime({
			year = tonumber(manager.time:STimeDescS(slot2 - 86400, "!%Y")),
			month = tonumber(manager.time:STimeDescS(slot2 - 86400, "!%m")),
			day = tonumber(manager.time:STimeDescS(slot2 - 86400, "!%d")),
			hour = GameSetting.refresh_time1.value[1][1],
			min = GameSetting.refresh_time1.value[1][2],
			sec = GameSetting.refresh_time1.value[1][3]
		})
	else
		slot1 = manager.time:Table2ServerTime({
			year = tonumber(manager.time:STimeDescS(slot2, "!%Y")),
			month = tonumber(manager.time:STimeDescS(slot2, "!%m")),
			day = tonumber(manager.time:STimeDescS(slot2, "!%d")),
			hour = GameSetting.refresh_time1.value[1][1],
			min = GameSetting.refresh_time1.value[1][2],
			sec = GameSetting.refresh_time1.value[1][3]
		})
	end

	return slot1 + (GameSetting.big_monthly_card_duration.value[1] + 1) * 86400
end

function slot0.GetSignDays(slot0)
	return uv0.sign_days
end

function slot0.GetHaveSign(slot0)
	return uv0.have_sign
end

function slot0.SetRecord(slot0, slot1)
	slot0:InitRecord(slot1.daily_record)
end

function slot0.GetRecord(slot0)
	return uv0.daily_record
end

function slot0.GetMonthCardLastDay(slot0)
	if math.floor((slot0:GetMonthCardDeadTime() - TimeMgr.GetInstance():GetServerTime()) / 86400) - uv0.is_sign < 0 then
		slot2 = 0
	end

	return slot2
end

function slot0.LoginPopFlag(slot0)
	if not uv0 then
		uv0 = true

		return uv0
	end

	return false
end

function slot0.IsExpireTip(slot0)
	return uv0.is_expire_tip
end

function slot0.SetIsExpireTip(slot0)
	uv0.is_expire_tip = 0
end

function slot0.GetTemplateId(slot0)
	return uv0.template_id
end

return slot0
