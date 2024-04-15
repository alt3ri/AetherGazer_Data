slot0 = singletonClass("NorseSurpriseGiftReceiveData")

function slot0.Ctor(slot0)
end

function slot0.InitData(slot0, slot1)
	print("抽扭蛋初始数据", 65429)

	slot0.delete_list = slot1.delete_list
	slot0.choose_list = slot1.choose_list
	slot0.draw_list = slot1.draw_list
	slot0.result_role_id = slot1.result_role_id

	slot0:UpdateRedPointData(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
	slot0:UpdateRedPointData2(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
end

function slot0.SetRoleData(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2.delete_list) do
		table.insert(slot0.delete_list, slot7)
	end

	for slot6, slot7 in ipairs(slot2.draw_list) do
		table.insert(slot0.draw_list, slot7)
	end

	slot0:UpdateRedPointData2(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
end

function slot0.GetDelRoleData(slot0)
	return slot0.delete_list
end

function slot0.GetDrawRoleData(slot0)
	return slot0.draw_list
end

function slot0.GetChooseRoleData(slot0)
	return slot0.choose_list
end

function slot0.SetChooseRoleData(slot0, slot1)
	slot0.choose_list = slot1
end

function slot0.GetResultRoleId(slot0)
	return slot0.result_role_id
end

function slot0.SetResultRoleId(slot0, slot1)
	slot0.result_role_id = slot1
end

function slot0.UpdateRedPointData(slot0, slot1)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, slot1), ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN))

	if #slot0.draw_list >= 5 or slot0.result_role_id and slot0.result_role_id > 0 then
		manager.redPoint:setTip(slot2, 0)
	end
end

function slot0.UpdateRedPointData2(slot0, slot1)
	slot0:UpdateRedPointData(slot1)

	if slot0.draw_list and #slot0.draw_list >= 5 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, slot1), 1)
	else
		manager.redPoint:setTip(slot2, 0)
	end

	if slot0.result_role_id and slot0.result_role_id > 0 then
		manager.redPoint:setTip(slot2, 0)
	end
end

return slot0
