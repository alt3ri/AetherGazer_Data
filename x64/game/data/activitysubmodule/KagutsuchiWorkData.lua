slot0 = {
	GRID_ENTRUST = 2,
	GRID_NORMAL = 1,
	GRID_BOSS = 3,
	GRID_BLANK = 4
}
slot1 = class("PlayGridData")

function slot2(slot0)
	return slot0 == uv0.GRID_NORMAL or slot0 == uv0.GRID_BOSS or slot0 == uv0.GRID_ENTRUST
end

function slot1.Ctor(slot0, slot1)
	if not uv0(slot1.type) then
		-- Nothing
	end

	slot0.id = slot1.id
	slot0.type = slot1.type
	slot0.cleared = slot1.cleared
	slot0.minTime = slot1.minTime
	slot0.level_ = slot1.level
	slot0.stageId_ = slot1.stageId
end

function slot1.IsBattle(slot0)
	return slot0.type == uv0.GRID_NORMAL or slot0.type == uv0.GRID_BOSS
end

function slot1.IsEntrust(slot0)
	return slot0.type == uv0.GRID_ENTRUST
end

function slot1.IsBoss(slot0)
	return slot0.type == uv0.GRID_BOSS
end

function slot1.GetLevel(slot0)
	return slot0.level_
end

function slot1.GetBattleStageId(slot0)
	return slot0.stageId_
end

function slot1.GetBattleStageCfg(slot0)
	return BattleStageTools.GetStageCfg(BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME, slot0.stageId_)
end

function slot1.GetName(slot0)
	if slot0:IsBattle() then
		return slot0:GetBattleStageCfg().name
	end

	return GetTips(KagutsuchiWorkData:GetEntrustTips(slot0:GetEntrustIndex())[1])
end

function slot1.GetSummary(slot0)
	if slot0:IsBattle() then
		return slot0:GetBattleStageCfg().tips
	end

	return GetTips(KagutsuchiWorkData:GetEntrustTips(slot0:GetEntrustIndex())[2])
end

function slot1.GetCompleteText(slot0)
	if slot0:IsBattle() then
		return "no text"
	end

	return GetTips(KagutsuchiWorkData:GetEntrustTips(slot0:GetEntrustIndex())[3])
end

function slot1.GetReward(slot0)
	if slot0.type == uv0.GRID_ENTRUST then
		return GameSetting.activity_kagutsuchi_battle_entrust_reward.value[1][2]
	end

	if slot0:GetBattleStageCfg().drop_lib_id == 0 then
		return 0
	end

	slot4 = ActivityKagutsuchiBattleCfg[slot0:GetLevel()].addition_reward

	if #getRewardFromDropCfg(slot2, not slot0.cleared) == 0 then
		return 0
	end

	return slot3[1].num + slot4[slot0:IsBoss() and 2 or 1]
end

function slot1.IsCleared(slot0)
	return slot0.cleared
end

function slot1.GetCost(slot0)
	if slot0:IsCleared() then
		return 0
	end

	if slot0.type == uv0.GRID_NORMAL then
		return GameSetting.activity_kagutsuchi_battle_fatigue_normal_stage_cost.value[1]
	elseif slot0.type == uv0.GRID_BOSS then
		return GameSetting.activity_kagutsuchi_battle_fatigue_boss_stage_cost.value[1]
	end

	return 0
end

function slot1.GetId(slot0)
	return slot0.id
end

function slot1.GetEntrustIndex(slot0)
	return slot0.id - KagutsuchiWorkData:GetBattleGridCount()
end

function slot1.GetBattleMinTime(slot0)
	return slot0.minTime
end

slot3 = singletonClass("KagutsuchiWorkData")

function slot3.InitData(slot0, slot1)
	slot0.activityId = slot1.activity_id
	slot0.day = slot1.map_type
	slot0.mapLevel = slot1.map_level
	slot0.totalCoins = slot1.total_currency_num
	slot0.maxMapLevel = 10

	slot0:InitEntrustHeros(slot1)
	slot0:InitPlayGrids(slot1)
	manager.notify:CallUpdateFunc("OnKagutsuchiWorkDataInit")
end

function slot3.InitPlayGrids(slot0, slot1)
	slot2 = {}
	slot3 = nil

	for slot7, slot8 in ipairs((not slot0:IsBossDay() or GameSetting.activity_kagutsuchi_battle_boss_stage_list.value[slot0:GetBossDayIndex()]) and GameSetting.activity_kagutsuchi_battle_normal_stage_list.value[slot0:GetNormalDayIndex()]) do
		slot9 = {
			id = slot7,
			level = slot0.mapLevel,
			stageId = slot8,
			cleared = false,
			minTime = -1,
			cleared = slot14.clear_times > 0,
			minTime = slot14.min_time
		}

		for slot13, slot14 in ipairs(slot1.mission_list) do
			if slot14.id == slot8 then
				break
			end
		end

		if slot0:IsBossDay() then
			slot9.type = uv0.GRID_BOSS
		else
			slot9.type = uv0.GRID_NORMAL
		end

		table.insert(slot2, uv1.New(slot9))
	end

	slot4 = GameSetting.activity_kagutsuchi_battle_entrust_num.value[1]

	if not slot0:IsBossDay() then
		for slot8 = 1, slot4 do
			slot9 = {
				id = slot8 + #slot3,
				level = slot0.mapLevel,
				cleared = false,
				type = uv0.GRID_ENTRUST
			}

			for slot13, slot14 in ipairs(slot1.entrust_battle_list) do
				if slot14.grid_id == slot9.id then
					slot9.cleared = true

					break
				end
			end

			table.insert(slot2, uv1.New(slot9))
		end
	end

	slot0.playGridList = slot2
end

