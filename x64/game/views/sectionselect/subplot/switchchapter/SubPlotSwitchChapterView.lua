slot0 = class("SubPlotSwitchChapterView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterItemList_ = {}

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	BattleStageAction.ClickSubPlot(slot0.chapterID_)

	for slot4, slot5 in pairs(slot0.chapterItemList_) do
		slot5:OnEnter()
	end

	manager.redPoint:bindUIandKey(slot0.selectResourceBtn_.transform, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, getChapterClientCfgByChapterID(slot0.chapterID_).id))
end

function slot0.OnExit(slot0)
	slot0:StopTimer()

	slot4 = false

	SetActive(slot0.selectResourcePanel_, slot4)

	for slot4, slot5 in pairs(slot0.chapterItemList_) do
		slot5:OnExit()
	end

	manager.redPoint:unbindUIandKey(slot0.selectResourceBtn_.transform, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, getChapterClientCfgByChapterID(slot0.chapterID_).id))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.chapterItemList_) do
		slot5:Dispose()
	end

	slot0.chapterItemList_ = nil
end

function slot0.SetData(slot0, slot1)
	slot0.chapterID_ = slot1
end

function slot0.RefreshUI(slot0)
	slot0:RefreshChapterBtn()
	slot0:RefreshChapterItemBtn()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.selectResourceBtn_, nil, function ()
		SetActive(uv0.selectResourcePanel_, true)
		uv0:ClickListener()
	end)
end

function slot0.RefreshChapterItemBtn(slot0)
	slot0.selectResourceText_.text = GetI18NText(ChapterCfg[slot0.chapterID_].subhead)
end

function slot0.RefreshChapterBtn(slot0)
	slot3 = #getChapterClientCfgByChapterID(slot0.chapterID_).chapter_list > 1

	if slot1.id == 6010010 then
		slot3 = false
	end

	slot7 = slot3

	SetActive(slot0.gameObject_, slot7)

	for slot7, slot8 in pairs(slot2) do
		if slot0.chapterItemList_[slot7] then
			slot0.chapterItemList_[slot7]:SetData(slot8)
		else
			slot0.chapterItemList_[slot7] = SubPlotBtnView.New(slot0.selectResourceItem_, slot0.selectResourcePanel_, slot8)
		end
	end

	for slot7 = #slot2 + 1, #slot0.chapterItemList_ do
		slot0.chapterItemList_[slot7]:Show(false)
	end
end

function slot0.ClickListener(slot0)
	if not slot0.clickTimer_ then
		slot0.buttonUp_ = 0
		slot0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
			if Input.GetMouseButtonUp(0) then
				uv0.buttonUp_ = uv0.buttonUp_ + 1

				if uv0.buttonUp_ >= 2 then
					SetActive(uv0.selectResourcePanel_, false)
					FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

					uv0.clickTimer_ = nil
				end
			end
		end, -1, true)
	end
end

function slot0.StopTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

return slot0
