slot1 = class("SummerSeabedStoryRemasterdView", import("game.views.activity.Submodule.storyStage.summer.stage.seabed.SummerStageSeabedView"))

function slot1.GetStageItemClass(slot0)
	return SummerSeabedStoryRemasteredItem
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "active")

	slot0.controller_:SetSelectedState("off")
end

function slot1.RefreshData(slot0)
	if slot0.params_.chapterID == nil then
		slot0.chapterID_ = BattleFieldData:GetCacheChapter(ChapterClientCfg[slot0.params_.chapterClientID].id)
	else
		slot0.chapterID_ = slot0.params_.chapterID
	end

	slot0.stageData_ = BattleStageData:GetStageData()
	slot0.stageList_ = ChapterCfg[slot0.chapterID_].section_id_list
end

function slot1.RefreshUI(slot0)
	slot0.selectStageID_ = BattleFieldData:GetCacheStage(slot0.chapterID_) or ChapterCfg[slot1].section_id_list[1]

	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
	slot0:RefreshSelectItem()
end

function slot1.RefreshStageList(slot0)
	for slot4 = 1, #slot0.stageItem_ do
		slot0.stageItem_[slot4]:Show(false)
	end

	for slot5 = 1, #slot0.stageList_ do
		if slot5 == 1 or BattleStageData:GetStageData()[slot0.stageList_[slot5]] then
			if not slot0.stageItem_[slot5] then
				slot0.stageItem_[slot5] = slot0:GetStageItemClass().New(slot0.itemGo_, slot0.content_)
			end

			slot0.stageItem_[slot5]:SetData(slot0.stageList_[slot5], slot0.chapterID_)
		end
	end
end

return slot1
