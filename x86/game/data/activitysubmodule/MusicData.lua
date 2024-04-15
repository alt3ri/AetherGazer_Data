slot0 = singletonClass("MusicData")
slot1 = {}
slot2 = 0
slot3 = 0
slot4 = {}
slot5 = 0
slot6 = 0
slot7, slot8, slot9, slot10, slot11, slot12, slot13 = nil
slot14 = false
slot15 = nil
slot16 = {}
slot17 = {}
slot18 = {}
slot19 = false
slot20 = 0

function slot0.Init(slot0)
	uv0 = {}
	uv1 = 0
	uv2 = 0
	uv3 = {}
	uv4 = 0
	uv5 = 0
	uv6 = nil
	uv7 = nil
	uv8 = nil
	uv9 = nil
	uv10 = nil
	uv11 = nil
	uv12 = {}
	uv13 = {}
	uv14 = {}
	uv15 = 0
end

function slot0.InitMusicData(slot0, slot1)
	slot2 = slot1.activity_id

	for slot8, slot9 in ipairs(slot1.challenge_info) do
		-- Nothing
	end

	uv0[slot2] = {
		[slot9.difficulty] = {
			score = slot9.score,
			reward_state = slot9.reward_state,
			sign = slot9.sign
		}
	}
end

function slot0.CheckIsHaveNewMusicData(slot0, slot1)
	if uv0[slot1.activity_id] then
		return false
	end

	slot3 = true

	for slot7, slot8 in ipairs(slot1.challenge_info) do
		if slot8.sign == 1 then
			slot3 = false
		end
	end

	return slot3
end

function slot0.SetRewardState(slot0, slot1, slot2)
	if uv0[slot1] and uv0[slot1][slot2] then
		uv0[slot1][slot2].reward_state = 1
	end
end

function slot0.GetScore(slot0, slot1, slot2)
	if slot2 == 3 then
		slot2 = 9
	end

	if uv0[slot1] and uv0[slot1][slot2] then
		return uv0[slot1][slot2].score
	end

	return 0
end

function slot0.GetIsComplete(slot0, slot1, slot2)
	if slot2 == 3 then
		slot2 = 9
	end

	if uv0[slot1] and uv0[slot1][slot2] then
		return uv0[slot1][slot2].sign
	end

	return 0
end

function slot0.SetScore(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		uv0[slot1] = {}
	end

	if not uv0[slot1][slot2] then
		uv0[slot1][slot2] = {
			sign = 1,
			reward_state = 0,
			score = slot3
		}
	end

	if uv0[slot1] and uv0[slot1][slot2] then
		uv0[slot1][slot2].score = slot3
		uv0[slot1][slot2].sign = 1
	end
end

function slot0.GetRewardState(slot0, slot1)
	slot2 = ActivityMusicCfg[slot1]
	slot5 = uv0[slot2.activity_id] and uv0[slot3][slot2.difficult]
	slot6 = slot5 and slot5.reward_state or 0

	if slot2.reward and #slot2.reward == 0 then
		return 0
	end

	if slot6 == 1 then
		return 2
	elseif slot2.target == 0 then
		for slot10, slot11 in pairs(uv0[slot3] or {}) do
			if slot11.sign == 1 then
				return 1
			end
		end
	else
		for slot12, slot13 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[slot3]) do
			if slot4 <= ActivityMusicCfg[slot13].difficult and slot0:GetTargetAccuracy(slot2.target) <= slot0:GetScore(slot3, slot14.difficult) / slot14.total_score * 100 then
				return 1
			end
		end
	end

	return 0
end

function slot0.GetTargetAccuracy(slot0, slot1)
	return GameSetting.attach_music_grade.value[slot1] or 0
end

function slot0.GetTargetAccuracyDes(slot0, slot1)
	return ({
		"S+",
		"S",
		"A",
		"B",
		"C",
		"F"
	})[slot1] or ""
end

function slot0.ResetGameData(slot0)
	uv0 = 0
	uv1 = {}
	uv2 = 0
	uv3 = 0
end

