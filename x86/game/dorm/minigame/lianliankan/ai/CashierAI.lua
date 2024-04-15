slot0 = {
	SetEntity = function (slot0)
		uv0 = slot0
	end,
	Work = function ()
		Dorm.DormEntityManager.SendDoActionCMD(uv0, "manners", "01", false)
	end
}
slot1 = nil
slot0.events = {
	[LIANLIANKAN_USE_ITEM] = slot0.Work
}

return slot0
