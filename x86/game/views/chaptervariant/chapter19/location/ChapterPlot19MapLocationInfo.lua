slot0 = class("ChapterPlot19MapLocationInfo", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/ChapterVerStageListInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.titleView_ = ChapterPlot19MapLocationTitleItem.New(slot0.titleItem_)
	slot0.eventTitleView_ = ChapterPlot19MapLocationTitleItem.New(slot0.eventTitleItem_)
	slot0.finishTitleView_ = ChapterPlot19MapLocationTitleItem.New(slot0.finishTitleItem_)
	slot0.stageItemList_ = {}
end

function slot0.OnEnter(slot0)
	slot0:SetData()
	slot0:RefreshUI()
end

function slot0.SetData(slot0)
	slot0.chapterID_ = slot0.params_.chapterID
	slot0.locationID_ = slot0.params_.locationID
end

function slot0.OnUpdate(slot0)
	slot0:SetData()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.titleView_:Dispose()

	slot0.titleView_ = nil

	slot0.eventTitleView_:Dispose()

	slot0.eventTitleView_ = nil

	slot0.finishTitleView_:Dispose()

	slot0.finishTitleView_ = nil

	for slot4, slot5 in ipairs(slot0.stageItemList_) do
		slot5:Dispose()
	end

	slot0.stageItemList_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = ChapterLocationCfg[slot0.locationID_].name
	slot2, slot3, slot4 = slot0:GetSortStageList()

	if #slot2 > 0 then
		slot0.titleView_:Show(true)
	else
		slot0.titleView_:Show(false)
	end

	for slot8, slot9 in ipairs(slot2) do
		slot0.stageItemList_[slot8] = slot0.stageItemList_[slot8] or ChapterPlot19MapLocationStageItem.New(slot0.stageItem_, slot0.parentGo_)

		slot0.stageItemList_[slot8]:SetData(slot0.chapterID_, slot9)
	end

	if #slot3 > 0 then
		slot0.eventTitleView_:Show(true)
	else
		slot0.eventTitleView_:Show(false)
	end

	for slot8, slot9 in ipairs(slot3) do
		slot0.stageItemList_[slot10] = slot0.stageItemList_[slot8 + #slot2] or ChapterPlot19MapLocationStageItem.New(slot0.stageItem_, slot0.parentGo_)

		slot0.stageItemList_[slot10]:SetData(slot0.chapterID_, slot9)
	end

	if #slot4 > 0 then
		slot0.finishTitleView_:Show(true)
	else
		slot0.finishTitleView_:Show(false)
	end

	for slot8, slot9 in ipairs(slot4) do
		slot0.stageItemList_[slot10] = slot0.stageItemList_[slot8 + #slot2 + #slot3] or ChapterPlot19MapLocationStageItem.New(slot0.stageItem_, slot0.parentGo_)

		slot0.stageItemList_[slot10]:SetData(slot0.chapterID_, slot9)
	end

	for slot8 = #slot2 + #slot3 + #slot4 + 1, #slot0.stageItemList_ do
		slot0.stageItemList_[slot8]:Show(false)
	end
end

function slot0.OnTop(slot0)
	slot0:Show(true)
end

function slot0.OnBehind(slot0)
	slot0:Show(false)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObjet_, slot1)
end

function slot0.GetSortStageList(slot0)
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in ipairs(ChapterLocationCfg[slot0.locationID_].stage_list) do
		if BattleStageData:GetStageData()[slot9] and slot10.clear_times > 0 then
			table.insert({}, {
				id = slot9,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY
			})
		elseif slot10 then
			table.insert(slot2, {
				id = slot9,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY
			})
		end
	end

	for slot8, slot9 in ipairs(slot1.sub_stage_list) do
		if BattleStageData:GetStageData()[slot9] and slot10.clear_times > 0 then
			table.insert(slot4, {
				id = slot9,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.SIDE_STORY
			})
		elseif slot10 then
			table.insert(slot2, {
				id = slot9,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.SIDE_STORY
			})
		end
	end

	for slot8, slot9 in ipairs(slot1.event_list) do
		if BattleStageData:HasReadLocationEvent(slot9) then
			table.insert(slot4, {
				id = slot9,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.EVENT
			})
		elseif ChapterTools.IsUnlockEvent(slot9) then
			table.insert(slot3, {
				id = slot9,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.EVENT
			})
		end
	end

	return slot2, slot3, slot4
end

return slot0
