slot0 = class("PosterDlcTouchState", PosterDlcInteractionState)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1, PosterGirlConst.InteractionKey.mainTouch)
end

function slot0.Enter(slot0)
	if PosterGirlConst.ViewDirect.left == slot0.actor:GetViewDirect() then
		slot0.interactionKey = PosterGirlConst.InteractionKey.touch2
	elseif PosterGirlConst.ViewDirect.right == slot1 then
		slot0.interactionKey = PosterGirlConst.InteractionKey.touch3
	else
		slot0.interactionKey = PosterGirlConst.InteractionKey.mainTouch
	end

	if slot0.lastInteractionKey ~= slot0.interactionKey then
		slot0.lastInteractionKey = slot0.interactionKey
		slot0.lastIndex = 0
	end

	uv0.super.Enter(slot0)
end

return slot0
