slot1 = class("NewChessEventQueue", require("game/chess/ChessEventQueue"))

function slot1.InsertNewEventQueue(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetCurTiming()
	slot5 = {
		eventP = 1,
		gridData = slot3,
		timing = slot2,
		list = {}
	}

	for slot9, slot10 in ipairs(slot1) do
		if not NewChessEventConfig[slot10.eventID] then
			-- Nothing
		end

		slot5.list[#slot5.list + 1] = {
			eventID = slot10.eventID,
			func = NewChessEventConfig[slot10.eventID][slot2] or NewChessEventConfig[slot10.eventID][NewChessConst.TIMING_ALL],
			params = slot10.params
		}
	end

	table.insert(slot0.eventQueue_, slot5)

	return #slot1
end

function slot1.InsertCurEventQueue(slot0, slot1)
	slot2 = slot0.eventQueue_[slot0.eventQueueP_]

	for slot8 = #slot2.list, slot2.eventP, -1 do
		slot3[slot8 + #slot1] = slot3[slot8]
	end

	slot6 = 1

	for slot10 = slot4, slot4 + #slot1 - 1 do
		slot11 = slot1[slot6]
		slot3[slot10] = {
			eventID = slot11.eventID,
			func = NewChessEventConfig[slot11.eventID][slot2.timing] or NewChessEventConfig[slot11.eventID][NewChessConst.TIMING_ALL],
			params = slot11.params
		}
		slot6 = slot6 + 1
	end
end

function slot1.IsEmpty(slot0)
	if next(slot0.eventQueue_) == nil and slot0.eventQueueP_ == 0 then
		return true
	else
		return false
	end
end

return slot1
