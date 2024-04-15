slot0 = class("PosterGirlDlcActor", PosterGirlDlcActor)
slot1 = 0

function slot0.Init(slot0)
	slot0.view_direct = uv0 or PosterGirlConst.ViewDirect.center
end

function slot0.GetTag(slot0)
	return PosterGirlConst.PosterGirlTag.t0
end

function slot0.GetViewDirect(slot0)
	return slot0.view_direct
end

function slot0.GetHeroPosAndRotCfg(slot0)
	return HeroPosAndRotCfg[slot0.skinId * 100 + slot0.view_direct]
end

function slot0.SwipeToLeft(slot0)
	if PosterGirlConst.ViewDirect.center == slot0.view_direct then
		slot0.view_direct = PosterGirlConst.ViewDirect.left

		slot0:ChangeState(PosterGirlConst.StateKay.mid2left)
	elseif PosterGirlConst.ViewDirect.right == slot0.view_direct then
		slot0.view_direct = PosterGirlConst.ViewDirect.center

		slot0:ChangeState(PosterGirlConst.StateKay.right2mid)
	end

	uv0 = slot0.view_direct
end

function slot0.SwipeToRight(slot0)
	if PosterGirlConst.ViewDirect.center == slot0.view_direct then
		slot0.view_direct = PosterGirlConst.ViewDirect.right

		slot0:ChangeState(PosterGirlConst.StateKay.mid2right)
	elseif PosterGirlConst.ViewDirect.left == slot0.view_direct then
		slot0.view_direct = PosterGirlConst.ViewDirect.center

		slot0:ChangeState(PosterGirlConst.StateKay.left2mid)
	end

	uv0 = slot0.view_direct
end

function slot0.TouchHelpSingleDrag(slot0, slot1, slot2)
	slot3 = GameSetting.drag_to_move_speed and GameSetting.drag_to_move_speed.value[1] or 200

	if not slot0:CheckInitState() then
		return
	end

	if slot3 < slot1 and slot0.cameraManager_.lastCameraIndex == 0 then
		slot0:SwipeToRight()
	elseif slot1 < -1 * slot3 and slot4 == 0 then
		slot0:SwipeToLeft()
	else
		slot0.cameraManager_:RotateCamera(slot1, slot2)
	end
end

function slot0.UpdateCameraParams(slot0)
	if not slot0.cameraManager_ then
		return
	end

	if PosterGirlConst.ViewDirect.left == slot0.view_direct then
		slot0.cameraManager_:SetCameraParams(1)
	elseif PosterGirlConst.ViewDirect.right == slot0.view_direct then
		slot0.cameraManager_:SetCameraParams(2)
	else
		slot0.cameraManager_:SetCameraParams(0)
	end

	slot0:SetSelfCamera(0)
end

return slot0
