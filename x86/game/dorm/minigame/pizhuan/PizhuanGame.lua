slot0 = class("PizhuanGame")
slot1 = "pizhuan_game"

function slot0.Ctor(slot0, slot1)
	slot0.gameFinish = slot1
end

function slot2(slot0)
	if slot0 then
		Dorm.DormEntityManager.Instance:RemoveEntity(slot0)

		slot0 = nil
	end
end

slot3 = "pizhuan_success"
slot4 = "pizhuan_fail"

function slot5(slot0)
	slot1 = DormCharacterActionManager.taskRunner:NewTask()

	slot1:Then(function ()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0.player, "power_storage")
	end):WaitUntil(function (slot0)
		slot1, slot0.taskDataCtx.result = uv0.gameFinish()

		if slot1 then
			-- Nothing
		end

		return slot1
	end):Then(function (slot0)
		if DormCharacterInteractBehaviour.GetSequence(DormUtils.GetEntityData(uv0.player).cfgID, nil, slot0.taskDataCtx.result and uv1 or uv2) then
			slot0.taskDataCtx.performanceTask = DormCharacterInteractBehaviour.MakeInteractTask(slot5, DormCharacterInteractBehaviour.MakeCtx(uv0.player, uv0.brickItem, {
				waitOneTick = true
			}))

			slot0.taskDataCtx.performanceTask:Start(true)
		end
	end):WaitUntil(function (slot0)
		if slot0.taskDataCtx.performanceTask == nil or slot0.taskDataCtx.performanceTask:IsFinished() then
			slot0.taskDataCtx.performanceTask = nil
			uv0.gameTask = nil
			uv0.vfxLevel = 0

			return true
		end
	end)

	return slot1
end

function slot0.Start(slot0, slot1)
	if slot0.gameTask then
		slot0.gameTask:Abort()
	end

	slot0.vfxLevel = 0
	slot0.player = slot1
	slot2 = Dorm.DormEntityManager.Instance:SpawnEntity("Dorm/Dormitory/HZ05_huodong_piwa", nil, false, true)
	slot0.brickItem = slot2
	slot4 = Dorm.DormEntityManager.QueryForwardDir(slot1)

	Dorm.DormEntityManager.PutEntityLookToDir(slot2, Dorm.DormEntityManager.QueryPosition(slot1) + slot4 * 0.2, -slot4)
	Dorm.DormEntityManager.SendInteractToEntityCMD(slot1, slot2, false)

	slot5 = uv0(slot0)

	slot5:SetOnComplete(function ()
		Dorm.DormEntityManager.ClearAllEffect(uv0, uv1)
		uv2(uv3)
	end)
	slot5:SetOnAbort(function ()
		Dorm.DormEntityManager.ClearAllEffect(uv0, uv1)

		if Dorm.DormEntityManager.IsValidEntityID(uv0) and not uv2:IsCancelled() then
			Dorm.DormEntityManager.StopAllCmd(uv0)
		end

		uv3(uv4)

		if uv2.taskDataCtx.performanceTask then
			slot0.performanceTask:Abort()

			slot0.performanceTask = nil
		end
	end)

	slot0.gameTask = slot5

	DormUtils.SetEntityInteractContext(slot1, DormCharacterInteractBehaviour.MakeCtx(slot1, slot2, {
		curActionTask = slot5
	}))
end

slot6 = {
	"Dorm/Effect/houzhai/fx_pizhuan_xuli01",
	"Dorm/Effect/houzhai/fx_pizhuan_xuli02",
	"Dorm/Effect/houzhai/fx_pizhuan_xuli03",
	"Dorm/Effect/houzhai/fx_pizhuan_xuli04",
	"Dorm/Effect/houzhai/fx_pizhuan_xuli05"
}
slot0.QTE_LEVEL_RESET = 0

function slot0.OnQte(slot0, slot1)
	if slot1 == nil then
		return
	end

	if slot1 == uv0.QTE_LEVEL_RESET then
		slot0.level = 0

		Dorm.DormEntityManager.ClearAllEffect(slot0.player, uv1)
	elseif slot0.vfxLevel < slot1 then
		slot0.level = slot1

		Dorm.DormEntityManager.ClearAllEffect(slot0.player, uv1)

		if uv2[slot1] then
			Dorm.DormEntityManager.PlayEffect(slot0.player, "root", uv1, slot2, -1)
		end
	end
end

function slot0.Abort(slot0)
	if slot0.gameTask then
		slot0.vfxLevel = 0

		slot0.gameTask:Abort()

		slot0.gameTask = nil
	end
end

return slot0
