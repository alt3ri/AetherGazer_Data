slot0 = class("DormLinkGameCustomerTemplate")
slot1 = nil

function slot0.Ctor(slot0, slot1)
	slot0.ID = slot1.customerID
	slot0.eid = slot1.customerEID
	slot0.posIndex = slot1.posIndex
	uv0 = 0
	slot0.curPreference = nil
	slot0.satietyNum = ActivityLinkGameCustomerCfg[slot0.ID].satiety_limit[1]
	slot0.satietyAddition = 0
	slot0.priority = ActivityLinkGameCustomerCfg[slot0.ID].seat_priority

	slot0:CalSatietyExtendAddition()
	slot0:RefreshNextPreferenceFood()
end

function slot0.FoodComplate(slot0)
	if slot0.curPreference then
		slot0:ReviseSatiety(ActivityLinkGameComposeCfg[slot0.curPreference].satiety_up)
		slot0:RefreshNextPreferenceFood()
		manager.notify:Invoke(LIANLIANKAN_CUSTOMER_EAT, slot0.posIndex)
	end
end

function slot0.RefreshNextPreferenceFood(slot0)
	if ActivityLinkGameCustomerCfg[slot0.ID].compose_list then
		while slot1[math.random(#slot1)] == slot0.curPreference and #slot1 > 1 do
			slot2 = slot1[math.random(#slot1)]
		end

		slot0.curPreference = slot2

		DormLinkGameData:UpdataCustomerNeed()
	end
end

function slot0.ReviseSatiety(slot0, slot1)
	slot0.satietyNum = slot0.satietyNum + ActivityLinkGameCustomerCfg[slot0.ID].satiety_limit[2] * slot1 / 100

	if slot0.satietyNum < ActivityLinkGameCustomerCfg[slot0.ID].satiety_limit[1] then
		slot0.satietyNum = slot3
	end

	if slot2 < slot0.satietyNum then
		slot0.satietyNum = slot2
	end

	slot0:CalSatietyExtendAddition()
	manager.notify:Invoke(DORM_LINK_REFRESH_CUSTOMER_SATIETY, slot0.ID)
end

function slot0.CalSatietyExtendAddition(slot0)
	slot2 = slot0.satietyAddition

	for slot6, slot7 in ipairs(ActivityLinkGameCustomerCfg[slot0.ID].satiety_score_up) do
		slot9 = slot7[2][2]

		if slot7[2][1] <= slot0.satietyNum and slot0.satietyNum < slot9 then
			slot0.satietyAddition = slot7[1]

			break
		end

		if slot6 == #slot1 and slot9 <= slot0.satietyAddition then
			slot0.satietyAddition = slot7[1]
		end
	end

	if slot2 ~= slot0.satietyAddition then
		DormLinkGameData:RefreshCustomerExtendAddition()
	end
end

function slot0.GetSatiety(slot0)
	if uv0 then
		return uv0
	else
		print(slot0.ID .. "号客人不存在饱食度数据")
	end
end

function slot0.RefreshCustomerBubble(slot0, slot1)
	DormLuaBridge.SetUIFollow(slot1, slot0.eid, "root")
end

return slot0
