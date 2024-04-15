slot0 = class("HeroRaiseModelToucherView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.rotateNode_ = nil
	slot0.isShowInteractive_ = false
	slot0.isEnterToThisView = true

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0.playable_ = slot0:FindCom(typeof(PlayableDirector), "")
	slot0.backGo_ = slot0:FindGo("back")
end

function slot0.SetRotateNode(slot0, slot1)
	slot0.rotateNode_ = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddDragListener(slot0.backGo_, function ()
		if uv0.rotateNode_ then
			uv0.startRot_ = uv0.rotateNode_.localEulerAngles
		else
			uv0.startRot_ = Vector3.zero
		end

		uv0.lastRotateY_ = nil
		uv0.lastDeltaX_ = 0
	end, function (slot0, slot1)
		if uv0.rotateNode_ then
			slot2 = uv0.lastRotateY_ or uv0.rotateNode_.localEulerAngles.y
			slot4 = slot2 + (slot0 - (uv0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - slot2
			slot5 = slot4

			if slot4 < -HeroConst.MAX_RORATE_ANGLE then
				slot5 = -HeroConst.MAX_RORATE_ANGLE
			elseif HeroConst.MAX_RORATE_ANGLE < slot4 then
				slot5 = HeroConst.MAX_RORATE_ANGLE
			end

			uv0.lastRotateY_ = slot2 + slot5
			uv0.lastDeltaX_ = slot0
			uv0.rotateNode_.localRotation = Quaternion.RotateTowards(uv0.rotateNode_.localRotation, Quaternion.Euler(uv0.startRot_.x, slot2 + slot5, uv0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
