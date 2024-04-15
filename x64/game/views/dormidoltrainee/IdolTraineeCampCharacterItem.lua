slot1 = class("IdolTraineeCampCharacterItem", import("game.views.dorm.DormView.DormCharacterItem"))

function slot2(slot0)
	if DormData:GetHeroTemplateInfo(slot0) then
		if slot1:GetHeroState() == DormEnum.DormHeroState.InCanteenEntrust or slot2 == DormEnum.DormHeroState.InCanteenJob then
			return true
		end

		return false
	end
end

function slot1.OnCtor(slot0, ...)
	uv0.super.OnCtor(slot0, ...)
	slot0:ShowMaskCallBack(uv1)
end

function slot1.AddUIListener(slot0)
	slot1 = slot0:FindCom("EventTriggerListener")

	function slot1.onPointerDown()
		if not uv0.canClick and uv0.dragFunc then
			uv0.dragFunc(uv0.heroID)
		end
	end

	slot0:AddBtnListener(slot0.heroitemBtn_, nil, function ()
		if not uv0.canClick and uv0.downFunc then
			uv0.downFunc(uv0.heroID)
		end
	end)
	slot0:AddBtnListenerScale(slot0.recallbtnBtn_, nil, function ()
		if not uv0.canClick and uv0.recallHero then
			uv0.recallHero(uv0.heroID)
		end
	end)

	function slot1.onBeginDrag(slot0, slot1)
		uv0:BeginDrag(slot1)
	end

	function slot1.onEndDrag(slot0, slot1)
		uv0:EndDrag(slot1)
	end

	function slot1.onDrag(slot0, slot1)
		uv0:Drag(slot1)
	end

	slot0:SetListener(slot1)

	slot0.eventTriggerListener = slot1
end

function slot1.RefreshUI(slot0, slot1, slot2)
	slot0.deployCharaView = slot1

	uv0.super.RefreshUI(slot0, slot2, slot1.selHeroID)
end

function slot1.EnableRecall(slot0)
	slot1 = slot0.heroID

	for slot6, slot7 in pairs(IdolTraineeCampBridge.charaAtPos) do
		if slot0.archiveID == IdolTraineeCampBridge.GetCharacterArchiveID(slot7) then
			return true
		end
	end

	return false
end

function slot3()
	manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
end

function slot4(slot0, slot1)
	if IdolTraineeCampBridge.GenCharacter(slot0) then
		uv0.curDragging = slot2

		Dorm.DormEntityManager.SendDoActionCMD(slot2, "carry", nil, true, false)
	end
end

function slot5()
	if uv0.curDragging then
		DormData:GetHeroTemplateInfo(IdolTraineeCampBridge.GetCharacterHeroID(uv0.curDragging)):GoToDance(nil)
		IdolTraineeCampBridge.RemoveEntity(uv0.curDragging)

		uv0.curDragging = nil
	end
end

function slot1.IsDragBlocked(slot0)
	return slot0.maskFunc(slot0.heroID)
end

function slot1.BeginDrag(slot0, slot1)
	slot0.deployCharaView:BeginDragHeroList(slot1, slot0)
	slot0:UpdateDraggingCharaPos(slot1)
end

function slot1.Drag(slot0, slot1)
	if uv0.curDragging then
		if slot0.deployCharaView:NotDragOutYet(slot1) then
			uv1()
		else
			slot3, slot4 = slot0:CanDrop(slot1)
			slot5 = uv0.curDragging

			if not slot3 or not slot0:SnapOnTarget(slot3, slot4, slot1) then
				slot0:UpdateDraggingCharaPos(slot1)
			end

			slot0.deployCharaView:HoverHightDragOnTarget(slot3, slot4)
		end
	elseif not slot2 and not slot0:IsDragBlocked() then
		uv2(slot0.heroID, slot1)
		slot0.deployCharaView:EndDragHeroList(slot1, slot0)
		slot0:UpdateDraggingCharaPos(slot1)
	else
		slot0.deployCharaView:DragHeroList(slot1, slot0)
	end
end

function slot1.EndDrag(slot0, slot1)
	if uv0.curDragging then
		slot3, slot4 = slot0:CanDrop(slot1)
		slot5 = uv0.curDragging

		if slot3 then
			slot0:DropCharaOnTarget(slot3, slot4)
		else
			IdolTraineeCampBridge.RemoveEntity(slot2)
		end

		slot0.deployCharaView:UpdateCurHeroNum()

		uv0.curDragging = nil
	end

	slot0.deployCharaView:EndDragHeroList(slot1, slot0)
	uv1()
end

function slot1.CanDrop(slot0, slot1)
	if nullable(slot0.deployCharaView, "targets") then
		for slot9 = #slot2, 1, -1 do
			if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(nullable(slot2, slot9, "trs"), slot1.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera) then
				return slot10, slot9
			end
		end
	end
end

function slot1.DropCharaOnTarget(slot0, slot1, slot2)
	if not uv0.curDragging then
		return
	end

	slot0:SnapOnTarget(slot1, slot2)
	slot0.deployCharaView:SetCharacterAtPos(slot3, slot2)
end

function slot1.SnapOnTarget(slot0, slot1, slot2)
	if not uv0.curDragging then
		return
	end

	return slot0.deployCharaView:SnapCharacterOnTarget(slot3, slot2)
end

function slot1.UpdateDraggingCharaPos(slot0, slot1)
	if not uv0.curDragging then
		return
	end

	DanceGameController.UpdateCharaGrabPos(IdolTraineeCampBridge.walls, uv0.curDragging, slot1)
end

return slot1
