slot0 = class("ChapterPlot19MapView", ReduxView)
slot0.SCALE_VALUE = 1.2

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.mapItemList_ = {}
	slot0.locationViewList_ = {}
	slot0.clueViewList_ = {}
	slot0.chapterMapScrollView_ = ChapterMapScrollView.New(slot0, slot1)
	slot0.chapterSelectLocationHandler_ = handler(slot0, slot0.ChapterSelectLocation)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(CHAPTER_SELECT_LOCATION, slot0.chapterSelectLocationHandler_)

	if slot0:GetBackCnt() > 0 then
		slot0.scrollViewTf_.localScale = Vector3(uv0.SCALE_VALUE, uv0.SCALE_VALUE, 1)

		slot0:ChapterSelectLocation()
	else
		slot0.scrollViewTf_.localScale = Vector3(1, 1, 1)

		slot0:RefreshItemSelectState(false)
	end
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(CHAPTER_SELECT_LOCATION, slot0.chapterSelectLocationHandler_)
	slot0.chapterMapScrollView_:OnExit()
end

function slot0.OnUpdate(slot0)
	for slot4, slot5 in pairs(slot0.locationViewList_) do
		if not slot5:IsDisabled() then
			slot5:OnUpdate()
		end
	end

	for slot4, slot5 in pairs(slot0.clueViewList_) do
		if not slot5:IsDisabled() then
			slot5:OnUpdate()
		end
	end

	slot0:ScaleMap()
end

function slot0.Dispose(slot0)
	slot0.chapterSelectLocationHandler_ = nil

	for slot4, slot5 in pairs(slot0.mapItemList_) do
		slot5:Dispose()
	end

	slot0.mapItemList_ = nil

	for slot4, slot5 in pairs(slot0.locationViewList_) do
		slot5:Dispose()
	end

	slot0.locationViewList_ = nil

	for slot4, slot5 in pairs(slot0.clueViewList_) do
		slot5:Dispose()
	end

	slot0.clueViewList_ = nil

	slot0.chapterMapScrollView_:Dispose()

	slot0.chapterMapScrollView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
end

function slot0.SetMapID(slot0, slot1, slot2, slot3)
	slot0.chapterID_ = slot1
	slot0.mapID_ = slot2

	if not slot0.mapItemList_[ChapterMapCfg[slot0.mapID_].map_prefab] then
		slot0.mapItemList_[slot5] = ChapterPlot19MapItem.New(slot5, slot0.mapParentTf_)
	end

	for slot9, slot10 in pairs(slot0.mapItemList_) do
		slot10:Show(slot9 == slot5)
	end

	slot0.mapItemList_[slot5]:SetSelectState(ChapterTools.GetChapter19MapState(slot2))
	slot0.mapItemList_[slot5]:PlayAnimator(slot3)

	if ChapterTools.IsNeedShowFog() then
		slot0:ShowFog(true)
	else
		slot0:ShowFog(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.mapParentTf_)

	slot6 = {}
	slot7 = {}

	for slot11, slot12 in ipairs(ChapterMapCfg[slot0.mapID_].location_list) do
		if ChapterLocationCfg[slot12].type == BattleConst.LOCATION_TYPE.BUILDING then
			table.insert(slot6, slot12)
		else
			table.insert(slot7, slot12)
		end
	end

	for slot11, slot12 in ipairs(slot6) do
		if slot0.locationViewList_[slot11] == nil then
			slot0.locationViewList_[slot11] = ChapterPlot19MapNormalLocation.New(slot0.stageItem_, slot0.itemParent_)
		end

		slot0.locationViewList_[slot11]:SetLocationID(slot0.chapterID_, slot2, slot12)
	end

	for slot11 = #slot6 + 1, #slot0.locationViewList_ do
		slot0.locationViewList_[slot11]:Disabled()
	end

	for slot11, slot12 in ipairs(slot7) do
		if slot0.clueViewList_[slot11] == nil then
			slot0.clueViewList_[slot11] = ChapterPlot19MapClueLocation.New(slot0.clueItem_, slot0.itemParent_)
		end

		slot0.clueViewList_[slot11]:SetLocationID(slot0.chapterID_, slot2, slot12)
	end

	for slot11 = #slot7 + 1, #slot0.clueViewList_ do
		slot0.clueViewList_[slot11]:Disabled()
	end
end

function slot0.ChapterSelectLocation(slot0)
	if BattleFieldData:GetChapterLocationID(slot0.chapterID_) == nil then
		return
	end

	slot4 = slot0.viewPortRect_.rect.width / 2
	slot6 = slot0.contentRect_.rect.width / 2

	if slot0.viewPortRect_.rect.height / 2 > (slot0.contentRect_.rect.height / 2 - math.abs(ChapterLocationCfg[slot1].position[2])) * uv0.SCALE_VALUE and slot3 <= slot5 and slot7 ~= 0 then
		slot7 = (slot5 * uv0.SCALE_VALUE - slot3) / uv0.SCALE_VALUE * math.abs(slot7) / slot7
	end

	if slot4 > (slot6 - math.abs(slot2[1] + 200)) * uv0.SCALE_VALUE and slot4 <= slot6 and slot8 ~= 0 and math.abs(slot8) / slot8 < 0 then
		slot8 = (slot6 * uv0.SCALE_VALUE - slot4) / uv0.SCALE_VALUE * math.abs(slot8) / slot8
	end

	slot0.chapterMapScrollView_:ScrollToPosition(Vector3(slot8, slot7, 0))
	slot0:RefreshItemSelectState(true)
end

function slot0.ResetMapPosition(slot0)
	slot0.scrollView_.normalizedPosition = Vector2(0.5, 0.5)
end

function slot0.RefreshItemSelectState(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.locationViewList_) do
		slot6:RefreshSelectState(slot1)
	end

	for slot5, slot6 in ipairs(slot0.clueViewList_) do
		slot6:RefreshSelectState(slot1)
	end
end

function slot0.ScaleMap(slot0)
	if slot0:GetBackCnt() > 0 then
		slot0:CancelTween()
		LeanTween.scale(slot0.scrollViewTf_, Vector3(uv0.SCALE_VALUE, uv0.SCALE_VALUE, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
		slot0:ChapterSelectLocation()
	else
		slot0.chapterMapScrollView_:EnabledScroll(true)
		slot0:CancelTween()
		LeanTween.scale(slot0.scrollViewTf_, Vector3(1, 1, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
		slot0:RefreshItemSelectState(false)
	end
end

function slot0.CancelTween(slot0)
	if slot0.leanTween_ then
		LeanTween.cancel(slot0.scrollViewTf_)

		slot0.leanTween_ = nil
	end
end

function slot0.ShowFog(slot0, slot1)
	slot4 = slot0.mapItemList_[ChapterMapCfg[slot0.mapID_].map_prefab]

	if slot1 == false and ChapterTools.NeedPlayFogAnimator() then
		slot4:SetFogState(true)
		slot4:SetLineState(true)
		BattleStageData:SaveFogAnimatorFlag(true)
		slot4:PlayFogAnimator()
	else
		slot4:SetFogState(slot1)
		slot4:SetLineState(slot1)
	end
end

function slot0.GetBackCnt(slot0)
	if slot0:IsOpenRoute("chapterPlot19MapLocationInfo") then
		slot1 = 0 + 1
	end

	if slot0:IsOpenRoute("chapter19SectionInfo") then
		slot1 = slot1 + 1
	end

	return slot1
end

return slot0
