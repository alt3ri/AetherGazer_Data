slot0 = singletonClass("SnowballGameTargetAI")
slot1 = {
	stop = 0,
	l = -1,
	r = 1
}

function slot0.Ctor(slot0)
	pauseNonHumanoid = false
	pause = false
end

function slot2(slot0)
	return SnowballGameUnitCfg[slot0].stop_time
end

function slot3(slot0)
	return SnowballGameUnitCfg[slot0].move_time
end

slot4 = Dorm.DormEntityManager.QueryPosition
slot5 = Dorm.DormEntityManager.QuerySpeed

function slot0.AddEntityToRow(slot0, slot1, slot2)
	slot0:Remove(slot1)

	slot3 = DormUtils.GetEntityData(slot1)
	slot4 = slot3.cfgID

	table.insert(slot0.row[slot2], {
		move = false,
		eid = slot1,
		dir = uv0.stop,
		isHumanoidTarget = slot3.isHumanoidTarget,
		unitType = slot4,
		timer = uv1(slot4)
	})
	table.sort(slot0.row[slot2], function (slot0, slot1)
		return uv0(slot0.eid).x < uv0(slot1.eid).x
	end)
end

function slot0.Remove(slot0, slot1)
	for slot5, slot6 in pairs(slot0.row) do
		for slot10, slot11 in ipairs(slot6) do
			if slot11.eid == slot1 then
				table.remove(slot6, slot10)

				break
			end
		end
	end
end

function slot6(slot0)
	return Dorm.storage:PickData(string.format("snowball.row%d.lbound", slot0)).transform, Dorm.storage:PickData(string.format("snowball.row%d.rbound", slot0)).transform
end

function slot7(slot0)
	return slot0 < 0
end

function slot8(slot0)
	return slot0 > 0
end

function slot9(slot0, slot1)
	return Vector3.Distance(Vector3(slot0.x, 0, slot0.z), Vector3(slot1.x, 0, slot1.z)) <= 1
end

function slot10(slot0, slot1, slot2, slot3)
	slot9 = slot3.move and slot3.dir * uv1(slot1) or 0

	if uv0(slot1).x < uv0(slot0).x then
		slot7 = slot6
		slot6 = slot7
		slot9 = slot2.move and slot2.dir * uv1(slot0) or 0
		slot8 = slot9
	end

	return uv2(slot6, slot7) and slot9 < slot8
end

function slot11(slot0, slot1, slot2)
	if uv0(slot0) then
		if slot2 then
			return uv1.r
		else
			return uv1.stop
		end
	elseif uv2(slot0) then
		if slot1 then
			return uv1.l
		else
			return uv1.stop
		end
	end

	return slot0
end

function slot12(slot0, slot1, slot2, slot3, slot4)
	slot5 = true
	slot6 = true
	slot8 = uv0(slot1.eid)
	slot9 = slot1.dir

	if slot1.dir == uv1.stop then
		slot1.dir = math.random() < 0.5 and uv1.l or uv1.r
	end

	if uv2(slot8, slot3.position) then
		slot5 = false
		slot1.dir = uv1.r
	elseif uv2(slot8, slot4.position) then
		slot6 = false
		slot1.dir = uv1.l
	end

	slot11 = slot2[slot0 + 1]
	slot12 = false

	if slot2[slot0 - 1] and uv3(slot1.dir) and uv4(slot7, slot10.eid, slot1, slot10) then
		slot5 = false
		slot12 = true
	end

	if slot11 and uv5(slot1.dir) and uv4(slot7, slot11.eid, slot1, slot11) then
		slot6 = false
		slot12 = true
	end

	if slot12 then
		slot1.dir = uv6(slot1.dir, slot5, slot6)
	end

	slot1.dirChanged = slot9 ~= slot1.dir
end

function slot13(slot0)
	if uv0(slot0) then
		return "snowball_target_move_L"
	elseif uv1(slot0) then
		return "snowball_target_move_R"
	end
end

function slot14(slot0, slot1)
	Dorm.LuaBridge.MiniGameBridge.SetMoveControllerInput(slot0.eid, Vector2(slot0.dir, 0))

	if slot0.dirChanged and slot0.dir ~= uv0.stop then
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(slot2, uv1(slot0.dir))
		Dorm.DormEntityManager.TryTriggerResetAnimeDuringMove(slot2)
	end
end

function slot15(slot0, slot1)
	slot2 = slot0.eid
	slot0.timer = slot0.timer - slot1
	slot3 = slot0.move

	if slot0.timer <= 0 then
		slot0.timer = slot3 and uv0(slot0.unitType) or uv1(slot0.unitType)
		slot0.move = not slot3
	end
end

function slot0.ShouldStop(slot0, slot1)
	return slot0.pause or not slot1.move or slot0.pauseNonHumanoid and not slot1.isHumanoidTarget
end

function slot0.Update(slot0)
	slot1 = DormCharacterActionManager.GetInstance():FrameTaskDeltaTime()

	for slot5, slot6 in pairs(slot0.row) do
		slot7, slot8 = uv0(slot5)

		for slot12, slot13 in ipairs(slot6) do
			slot14 = slot13.eid

			uv1(slot13, slot1)

			if slot0:ShouldStop(slot13) then
				slot13.dir = uv2.stop
			else
				uv3(slot12, slot13, slot6, slot7, slot8)
			end
		end

		for slot12, slot13 in pairs(slot6) do
			uv4(slot13, slot1)
		end
	end
end

function slot0.Clear(slot0)
	slot0.row = {
		{},
		{},
		{}
	}
end

function slot0.Init(slot0)
	slot0:Clear()
end

function slot0.Dispose(slot0)
	slot0.row = nil
end

return slot0