function slot3.InitEntrustHeros(slot0, slot1)
	slot0.entrustHeroIds = GameSetting.activity_kagutsuchi_battle_entrust_hero_list.value
	slot0.isHeroEntrusted = {}

	for slot5, slot6 in ipairs(slot0.entrustHeroIds) do
		slot0.isHeroEntrusted[slot6] = false
	end

	for slot5, slot6 in ipairs(slot1.entrust_battle_list) do
		slot0:UpdateEntrustedHeros(slot6.hero_list)
	end
end

function slot3.UpdateEntrustedHeros(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.isHeroEntrusted[slot6] = true
	end
end

function slot3.GetUpgradeCondition(slot0)
	return ConditionCfg[ActivityKagutsuchiBattleCfg[slot0.mapLevel].level_up_condition[1]]
end

function slot3.GetUpgradeConditionText(slot0)
	slot1 = slot0:GetUpgradeCondition()

	return string.format(slot1.desc, slot1.params[1], slot0.mapLevel + 1)
end

function slot3.IsMaxLevel(slot0)
	return slot0.mapLevel == slot0.maxMapLevel
end

function slot3.IsBossDay(slot0)
	return math.fmod(slot0.day, GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1) == 0
end

function slot3.GetEntrustHeroList(slot0)
	slot1 = {}
	slot2 = {
		[slot7] = true
	}

	for slot6, slot7 in ipairs(slot0.entrustHeroIds) do
		-- Nothing
	end

	for slot7, slot8 in pairs(HeroData:GetHeroList()) do
		if slot2[slot8.id] then
			table.insert(slot1, slot8)
		end
	end

	return slot1
end

function slot3.GetEntrustHeroIdList(slot0)
	return slot0.entrustHeroIds
end

function slot3.GetAttributeFactor(slot0)
	if ActivityKagutsuchiBattleCfg[slot0.mapLevel].attribute_factor and slot1[3] then
		return Vector3.New(slot1[1] / 1000, slot1[2] / 1000, slot1[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot3.IsEntrusted(slot0, slot1)
	return slot0.isHeroEntrusted[slot1]
end

function slot3.GetMinEntrustHeroNum(slot0)
	return GameSetting.activity_kagutsuchi_battle_entrust_hero_num_need.value[1]
end

function slot3.GetMinEntrustHeroLevel(slot0)
	return GameSetting.activity_kagutsuchi_battle_entrust_hero_level.value[1]
end

function slot3.GetIndexByStageId(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.playGridList) do
		if slot6:GetBattleStageId() == slot1 then
			return slot5
		end
	end

	return -1
end

function slot3.GetPlayGridData(slot0, slot1)
	return slot0.playGridList[slot1]
end

function slot3.GetPlayGridNum(slot0)
	return #slot0.playGridList
end

function slot3.GetCoins(slot0)
	return ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)
end

function slot3.GetStamina(slot0)
	return ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
end

function slot3.GetTotalCoins(slot0)
	return slot0.totalCoins
end

function slot3.GetDay(slot0)
	return slot0.day
end

function slot3.GetNextBossTime(slot0)
	slot3 = GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1
	slot7 = ActivityData:GetActivityData(slot0:GetActivityID()).startTime + 86400 * ((math.floor(slot0.day / slot3) + 1) * slot3 - 1)

	return slot7 - (tonumber(manager.time:STimeDescS(slot7, "!%H")) - tonumber(manager.time:STimeDescS(manager.time:GetNextFreshTime(), "!%H"))) * 3600
end

function slot3.GetBossDayIndex(slot0)
	return math.fmod(math.floor(slot0.day / (GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1)) - 1, #GameSetting.activity_kagutsuchi_battle_boss_stage_list.value) + 1
end

function slot3.GetNormalDayIndex(slot0)
	return math.fmod(slot0.day - math.floor(slot0.day / (GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1)) - 1, #GameSetting.activity_kagutsuchi_battle_normal_stage_list.value) + 1
end

function slot3.GetBattleGridCount(slot0)
	if slot0:IsBossDay() then
		return #GameSetting.activity_kagutsuchi_battle_boss_stage_list.value[slot0:GetBossDayIndex()]
	else
		return #GameSetting.activity_kagutsuchi_battle_normal_stage_list.value[slot0:GetNormalDayIndex()]
	end
end

function slot3.GetEntrustTips(slot0, slot1)
	slot2 = GameSetting.activity_kagutsuchi_battle_entrust_tips.value

	return slot2[math.fmod(slot0:GetNormalDayIndex() + slot1 - 1, #slot2) + 1]
end

function slot3.IsUpgraded(slot0)
	for slot6, slot7 in ipairs(slot0.playGridList) do
		if slot7.cleared and slot7:IsBattle() and slot7.minTime >= 0 and slot7.minTime <= slot0:GetUpgradeCondition().params[1] then
			return true
		end
	end

	return false
end

function slot3.IsAllClear(slot0)
	for slot4, slot5 in ipairs(slot0.playGridList) do
		if not slot5:IsCleared() then
			return false
		end
	end

	return true
end

function slot3.GetMapSeed(slot0)
	return slot0.day
end

function slot3.SetGridClear(slot0, slot1)
	if slot0:GetPlayGridData(slot1):IsBattle() then
		if slot2.minTime >= 0 then
			slot2.minTime = math.min(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime, slot2.minTime)
		else
			slot2.minTime = slot3
		end
	end

	if slot2.cleared then
		return
	end

	slot4 = slot2:GetCost()
	slot2.cleared = true
	slot0.totalCoins = slot0.totalCoins + slot2:GetReward()
end

function slot3.GetActivityID(slot0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function slot3.GetServerActivityID(slot0)
	return slot0.activityId
end

return slot3
