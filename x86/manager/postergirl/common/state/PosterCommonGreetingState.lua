slot0 = class("PosterCommonGreetingState", PosterCommonInteractionState)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)

	slot0.interactionKey = PosterGirlConst.InteractionKey.greeting
end

function slot0.Enter(slot0)
	slot0.greetTimer = Timer.New(function ()
		uv0:CheckInsteraction()
	end, 1.2, 1)

	slot0.greetTimer:Start()
end

function slot0.Exit(slot0)
	uv0.super.Exit(slot0)

	if slot0.greetTimer then
		slot0.greetTimer:Stop()

		slot0.greetTimer = nil
	end
end

return slot0
