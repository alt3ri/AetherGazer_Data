slot0 = class("PosterDlcInitState", PosterDlcTimelineState)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)
end

function slot0.Enter(slot0)
	uv0.super.Enter(slot0)
	slot0.actor:EnableEyeController(true)
	slot0.actor:MuteCamera(true)

	slot1 = "action1_1"

	slot0:PlayAni(manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.playerInfo and "action1_1" or "action1_" .. slot0.actor:GetViewDirect() + 1)
end

function slot0.TimelineStopCallback(slot0)
end

function slot0.Exit(slot0, slot1)
	uv0.super.Exit(slot0, slot1)
	slot0.actor:MuteCamera(false)
end

return slot0
