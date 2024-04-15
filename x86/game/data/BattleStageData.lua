local var_0_0 = singletonClass("BattleStageData")

function var_0_0.Init(arg_1_0)
	arg_1_0.stageList_ = {}
	arg_1_0.maxChapterLevel_ = 1
	arg_1_0.chapterStarReward_ = {}
	arg_1_0.chapterStarCnt_ = {}
	arg_1_0.openChapter_ = {}
	arg_1_0.subPlotRedPointFlag_ = {}
	arg_1_0.isLogin_ = 0
	arg_1_0.mapLocationInfo_ = {}
	arg_1_0.mapLocationEventList_ = {}
	arg_1_0.operateChapterDayList_ = {}
end

local var_0_1 = 0
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = -1

function var_0_0.InitPlotData(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = getChapterIDByStageID(iter_2_1.id)
		local var_2_2 = ChapterCfg[var_2_1]

		if var_2_2 ~= nil then
			arg_2_0.stageList_[iter_2_1.id] = {
				id = iter_2_1.id,
				clear_times = iter_2_1.clear_times,
				stars = {}
			}

			if var_2_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
				arg_2_0:ModifyThreeStar(iter_2_1.id, iter_2_1.star_list)

				if var_2_2.sub_type > arg_2_0.maxChapterLevel_ then
					arg_2_0.maxChapterLevel_ = var_2_2.sub_type
				end

				var_2_0[var_2_1] = true
				arg_2_0.openChapter_[var_2_1] = true

				if var_2_2.difficulty == 1 then
					var_0_2[var_2_1] = 1
				end
			end
		end

		if not var_0_3[iter_2_1.id] and iter_2_1.clear_times > 0 then
			var_0_4[iter_2_1.id] = 1
		end

		if iter_2_1.clear_times > 0 then
			var_0_3[iter_2_1.id] = 1
		end
	end

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		arg_2_0:CalcChapterStarCnt(iter_2_2)
	end

	var_0_1 = table.length(var_0_2)

	if var_0_5 >= 0 and var_0_1 > var_0_5 then
		SendMessageManagerToSDK("chapter_main", {
			passChapter = var_0_1
		})
	end

	var_0_5 = var_0_1

	if arg_2_0.isLogin_ > 0 and next(var_0_4) ~= nil then
		local var_2_3 = deepClone(var_0_4)

		if not arg_2_0.timer_ then
			arg_2_0.timer_ = Timer.New(function()
				SendMessageManagerToSDK("passStage", {
					passStage = var_2_3
				})
				arg_2_0.timer_:Stop()

				arg_2_0.timer_ = nil
			end, 1)

			arg_2_0.timer_:Start()
		end
	end

	var_0_4 = {}

	manager.notify:Invoke(BATTLE_STAGE_PLOT_CHANGE)

	arg_2_0.isLogin_ = 1
end

function var_0_0.ModifyThreeStar(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		arg_4_0.stageList_[arg_4_1].stars[iter_4_0] = iter_4_1
	end
end

function var_0_0.CalcChapterStarCnt(arg_5_0, arg_5_1)
	local var_5_0 = ChapterCfg[arg_5_1].section_id_list
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if arg_5_0.stageList_[iter_5_1] then
			for iter_5_2 = 1, 3 do
				var_5_1 = var_5_1 + arg_5_0.stageList_[iter_5_1].stars[iter_5_2]
			end
		end
	end

	arg_5_0.chapterStarCnt_[arg_5_1] = var_5_1
end

function var_0_0.ClientModifyThreeStar(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:ModifyThreeStar(arg_6_1, arg_6_2)

	local var_6_0 = getChapterIDByStageID(arg_6_1)

	arg_6_0:CalcChapterStarCnt(var_6_0)
end

local var_0_6 = {
	[2014] = 0,
	[202] = 0,
	[2012] = 0,
	[2015] = 0,
	[2013] = 0,
	[2016] = 0,
	[2011] = 0
}
local var_0_7 = -1

function var_0_0.InitResourceData(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		var_7_1 = getChapterIDByStageID(iter_7_1.id)
		arg_7_0.stageList_[iter_7_1.id] = {
			id = iter_7_1.id,
			clear_times = iter_7_1.clear_times
		}
		var_7_0 = iter_7_1.id
		arg_7_0.openChapter_[var_7_1] = true
	end

	local var_7_2 = BattleDailyStageCfg[var_7_0]
	local var_7_3 = PlayerData:GetPlayerInfo().userLevel

	if var_0_7 > 0 then
		if var_7_2 and var_7_3 >= var_7_2.level and ChapterTools.IsClearChapter(var_7_1) and var_0_6[var_7_1] == 0 then
			var_0_6[var_7_1] = 1

			SendMessageManagerToSDK("unlockStage", {
				chapterID = var_7_1
			})
		end
	else
		var_0_7 = 1

		for iter_7_2, iter_7_3 in pairs(var_0_6) do
			if ChapterTools.IsClearChapter(iter_7_2) then
				var_0_6[iter_7_2] = 1
			end
		end
	end

	DailyNewRedPoint:InitNewTagData()
	BattleEquipData:InitNewTagData()
end

function var_0_0.InitChallengeData(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0 = getChapterIDByStageID(iter_8_1.id)
		local var_8_1 = ChapterCfg[var_8_0]

		arg_8_0.stageList_[iter_8_1.id] = {
			id = iter_8_1.id,
			clear_times = iter_8_1.clear_times,
			stars = {}
		}
		arg_8_0.openChapter_[var_8_0] = true

		arg_8_0:ModifyThreeStar(iter_8_1.id, iter_8_1.star_list)
	end
end

function var_0_0.InitChapterStarReward(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		arg_9_0.chapterStarReward_[iter_9_1.id] = {}

		for iter_9_2, iter_9_3 in ipairs(iter_9_1.reward_list) do
			arg_9_0.chapterStarReward_[iter_9_1.id][iter_9_3.reward_order] = iter_9_3.is_received
		end
	end
end

function var_0_0.GetStageIsOpen(arg_10_0, arg_10_1)
	local var_10_0 = BattleDailyStageCfg[arg_10_1]

	if var_10_0 then
		local var_10_1 = PlayerData:GetPlayerInfo().userLevel or 0

		if var_10_0 and var_10_1 < var_10_0.level then
			return false
		end

		if not arg_10_0:GetStageData()[arg_10_1] then
			return false
		end
	end

	return true
end

function var_0_0.GetMaxChapterLevel(arg_11_0)
	return arg_11_0.maxChapterLevel_
end

function var_0_0.GetStageData(arg_12_0)
	return arg_12_0.stageList_
end

function var_0_0.GetStageClearTimes(arg_13_0, arg_13_1)
	if arg_13_0.stageList_[arg_13_1] and arg_13_0.stageList_[arg_13_1].clear_times then
		return arg_13_0.stageList_[arg_13_1].clear_times
	end

	return 0
end

function var_0_0.SetChapterStarReward(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.chapterStarReward_[arg_14_1] == nil then
		arg_14_0.chapterStarReward_[arg_14_1] = {}
	end

	arg_14_0.chapterStarReward_[arg_14_1][arg_14_2] = 2
end

function var_0_0.GetChapterStarRewardState(arg_15_0)
	return arg_15_0.chapterStarReward_
end

function var_0_0.IsOpenChapter(arg_16_0, arg_16_1)
	return arg_16_0.openChapter_[arg_16_1]
end

function var_0_0.GetChapterStarCnt(arg_17_0, arg_17_1)
	return arg_17_0.chapterStarCnt_[arg_17_1] or 0
end

function var_0_0.GetChapterStarList(arg_18_0)
	return arg_18_0.chapterStarCnt_
end

function var_0_0.GetChapterRedPointNotice(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.chapterStarReward_
	local var_19_1 = arg_19_0.chapterStarCnt_[arg_19_1] or 0

	for iter_19_0 = 1, 3 do
		if not (var_19_1 >= ChapterCfg[arg_19_1].star_need[iter_19_0]) or var_19_0[arg_19_1] and var_19_0[arg_19_1][iter_19_0] and var_19_0[arg_19_1][iter_19_0] >= 1 then
			-- block empty
		else
			return true
		end
	end

	return false
end

function var_0_0.GetOpenChapter(arg_20_0)
	return arg_20_0.openChapter_
end

function var_0_0.SetSubPlotRedPointFlag(arg_21_0, arg_21_1)
	arg_21_0.subPlotRedPointFlag_[arg_21_1] = 1
end

function var_0_0.GetSubPlotRedPointFlag(arg_22_0, arg_22_1)
	return arg_22_0.subPlotRedPointFlag_[arg_22_1]
end

function var_0_0.SetAutoNextBattle(arg_23_0, arg_23_1)
	arg_23_0.autoNextBattle_ = arg_23_1
end

function var_0_0.GetAutoNextBattle(arg_24_0)
	return arg_24_0.autoNextBattle_
end

function var_0_0.InitMapLocation(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1.map_info) do
		local var_25_0 = {}

		for iter_25_2, iter_25_3 in ipairs(iter_25_1.scan_location_list) do
			var_25_0[iter_25_3] = 0
		end

		for iter_25_4, iter_25_5 in ipairs(iter_25_1.clue_location_list) do
			var_25_0[iter_25_5.location_id] = iter_25_5.clue_id
		end

		arg_25_0.mapLocationInfo_[iter_25_1.map_id] = var_25_0

		for iter_25_6, iter_25_7 in ipairs(iter_25_1.event_list) do
			table.insert(arg_25_0.mapLocationEventList_, iter_25_7)
		end

		for iter_25_8, iter_25_9 in ipairs(iter_25_1.clue_list) do
			for iter_25_10, iter_25_11 in ipairs(ChapterMapCfg[iter_25_1.map_id].location_list) do
				if table.keyof(ChapterLocationCfg[iter_25_11].clue, iter_25_9) then
					var_25_0[iter_25_11] = iter_25_9

					break
				end
			end
		end
	end

	for iter_25_12, iter_25_13 in ipairs(arg_25_1.detector_info) do
		local var_25_1 = iter_25_13.chapter_id
		local var_25_2 = iter_25_13.day

		arg_25_0.operateChapterDayList_[var_25_1] = arg_25_0.operateChapterDayList_[var_25_1] or {}

		if iter_25_13.status == 1 then
			arg_25_0.operateChapterDayList_[var_25_1][var_25_2] = true
		end
	end
end

function var_0_0.ScanClueLocationData(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.mapLocationInfo_[arg_26_1][arg_26_2] = 0
end

function var_0_0.UpdateClueLocationData(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0.mapLocationInfo_[arg_27_1] = arg_27_0:GetMapLocationData(arg_27_1)
	arg_27_0.mapLocationInfo_[arg_27_1][arg_27_2] = arg_27_3
end

function var_0_0.GetMapLocationData(arg_28_0, arg_28_1)
	return arg_28_0.mapLocationInfo_[arg_28_1] or {}
end

function var_0_0.UpdateLocationEvent(arg_29_0, arg_29_1)
	table.insert(arg_29_0.mapLocationEventList_, arg_29_1)
end

function var_0_0.HasReadLocationEvent(arg_30_0, arg_30_1)
	return table.keyof(arg_30_0.mapLocationEventList_, arg_30_1)
end

function var_0_0.GetOperateChapterDay(arg_31_0, arg_31_1, arg_31_2)
	return arg_31_0.operateChapterDayList_[arg_31_1] and arg_31_0.operateChapterDayList_[arg_31_1][arg_31_2] or false
end

function var_0_0.SetOperateChapterDay(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.operateChapterDayList_[arg_32_1] = arg_32_0.operateChapterDayList_[arg_32_1] or {}
	arg_32_0.operateChapterDayList_[arg_32_1][arg_32_2] = true
end

function var_0_0.SaveAutoBattleFlag(arg_33_0, arg_33_1)
	saveData("BattleStage", "autoBattle" .. arg_33_1, true)
end

function var_0_0.GetAutoBattleFlag(arg_34_0, arg_34_1)
	return getData("BattleStage", "autoBattle" .. arg_34_1)
end

function var_0_0.GetFogAnimatorFlag(arg_35_0)
	if arg_35_0.chapter19FogAnimatorFlag_ == nil then
		arg_35_0.chapter19FogAnimatorFlag_ = getData("BattleStage", "fog")
	end

	return arg_35_0.chapter19FogAnimatorFlag_
end

function var_0_0.SaveFogAnimatorFlag(arg_36_0, arg_36_1)
	arg_36_0.chapter19FogAnimatorFlag_ = arg_36_1

	saveData("BattleStage", "fog", arg_36_1)
end

return var_0_0
