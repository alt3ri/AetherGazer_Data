slot0 = singletonClass("SequentialBattleData")
slot1 = require("cjson")

function slot0.Init(slot0)
	slot0.selectChapterID_ = {}
	slot0.chapterData_ = {}
	slot0.cacheChapterData_ = {}
	slot0.sortRewardList_ = {}
end

function slot0.InitData(slot0, slot1)
	if slot0.chapterData_[slot1.activity_id] == nil then
		slot0:InitChapterData(slot2)
	end

	slot0.chapterData_[slot2].historyFinishStage = {}

	for slot6, slot7 in ipairs(slot1.activity_info.finished_stage_list) do
		table.insert(slot0.chapterData_[slot2].historyFinishStage, slot7)
	end

	slot0.chapterData_[slot2].rewardList = {}

	for slot6, slot7 in ipairs(slot1.activity_info.admitted_reward_list) do
		table.insert(slot0.chapterData_[slot2].rewardList, slot7)
	end

	slot0:LoadHeroTeam(slot2)
	slot0:SortReward(slot2)
end

function slot0.InitChapterData(slot0, slot1)
	slot0.chapterData_[slot1] = {
		curFinishStageIndex = 0,
		historyFinishStage = {},
		rewardList = {},
		enabledBuff = {}
	}

	slot0:InitChapteTeamData(slot1)
end

function slot0.InitChapteTeamData(slot0, slot1)
	slot0.chapterData_[slot1].team = {}

	for slot5 = 1, #SequentialBattleChapterCfg[slot1].stage_id do
		slot0.chapterData_[slot1].team[slot5] = {
			chipID = 0,
			comboSkillID = 0,
			needRefreshComboSkill = false,
			id = slot5,
			heroList = {},
			chipList = {},
			enabledBuff = {}
		}
	end
end

function slot0.GetSelectChapterID(slot0, slot1)
	if slot0.selectChapterID_[slot1] == nil then
		slot0.selectChapterID_[slot1] = getData("SequentialBattle", "activityID" .. slot1) or SequentialBattleChapterCfg.get_id_list_by_main_id[slot1][1]
	end

	return slot0.selectChapterID_[slot1]
end

function slot0.SetSelectChapterID(slot0, slot1, slot2)
	slot0.selectChapterID_[slot1] = slot2

	saveData("SequentialBattle", "activityID" .. slot1, slot2)
end

function slot0.GetChapterData(slot0, slot1)
	return slot0.chapterData_[slot1]
end

function slot0.GetHeroTeam(slot0, slot1, slot2)
	if slot0.chapterData_[slot1] and slot0.chapterData_[slot1].team and slot0.chapterData_[slot1].team[slot2] then
		return slot0.chapterData_[slot1].team[slot2].heroList
	else
		return {}
	end
end

function slot0.SaveHeroTeam(slot0, slot1, slot2, slot3, slot4)
	for slot8, slot9 in ipairs(slot3) do
		slot0.chapterData_[slot1].team[slot2].heroList[slot8] = slot0.chapterData_[slot1].team[slot2].heroList[slot8] or {}
		slot0.chapterData_[slot1].team[slot2].heroList[slot8].heroID = slot9
		slot0.chapterData_[slot1].team[slot2].heroList[slot8].trialID = slot4[slot8]
	end
end

function slot0.GetHeroTeamData(slot0, slot1)
	return slot0.chapterData_[slot1].team
end

function slot0.SetComboSkillID(slot0, slot1, slot2, slot3, slot4)
	slot0.chapterData_[slot1].team[slot2].comboSkillID = slot3
	slot0.chapterData_[slot1].team[slot2].needRefreshComboSkill = slot4
end

function slot0.CacheChapterData(slot0, slot1)
	slot0.cacheChapterData_[slot1] = clone(slot0.chapterData_[slot1])
end

function slot0.RevertChapterData(slot0, slot1)
	slot0.chapterData_[slot1] = slot0.cacheChapterData_[slot1]
end

function slot0.ResetChapterTeamData(slot0, slot1)
	slot0.chapterData_[slot1].curFinishStageIndex = 0
end

function slot0.ResetChapterCacheTeamData(slot0, slot1)
	slot0:InitChapteTeamData(slot1)
	slot0:SaveLocalAllTeam(slot1)
end