function slot0.ModifGameData(slot0, slot1)
	if MusicConst.MusicNodeHitRating.PerfectPlus == slot1 then
		uv0 = uv0 + 101
		uv1 = uv1 + 1
	elseif MusicConst.MusicNodeHitRating.Perfect == slot1 then
		uv0 = uv0 + 100
		uv1 = uv1 + 1
	elseif MusicConst.MusicNodeHitRating.Good == slot1 then
		uv0 = uv0 + 70
		uv1 = uv1 + 1
	else
		uv1 = 0
	end

	if uv2 < uv1 then
		uv2 = uv1
	end

	uv3[slot1] = uv3[slot1] and uv3[slot1] + 1 or 1
end

function slot0.GetGameScore(slot0)
	return uv0
end

function slot0.SetLookBackState(slot0, slot1)
	uv0 = slot1
end

function slot0.GetLookBackState(slot0)
	return uv0
end

function slot0.SetGameId(slot0, slot1)
	uv0 = slot1
end

function slot0.GetGameId(slot0)
	return uv0
end

function slot0.GetGameRecord(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.GetComboHit(slot0)
	return uv0
end

function slot0.GetMaxComboHit(slot0)
	return uv0
end

function slot0.SetPageActivityId(slot0, slot1)
	uv0 = slot1
end

function slot0.GetSpeedValue(slot0, slot1)
	if slot1 then
		if not uv0 then
			uv0 = getData("Music", "VerticalSpeed")
		end

		if type(uv0) ~= "number" then
			uv0 = 3
		else
			uv0 = math.max(uv0, 1)
			uv0 = math.min(uv0, 5)
		end

		return uv0
	else
		if not uv1 then
			uv1 = getData("Music", "Speed")
		end

		if type(uv1) ~= "number" then
			uv1 = 3
		else
			uv1 = math.max(uv1, 1)
			uv1 = math.min(uv1, 5)
		end

		return uv1
	end
end

function slot0.SetSpeedValue(slot0, slot1, slot2)
	if slot2 then
		saveData("Music", "VerticalSpeed", slot1)

		uv0 = slot1
	else
		saveData("Music", "Speed", slot1)

		uv1 = slot1
	end
end

function slot0.GetSpeedData(slot0, slot1)
	slot5 = 350

	return slot5 + (5 - slot0:GetSpeedValue(slot1)) * (1500 - slot5) / 4
end

function slot0.GetJudgeValue(slot0)
	if not uv0 then
		uv0 = getData("Music", "Judge")
	end

	if type(uv0) ~= "number" then
		uv0 = 0
	else
		uv0 = math.max(uv0, -50)
		uv0 = math.min(uv0, 50)
	end

	return uv0
end

function slot0.SetJudgeValue(slot0, slot1)
	uv0 = slot1

	saveData("Music", "Judge", slot1)
end

function slot0.GetJudgeData(slot0)
	slot1 = slot0:GetJudgeValue()
	slot2 = math.abs(slot1) / 50 * 300

	if slot1 < 0 then
		return -1 * slot2
	end

	return slot2
end

function slot0.GetScreanValue(slot0)
	if not uv0 then
		uv0 = getData("Music", "Screan")
	end

	if type(uv0) ~= "number" then
		uv0 = 0
	else
		uv0 = math.max(uv0, -50)
		uv0 = math.min(uv0, 50)
	end

	return uv0
end

function slot0.SetScreanValue(slot0, slot1)
	uv0 = slot1

	saveData("Music", "Screan", uv0)
end

function slot0.GetScreanData(slot0)
	slot1 = slot0:GetScreanValue()
	slot2 = math.abs(slot1) / 50 * 300

	if slot1 < 0 then
		return -1 * slot2
	end

	return slot2
end

function slot0.GetVolumeValue(slot0)
	if not uv0 then
		uv0 = getData("Music", "Volume")
	end

	if type(uv0) ~= "number" then
		uv0 = 50
	else
		uv0 = math.max(uv0, 0)
		uv0 = math.min(uv0, 100)
	end

	return uv0
end

function slot0.SetVolumeValue(slot0, slot1)
	uv0 = slot1

	saveData("Music", "Volume", uv0)
end

function slot0.GetVolumeData(slot0)
	return math.abs(slot0:GetVolumeValue()) / 100
end

function slot0.GetShowMovie(slot0)
	if not uv0 then
		uv0 = getData("Music", "ShowMovie")
	end

	if type(uv0) ~= "number" then
		uv0 = 1
	end

	return uv0 ~= 0
end

function slot0.SetShoMovie(slot0, slot1)
	uv0 = slot1 and 1 or 0

	saveData("Music", "ShowMovie", uv0)
end

function slot0.GetVerical(slot0)
	if not uv0 then
		uv0 = getData("Music", "isVertical")
	end

	if type(uv0) ~= "number" then
		uv0 = 0
	end

	return uv0 ~= 0
end

function slot0.SetVerical(slot0, slot1)
	uv0 = slot1 and 1 or 0

	saveData("Music", "isVertical", uv0)
end

function slot0.GetSpectralType(slot0)
	if not uv0 then
		uv0 = getData("Music", "SpectralType")
	end

	if type(uv0) ~= "number" then
		uv0 = 0
	end

	return uv0
end

function slot0.SetSpectralType(slot0, slot1)
	uv0 = slot1

	saveData("Music", "SpectralType", uv0)
end

function slot0.GetSpectralAndVercialSDKKey(slot0)
	slot1 = "[" .. slot0:GetSpectralType() + 1 .. ","

	return (slot0:GetVerical() and slot1 .. 1 or slot1 .. 2) .. "]"
end

function slot0.GetSpectralSendData(slot0)
	table.insert({}, slot0:GetSpectralType() + 1)

	if slot0:GetVerical() then
		table.insert(slot1, 1)
	else
		table.insert(slot1, 2)
	end

	return slot1
end

function slot0.GetPlayKeyEffectSound(slot0)
	if not uv0 then
		uv0 = getData("Music", "PlayKeyEffectSound")
	end

	if type(uv0) ~= "number" then
		uv0 = 1
	end

	return uv0 ~= 0
end

function slot0.SetPlayKeyEffectSound(slot0, slot1)
	uv0 = slot1 and 1 or 0

	saveData("Music", "PlayKeyEffectSound", uv0)
end

function slot0.GetDifficultyIndex(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = getData("MusicSelectDiffcult", tostring(slot1))
	end

	if type(uv0[slot1]) ~= "number" then
		uv0[slot1] = 0
	end

	return uv0[slot1]
end

function slot0.SetDifficultIndex(slot0, slot1, slot2)
	uv0[slot1] = slot2

	saveData("MusicSelectDiffcult", tostring(slot1), slot2)
end

function slot0.GetRead(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.SetRead(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.SetSelectIndex(slot0, slot1)
	uv0[slot0] = slot1

	saveData("MusicSelect", tostring(slot0), slot1)
end

function slot0.GetSelectIndex(slot0)
	if not uv0[slot0] then
		uv0[slot0] = getData("MusicSelect", tostring(slot0))
	end

	if type(uv0[slot0]) ~= "number" then
		uv0[slot0] = 1
	end

	return uv0[slot0]
end

function slot0.GetAisacSet(slot0, slot1)
	slot2 = {}

	if MusicRecordCfg[slot1] and slot3.initAISAC ~= "" then
		for slot7, slot8 in ipairs(slot3.initAISAC) do
			slot2[slot8[1]] = slot8[2]
		end
	end

	return slot2
end

function slot0.GetMusicViewPathList(slot0, slot1)
	return MusicConst.MusicViewRoutesName[slot0:GetMusicViewType(slot1)]
end

function slot0.GetMusicViewType(slot0, slot1)
	slot2 = nil

	if ((not slot0:GetLookBackState() or ActivityTools.GetActivityTheme(uv0)) and ActivityTools.GetActivityTheme(slot1)) == ActivityConst.THEME.ACTIVITY_2_0 then
		return MusicConst.MusicViewType.Enternal
	else
		return MusicConst.MusicViewType.V210
	end
end

return slot0
