slot0 = {
	fps = 30,
	duration = 3.733
}
slot0.sequence = {
	[0] = function (slot0)
		slot1 = slot0.entityID

		Dorm.DormEntityManager.PlayAnimeDuringInteract(slot1, "dressingroom", "01", 0)
		Dorm.DormEntityManager.SetFadeCMD(slot1, 0)
		Dorm.DormEntityManager.SetPlayerMainColliderEnabled(slot1, false)
		Dorm.DormEntityManager.PlayEffect(slot1, "root", "Dorm/Effect/houzhai/fx_yigui_huanyifu", -1)
	end,
	[43 / slot0.fps] = function (slot0)
		slot1 = slot0.entityID
		slot0.oldCharaEID = nil
		slot0.removeOldChara = slot0.oldCharaEID

		Dorm.DormEntityManager.SetFadeCMD(slot1, 1)
		Dorm.DormEntityManager.SetPlayerMainColliderEnabled(slot1, true)
		DormAction:SetHeroSkin(DormUtils.GetEntityData(slot1).cfgID, DormConst.DORM_CHANGESKIN_TYPE.furniture)
	end
}

return slot0