function slot0.IsSameTeamData(slot0, slot1, slot2)
	return table.equal(slot0.chapterData_[slot1].team[slot2], slot0.cacheChapterData_[slot1].team[slot2], "all")
end

function slot0.SetChipManagerID(slot0, slot1, slot2, slot3)
	slot0.chapterData_[slot1].team[slot2].chipID = slot3
end

function slot0.SetChipList(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot3) do
		if not slot0:InsertChipList(slot1, slot2, slot8) then
			return false
		end
	end

	return true
end

function slot0.InsertChipList(slot0, slot1, slot2, slot3)
	slot4 = true
	slot6 = false
	slot7 = 0

	for slot13, slot14 in ipairs(slot0.chapterData_[slot1].team[slot2].chipList) do
		if ChipCfg[slot14].spec_char ~= 0 and table.keyof(ChipCfg.get_id_list_by_spec_char[ChipCfg[slot3].spec_char], slot14) and slot14 ~= slot3 then
			slot6 = true
			slot7 = slot14

			break
		end
	end

	if not table.keyof(slot5, slot3) and not slot6 and GameSetting.ai_secondary_chip_equip_num.value[1] <= #slot5 then
		ShowTips("CHIP_CNT_MORE_THEN_MAX")

		return
	end

	if slot6 then
		slot4 = false

		table.remove(slot5, table.indexof(slot5, slot7))
		ShowTips("CHIP_USE_SUCCESS")
		table.insert(slot5, slot3)
	elseif slot10 then
		ShowTips("CHIP_UNLOAD_SUCCESS")
		table.remove(slot5, table.indexof(slot5, slot3))
	else
		table.insert(slot5, slot3)
	end

	slot0.chapterData_[slot1].team[slot2].chipList = slot5

	manager.notify:Invoke(ENABLED_CHIP)

	return slot4
end

function slot0.ResetChipManager(slot0, slot1, slot2)
	slot0.chapterData_[slot1].team[slot2].chipList = {}
end

function slot0.GetCurrentFinishStageIndex(slot0, slot1)
	return slot0.chapterData_[slot1].curFinishStageIndex
end

function slot0.ClearStage(slot0, slot1)
	slot0.chapterData_[slot1].curFinishStageIndex = slot0.chapterData_[slot1].curFinishStageIndex + 1

	if table.keyof(slot0.chapterData_[slot1].historyFinishStage, SequentialBattleChapterCfg[slot1].stage_id[slot0.chapterData_[slot1].curFinishStageIndex]) == nil then
		table.insert(slot0.chapterData_[slot1].historyFinishStage, slot2)
	end

	slot0:SortReward(slot1)
end

function slot0.SortReward(slot0, slot1)
	slot2 = table.length(slot0.chapterData_[slot1].historyFinishStage)
	slot4 = {}
	slot6 = {}

	for slot10, slot11 in ipairs(SequentialBattleChapterCfg[slot1].reward_item_list) do
		if table.keyof(slot0.chapterData_[slot1].rewardList, slot10) then
			table.insert({}, slot10)
		elseif slot11[1] <= slot2 then
			table.insert(slot4, slot10)
		else
			table.insert(slot6, slot10)
		end
	end

	if #slot4 > 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot1), 0)
	end

	table.insertto(slot4, slot6)
	table.insertto(slot4, slot5)

	slot0.sortRewardList_[slot1] = slot4
end

function slot0.GetSortRewardList(slot0, slot1)
	if slot0.sortRewardList_[slot1] == nil then
		slot0:SortReward(slot1)
	end

	return slot0.sortRewardList_[slot1]
end

function slot0.GetRewadList(slot0, slot1)
	return slot0.chapterData_[slot1].rewardList or {}
end

function slot0.ReceiveReward(slot0, slot1, slot2)
	table.insert(slot0.chapterData_[slot1].rewardList, slot2)
	slot0:SortReward(slot1)
end

function slot0.GetFinishStageList(slot0, slot1)
	return slot0.chapterData_[slot1].historyFinishStage or {}
end

function slot0.LoadHeroTeam(slot0, slot1)
end

function slot0.SaveLocalAllTeam(slot0, slot1)
	for slot5 = 1, #SequentialBattleChapterCfg[slot1].stage_id do
		slot0:SaveLocalHeroTeam(slot1, slot5)
	end
end

function slot0.SaveLocalHeroTeam(slot0, slot1, slot2)
end

return slot0
