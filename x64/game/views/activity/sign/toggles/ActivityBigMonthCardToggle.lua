slot0 = class("ActivityBigMonthCardToggle", ActivityBaseToggle)

function slot0.GetName(slot0)
	return "ActivityBigMonthCardToggle"
end

function slot0.IsActivity(slot0)
	return true
end

function slot0.UIClass(slot0)
	return BigMonthCardPage
end

function slot0.Check(slot0)
	return BigMonthCardData:HaveMonthCard() and BigMonthCardData:IsSignToday() and BigMonthCardData:IsNeedAccumulatSign() or not BigMonthCardData:HaveMonthCard() and BigMonthCardData:IsExpireTip() == 1
end

function slot0.Title(slot0)
	return GetTips("SIGN_TITLE_BIGMONTHCARD")
end

function slot0.Image(slot0)
	return "big_monthCard"
end

function slot0.RedPointKey(slot0)
	return RedPointConst.BIG_MONTH_CARD
end

function slot0.IsManual(slot0)
	return true
end

function slot0.Order(slot0)
	return 5
end

function slot0.GetSystemID(slot0)
	return ViewConst.SYSTEM_ID.BIG_MONTH_CARD
end

return slot0
