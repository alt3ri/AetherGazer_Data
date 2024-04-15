slot0 = class("DailySectionInfoView", import("..SectionInfoMultipleBaseView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideStageDescController_:SetSelectedState("false")
	slot0.hideDropPanelController_:SetSelectedState("false")
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.stageID_,
		multiple = slot0.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY
	})
end

function slot0.RefreshData(slot0)
	slot1 = BattleDailyStageCfg[slot0.stageID_]
	slot0.cost_ = slot1.cost
	slot0.dropLibID_ = slot1.drop_lib_id
	slot0.isFirstClear_ = false

	slot0:RefreshLock()
	uv0.super.RefreshData(slot0)
end

function slot0.RefreshLock(slot0)
	BattleFieldData:SetCacheStage(getChapterAndSectionID(slot0.stageID_), slot0.stageID_)

	slot0.lock_ = PlayerData:GetPlayerInfo().userLevel < BattleDailyStageCfg[slot0.stageID_].level
	slot0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1.level)

	if slot0.lock_ then
		return
	end

	slot3 = BattleStageData:GetStageData()

	for slot7, slot8 in pairs(slot1.pre_unlock_id_list or {}) do
		if slot3[slot8] == nil or slot3[slot8] and slot3[slot8].clear_times <= 0 then
			slot0.lock_ = true
			slot9, slot10 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY, slot8)
			slot0.lockTips_ = string.format(GetTips("ACTIVITY_RACE_UNLOCK"), string.format("%s-%s", GetI18NText(slot9), GetI18NText(slot10)))

			return
		end
	end

	slot0.lock_ = false
end

function slot0.RefreshStageInfo(slot0)
	uv0.super.RefreshStageInfo(slot0)

	slot0.storyText_.text = GetI18NText(BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).tips)
end

return slot0
