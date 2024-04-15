slot0 = singletonClass("ColorPuzzleData")

function slot0.Init(slot0)
	slot0.levelClear = {}
	slot0.clearedLevelCnt = 0
end

function slot0.SetFinishedLevels(slot0, slot1)
	slot0.levelClear = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.levelClear[slot6] = true
	end

	slot0.clearedLevelCnt = #slot1
end

function slot0.GetClearedLevelCount(slot0)
	return slot0.clearedLevelCnt
end

function slot0.IsLevelCleared(slot0, slot1)
	return slot0.levelClear[slot1] ~= nil
end

function slot0.IsLevelUnlocked(slot0, slot1)
	slot4 = nil

	if ActivityHeroChallengeColor[slot1].pre_stage ~= 0 and not slot0:IsLevelCleared(slot3) then
		return false, "ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK"
	end

	return true
end

function slot0.IsLevelCanNotChallenge(slot0, slot1)
	if slot0:IsLevelCleared(slot1) then
		return false
	end

	slot2 = nil
	slot4, slot5 = SPHeroChallengeData:GetCurActivityInfo():GetStartBattelScheduleByType(SpHeroChallengeConst.ScheduleSubType.decode)

	if slot4 <= slot5 then
		return true, GetTips("ACTIVITY_HERO_CHALLENGE_TIME_NULL")
	end
end

function slot0.GetLevelClearTime(slot0, slot1)
	return getData("colorPuzzleLevel", tostring(slot1))
end

function slot0.UpdateLevelClearTime(slot0, slot1, slot2, slot3)
	slot4 = true

	if not slot3 then
		slot4 = slot2 < (slot0:GetLevelClearTime(slot1) or math.huge)
	end

	if slot4 then
		saveData("colorPuzzleLevel", tostring(slot1), slot2)
	end
end

function slot0.GetNextStage(slot0)
	if not next(slot0.levelClear) then
		return ActivityHeroChallengeColor.all[1]
	end

	for slot5, slot6 in pairs(slot0.levelClear) do
		slot1 = math.max(slot1, slot5)
	end

	slot2 = ActivityHeroChallengeColor.all[#ActivityHeroChallengeColor.all]

	for slot6, slot7 in ipairs(ActivityHeroChallengeColor.all) do
		if ActivityHeroChallengeColor[slot7].pre_stage == slot1 then
			slot2 = slot7

			break
		end
	end

	return slot2
end

function slot0.GetNextStageName(slot0)
	if ActivityHeroChallengeColor.all[#slot0.levelClear + 1] then
		return ActivityHeroChallengeColor[slot2].name
	end
end

return slot0
