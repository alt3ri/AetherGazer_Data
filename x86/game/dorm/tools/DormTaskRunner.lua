slot0 = class("DormTaskRunner")

function slot0.Ctor(slot0)
	slot0.timers = {}
end

function slot0.Init(slot0)
	slot0.taskListAdd = {}
	slot0.taskList = {}
	slot0.lastUpdate = nil
	slot0.now = 0
end

function slot0.Reset(slot0)
	for slot4, slot5 in ipairs(slot0.taskList) do
		slot5:Abort()
	end

	for slot4, slot5 in ipairs(slot0.taskListAdd) do
		slot5:Abort()
	end

	slot0.taskListAdd = nil
	slot0.taskList = nil

	for slot4, slot5 in pairs(slot0.timers) do
		slot5:Stop()
	end

	slot0.timers = {}
end

function slot0.DoTask(slot0, slot1)
	if slot1:IsCancelled() then
		slot1:Abort()
	end

	while slot1.progress >= 1 and slot1.progress <= #slot1.taskList do
		slot3, slot4, slot5 = unpack(slot1.taskList[slot1.progress])
		slot6 = nil

		if slot3(slot5) then
			if slot1.progress ~= -1 then
				slot1.progress = slot1.progress + 1
			end

			if slot4 then
				return false
			end
		else
			return false
		end
	end

	if not slot1:IsAborted() and slot1.onComplete then
		slot1.onComplete()
	end

	return true
end

function slot0.TickUpdate(slot0)
	if slot0.pause then
		return
	end

	for slot4, slot5 in ipairs(slot0.taskListAdd) do
		table.insert(slot0.taskList, slot5)

		slot0.taskListAdd[slot4] = nil
	end

	slot0.now = slot0:Time()
	slot0.lastUpdate = slot0.lastUpdate or slot0.now

	for slot5, slot6 in ipairs(slot0.taskList) do
		if not slot0:DoTask(slot6) then
			table.insert({}, slot6)

			slot0.taskList[slot5] = nil
		end
	end

	slot1 = slot0.taskList
	slot0.taskList = slot1
	slot0.lastUpdate = slot0.now
end

function slot0.RegisterTask(slot0, slot1)
	table.insert(slot0.taskListAdd, slot1)
end

function slot0.NewTask(slot0, slot1)
	slot2 = DormTask.New(slot1)

	slot2:SetRunner(slot0)

	return slot2
end

function slot0.NewTimer(slot0, ...)
	slot1 = Timer.New(...)

	table.insert(slot0.timers, slot1)

	return slot1
end

function slot0.DeltaTime(slot0)
	if slot0.lastUpdate then
		return slot0:Now() - slot0.lastUpdate
	end

	return 0
end

function slot0.Now(slot0)
	return slot0.now
end

function slot0.Time(slot0)
	return Time.time
end

return slot0
