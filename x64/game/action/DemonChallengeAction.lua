return {
	RequireReceive = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11032, {
			stage_id = slot0
		}, 11033, function (slot0)
			uv0(slot0)
		end)
	end
}
