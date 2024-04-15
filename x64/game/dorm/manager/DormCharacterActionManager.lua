slot0 = singletonClass("DormCharacterActionManager")

function slot0.Ctor(slot0)
	slot0.listener = EventListener.New()
	slot1 = class("SyncUpdateDormTaskRunner", DormTaskRunner)

	function slot1.Time(slot0)
		return uv0.now
	end

	slot0.taskRunner = slot1.New()
	slot0.frameTaskRunner = slot1.New()
end

function slot0.Init(slot0)
	slot0.animationEventHandlers = {}
	slot0.schedule = {}

	slot0:RegisterTaskRunner(slot0.taskRunner, 15, 7)
	slot0:RegisterTaskRunner(slot0.frameTaskRunner, 2)

	slot0.tickCount = 0
	slot0.now = Time.time
	slot0.tick = Timer.New(function ()
		uv0.now = Time.time
		uv0.tickCount = uv0.tickCount + 1

		if uv0.tickCount % 2 == 0 then
			manager.notify:Invoke(DORM_FRAME_TICK, slot0)
		end

		if uv0.tickCount % 15 == 7 then
			manager.notify:Invoke(DORM_LOGIC_TICK, slot0)
		end

		for slot4, slot5 in pairs(uv0.schedule) do
			if uv0.tickCount % slot5.interval == slot5.offset then
				slot4:TickUpdate()
			end
		end
	end, 0.016666666666666666, -1)

	slot0.tick:Start()
	slot0.listener:Register(ON_DORM_ENTITY_ANIME_EVENT, handler(slot0, slot0.HandleAnimationLoop))
end

function slot0.RegisterTaskRunner(slot0, slot1, slot2, slot3)
	slot1:Init()

	slot0.schedule[slot1] = {
		interval = slot2,
		offset = (slot3 or 0) % slot2
	}

	return slot1
end

function slot0.Reset(slot0)
	slot0.listener:RemoveAll()

	if slot0.tick then
		slot0.tick:Stop()
	end

	slot0.taskRunner:Reset()
	slot0.frameTaskRunner:Reset()

	slot0.schedule = {}
end

function slot0.HandleAnimationLoop(slot0, slot1, slot2, slot3)
	if slot0.animationEventHandlers then
		slot0.inAnimationHandleLoop = true
		slot4 = {}

		for slot8, slot9 in ipairs(slot0.animationEventHandlers) do
			if not slot9(slot1, slot2, slot3) then
				table.insert(slot4, slot9)
			end
		end

		slot0.animationEventHandlers = slot4
		slot0.inAnimationHandleLoop = false
	end
end

function slot0.RegisterAnimeEvent(slot0, slot1)
	table.insert(slot0.animationEventHandlers, slot1)
end

function slot0.FrameTaskDeltaTime(slot0)
	return slot0.frameTaskRunner:DeltaTime()
end

function slot0.LogicTaskDeltaTime(slot0)
	return slot0.taskRunner:DeltaTime()
end

return slot0.GetInstance()
