slot0 = {
	SetEntity = function (slot0, slot1)
		uv0[slot0] = slot1
	end,
	Clear = function ()
		uv0 = {}
	end,
	Work = function (slot0)
		Dorm.DormEntityManager.SendDoActionCMD(uv0[slot0], "sit_eat", false)
	end
}
slot1 = {}
slot0.events = {
	[LIANLIANKAN_CUSTOMER_EAT] = slot0.Work
}

return slot0
