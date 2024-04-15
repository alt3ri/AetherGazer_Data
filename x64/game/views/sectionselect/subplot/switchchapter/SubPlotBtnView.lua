slot0 = class("SubPlotBtnView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")

	slot0:SetData(slot3)
	slot0:RefreshItem()
	slot0:Show(true)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPoint(slot0.chapterID_)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.btn_ = nil
	slot0.gameObject_ = nil
	slot0.text_ = nil
	slot0.canvasGroup_ = nil
	slot0.unsubscribeFun = nil
	slot0.selector_ = nil
	slot0.lockGo_ = nil
end

function slot0.SetData(slot0, slot1)
	slot0:UnBindRedPoint(slot0.chapterID_)
	slot0:BindRedPoint(slot1)

	slot0.chapterID_ = slot1

	slot0:RefreshItem()
	slot0:Show(true)
	slot0:AddTimer()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ChapterTools.IsUnlockChapter(uv0.chapterID_) then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ChapterCfg[uv0.chapterID_].activity_id).startTime)))

			return
		end

		if table.keyof(getChapterClientCfgByChapterID(uv0.chapterID_).chapter_list, uv0.chapterID_) > 1 and not ChapterTools.IsClearChapter(slot0.chapter_list[slot1 - 1]) then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", ChapterCfg[slot2].subhead))

			return
		end

		BattleStageAction.ClickSubPlot(uv0.chapterID_)
		manager.notify:Invoke(CHANGE_CHAPTER, uv0.chapterID_)
	end)
end

function slot0.BindRedPoint(slot0, slot1)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot1))
end

function slot0.UnBindRedPoint(slot0, slot1)
	if slot1 then
		manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot1))
	end
end

function slot0.RefreshItem(slot0)
	slot0.text_.text = GetI18NText(ChapterCfg[slot0.chapterID_].subhead)
	slot0.text2_.text = GetI18NText(ChapterCfg[slot0.chapterID_].subhead)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	if table.keyof(getChapterClientCfgByChapterID(slot0.chapterID_).chapter_list, slot0.chapterID_) > 1 and not ChapterTools.IsClearChapter(slot1.chapter_list[slot2 - 1]) then
		slot0.lockController_:SetSelectedState("off")

		return
	end

	if ActivityData:GetActivityData(ChapterCfg[slot0.chapterID_].activity_id).startTime <= manager.time:GetServerTime() then
		slot0.lockController_:SetSelectedState("on")

		return
	end

	slot0.lockController_:SetSelectedState("off")

	slot0.timer_ = Timer.New(function ()
		if uv0.startTime <= manager.time:GetServerTime() then
			uv1.lockController_:SetSelectedState("on")
			uv1:StopTimer()

			return
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
