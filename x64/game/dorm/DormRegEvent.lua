slot0 = false

function Dorm.Enter()
	uv0 = true
end

function Dorm.Leave()
	uv0 = false
end

function Dorm.InvokeEvent(slot0, ...)
	if uv0 then
		manager.notify:Invoke(slot0, ...)
	end
end

function Dorm.InvokeEntityEvent(slot0, slot1, ...)
	if uv0 then
		manager.notify:Invoke(slot0, slot1, ...)
	end
end

function Dorm.RecordItemTagData(slot0, slot1, slot2)
	slot3 = Dorm.sceneItemInfo[slot0] or {}
	slot3[slot1] = slot2
	Dorm.sceneItemInfo[slot0] = slot3
end

slot1 = {}

function slot2(slot0, slot1)
	table.insert(uv0, {
		slot0,
		slot1
	})
end

function DormRegisterCMDEvent()
	for slot3, slot4 in ipairs(uv0) do
		slot5, slot6, slot7 = unpack(slot4)

		if not slot7 then
			manager.notify:RegistListener(slot5, slot6)

			slot4[3] = true
		end
	end
end

function DormEventInvoke(slot0, slot1, slot2, ...)
	manager.notify:Invoke(slot0, slot2, ...)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityCurrentAction, slot2, slot1)
end

slot2(DORM_CHARACTER_MOVE, function (slot0, slot1, slot2, slot3)
	Dorm.DormEntityManager.SendMoveCMD(slot0, slot1, slot2, slot3)
end)
slot2(DORM_CHARACTER_MOVE_LOOK_AT, function (slot0, slot1, slot2, slot3, slot4)
	Dorm.DormEntityManager.SendMoveLookAtCMD(slot0, slot1, slot2 or slot1, slot3, slot4)
end)
slot2(DORM_CHARACTER_MOVE_LOOK_TO_DIR, function (slot0, slot1, slot2, slot3, slot4)
	Dorm.DormEntityManager.SendMoveLookToDirCMD(slot0, slot1, slot2 or slot1, slot3, slot4)
end)
slot2(DORM_CHARACTER_MOVE_WANDER, function (slot0, slot1, slot2)
	Dorm.DormEntityManager.SendRndWanderMoveCMD(slot0, slot1, slot2)
end)
slot2(DORM_CHARACTER_INTERACT, function (slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = true
	end

	Dorm.DormEntityManager.SendInteractToEntityCMD(slot0, slot1, slot2)
end)
