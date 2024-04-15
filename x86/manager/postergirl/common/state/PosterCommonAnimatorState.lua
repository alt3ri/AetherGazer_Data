slot0 = class("PosterGirlAnimatorState", PosterGirlBaseState)
slot1 = 0.4

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.clipName = slot2
	slot0.animator = slot0.actor:GetAnimator()
end

function slot0.PlayAni(slot0, slot1)
	slot3 = false
	slot2.speed = 1

	if not slot0.animator:GetCurrentAnimatorStateInfo(0):IsName("ui_stand") and slot0.clipName ~= "ui_stand" then
		slot2:CrossFade(slot1, uv0 / slot2:GetCurrentAnimatorStateInfo(0).length, 0)
	else
		slot2:Play(slot1)
	end

	slot0.timer = Timer.New(function ()
		if slot0:IsName(uv3) and slot0.normalizedTime >= 1 - (uv1 and uv2 or 0) / uv0:GetCurrentAnimatorStateInfo(0).length then
			if uv4.timer ~= nil then
				uv4.timer:Stop()

				uv4.timer = nil
			end

			uv4:AnimationEndCall()
		end
	end, 0.033, -1)

	slot0.timer:Start()
end

function slot0.AnimationEndCall(slot0)
	slot0.actor:ChangeState(PosterGirlConst.StateKay.init)
end

function slot0.Exit(slot0)
	if slot0.timer ~= nil then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0.actor:ResetBlendShapes()
end

return slot0
