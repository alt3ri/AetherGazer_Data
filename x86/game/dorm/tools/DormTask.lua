slot0 = class("DormTaskRunner.Task")

function slot0.Ctor(slot0, slot1)
	slot0.progress = 0
	slot0.taskList = {}
	slot0.taskDataCtx = slot1 or {}
	slot0.taskDataCtx.task = slot0
end

function slot0.Then(slot0, slot1, slot2)
	slot2 = slot2 or {}
	slot2.taskDataCtx = slot0.taskDataCtx

	table.insert(slot0.taskList, {
		function (slot0)
			if uv0 then
				uv0(slot0)
			end

			return true, slot0
		end,
		true,
		slot2
	})

	return slot0
end

function slot0.WaitUntil(slot0, slot1, slot2, slot3)
	slot3 = slot3 or {}
	slot3.taskDataCtx = slot0.taskDataCtx

	table.insert(slot0.taskList, {
		slot1,
		slot2,
		slot3
	})

	return slot0
end

function slot1(slot0)
	if not slot0.timer.running then
		slot1:Start()
	end

	return slot1.timeout
end

function slot2()
	return true
end

function slot0.WaitForSec(slot0, slot1, slot2)
	if slot1 == 0 then
		return slot0:WaitUntil(uv0, slot2)
	end

	return slot0:WaitUntil(uv1, slot2, {
		timer = slot0.taskRunner:NewTimer(nil, slot1, false, false)
	})
end

function slot0.WaitTask(slot0, ...)
	slot1 = {
		...
	}

	return slot0:WaitUntil(function ()
		for slot3, slot4 in ipairs(uv0) do
			if not slot4:IsFinished() then
				return false
			end
		end

		return true
	end)
end

function slot0.HandleAnimeLoop(slot0, slot1)
	slot2 = {
		continue = false,
		started = false
	}

	DormCharacterActionManager:RegisterAnimeEvent(function (slot0, slot1, ...)
		if uv0.started and uv1(slot0, slot1, ...) then
			uv0.continue = true

			return true
		end
	end)

	if #slot0.taskList >= 1 then
		slot0.taskList[#slot0.taskList][2] = false
	end

	return slot0:WaitUntil(function (slot0)
		if not slot0.started then
			slot0.started = true
		end

		return slot0.continue
	end, false, slot2)
end

function slot0.Start(slot0, slot1)
	slot0.progress = 1

	if not slot1 then
		slot0.taskRunner:DoTask(slot0)
	end

	slot0.taskRunner:RegisterTask(slot0)
end

function slot0.SetRunner(slot0, slot1)
	slot0.taskRunner = slot1
end

function slot0.Abort(slot0)
	if slot0.progress ~= -1 and not slot0:IsFinished() then
		slot0.progress = -1

		if slot0.onAbort then
			slot0:onAbort()
		end
	end
end

function slot0.IsCancelled(slot0)
	if slot0.cancellationSrc then
		return slot0.cancellationSrc()
	end
end

function slot0.IsStarted(slot0)
	return slot0.progress ~= 0
end

function slot0.IsFinished(slot0)
	return slot0.progress > #slot0.taskList
end

function slot0.IsAborted(slot0)
	return slot0.progress == -1
end

function slot0.SetCancellationSrc(slot0, slot1)
	slot0.cancellationSrc = slot1

	return slot0
end

function slot0.SetOnAbort(slot0, slot1)
	slot0.onAbort = slot1

	return slot0
end

function slot0.SetOnComplete(slot0, slot1)
	slot0.onComplete = slot1

	return slot0
end

return slot0
