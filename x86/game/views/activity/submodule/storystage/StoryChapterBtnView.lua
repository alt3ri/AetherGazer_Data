slot0 = class("StoryChapterBtnView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterID_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0, slot1)
	slot0.isLock_ = table.length(StoryStageActivityData:GetStageData(slot0.chapterID_)) <= 0

	slot0:RefreshBtn(slot1)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.OnUpdate(slot0, slot1)
	slot0:RefreshBtn(slot1)
end

function slot0.RefreshBtn(slot0, slot1)
	if slot0.chapterID_ == slot1 then
		slot0.controller_:SetSelectedState("value_2")
		StoryStageActivityData:SetUnlockState(slot0.chapterID_)
	elseif slot0.isLock_ then
		slot0.controller_:SetSelectedState("false")
	else
		slot0.controller_:SetSelectedState("true")

		if StoryStageActivityData:GetUnlockState(slot0.chapterID_) then
			slot0.animator_:Play("Ani_unselect", -1, 1)
		else
			slot0:AddTimer()
		end
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.isLock_ then
			if (table.keyof(ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityStoryChapterCfg[uv0.chapterID_].activity_id], uv0.chapterID_) or 1) <= 1 then
				return
			end

			ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), GetI18NText(ActivityStoryChapterCfg[slot1[slot2 - 1]].name)))

			return
		else
			slot0 = ActivityStoryChapterCfg[uv0.chapterID_]

			StoryStageActivityData:SaveHistoryChapter(slot0.activity_id, uv0.chapterID_)
			uv0:Go("/storyStageActivity", {
				chapterID = uv0.chapterID_,
				theme = ActivityCfg[slot0.activity_id].activity_theme
			})
		end
	end)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot1 = slot0.animator_:GetCurrentAnimatorStateInfo(0)
	slot0.timer_ = Timer.New(function ()
		if uv0.normalizedTime > 0.5 then
			StoryStageActivityData:SetUnlockState(uv1.chapterID_)
			uv1:StopTimer()
		end
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
