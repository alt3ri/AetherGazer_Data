slot0 = partialClass("MainHomeView", ReduxView)

function slot0.StartRefreshUITimer(slot0)
	if slot0.updateTimer == nil then
		slot0.updateTimer = Timer.New(function ()
			uv0:RefreshRealtimeUI()
		end, 1, -1)
	end

	slot0.updateTimer:Start()
end

function slot0.StartShowTimer(slot0, slot1)
	if slot0.showTimer_ or not (slot1 and #slot1 > 0) then
		return
	end

	slot3 = Timer.New(function ()
		uv0.showTimer_ = nil

		if manager.guide:IsPlaying() then
			return
		end

		if uv1 then
			uv1[1]()

			return
		end
	end, 1, 1)
	slot0.showTimer_ = slot3

	slot3:Start()
end

function slot0.ClearMsgTimer(slot0)
	if slot0.msgTimer_ then
		slot0.msgTimer_:Stop()

		slot0.msgTimer_ = nil
	end
end

function slot0.StartViewHideTimer(slot0)
	slot0:StopViewHideTimer()
	SetActive(slot0.appearViewBtn_.gameObject, true)

	slot0.viewHideTimer_ = Timer.New(function ()
		uv0:StopViewHideTimer()
		SetActive(uv0.appearViewBtn_.gameObject, false)
	end, 3, 1)

	slot0.viewHideTimer_:Start()
end

function slot0.StopViewHideTimer(slot0)
	if slot0.viewHideTimer_ then
		slot0.viewHideTimer_:Stop()

		slot0.viewHideTimer_ = nil
	end
end

function slot0.StopAllTimers(slot0)
	slot0:ClearMsgTimer()
	slot0:StopViewHideTimer()

	if slot0.updateTimer then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end

	if slot0.showTimer_ then
		slot0.showTimer_:Stop()

		slot0.showTimer_ = nil
	end

	if slot0.activiteTime_ then
		slot0.activiteTime_:Stop()

		slot0.activiteTime_ = nil
	end

	if slot0.multiTouchTimer_ then
		slot0.multiTouchTimer_:Stop()

		slot0.multiTouchTimer_ = nil
	end

	if slot0.talkBubbleTimer_ ~= nil then
		slot0.talkBubbleTimer_:Stop()

		slot0.talkBubbleTimer_ = nil
	end
end
