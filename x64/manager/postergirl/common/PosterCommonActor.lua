slot0 = class("PosterCommonActor", PosterGirlBaseActor)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot3, slot4 = PosterGirlTools.GetLoadLightEffect(PosterGirlConst.ViewDirect.center, PosterGirlConst.ViewDirect.center)

	if slot3 then
		manager.ui:SetSceneLightEffect(slot4)
	end
end

function slot0.LoadModel(slot0)
	uv0.super.LoadModel(slot0)

	slot0.animator = slot0.ui_topse:GetComponent(typeof(Animator))
end

function slot0.GetTag(slot0)
	return PosterGirlConst.PosterGirlTag.common
end

function slot0.GetAnimator(slot0)
	return slot0.animator
end

function slot0.GetState(slot0, slot1)
	if slot0._states[slot1] then
		return slot0._states[slot1]
	end

	if PosterGirlTools.ProduceCommonState(slot1, slot0) ~= nil then
		slot2:SetStateKey(slot1)

		slot0._states[slot1] = slot2

		return slot2
	end
end

function slot0.GetInteractionCfg(slot0)
	return HeroTools:GetUnlockInteractionCfg(SkinCfg[slot0.skinId].hero)
end

function slot0.DoShacking(slot0)
	if not slot0:CheckInitState() then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.shake)
end

function slot0.DoTouch(slot0)
	if not slot0:CheckInitState() then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.touch)
end

function slot0.DoQuickTouch(slot0)
	if not slot0:CheckInitState() then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.quickclick)
end

function slot0.DoShowing(slot0)
	if not slot0:CheckInitState() then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.show)
end

function slot0.DoGreeting(slot0)
	if not slot0:CheckInitState() then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.greet)
end

function slot0.DoIdle(slot0)
	if not slot0:CheckInitState() then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.idle)
end

function slot0.DoInit(slot0, slot1)
	slot0:ChangeState(PosterGirlConst.StateKay.init)
end

return slot0
