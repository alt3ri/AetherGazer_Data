slot0 = class("PosterDlcTimelineState", PosterGirlBaseState)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)

	slot0.playableStopped = handler(slot0, slot0.TimelineStopCallback)
end

function slot0.Enter(slot0)
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function slot0.PlayAni(slot0, slot1)
	slot0.playable, slot0.timeLintGo = slot0.actor:GetPlayable(slot1)

	SetActive(slot0.timeLintGo, true)

	if slot0.playable == nil then
		print("PosterDlcTimelineState error find clipName:" .. slot1)
	end

	slot0.playable.stopped = slot0.playable.stopped + slot0.playableStopped

	slot0.playable:RebuildGraph()
	slot0.playable:Play()
end

function slot0.TimelineStopCallback(slot0)
	slot0.actor:ChangeState(PosterGirlConst.StateKay.init)
end

function slot0.Exit(slot0, slot1)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	slot0.playable.stopped = slot0.playable.stopped - slot0.playableStopped

	if slot1 then
		slot0.playable.time = slot0.playable.duration

		slot0.playable:Evaluate()
	end

	slot0.playable:Stop()
	SetActive(slot0.timeLintGo, false)
end

return slot0
