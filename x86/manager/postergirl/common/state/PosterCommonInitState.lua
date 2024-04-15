slot0 = class("PosterCommonInitState", PosterCommonAnimatorState)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)
end

function slot0.Enter(slot0)
	uv0.super.Enter(slot0)
	slot0.actor:EnableEyeController(true)

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.home and #slot0.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.idle] ~= 0 then
		slot0.idleTimer = Timer.New(function ()
			uv0.actor:ChangeState(PosterGirlConst.StateKay.idle)
		end, 60, -1)

		slot0.idleTimer:Start()
	end

	slot0:PlayAni("action1_1")
end

function slot0.AnimationEndCall(slot0)
end

function slot0.Exit(slot0)
	uv0.super.Exit(slot0)

	if slot0.idleTimer then
		slot0.idleTimer:Stop()

		slot0.idleTimer = nil
	end
end

return slot0
