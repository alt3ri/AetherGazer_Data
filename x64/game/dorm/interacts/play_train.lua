slot0 = {}
slot1 = "CharDorm/prop/huochetou"
slot2 = "CharDorm/prop/huochexiang"

function slot3(slot0)
	slot5 = slot0[1]

	table.insert({}, slot5)

	for slot5 = #slot0, 2, -1 do
		table.insert(slot1, slot0[slot5])
	end

	return slot1
end

function slot4(slot0)
	return nullable(DormUtils.GetEntityData(slot0), "rail")
end

slot5 = 1.55
slot6 = 4
slot7 = "train_head"
slot8 = 1.5
slot9 = "train_head_stand"
slot10 = 1.3

return function (slot0)
	slot1 = math.random() > 0.5
	slot2 = slot0.entityID

	if uv0(slot0.targetID) and not slot4:HasTrainStarted() then
		slot5 = slot4.path
		slot6 = Dorm.DormEntityManager.QueryPosition(slot2)
		slot8 = slot4:GenerateTrain(uv1)[1]

		Dorm.DormEntityManager.KeepAsInteractNotEnd(slot2, slot8, true)
		Dorm.DormEntityManager.AttachToEntityCMD(slot2, slot8, "gua_start")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(slot2, uv2)

		slot12 = slot4

		for slot12 = 2, slot4.GetTrainCartNum(slot12) do
			DormLuaBridge.SetupFurnitureTileEntity(slot4:GetTrainEID(slot12))
		end

		slot9 = slot4:FindClosestPointOnRail(slot6)
		slot10 = DormCharacterActionManager.taskRunner:NewTask()

		slot10:Then(function (slot0)
			for slot4, slot5 in ipairs(uv0) do
				Dorm.DormEntityManager.SendPatrolCMD(slot5, uv4, uv3, uv1 - (slot4 - 1) * uv2 * (uv3 and -1 or 1), false)
				Dorm.DormEntityManager.SetEntitySpeed(slot5, 0)
			end

			manager.audio:PlayEffect("ui_dorm", "ui_dorm_train")
		end):WaitForSec(uv4):Then(function ()
			for slot3, slot4 in ipairs(uv0) do
				Dorm.DormEntityManager.SetEntitySpeed(slot4, uv1)
			end

			Dorm.DormEntityManager.PlayAnimeDuringInteract(uv2, uv3)
		end):WaitUntil(function ()
			return false
		end)
		slot10:SetOnAbort(function ()
			slot3 = uv1
			slot4 = false

			Dorm.DormEntityManager.KeepAsInteractNotEnd(uv0, slot3, slot4)

			for slot3, slot4 in ipairs(uv2) do
				if slot4 ~= uv1 then
					for slot8, slot9 in DormUtils.EnumerateInteractEntities(slot4) do
						Dorm.DormEntityManager.StopAllCmd(slot9)
						DormLuaBridge.TryGrabPlayerOutOfStuck(slot9)
					end
				end
			end

			uv3:ClearTrain()
		end)

		return slot10
	else
		DormLuaBridge.TryGrabPlayerOutOfStuck(slot2, true)
	end
end
