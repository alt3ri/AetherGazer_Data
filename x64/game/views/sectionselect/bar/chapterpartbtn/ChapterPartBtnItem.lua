slot0 = class("ChpaterPartBtnItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.choiceController_ = ControllerUtil.GetController(slot0.transform_, "choice")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPoint(slot0.chapterID_)

	slot0.chapterID_ = nil

	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.selectChapterID_ == uv0.chapterID_ then
			return
		end

		if uv0.toggleType_ == BattleConst.TOGGLE.PLOT then
			ChapterTools.GotoChapterSection(uv0.chapterID_)
		else
			JumpTools.Jump2SubPlotByChapterID(uv0.chapterID_)
		end
	end)
end

function slot0.SetChapterID(slot0, slot1, slot2)
	slot0.selectChapterID_ = slot2

	slot0:UnBindRedPoint(slot0.chapterID_)
	slot0:BindRedPoint(slot1)

	slot0.chapterID_ = slot1
	slot0.toggleType_ = getChapterClientCfgByChapterID(slot0.chapterID_).toggle

	slot0.choiceController_:SetSelectedState(tostring(slot1 == slot2))

	if slot3.id ~= ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 then
		slot0.nameText_.text = ChapterCfg[slot1].subhead
	end

	slot0:AddTimer()
end

function slot0.BindRedPoint(slot0, slot1)
	if slot0.toggleType_ == nil then
		slot0.toggleType_ = getChapterClientCfgByChapterID(slot1).toggle
	end

	if slot0.toggleType_ == BattleConst.TOGGLE.PLOT then
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot1))
	else
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot1))
	end
end

function slot0.UnBindRedPoint(slot0, slot1)
	if slot1 then
		if slot0.toggleType_ == BattleConst.TOGGLE.PLOT then
			manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot1))
		else
			manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot1))
		end
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	if table.keyof(getChapterClientCfgByChapterID(slot0.chapterID_).chapter_list, slot0.chapterID_) > 1 and not ChapterTools.IsClearChapter(slot1.chapter_list[slot2 - 1]) then
		slot0.lockController_:SetSelectedState("lock")

		return
	end

	slot3 = nil
	slot3 = (slot0.toggleType_ ~= BattleConst.TOGGLE.PLOT or ChapterCfg[slot0.chapterID_].unlock_activity_id) and ChapterCfg[slot0.chapterID_].activity_id
	slot4 = nil

	if ((slot0.toggleType_ ~= BattleConst.TOGGLE.PLOT or ActivityData:GetActivityData(slot3).startTime) and ActivityData:GetActivityRefreshTime(slot3)) <= manager.time:GetServerTime() then
		slot0.lockController_:SetSelectedState("unlock")

		return
	end

	slot0.lockController_:SetSelectedState("lock")

	slot0.timer_ = Timer.New(function ()
		if uv0 <= manager.time:GetServerTime() then
			uv1.lockController_:SetSelectedState("unlock")
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
