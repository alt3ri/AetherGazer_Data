slot1 = class("ChapterChallengeMatrixItemView", import(".ChapterChallengeItemWithCD"))

function slot1.Ctor(slot0, ...)
	uv0.super.Ctor(slot0, ...)

	slot0.updateHandler_ = handler(slot0, slot0.UpdateMatrix)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.notify:RegistListener(MATRIX_UPDATE, slot0.updateHandler_)
end

function slot1.OnExit(slot0)
	manager.notify:RemoveListener(MATRIX_UPDATE, slot0.updateHandler_)
	uv0.super.OnExit(slot0)
end

function slot1.Dispose(slot0)
	slot0.updateHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.GetLostTime(slot0)
	return ActivityData:GetActivityData(PolyhedronData:GetActivityID()).stopTime
end

function slot1.ClickItem(slot0)
	if slot0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_polyhedron_above")

		slot0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_polyhedron_below")
	end

	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	if not PolyhedronData:GetPolyhedronInfo() then
		return
	end

	if not ActivityData:GetActivityIsOpen(PolyhedronData:GetActivityID()) then
		ShowTips("TIME_OVER")

		return
	end

	if slot0.isShowNew_ == 1 and not slot0.isLock_ then
		slot0.isShowNew_ = 0

		RedPointData:SetJsonCacheRedPoint("Polyhedron")
		manager.redPoint:bindUIandKey(slot0.panelTf_, RedPointConst.POLYHEDRON)
	end

	if PolyhedronConst.STATE_TYPE.SETTLEMENT == slot1:GetState() then
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronOver", nil, ViewConst.SYSTEM_ID.MATRIX)
	else
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil, ViewConst.SYSTEM_ID.MATRIX)
	end
end

function slot1.AddRedPoint(slot0)
	slot0.isShowNew_ = RedPointData:GetJsonCacheRedPoint("Polyhedron")

	manager.redPoint:bindUIandKey(slot0.panelTf_, RedPointConst.POLYHEDRON)
end

function slot1.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.panelTf_)
end

function slot1.UpdateMatrix(slot0)
	manager.redPoint:unbindUIandKey(slot0.panelTf_)
	slot0:AddRedPoint()
end

function slot1.AddCountdown(slot0)
end

function slot1.RefreshTimeText(slot0)
	slot0.timeLock_ = slot0:GetLostTime() <= manager.time:GetServerTime()

	if slot0.tiemLock_ ~= slot0.timeLock_ then
		slot0:RefreshLock()
	end

	if slot0.timeLock_ then
		slot0.openText_.text = ""
	else
		slot0.openText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr(slot0:GetLostTime(), nil, true))
	end
end

return slot1
