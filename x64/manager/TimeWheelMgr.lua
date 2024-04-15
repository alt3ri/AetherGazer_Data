slot0 = singletonClass("TimeWheelMgr")

function slot0.Ctor(slot0, slot1)
	slot0.tickInterval_ = slot1 or 1
	slot0.timeWheel_ = {}

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(handler(slot0, slot0.Update), 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.AddTask(slot0, slot1, slot2, slot3)
	slot4 = {
		func = slot1,
		next_tick = slot2,
		interval = slot3 or slot0.tickInterval_
	}

	table.insert(slot0.timeWheel_, slot4)

	return slot4
end

function slot0.RemoveTask(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.timeWheel_) do
		if slot6 == slot1 then
			table.remove(slot0.timeWheel_, slot5)

			break
		end
	end
end

function slot0.Update(slot0)
	if not manager.time:GetServerTime() then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot0.timeWheel_) do
		if slot7.next_tick <= slot1 then
			table.insert(slot2, slot7)

			slot7.next_tick = slot1 + slot7.interval
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		slot7.func()
	end
end

function slot0.Dispose(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
