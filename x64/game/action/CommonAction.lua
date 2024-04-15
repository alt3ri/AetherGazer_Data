return {
	TryToUseItem = function (slot0)
		slot1 = {
			use_item_list = slot0
		}
		slot2 = true

		for slot6, slot7 in pairs(slot0) do
			if ItemTools.IsItemExpired({
				id = slot7.item_info.id,
				timeValid = slot7.item_info.timeValid
			}) then
				slot2 = false

				break
			end
		end

		if slot2 then
			manager.net:SendWithLoadingNew(17012, slot1, 17013, uv0.OnTryToUseItem)
		else
			ShowTips("ERROR_ITEM_TIME_INVALID")
		end
	end,
	OnTryToUseItem = function (slot0, slot1)
		manager.notify:CallUpdateFunc(ON_TRY_TO_USE_ITEM, slot0, slot1)
	end,
	TryToUseItemWitchCallback = function (slot0, slot1)
		slot2 = {
			use_item_list = slot0
		}
		slot3 = true

		for slot7, slot8 in pairs(slot0) do
			if ItemTools.IsItemExpired({
				id = slot8.item_info.id,
				timeValid = slot8.item_info.timeValid
			}) then
				slot3 = false

				break
			end
		end

		if slot3 then
			manager.net:SendWithLoadingNew(17012, slot2, 17013, function (slot0)
				if isSuccess(slot0.result) then
					uv0(slot0)
				else
					ShowTips(slot0.result)
				end
			end)
		else
			ShowTips("ERROR_ITEM_TIME_INVALID")
		end
	end
}
