slot1 = class("ChapterSectionItem", import("game.views.sectionSelect.SectionBaseItem"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.hasTipsController_ = slot0.controllerEx_:GetController("hasTipsText")
end

function slot1.RefreshStar(slot0)
	if #BattleChapterStageCfg[slot0.stageID_].three_star_need == 1 then
		for slot6 = 1, 3 do
			slot0.threeStarBarList_[slot6]:SetData(slot0.starCnt_ >= 1)
		end
	else
		for slot6 = 1, 3 do
			slot0.threeStarBarList_[slot6]:SetData(slot6 <= slot0.starCnt_)
		end
	end
end

function slot1.GetTag(slot0)
	return BattleChapterStageCfg[slot0.stageID_] and slot1.tag or 0
end

function slot1.GetPosition(slot0)
	return BattleChapterStageCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot1.RefreshData(slot0)
	slot2 = BattleStageData:GetStageData()[slot0.stageID_]
	slot4 = PlayerData:GetPlayerInfo().userLevel
	slot5 = BattleChapterStageCfg[slot0.stageID_].level

	if ActivityData:GetActivityIsOpen(ChapterCfg[slot0.chapterID_].activity_id) then
		slot0.enoughLevel_ = true
	else
		slot0.enoughLevel_ = slot5 <= slot4
	end

	if slot2 then
		slot0.isLock_ = false
		slot0.clearTimes_ = slot2.clear_times

		for slot10, slot11 in ipairs(slot2.stars) do
			if slot11 > 0 then
				slot6 = 0 + 1
			end
		end

		slot0.starCnt_ = slot6
	elseif table.keyof(slot3.section_id_list, slot0.stageID_) == 1 then
		slot0.isLock_ = false
		slot0.clearTimes_ = 0
		slot0.starCnt_ = 0
	elseif slot0:IsUnlockPreStage() then
		slot0.isLock_ = false
		slot0.enoughLevel_ = false
		slot0.clearTimes_ = 0
		slot0.starCnt_ = 0
	else
		slot0.isLock_ = true
		slot0.clearTimes_ = -1
		slot0.starCnt_ = 0
	end

	if slot0.stageID_ == GameSetting.travel_skuld_new_ending_stage_id.value[1] and slot0.clearTimes_ < 1 then
		slot0.isLock_ = true
	end
end

function slot1.IsUnlockPreStage(slot0)
	slot1 = BattleStageData:GetStageData()

	if BattleChapterStageCfg[slot0.stageID_].pre_show_id_list == nil then
		print(string.format("关卡 %s 未配置前置关卡", slot0.stageID_))

		return true
	end

	for slot6, slot7 in pairs(slot2.pre_show_id_list) do
		if slot1[slot7] and slot1[slot7].clear_times > 0 then
			return true
		end
	end

	return false
end

function slot1.OnClick(slot0)
	if not slot0.isLock_ then
		slot0:Go("chapterSectionInfo", {
			section = slot0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
		})
	end
end

function slot1.RefreshText(slot0)
	slot1, slot2 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0.stageID_)
	slot0.text_.text = string.format("%s-%s", GetI18NText(slot1), GetI18NText(slot2))

	if BattleChapterStageCfg[slot0.stageID_].line_text == "" then
		slot0.hasTipsController_:SetSelectedState("false")
	else
		slot0.lineText_.text = GetI18NText(slot3.line_text)

		slot0.hasTipsController_:SetSelectedState("true")
	end
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("chapterSectionInfo")
end

return slot1
