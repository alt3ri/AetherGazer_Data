function slot0(slot0)
	return DormHeroTools:GetDormHeroNextCanUseSkin(BackHomeHeroSkinCfg[slot0].hero_id, slot0)
end

slot1 = "change_skin_end"
slot2 = {
	fps = 30
}
slot3 = 43 / slot2.fps
slot2.duration = slot3
slot2.sequence = {
	[0] = function (slot0)
		slot2 = slot0.entityID
		slot3, slot4 = DormCharacterManager.GetInstance():Generate(slot0.nextSkin, true)
		slot0.newCharaEID = slot3

		Dorm.DormEntityManager.PutEntityAt(slot3, slot2, "root")

		slot6 = nullable(DormUtils.GetEntityData(slot2), "interactCtx", "exitPos")

		DormUtils.SetEntityInteractContext(slot3, DormCharacterInteractBehaviour.MakeCtxForInternalAction(slot3, slot0.targetID, uv0, {
			oldCharaEID = slot2,
			exitPos = slot6,
			startTime = nullable(slot0.curActionTask, "taskDataCtx", "start")
		}))
		Dorm.DormEntityManager.TryExecuteInteractToEntityImmediate(slot3, slot0.targetID)

		if slot6 then
			Dorm.DormEntityManager.SendMoveLookToDirCMD(slot3, slot6, true, true)
		end

		DormHeroAI:SwitchControl(slot2, DormEnum.ControlType.Player)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(slot2, "dressingroom", "01", 0)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(slot0.targetID, "dressingroom", "01", 0)
	end,
	[1.18] = function (slot0)
		Dorm.DormEntityManager.SetPlayerMainColliderEnabled(slot0.entityID, false)
	end,
	[slot3] = function (slot0)
		if slot0.newCharaEID then
			slot0.newCharaEID = nil

			Dorm.DormEntityManager.SetFadeCMD(slot0.entityID, 0)
			Dorm.DormEntityManager.SetFadeCMD(slot0.newCharaEID, 1)
		end
	end
}

function slot2.onAbort(slot0)
	DormUtils.CallOnNextUpdate(function ()
		if uv0.newCharaEID then
			DormCharacterManager.FindAndRemove(uv0.newCharaEID)
		end
	end)
end

function slot2.onComplete(slot0)
	DormUtils.CallOnNextUpdate(function ()
		DormCharacterManager.FindAndRemove(uv0.entityID)
	end)
end

slot6 = {
	sequence = {
		[0] = function (slot0)
			Dorm.DormEntityManager.PlayAnimeDuringInteract(slot0.entityID, "dressingroom", "02", 0)
			Dorm.DormEntityManager.PlayAnimeDuringInteract(slot0.targetID, "dressingroom", "02", 0)
		end
	},
	duration = 3.467
}

function slot8(slot0)
	if uv0(slot0.entityCfg or DormUtils.GetEntityData(slot0.entityID).cfgID) then
		slot0.nextSkin = slot2
		slot0.continuous = true

		return uv1
	else
		slot0.continuous = false

		return uv2
	end
end

return function (slot0)
	return DormCharacterInteractBehaviour.MakeInteractTask(uv0(slot0), slot0)
end
