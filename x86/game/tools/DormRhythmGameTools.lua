slot0 = {
	gameConfig = {
		Dorm = 1,
		Barbecue = ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1
	}
}
slot0.gameConfigData = {
	[slot0.gameConfig.Dorm] = {
		failCueName = "ui_dorm_game_fail",
		successCueName = "ui_dorm_game_success",
		cueName = "ui_dorm",
		judgeWidth = GameDisplayCfg.dorm_mg_break_check_range.value[1],
		scoreLevel = GameSetting.dorm_mg_break_level.value,
		effectLevel = GameDisplayCfg.dorm_mg_break_effect.value,
		stageCfg = BackHomeBreakGameCfg
	},
	[slot0.gameConfig.Barbecue] = {
		failCueName = "ui_dorm_game_fail",
		successCueName = "ui_dorm_game_success",
		cueName = "ui_dorm",
		judgeWidth = GameDisplayCfg.dorm_mg_break_check_range.value[1],
		scoreLevel = GameSetting.dorm_mg_break_level.value,
		effectLevel = GameDisplayCfg.dorm_mg_break_effect.value,
		stageCfg = ActivityHeroChallengeBarbecueCfg
	}
}

function slot0.GetGameConfigData(slot0, slot1)
	if uv0.gameConfigData[slot1] then
		return uv0.gameConfigData[slot1]
	end

	Debug.LogError("未获取到对应活动的小游戏配置信息" .. slot1)
end

function slot0.GetRank(slot0, slot1)
	for slot6, slot7 in ipairs(GameSetting.dorm_mg_break_level.value) do
		if slot1 < slot7 then
			return slot6 - 1
		end
	end

	return #slot2
end

function slot0.GetEffectRank(slot0, slot1)
	slot3 = -1

	for slot7, slot8 in ipairs(GameDisplayCfg.dorm_mg_break_effect.value) do
		if slot1 < slot8 then
			slot3 = slot7 - 1

			break
		end
	end

	if slot3 < 0 then
		slot3 = #slot2
	end

	return slot3
end

function slot0.CalGameScore(slot0, slot1, slot2, slot3)
	if slot1 then
		return math.ceil((slot1.successfulNum + slot1.maxBatterNum) / slot0.gameConfigData[slot3 or 1].stageCfg[slot2].total_check * 100)
	end
end

function slot0.GetGameResult(slot0, slot1, slot2, slot3)
	if GameDisplayCfg.dorm_mg_break_success.value[1] <= slot0:CalGameScore(slot1, slot2, slot3 or 1) then
		return true
	end

	return false
end

return slot0
