slot0 = class("Chapter19SectionInfoView", import("..SectionInfoBaseView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideStageNumController_:SetSelectedState("true")
	slot0.hideStageDescController_:SetSelectedState("false")
	slot0.hideDropPanelController_:SetSelectedState("true")
	slot0.showTipsController_:SetSelectedState("true")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.RefreshData(slot0)
	uv0.super.RefreshData(slot0)

	slot0.dropLibID_ = BattleChapterStageCfg[slot0.stageID_].drop_lib_id

	if BattleStageData:GetStageData()[slot0.stageID_] then
		slot0.isFirstClear_ = slot2.clear_times <= 0
	else
		slot0.isFirstClear_ = true
	end

	if slot0.isFirstClear_ then
		slot0.cost_ = slot1.cost or 0
	else
		slot0.cost_ = 0
	end

	slot0:RefreshLock()
end

function slot0.RefreshLock(slot0)
	slot1 = BattleChapterStageCfg[slot0.stageID_]
	slot2 = getChapterAndSectionID(slot0.stageID_)

	BattleFieldData:SetCacheStage(slot2, slot0.stageID_)

	if ActivityData:GetActivityIsOpen(ChapterCfg[slot2].activity_id) then
		slot0.lock_ = false
	else
		slot0.lock_ = PlayerData:GetPlayerInfo().userLevel < slot1.level
		slot0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1.level)

		if slot0.lock_ then
			return
		end
	end

	slot3 = BattleStageData:GetStageData()

	for slot7, slot8 in pairs(slot1.pre_unlock_id_list or {}) do
		if slot3[slot8] == nil or slot3[slot8] and slot3[slot8].clear_times <= 0 then
			slot0.lock_ = true
			slot11, slot12 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot8).toggle, slot8)
			slot0.lockTips_ = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot8), GetI18NText(slot11), GetI18NText(slot12))

			return
		end
	end

	slot0.lock_ = false
end

function slot0.RefreshStageInfo(slot0)
	uv0.super.RefreshStageInfo(slot0)

	slot0.storyText_.text = GetI18NText(BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).tips)
end

function slot0.OnClickBtn(slot0)
	ChapterTools.DoReadyBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0.stageID_)
end

return slot0
