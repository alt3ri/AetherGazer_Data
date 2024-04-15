slot0 = class("SubPlotSectionInfoView", import("..SectionInfoBaseView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideStageNumController_:SetSelectedState("true")
	slot0.hideStageDescController_:SetSelectedState("false")
	slot0.hideDropPanelController_:SetSelectedState("false")
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnClickBtn(slot0)
	slot2 = BattleActivityStoryStageCfg[slot0.stageID_]

	if StageTools.NeedShowContinueBattleWindow(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT, slot0.stageID_) then
		JumpTools.OpenPopUp("continueBattleCostPop", {
			stageType = slot1,
			stageID = slot0.stageID_,
			callback = function ()
				ChapterTools.DoReadyBattle(uv0, uv1.stageID_)
			end
		})
	else
		ChapterTools.DoReadyBattle(slot1, slot0.stageID_)
	end
end

function slot0.RefreshData(slot0)
	slot0.lock_ = PlayerData:GetPlayerInfo().userLevel < BattleActivityStoryStageCfg[slot0.stageID_].level
	slot0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1.level)

	if ChapterCfg[slot0.params_.chapterID].activity_id ~= 0 then
		if ActivityData:GetActivityData(slot3).startTime < manager.time:GetServerTime() and slot5 <= slot4.stopTime then
			slot0.dropLibID_ = slot1.drop_lib_id_list[1]
		else
			slot0.dropLibID_ = slot1.drop_lib_id_list[2]
		end
	else
		slot0.dropLibID_ = slot1.drop_lib_id_list[2]
	end

	if BattleStageData:GetStageData()[slot0.stageID_] then
		slot0.isFirstClear_ = slot4.clear_times <= 0
	else
		slot0.isFirstClear_ = true
	end

	if slot0.isFirstClear_ then
		if type(BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).extra_cost) == "table" and slot5.extra_cost[1] then
			slot0.cost_ = slot5.extra_cost[2] or 0
		else
			slot0.cost_ = slot5.cost or 0
		end
	else
		slot0.cost_ = 0
	end

	BattleFieldData:SetCacheStage(getChapterAndSectionID(slot0.stageID_), slot0.stageID_)
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleActivityStoryStageCfg[slot0.stageID_].id then
		slot0.sectionText_.text = ""
		slot0.sectionName_.text = GetI18NText(slot1.name)
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.oldCfgID_ = slot1.id
		slot0.storyText_.text = GetI18NText(slot1.tips)
	end
end

return slot0
