slot0 = {
	SetEntity = function (slot0)
		uv0 = slot0
	end,
	Work = function ()
		slot1 = uv1
		uv2 = true

		Dorm.DormEntityManager.ClearInteractEffectOnAttachPoint(slot1, "gua_R_hand_bone")
		Dorm.DormEntityManager.PlayEffect(slot1, "gua_R_hand_bone", "Effect/Dorm/food03", -1)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(slot1, "carry")
		Dorm.DormEntityManager.StopAllCmd(slot1)
		Dorm.DormEntityManager.SendDoActionCMD(slot1, "serve", "01", false)
		DormUtils.MoveByPath(slot1, Dorm.storage:PickData(uv0), true, false)
	end,
	Back = function ()
		uv0 = false
		slot1 = uv2

		Dorm.DormEntityManager.ClearInteractEffectOnAttachPoint(slot1, "gua_R_hand_bone")
		Dorm.DormEntityManager.RestoreEntityAnimeScheme(slot1)
		DormUtils.MoveByPath(slot1, Dorm.storage:PickData(uv1), true, true)
	end,
	OnEntityCompleteAllCmd = function (slot0)
		if slot0 == uv0 and uv1 then
			uv2.Back()
		end
	end
}
slot1 = "lianliankan.path.RestaurantWaiter"
slot2, slot3 = nil
slot0.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = slot0.OnEntityCompleteAllCmd,
	[LIANLIANKAN_ITEM_OVERFLOW] = slot0.Work
}

return slot0
