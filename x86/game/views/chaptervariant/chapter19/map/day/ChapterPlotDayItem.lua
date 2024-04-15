slot0 = class("ChapterPlotDayItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.chapterID_ = slot3
	slot0.day_ = slot4

	slot0:BindCfgUI()
	slot0:BindCfgUI()
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateController_ = slot0.controllerEx_:GetController("state")
	slot0.dayImageController_ = slot0.controllerEx_:GetController("default1")
	slot0.newDayController_ = slot0.controllerEx_:GetController("newDay")

	slot0:Show(true)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.timeLock_ then
			ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[uv0.chapterID_][uv0.day_][1]].activity_id).startTime)))

			return
		end

		if uv0.isLock_ then
			slot0 = ChapterTools.GetChapterDayList(uv0.chapterID_)

			if ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[uv0.chapterID_][slot0[table.keyof(slot0, uv0.day_) - 1]][1]].name == "" then
				ShowTips(string.format(GetTips("CLEAR_DAY_ALL_STAGE_THEN_UNLOCK"), slot2))
			else
				ShowTips(string.format(GetTips("CLEAR_DAY_ALL_STAGE_THEN_UNLOCK_2"), slot4.name))
			end

			return
		end

		if not BattleStageData:GetOperateChapterDay(uv0.chapterID_, uv0.day_) then
			BattleStageAction.OperateChapterDay(uv0.chapterID_, uv0.day_, function ()
				BattleFieldData:SaveChapterMapDay(uv0.chapterID_, uv0.day_)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
			end)
		else
			BattleFieldData:SaveChapterMapDay(uv0.chapterID_, uv0.day_)
			manager.notify:Invoke(CHAPTER_DAY_CHANGED)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.day_ = slot1
	slot0.selectDay_ = slot2
	slot0.isLock_ = not ChapterTools.IsClearPreChapterDayAllStage(slot0.chapterID_, slot1)

	if table.keyof(ChapterTools.GetChapterDayList(slot0.chapterID_), slot1) == 2 and ChapterTools.IsNeedOperateFirstDayWatch(slot0.chapterID_, slot3[1]) then
		slot0.isLock_ = true
	end

	if ChapterTools.IsLastDay(slot0.chapterID_, slot1) and not BattleStageData:GetOperateChapterDay(slot0.chapterID_, slot1) then
		slot0.isLock_ = true
	end

	slot0.timeLock_ = ActivityTools.GetActivityStatus(ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[slot0.chapterID_][slot1][1]].activity_id) == 0

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[slot0.chapterID_][slot0.day_][1]].icon_id ~= "" then
		slot0.dayImage_.sprite = getSprite("Atlas/OperationAtlas", slot2.icon_id)

		slot0.dayImageController_:SetSelectedState("image")
	else
		slot0.dayText_.text = string.format("%s", slot0.day_)

		slot0.dayImageController_:SetSelectedState("num")
	end

	if slot0.selectDay_ == slot0.day_ then
		slot0.stateController_:SetSelectedState("select")
	elseif slot0.isLock_ or slot0.timeLock_ then
		slot0.stateController_:SetSelectedState("lock")
	else
		slot0.stateController_:SetSelectedState("unlock")
	end

	slot0:RefreshGuild()
	slot0:AddTimer()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.RefreshGuild(slot0)
	if ChapterTools.IsNeedGuildDay(slot0.chapterID_, slot0.day_) then
		slot0.newDayController_:SetSelectedState("true")
	else
		slot0.newDayController_:SetSelectedState("false")
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	if slot0.timeLock_ then
		slot3 = ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[slot0.chapterID_][slot0.day_][1]].activity_id
		slot0.timer_ = Timer.New(function ()
			if ActivityData:GetActivityData(uv0) and slot0.startTime <= manager.time:GetServerTime() then
				uv1.timeLock_ = false

				uv1:RefreshUI()
				uv1:StopTimer()
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
