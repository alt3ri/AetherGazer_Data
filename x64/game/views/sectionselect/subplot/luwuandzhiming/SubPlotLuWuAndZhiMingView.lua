SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")
slot0 = class("SubPlotLuWuAndZhiMingView", SubPlotBaseView)

function slot0.UIName(slot0)
	return "UI/BranchlineUI/IndiaChapterSectionUI"
end

function slot0.GetItemClass(slot0)
	return SubPlotLuWuAndZhiMingItem
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.chapterPartBtnView_ = ChapterPartBtnView.New(slot0.chapterBranchGo_)

	slot0.chapterPartBtnView_:Show(true)

	slot0.lineList_ = {}
	slot0.itemWidth_ = slot0.sectionItem_.transform:GetComponent("RectTransform").rect.width
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.chapterPartBtnView_:OnEnter()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0.chapterPartBtnView_:OnExit()
end

function slot0.RefreshData(slot0)
	uv0.super.RefreshData(slot0)

	slot0.openStageList_ = ChapterTools.GetOpenStageList(slot0.chapterID_, slot0:GetCfgName())
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)

	slot0.titleText_.text = ChapterCfg[slot0.chapterID_].subhead

	slot0.chapterPartBtnView_:RefreshUI(slot0.chapterID_)
	slot0:RefreshLineItemList()
	slot0:SwitchBG()
end

function slot0.RefreshLineItemList(slot0)
	for slot4, slot5 in pairs(slot0.lineList_) do
		slot5:Show(false)
	end

	slot1 = 1

	for slot6, slot7 in ipairs(slot0.openStageList_) do
		slot9 = slot0.stageItemList_[table.keyof(slot0.stageList_, slot7)]:GetLocalPosition() + Vector3(slot0.itemWidth_ / -2, 0, 0)
		slot11 = #(slot0:GetCfgName()[slot7].pre_show_id_list or {}) > 1

		for slot15, slot16 in ipairs(slot10) do
			if not slot0.stageData_[slot16] or slot0.stageData_[slot16].clear_times <= 0 then
				slot11 = false

				break
			end
		end

		for slot15, slot16 in ipairs(slot10) do
			slot17 = slot0:GetCfgName()[slot7]

			if table.keyof(slot2, slot16) then
				slot20 = slot0.lineList_[slot1] or SectionSingleLineItem.New(slot0.lineGo_, slot0.content_, 11)

				slot20:Show(true)

				slot0.lineList_[slot1] = slot20

				slot20:RefreshUI(slot0.stageItemList_[table.keyof(slot0.stageList_, slot16)]:GetLocalPosition() + Vector3(slot0.itemWidth_ / 2, 0, 0), slot9)

				slot1 = slot1 + 1
			end
		end
	end
end

function slot0.Dispose(slot0)
	slot0.chapterPartBtnView_:Dispose()

	slot0.chapterPartBtnView_ = nil

	for slot4, slot5 in pairs(slot0.lineList_) do
		slot5:Dispose()
	end

	slot0.lineList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
