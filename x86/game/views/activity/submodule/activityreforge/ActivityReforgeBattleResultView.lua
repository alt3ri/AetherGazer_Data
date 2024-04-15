slot0 = class("ActivityReforgeBattleResultView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeBattleResultUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.timeInfoItem_ = ActivityReforgeBattleResultItem.New(slot0.timeInfoGo_)
	slot0.pointInfoItem_ = ActivityReforgeBattleResultItem.New(slot0.pointInfoGo_)
	slot0.goldInfoItem_ = ActivityReforgeBattleResultItem.New(slot0.goldInfoGo_)
	slot0.controller_ = slot0.controllerEx_:GetController("levelIndex")
end

function slot0.OnEnter(slot0)
	slot0.IsBattleBack_ = slot0.params_.IsBattleBack
	slot0.chapterActivityID_ = slot0.params_.chapterActivityID
	slot0.levelID_ = slot0.params_.levelID

	slot0.controller_:SetSelectedState(table.indexof(ActivityReforgeChapterCfg[slot0.chapterActivityID_].level_list, slot0.levelID_))

	slot0.levelName_.text = ActivityReforgeLevelCfg[slot0.levelID_].name
	slot2 = ActivityReforgeGameSettingCfg[slot0.params_.activityID].bar_num_min
	slot3 = ActivityReforgeData:GetCurFinishLevelServerData()
	slot4 = ActivityReforgeData:GetLevelAllPlayerServerData(slot0.levelID_)

	ActivityReforgeData:FinishLevel(slot0.chapterActivityID_, slot0.levelID_, slot3)
	slot0.timeInfoItem_:SetData(1, slot2, slot0.levelID_, slot3.minUseSeconds, slot4.minUseSeconds.rangeValue, slot4.minUseSeconds.rangeLength)
	slot0.pointInfoItem_:SetData(2, slot2, slot0.levelID_, slot3.minLosePoint, slot4.minLosePoint.rangeValue, slot4.minLosePoint.rangeLength)
	slot0.goldInfoItem_:SetData(3, slot2, slot0.levelID_, slot3.minUseGold, slot4.minUseGold.rangeValue, slot4.minUseGold.rangeLength)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		ActivityReforgeData:ClearCurLevelData()

		if uv0.IsBattleBack_ then
			BattleInstance.QuitBattle(uv0.params_.stageData)
		else
			JumpTools.OpenPageByJump("/activityReforgeLevelView", {
				activityID = uv0.params_.activityID,
				chapterActivityID = uv0.params_.chapterActivityID
			})
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.timeInfoItem_:Dispose()
	slot0.pointInfoItem_:Dispose()
	slot0.goldInfoItem_:Dispose()

	slot0.timeInfoItem_ = nil
	slot0.pointInfoItem_ = nil
	slot0.goldInfoItem_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
