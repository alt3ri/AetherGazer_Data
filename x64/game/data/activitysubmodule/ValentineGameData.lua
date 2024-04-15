slot0 = singletonClass("ValentineGameData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.InitData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {
			id = slot2,
			isOpen = slot1.clear_state == 0
		}
	end

	uv0[slot2].isClear = slot1.clear_state ~= 0
	uv0[slot2].isReward = slot1.reward_state ~= 0
	uv0[slot2].point = slot1.point or 0
	uv0[slot2].answerQuestionID = cleanProtoTable(slot1.qa_list)
	uv0[slot2].selectQuestionID = cleanProtoTable(slot1.choose_list)
end

function slot0.GetData(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetNotNewOpen(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].isOpen = false

		ValentineGameAction:RefreshRedPoint(slot1)
	end
end

function slot0.SetClear(slot0, slot1, slot2, slot3)
	if uv0[slot1] then
		uv0[slot1].isClear = true

		if slot2 and not table.indexof(uv0[slot1].selectQuestionID, slot2) then
			table.insert(uv0[slot1].selectQuestionID, slot2)
		end

		if slot3 and not table.indexof(uv0[slot1].answerQuestionID, slot3) then
			table.insert(uv0[slot1].answerQuestionID, slot3)
		end

		ValentineGameAction:RefreshRedPoint(slot1)
	end
end

function slot0.SetReward(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].isReward = true

		ValentineGameAction:RefreshRedPoint(slot1)
	end
end

function slot0.SetPoint(slot0, slot1, slot2)
	uv0[slot1].point = slot2

	slot0:SetClear(slot1)
end

function slot0.SetLastLevel(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetLastLevel(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.SaveLastSelect(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.ClearReadedQID(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].answerQuestionID = {}
	end
end

slot3 = 0

function slot0.CacheChooseQID(slot0, slot1)
	uv0 = slot1
end

slot4 = 0

function slot0.CacheRandomQID(slot0, slot1)
	uv0 = slot1
end

function slot0.GetQID(slot0)
	return uv0, uv1
end

return slot0
