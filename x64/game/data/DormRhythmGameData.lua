require("game.data.RhythmItemTemplate")

slot0 = singletonClass("DormRhythmGameData")
slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8 = nil

function slot9()
	uv0.judgeWidth = uv1.judgeWidth
	uv2.deterGo.transform.rect.width = uv0.judgeWidth
end

function slot10()
	for slot4, slot5 in ipairs(uv0[uv1.levelID].check_speed) do
		if uv2.deterGenNum < slot5[1] then
			uv2.gameSpeed = slot0.check_speed[slot4 - 1][2]

			return
		end
	end

	uv2.gameSpeed = slot0.check_speed[#slot0.check_speed][2]
end

function slot11()
	for slot4, slot5 in ipairs(uv0[uv1.levelID].check_hit_length) do
		if uv2.deterGenNum < slot5[1] then
			uv2.deterLength = slot0.check_hit_length[slot4 - 1][2]

			return
		end
	end

	uv2.deterLength = slot0.check_hit_length[#slot0.check_hit_length][2]
end

function slot12()
	for slot4, slot5 in ipairs(uv0[uv1.levelID].time_interval) do
		if uv2.deterGenNum < slot5[1] then
			uv2.interval = slot0.time_interval[slot4 - 1][2]

			return
		end
	end

	uv2.interval = slot0.time_interval[#slot0.time_interval][2]
end

function slot13()
	uv0()
	uv1()
	uv2()
end

function slot14()
	uv0 = {
		interval = 0,
		gameSpeed = 0,
		batterNum = 0,
		pauseFlag = false,
		gameRunFlag = false,
		deterGenNum = 0,
		judgeWidth = 0,
		mistakeNum = 0,
		maxBatterNum = 0,
		successfulNum = 0,
		deterLength = 0
	}
	uv1 = {}
	uv2 = 1

	uv3()
	uv4()
end

function slot15()
	if uv1[uv2.levelID].total_check <= uv0.deterGenNum then
		return
	end

	if uv3[uv4] and uv0.gameRunFlag then
		slot0 = uv3[uv4].trs

		if not isNil(uv5.parentTrs) and slot1.rect.width / 2 - slot0.localPosition.x > slot0.rect.width + math.random(uv0.interval[1], uv0.interval[2]) * 10 then
			uv4 = uv4 + 1
			uv0.deterGenNum = uv0.deterGenNum + 1
			uv3[uv4] = DormRhythmItemTemplate.New(uv5, {
				index = uv4,
				type = math.random(1, 2),
				totalNum = uv0.deterGenNum
			}, uv1)

			uv6()
		end
	end

	if uv4 == 1 and not uv3[uv4] and uv0.gameRunFlag then
		uv0.deterGenNum = uv0.deterGenNum + 1
		uv3[uv4] = DormRhythmItemTemplate.New(uv5, {
			index = uv4,
			type = math.random(1, 2),
			totalNum = uv0.deterGenNum
		}, uv1)

		uv6()
	end
end

function slot16()
	if uv0 then
		for slot3, slot4 in pairs(uv0) do
			slot4:Tick()
		end
	end
end

function slot17()
	uv0()
	uv1()
end

function slot18()
	if uv0 then
		for slot3, slot4 in pairs(uv0) do
			FuncTimerManager.inst:RemoveFuncTimer(slot4)

			slot4 = nil
		end
	end
end

function slot19()
	uv0()

	uv1 = {}
	uv1.tickTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
		if not uv0.pauseFlag then
			uv1()
		end
	end, -1, true)
end

function slot20(slot0)
	uv0 = {
		ratio = Screen.width / 1920,
		diff = slot0.diff,
		heroID = slot0.heroID
	}
	uv1 = slot0.goInfo
	slot1 = slot0.activityID or 1
	uv2 = DormRhythmGameTools:GetGameConfigData(slot1)
	uv3 = DormRhythmGameTools.gameConfigData[slot1].stageCfg

	if slot1 == 1 then
		uv0.levelID = slot0.diff
	else
		uv0.levelID = uv3.get_id_list_by_difficult[slot0.diff][1]
	end
end

function slot21()
	if uv0 then
		for slot3, slot4 in pairs(uv0) do
			slot4:Dispose()

			uv0[slot3] = nil
		end
	end

	uv0 = nil
end

function slot0.GetLevelData(slot0)
	return uv0
end

function slot0.GetRunTimeData(slot0)
	return uv0
end

function slot0.GetResultInfo(slot0)
	return {
		maxBatterNum = uv0.maxBatterNum,
		mistakeNum = uv0.mistakeNum,
		successfulNum = uv0.successfulNum
	}
end

function slot0.GetJudgeWidth(slot0)
	return uv0.judgeWidth
end

function slot0.GetDeterLength(slot0)
	return uv0.deterLength, uv1.ratio
end

function slot0.GetMistakeNum(slot0)
	return uv0.mistakeNum or 0
end

function slot0.GetLevelIDByDiff(slot0, slot1, slot2)
	if (slot2 or 1) == 1 then
		return slot1
	end

	if DormRhythmGameTools.gameConfigData[slot3] then
		return slot4.stageCfg.get_id_list_by_difficult[slot1][1]
	end
end

function slot0.DisPoseItem(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1]:Dispose()

		uv0[slot1] = nil
	end
end

function slot0.GetGameInterval(slot0)
	return uv0.interval
end

function slot0.GetGameSpeed(slot0)
	return 1920 / (uv0.gameSpeed / 10) * Time.deltaTime
end

function slot0.GetGameRunFlag(slot0)
	if uv0 then
		return uv0.gameRunFlag
	end
end

function slot0.Dispose(slot0)
	uv0()
	uv1()

	uv2 = nil
	uv3 = nil
	uv4 = nil
	uv5 = nil
	uv6 = nil
end

function slot0.StartGame(slot0, slot1)
	if not uv0 or not uv0.gameRunFlag then
		uv1(slot1)
		uv2()

		uv0.gameRunFlag = true

		uv3()
	else
		Debug.LogError("已开始游戏")
	end
end

function slot0.SetPauseFlag(slot0, slot1)
	uv0.pauseFlag = slot1
end

function slot0.StopGame(slot0)
	if uv0 and uv0.gameRunFlag then
		manager.audio:StopEffect()

		uv0.gameRunFlag = false

		uv1()
		uv2()
		manager.gc:Collect()
	end
end

function slot0.ClickDetermination(slot0, slot1)
	if uv0.gameRunFlag then
		slot2 = {
			buttonType = slot1,
			judgeWidth = uv0.judgeWidth
		}
		slot3 = false

		if uv1 then
			slot4 = false

			for slot8, slot9 in pairs(uv1) do
				if slot9.go and not slot0.hasCheck then
					slot4, slot11 = slot9:CheckHit(slot2)

					if slot11 then
						if not slot9.hasHit then
							slot9.hasHit = true
							slot3 = slot9:IsLast()

							break
						else
							return nil
						end
					end
				end
			end

			uv2:UpdateBatterNum(slot4, slot1, slot3)

			return slot4 and 1 or 0
		end
	end
end

function slot0.UpdateBatterNum(slot0, slot1, slot2, slot3)
	if slot1 == nil then
		return
	end

	if slot1 == true then
		uv0.successfulNum = uv0.successfulNum + 1
		uv0.batterNum = uv0.batterNum + 1
		uv0.maxBatterNum = math.max(uv0.maxBatterNum, uv0.batterNum)
	elseif slot1 == false then
		uv0.maxBatterNum = math.max(uv0.maxBatterNum, uv0.batterNum)
		uv0.batterNum = 0
		uv0.mistakeNum = uv0.mistakeNum + 1
	end

	if uv0.gameRunFlag then
		manager.notify:Invoke(DORM_REFRESH_BATTER_NUM, slot2, slot3)
	end
end

return slot0
