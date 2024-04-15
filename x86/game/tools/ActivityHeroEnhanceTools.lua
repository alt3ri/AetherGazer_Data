function slot1()
	return ActivityHeroEnhanceCfg[ActivityHeroEnhanceCfg.all[1]]
end

slot2 = {}

function slot3(slot0, slot1, slot2)
	if uv0[slot0] == nil then
		return nil
	end

	if slot3[slot1] == nil then
		return nil
	end

	return slot4[slot2]
end

function slot4(slot0, slot1, slot2, slot3)
	if uv0[slot0] == nil then
		uv0[slot0] = {}
	end

	if slot4[slot1] == nil then
		slot4[slot1] = {}
	end

	slot5[slot2] = slot3
end

slot5 = {}

function slot6(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = TalentTreeCfg[slot1].stage - 1
	end

	if slot2 <= 0 then
		return false
	end

	if uv0.GetTalentListActivatedIdx(slot0, uv0.GetCfgTalentListByStage(uv0.GetCfgByTalentId(slot0, slot1), slot2)) < 0 then
		return true
	end

	return false
end

return {
	GetEnterUI = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_3_0 then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceMainUI"
		end

		Debug.LogError("HeroEnhance: activity " .. slot0 .. " has no EnterUI")

		return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceMainUI"
	end,
	GetHeroUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_3_0 then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceHeroUI"
		end

		Debug.LogError("HeroEnhance: activity " .. slot0 .. " has no HeroUI")

		return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceHeroUI"
	end,
	GetStageUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_3_0 then
			-- Nothing
		end

		return "Widget/System/Operation/OperationStageUI"
	end,
	GetStageInfoUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_3_0 then
			-- Nothing
		end

		return "Widget/System/Operation/ChapterSectionInfoUI"
	end,
	GetStageAttachUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_3_0 then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceStageAttachUI"
		end

		Debug.LogError("HeroEnhance: activity " .. slot0 .. " has no StageAttachUI")

		return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceStageAttachUI"
	end,
	GetAllRewardList = function (slot0)
		if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[slot0] == nil then
			Debug.LogError("hero enhance config empty for activity: " .. slot0)

			return {}
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			for slot12, slot13 in ipairs(ActivityHeroEnhanceCfg[slot7].stage_list) do
				slot2 = mergeRewardList(slot2, uv0.GetStageRewardList(slot0, slot13, true))
			end
		end

		return slot2
	end,
	GetStageRewardList = function (slot0, slot1, slot2)
		if BattleHeroEnhanceCfg[slot1] == nil then
			Debug.LogError("battle hero enhance config empty for activity(" .. slot0 .. "), stageId(" .. slot1 .. ")")

			return {}
		end

		if slot2 == nil then
			slot2 = not ActivityHeroEnhanceData:IsStageClear(slot0, slot1)
		end

		return getRewardFromDropCfg(slot3.drop_lib_id, slot2)
	end,
	GetCfgIdList = function (slot0)
		if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[slot0] == nil then
			return {
				uv0().id
			}
		end

		return slot1
	end,
	GetCfgTalentDict = function (slot0)
		if uv0[slot0.id] then
			return slot1
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot0.talent_list) do
			slot8 = TalentTreeCfg[slot7]
			slot2[slot8.stage] = slot2[slot8.stage] or {}

			table.insert(slot2[slot8.stage], slot7)
		end

		uv0[slot0.id] = slot2

		return slot2
	end,
	GetCfgTalentListByStage = function (slot0, slot1)
		return uv0.GetCfgTalentDict(slot0)[slot1]
	end,
	GetCfgActivatedTalentList = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0.talent_list) do
			slot7 = TalentTreeCfg[slot6]

			if ActivityHeroEnhanceData:IsTalentActivated(slot0.activity_id, slot6) then
				table.insert(slot1, slot6)
			end
		end

		return slot1
	end,
	GetCfgActivatedTalentDict = function (slot0)
		for slot5, slot6 in ipairs(slot0.talent_list) do
			if ActivityHeroEnhanceData:IsTalentActivated(slot0.activity_id, slot6) then
				-- Nothing
			end
		end

		return {
			[TalentTreeCfg[slot6].stage] = slot6
		}
	end,
	GetTutorialCfg = function (slot0)
		if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[slot0] == nil then
			return uv0()
		end

		return ActivityHeroEnhanceCfg[slot1[1]]
	end,
	GetTutorialHeroId = function (slot0)
		return uv0.GetTutorialCfg(slot0).hero_id
	end,
	GetCfgByTalentId = function (slot0, slot1)
		if uv0(slot0, "GetCfgByTalentId", slot1) then
			return slot2
		end

		if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[slot0] == nil then
			return uv1()
		end

		for slot7, slot8 in ipairs(slot3) do
			if table.indexof(ActivityHeroEnhanceCfg[slot8].talent_list, slot1) then
				uv2(slot0, "GetCfgByTalentId", slot1, slot2)

				return slot2
			end
		end

		return uv1()
	end,
	IsCfgHeroPass = function (slot0)
		for slot4, slot5 in ipairs(slot0.stage_list) do
			if not ActivityHeroEnhanceData:IsStageClear(slot0.activity_id, slot5) then
				return false
			end
		end

		return true
	end,
	IsCfgHeroLock = function (slot0)
		if ActivityHeroEnhanceData:GetDay(slot0.activity_id) < slot0.start_day then
			return true, {
				isBeforeStartDay = true,
				curDay = slot1,
				startDay = slot0.start_day
			}
		end

		if uv0.GetTutorialCfg(slot0.activity_id).id == slot0.id then
			return false
		end

		if not uv0.IsCfgHeroPass(slot2) then
			return true, {
				isTutorialNotPass = true
			}
		end

		return false
	end,
	GetTalentLockConditionId = function (slot0, slot1, slot2)
		for slot7, slot8 in ipairs(TalentTreeCfg[slot1].unlock_condition) do
			if ConditionCfg[slot8].type == 11401 then
				if not ActivityHeroEnhanceData:IsStageClear(slot0, slot9.params[1]) then
					return slot8
				end
			elseif slot10 == 11400 and not slot2 and uv0(slot0, slot1, slot9.params[1]) then
				return slot8
			end
		end

		return nil
	end,
	IsTalentLock = function (slot0, slot1, slot2)
		if uv0.GetTalentLockConditionId(slot0, slot1, slot2) ~= nil then
			return true
		end

		if not slot2 and uv1(slot0, slot1, TalentTreeCfg[slot1].stage - 1) then
			return true
		end

		return false
	end,
	IsCfgTalentStageLock = function (slot0, slot1, slot2)
		for slot7, slot8 in ipairs(uv0.GetCfgTalentListByStage(slot0, slot1)) do
			if not uv0.IsTalentLock(slot0.activity_id, slot8, slot2) then
				return false
			end
		end

		return true
	end,
	IsCfgTalentStageFirstCanAdd = function (slot0, slot1)
		if ActivityHeroEnhanceTools.GetCfgActivatedTalentDict(slot0)[slot1] then
			return false
		end

		slot3 = uv0.IsCfgTalentStageLock(slot0, slot1, true)

		if slot1 == 1 then
			return not slot3
		end

		return not slot3 and slot2[slot1 - 1] ~= nil
	end,
	GetTalentListActivatedIdx = function (slot0, slot1)
		if slot1 == nil then
			return -1
		end

		for slot5, slot6 in ipairs(slot1) do
			if ActivityHeroEnhanceData:IsTalentActivated(slot0, slot6) then
				return slot5
			end
		end

		return -1
	end,
	IsCfgStageUnlock = function (slot0, slot1)
		slot2 = nil

		for slot6, slot7 in ipairs(slot0.stage_list) do
			if table.indexof(BattleHeroEnhanceCfg[slot7].next_unlock_id_list, slot1) then
				if ActivityHeroEnhanceData:IsStageClear(slot0.activity_id, slot7) then
					return true
				end

				slot2 = slot7
			end
		end

		if slot2 == nil then
			return true
		end

		return false
	end,
	GetCfgTalentMaxStage = function (slot0)
		return 4
	end
}
