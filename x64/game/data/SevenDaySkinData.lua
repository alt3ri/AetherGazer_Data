slot1 = require(...:gsub("%.SevenDaySkinData", "") .. ".SignInfoStruct")
slot2 = singletonClass("SevenDaySkinData")

function slot2.Ctor(slot0)
	slot0.activity_map = {}
end

function slot2.InitData(slot0, slot1)
	print("七日签到皮肤初始化", 11080)

	slot0.activity_map[slot1.activity_id] = uv0.New(slot1)

	slot0:UpdateRedDotCount(slot1.activity_id)
end

function slot2.Clear(slot0)
	if not slot0.activity_map then
		return
	end

	for slot4, slot5 in pairs(slot0.activity_map) do
		slot5:OnCrossDay()
		uv0:UpdateRedDotCount(slot4)
	end
end

function slot2.MaxSignDay(slot0)
	return ActivityCumulativeSignCfg[slot0.activity_id] and #slot1.config_list or 7
end

function slot2.GetActivityData(slot0, slot1)
	slot0.activity_map = slot0.activity_map or {}

	if not slot0.activity_map[slot1] then
		slot0.activity_map[slot1] = uv0.New({
			activity_id = slot1
		})
	end

	return slot2
end

function slot2.UpdateActivityData(slot0, slot1, slot2)
	slot0:GetActivityData(slot1):Update(slot2)
	slot0:UpdateRedDotCount(slot1)
end

function slot2.GetRedDotCount(slot0, slot1)
	return slot0:GetActivityData(slot1):RedDotCount()
end

function slot2.UpdateRedDotCount(slot0, slot1)
	slot3 = slot0:GetRedDotCount(slot1)

	print(slot1, "------------------------->", slot3)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, slot1), slot3)
end

return slot2
