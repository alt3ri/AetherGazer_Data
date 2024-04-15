slot0 = singletonClass("FukubukuroData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitData(slot0, slot1)
	uv0 = {}

	slot0:UpdateData(slot1)
end

function slot0.UpdateData(slot0, slot1)
	slot2 = false

	for slot6, slot7 in ipairs(slot1) do
		if slot7.item.num <= 0 then
			uv0[slot7.instance_id] = nil
			slot2 = true
		else
			slot8 = {}

			for slot12, slot13 in ipairs(slot7.select_list) do
				table.insert(slot8, {
					id = slot13.id,
					number = slot13.num,
					timeValid = slot13.time_valid
				})
			end

			uv0[slot7.instance_id] = {
				item_id = slot7.item.id,
				instance_id = slot7.instance_id,
				select_list = slot8
			}
		end
	end

	if slot2 then
		manager.notify:Invoke(FUKUBURO_LIST_UPDATE)
	end
end

function slot0.GetFukubukuroByInstanceId(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetFukuburoList(slot0)
	return uv0
end

function slot0.CheckHaveItemId(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot1 == slot6.item_id then
			return true
		end
	end

	return false
end

return slot0
