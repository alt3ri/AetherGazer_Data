slot0 = class("PosterDlcMid2LeftState", PosterDlcTimelineState)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.oldDirect = slot2
	slot0.newDiect = slot3
	slot0.clipName = slot0:GetAnimaName(slot2, slot3)

	uv0.super.Ctor(slot0, slot1)
end

function slot0.GetAnimaName(slot0, slot1, slot2)
	if PosterGirlConst.ViewDirect.center == slot1 and PosterGirlConst.ViewDirect.left == slot2 then
		return "enter2"
	elseif PosterGirlConst.ViewDirect.center == slot1 and PosterGirlConst.ViewDirect.right == slot2 then
		return "enter3"
	elseif PosterGirlConst.ViewDirect.left == slot1 and PosterGirlConst.ViewDirect.center == slot2 then
		return "return2"
	else
		return "return3"
	end
end

function slot0.Enter(slot0)
	uv0.super.Enter(slot0)
	slot0:PlayAni(slot0.clipName)
	slot0.actor:MuteCamera(true)

	slot3, slot4, slot5 = PosterGirlTools.GetLoadLightEffect(slot0.oldDirect, slot0.newDiect)

	if slot3 then
		if slot5 and slot5 > 0 then
			slot0.loadEffectTimer_ = Timer.New(function ()
				manager.ui:SetSceneLightEffect(uv0)
			end, slot5)

			slot0.loadEffectTimer_:Start()
		else
			manager.ui:SetSceneLightEffect(slot4)
		end
	end

	PlayerAction.TouchPosterGirl()
end

function slot0.Exit(slot0, slot1)
	slot0.actor:MuteCamera(false)

	if slot0.loadEffectTimer_ then
		slot0.loadEffectTimer_:Stop()

		slot0.loadEffectTimer_ = nil
	end

	uv0.super.Exit(slot0, slot1)
	slot0.actor:UpdateCameraParams()
end

return slot0
