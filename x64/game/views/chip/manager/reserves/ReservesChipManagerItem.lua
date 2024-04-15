slot0 = class("ReservesChipManagerItem", ChipManagerItem)

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/reservesChipManager", {
			index = uv0.index_,
			chipManagerID = uv0.chipManagerID_
		})
	end)
end

function slot0.SetIndex(slot0, slot1)
	slot0.index_ = slot1
end

return slot0
