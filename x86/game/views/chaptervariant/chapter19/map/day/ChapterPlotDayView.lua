slot0 = class("ChapterPlotDayView", BaseView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.parentView_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.dayItemList_ = {}
	slot0.dayController_ = slot0.controllerEx_:GetController("dayList")
	slot0.guildController_ = slot0.controllerEx_:GetController("guildState")
	slot0.dayImageController_ = slot0.dayControllerEx_:GetController("default0")
	slot0.isExpandDay_ = false
end

function slot0.OnEnter(slot0)
	if ChapterTools.IsNeedExpandDay(slot0.chapterID_) then
		slot0.isExpandDay_ = true

		slot0:SwitchUI()
	end
end

function slot0.OnUpdate(slot0)
end

function slot0.OnExit(slot0)
	slot0.isExpandDay_ = false
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.dayItemList_) do
		slot5:Dispose()
	end

	slot0.dayItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.dayBtn_, nil, function ()
		if not uv0.parentView_:IsTop() then
			JumpTools:Back()

			return
		end

		uv0.isExpandDay_ = true

		uv0:SwitchUI()
	end)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0.isExpandDay_ = false

		uv0:SwitchUI()
		manager.notify:Invoke(CHAPTER_CLOSE_DAY_LIST)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.selectDay_ = slot1
	slot0.chapterID_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[slot0.chapterID_][slot0.selectDay_][1]].icon_id ~= "" then
		slot0.dayImage_.sprite = getSprite("Atlas/OperationAtlas", slot2.icon_id)

		slot0.dayImageController_:SetSelectedState("image")
	else
		slot0.selectDayText_.text = slot0.selectDay_

		slot0.dayImageController_:SetSelectedState("num")
	end

	if slot2.name ~= "" then
		slot0.dayBottomText_.text = slot2.name
	else
		slot0.dayBottomText_.text = GetTips("DATE")
	end

	slot0:SwitchUI()
	slot0:RefreshDayItemList()
end

function slot0.SwitchUI(slot0)
	slot0.dayController_:SetSelectedState(tostring(slot0.isExpandDay_))

	if slot0.isExpandDay_ then
		slot0.animator_:Play("dayList1")
	else
		slot0.animator_:Play("dayList2")
	end

	if ChapterTools.IsNeedExpandDay(slot0.chapterID_) then
		slot0.guildController_:SetSelectedState(tostring(true))
	else
		slot0.guildController_:SetSelectedState(tostring(false))
	end
end

function slot0.RefreshDayItemList(slot0)
	for slot5, slot6 in ipairs(ChapterTools.GetChapterDayList(slot0.chapterID_)) do
		if slot0.dayItemList_[slot6] == nil then
			slot0.dayItemList_[slot6] = ChapterPlotDayItem.New(slot0.dayItem_, slot0.dayParent_, slot0.chapterID_, slot6)
		end

		slot0.dayItemList_[slot6]:SetData(slot6, slot0.selectDay_)
	end
end

return slot0
