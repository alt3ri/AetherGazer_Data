slot0 = class("ChapterChallengeLnkItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.SetData(slot0, slot1)
	slot0.chapterClientID_ = slot1
	slot2 = ChapterClientCfg[slot1]
	slot0.isLock_ = JumpTools.GetLinkIsLocked(slot2.jump_system)

	SetSpriteWithoutAtlasAsync(slot0.image_, SpritePathCfg.ChapterPaint.path .. slot2.chapter_paint_2)

	slot0.nameText_.text = slot2.name

	slot0:RefreshLockState()
	slot0:AddTimer()
	manager.redPoint:bindUIandKey(slot0.transform_, ChapterTools.GetRedPoint(slot1))
	slot0:Show(true)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		slot0 = ChapterClientCfg[uv0.chapterClientID_]

		if not uv0.isLock_ then
			SystemRedPoint:CancelNewTagByChapterId(uv0.chapterClientID_)
		end

		JumpTools.JumpToPage2(slot0.jump_system)
	end)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTimeStamp(true)

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshTimeStamp()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTimeStamp(slot0, slot1)
	if slot1 then
		if ChapterTools.GetChallengeNextRefreshTimeStamp(slot0.chapterClientID_) == 0 or slot0.isLock_ then
			SetActive(slot0.timeGo_, false)
		else
			SetActive(slot0.timeGo_, true)
		end
	end

	if slot3 ~= 0 then
		slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(slot3, true)
	end
end

function slot0.RefreshLockState(slot0)
	if slot0.isLock_ then
		slot0.lockController_:SetSelectedState("true")
	else
		slot0.lockController_:SetSelectedState("false")
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
