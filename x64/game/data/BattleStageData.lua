slot0 = singletonClass("BattleStageData")

function slot0.Init(slot0)
	slot0.stageList_ = {}
	slot0.maxChapterLevel_ = 1
	slot0.chapterStarReward_ = {}
	slot0.chapterStarCnt_ = {}
	slot0.openChapter_ = {}
	slot0.subPlotRedPointFlag_ = {}
	slot0.isLogin_ = 0
	slot0.mapLocationInfo_ = {}
	slot0.mapLocationEventList_ = {}
	slot0.operateChapterDayList_ = {}
end

slot1 = 0
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = -1

function slot0.InitPlotData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if ChapterCfg[getChapterIDByStageID(slot7.id)] ~= nil then
			slot0.stageList_[slot7.id] = {
				id = slot7.id,
				clear_times = slot7.clear_times,
				stars = {}
			}

			if slot9.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
				slot0:ModifyThreeStar(slot7.id, slot7.star_list)

				if slot0.maxChapterLevel_ < slot9.sub_type then
					slot0.maxChapterLevel_ = slot9.sub_type
				end

				slot2[slot8] = true
				slot0.openChapter_[slot8] = true

				if slot9.difficulty == 1 then
					uv0[slot8] = 1
				end
			end
		end

		if not uv1[slot7.id] and slot7.clear_times > 0 then
			uv2[slot7.id] = 1
		end

		if slot7.clear_times > 0 then
			uv1[slot7.id] = 1
		end
	end

	for slot6, slot7 in pairs(slot2) do
		slot0:CalcChapterStarCnt(slot6)
	end

	uv3 = table.length(uv0)

	if uv4 >= 0 and uv4 < uv3 then
		SendMessageManagerToSDK("chapter_main", {
			passChapter = uv3
		})
	end

	uv4 = uv3

	if slot0.isLogin_ > 0 and next(uv2) ~= nil then
		slot3 = deepClone(uv2)

		if not slot0.timer_ then
			slot0.timer_ = Timer.New(function ()
				SendMessageManagerToSDK("passStage", {
					passStage = uv0
				})
				uv1.timer_:Stop()

				uv1.timer_ = nil
			end, 1)

			slot0.timer_:Start()
		end
	end

	uv2 = {}

	manager.notify:Invoke(BATTLE_STAGE_PLOT_CHANGE)

	slot0.isLogin_ = 1
end

