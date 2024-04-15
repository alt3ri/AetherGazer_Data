return {
	AddEventUpdateListener = function (slot0, slot1)
		slot0:AddEventListUpdateListener(function (slot0, slot1)
			uv0(slot0:ToTable(), slot1:ToTable())
		end)
	end,
	AddAllEventClickHandler = function (slot0, slot1, slot2, slot3)
		slot4 = {}

		uv0.AddEventUpdateListener(slot1, function (slot0, slot1)
			uv0.names = slot0
			uv0.args = slot1
		end)

		if slot2 == nil then
			slot0:GetOrAddComponent(slot1.gameObject, typeof(Button)).transition = UnityEngine.UI.Selectable.Transition.None
		end

		slot0:AddBtnListener(slot2, nil, function ()
			if uv0.names == nil or uv0.args == nil then
				return
			end

			uv1(uv0.names, uv0.args)
		end)
	end,
	AddEventClickHandler = function (slot0, slot1, slot2, slot3, slot4)
		uv0.AddAllEventClickHandler(slot0, slot1, slot2, function (slot0, slot1)
			uv0(uv1.FilterEvent(slot0, slot1, uv2))
		end)
	end,
	FilterEvent = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in ipairs(slot0) do
			if slot8 == slot2 then
				table.insert(slot3, slot1[slot7])
			end
		end

		return slot3
	end
}