function slot0.ModifyThreeStar(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot0.stageList_[slot1].stars[slot6] = slot7
	end
end

function slot0.CalcChapterStarCnt(slot0, slot1)
	slot3 = 0

	for slot7, slot8 in ipairs(ChapterCfg[slot1].section_id_list) do
		if slot0.stageList_[slot8] then
			for slot12 = 1, 3 do
				slot3 = slot3 + slot0.stageList_[slot8].stars[slot12]
			end
		end
	end

	slot0.chapterStarCnt_[slot1] = slot3
end

function slot0.ClientModifyThreeStar(slot0, slot1, slot2)
	slot0:ModifyThreeStar(slot1, slot2)
	slot0:CalcChapterStarCnt(getChapterIDByStageID(slot1))
end

slot6 = {
	[2014.0] = 0,
	[202.0] = 0,
	[2012.0] = 0,
	[2015.0] = 0,
	[2013.0] = 0,
	[2016.0] = 0,
	[2011.0] = 0
}
slot7 = -1

function slot0.InitResourceData(slot0, slot1)
	slot2, slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		slot0.stageList_[slot8.id] = {
			id = slot8.id,
			clear_times = slot8.clear_times
		}
		slot2 = slot8.id
		slot0.openChapter_[getChapterIDByStageID(slot8.id)] = true
	end

	slot4 = BattleDailyStageCfg[slot2]

	if uv0 > 0 then
		if slot4 and slot4.level <= PlayerData:GetPlayerInfo().userLevel and ChapterTools.IsClearChapter(slot3) and uv1[slot3] == 0 then
			uv1[slot3] = 1

			SendMessageManagerToSDK("unlockStage", {
				chapterID = slot3
			})
		end
	else
		uv0 = 1

		for slot9, slot10 in pairs(uv1) do
			if ChapterTools.IsClearChapter(slot9) then
				uv1[slot9] = 1
			end
		end
	end

	DailyNewRedPoint:InitNewTagData()
	BattleEquipData:InitNewTagData()
end

function slot0.InitChallengeData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = getChapterIDByStageID(slot6.id)
		slot8 = ChapterCfg[slot7]
		slot0.stageList_[slot6.id] = {
			id = slot6.id,
			clear_times = slot6.clear_times,
			stars = {}
		}
		slot0.openChapter_[slot7] = true

		slot0:ModifyThreeStar(slot6.id, slot6.star_list)
	end
end

function slot0.InitChapterStarReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.chapterStarReward_[slot6.id] = {}

		for slot10, slot11 in ipairs(slot6.reward_list) do
			slot0.chapterStarReward_[slot6.id][slot11.reward_order] = slot11.is_received
		end
	end
end

function slot0.GetStageIsOpen(slot0, slot1)
	if BattleDailyStageCfg[slot1] then
		if slot2 and (PlayerData:GetPlayerInfo().userLevel or 0) < slot2.level then
			return false
		end

		if not slot0:GetStageData()[slot1] then
			return false
		end
	end

	return true
end

function slot0.GetMaxChapterLevel(slot0)
	return slot0.maxChapterLevel_
end

function slot0.GetStageData(slot0)
	return slot0.stageList_
end

function slot0.GetStageClearTimes(slot0, slot1)
	if slot0.stageList_[slot1] and slot0.stageList_[slot1].clear_times then
		return slot0.stageList_[slot1].clear_times
	end

	return 0
end

function slot0.SetChapterStarReward(slot0, slot1, slot2)
	if slot0.chapterStarReward_[slot1] == nil then
		slot0.chapterStarReward_[slot1] = {}
	end

	slot0.chapterStarReward_[slot1][slot2] = 2
end

function slot0.GetChapterStarRewardState(slot0)
	return slot0.chapterStarReward_
end

function slot0.IsOpenChapter(slot0, slot1)
	return slot0.openChapter_[slot1]
end

function slot0.GetChapterStarCnt(slot0, slot1)
	return slot0.chapterStarCnt_[slot1] or 0
end

function slot0.GetChapterStarList(slot0)
	return slot0.chapterStarCnt_
end

function slot0.GetChapterRedPointNotice(slot0, slot1)
	slot2 = slot0.chapterStarReward_

	for slot7 = 1, 3 do
		if ChapterCfg[slot1].star_need[slot7] <= (slot0.chapterStarCnt_[slot1] or 0) then
			if not slot2[slot1] or not slot2[slot1][slot7] or slot2[slot1][slot7] < 1 then
				return true
			end
		end
	end

	return false
end

function slot0.GetOpenChapter(slot0)
	return slot0.openChapter_
end

function slot0.SetSubPlotRedPointFlag(slot0, slot1)
	slot0.subPlotRedPointFlag_[slot1] = 1
end

function slot0.GetSubPlotRedPointFlag(slot0, slot1)
	return slot0.subPlotRedPointFlag_[slot1]
end

function slot0.SetAutoNextBattle(slot0, slot1)
	slot0.autoNextBattle_ = slot1
end

function slot0.GetAutoNextBattle(slot0)
	return slot0.autoNextBattle_
end

function slot0.InitMapLocation(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.map_info) do
		slot7 = {
			[slot12] = 0
		}

		for slot11, slot12 in ipairs(slot6.scan_location_list) do
			-- Nothing
		end

		for slot11, slot12 in ipairs(slot6.clue_location_list) do
			slot7[slot12.location_id] = slot12.clue_id
		end

		slot0.mapLocationInfo_[slot6.map_id] = slot7

		for slot11, slot12 in ipairs(slot6.event_list) do
			table.insert(slot0.mapLocationEventList_, slot12)
		end

		for slot11, slot12 in ipairs(slot6.clue_list) do
			slot16 = slot6.map_id

			for slot16, slot17 in ipairs(ChapterMapCfg[slot16].location_list) do
				if table.keyof(ChapterLocationCfg[slot17].clue, slot12) then
					slot7[slot17] = slot12

					break
				end
			end
		end
	end

	for slot5, slot6 in ipairs(slot1.detector_info) do
		slot0.operateChapterDayList_[slot7] = slot0.operateChapterDayList_[slot6.chapter_id] or {}

		if slot6.status == 1 then
			slot0.operateChapterDayList_[slot7][slot6.day] = true
		end
	end
end

function slot0.ScanClueLocationData(slot0, slot1, slot2)
	slot0.mapLocationInfo_[slot1][slot2] = 0
end

function slot0.UpdateClueLocationData(slot0, slot1, slot2, slot3)
	slot0.mapLocationInfo_[slot1] = slot0:GetMapLocationData(slot1)
	slot0.mapLocationInfo_[slot1][slot2] = slot3
end

function slot0.GetMapLocationData(slot0, slot1)
	return slot0.mapLocationInfo_[slot1] or {}
end

function slot0.UpdateLocationEvent(slot0, slot1)
	table.insert(slot0.mapLocationEventList_, slot1)
end

function slot0.HasReadLocationEvent(slot0, slot1)
	return table.keyof(slot0.mapLocationEventList_, slot1)
end

function slot0.GetOperateChapterDay(slot0, slot1, slot2)
	return slot0.operateChapterDayList_[slot1] and slot0.operateChapterDayList_[slot1][slot2] or false
end

function slot0.SetOperateChapterDay(slot0, slot1, slot2)
	slot0.operateChapterDayList_[slot1] = slot0.operateChapterDayList_[slot1] or {}
	slot0.operateChapterDayList_[slot1][slot2] = true
end

function slot0.SaveAutoBattleFlag(slot0, slot1)
	saveData("BattleStage", "autoBattle" .. slot1, true)
end

function slot0.GetAutoBattleFlag(slot0, slot1)
	return getData("BattleStage", "autoBattle" .. slot1)
end

function slot0.GetFogAnimatorFlag(slot0)
	if slot0.chapter19FogAnimatorFlag_ == nil then
		slot0.chapter19FogAnimatorFlag_ = getData("BattleStage", "fog")
	end

	return slot0.chapter19FogAnimatorFlag_
end

function slot0.SaveFogAnimatorFlag(slot0, slot1)
	slot0.chapter19FogAnimatorFlag_ = slot1

	saveData("BattleStage", "fog", slot1)
end

return slot0
